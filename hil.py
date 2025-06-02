import os
from datetime import datetime, timedelta
from pydantic import BaseModel, Field
from langgraph.types import interrupt
from langgraph.prebuilt import create_react_agent
from supabase import create_client, Client

supabase_url = os.environ.get("SUPABASE_URL")
supabase_key = os.environ.get("SUPABASE_ANON_KEY")
supabase: Client = create_client(supabase_url, supabase_key)

class QueryTransactionsInput(BaseModel):
    user_email: str = Field(description="Customer email address to search transactions for")
    date_range: str = Field(default="30_days", description="Time range: '30_days', '90_days', or '1_year'")
    concept_filter: str = Field(default="", description="Filter transactions by description keywords")

class ExecuteRefundInput(BaseModel):
    transaction_id: str = Field(description="Unique transaction ID to refund")
    refund_amount: float = Field(description="Amount to refund in dollars")
    reason: str = Field(description="Reason for the refund request")
    notes: str = Field(description="Notes for the refund request. Insights, possible risks, etc.")

class AssessRefundEligibilityInput(BaseModel):
    transaction_id: str = Field(description="Unique transaction ID to assess for refund eligibility")

def query_transactions(input: QueryTransactionsInput) -> str:
    """Query transaction history from Supabase. Read-only operation, no human approval needed."""
    try:
        end_date = datetime.now()
        if input.date_range == "30_days":
            start_date = end_date - timedelta(days=30)
        elif input.date_range == "90_days":
            start_date = end_date - timedelta(days=90)
        elif input.date_range == "1_year":
            start_date = end_date - timedelta(days=365)
        else:
            start_date = end_date - timedelta(days=30)
        
        query = supabase.table("transactions").select("*").eq("user_email", input.user_email)
        query = query.gte("created_at", start_date.isoformat())
        query = query.lte("created_at", end_date.isoformat())
        
        if input.concept_filter:
            query = query.ilike("description", f"%{input.concept_filter}%")
        
        result = query.execute()
        
        if result.data:
            transactions_summary = []
            for txn in result.data:
                transactions_summary.append(
                    f"ID: {txn['id']}, Amount: ${txn['amount']:.2f}, "
                    f"Date: {txn['created_at']}, Description: {txn['description']}, "
                    f"Status: {txn['status']}"
                )
            return f"Found {len(result.data)} transactions for {input.user_email}:\n" + "\n".join(transactions_summary)
        else:
            return f"No transactions found for {input.user_email} in the specified date range"
            
    except Exception as e:
        return f"Error querying transactions: {str(e)}"

def execute_refund(input: ExecuteRefundInput) -> str:
    """Execute refund with mandatory human approval."""
    try:
        transaction_result = supabase.table("transactions").select("*").eq("id", input.transaction_id).execute()
    except Exception as e:
        return f"Error getting transaction: {str(e)}"
        
    if not transaction_result.data:
        return f"Error: Transaction {input.transaction_id} not found"
    
    transaction = transaction_result.data[0]
    
    if transaction['status'] == 'refunded':
        return f"Error: Transaction {input.transaction_id} has already been refunded"
    
    if input.refund_amount > transaction['amount']:
        return f"Error: Refund amount ${input.refund_amount:.2f} exceeds transaction amount ${transaction['amount']:.2f}"
    
    # Step 1: Create task with 'pending' status
    task_data = {
        "type": "refund",
        "transaction_id": input.transaction_id,
        "refund_amount": input.refund_amount,
        "reason": input.reason,
        "notes": input.notes,
        "status": "pending_approval",
        "created_at": datetime.now().isoformat(),
    }

    try:
        # Check if there's already a pending task for this transaction
        existing_task = supabase.table("tasks").select("*").eq("transaction_id", task_data["transaction_id"]).eq("status", task_data["status"]).execute()
        
        if existing_task.data and len(existing_task.data) > 0:
            task_id = existing_task.data[0]['id']
        else:
            task_result = supabase.table("tasks").insert(task_data).execute()
            task_id = task_result.data[0]['id']
    except Exception as e:
        return f"Error processing refund: {str(e)}"
    
    print("## task_id before interrupt:", task_id)

    # Step 2: Human approval step using interrupt()
    response = interrupt(
        f"REFUND REQUEST APPROVAL REQUIRED\n"
        f"Task ID: {task_id}\n"
        f"Transaction ID: {input.transaction_id}\n"
        f"Original Amount: ${transaction['amount']:.2f}\n"
        f"Refund Amount: ${input.refund_amount:.2f}\n"
        f"Customer: {transaction['user_email']}\n"
        f"Transaction Date: {transaction['created_at']}\n"
        f"Description: {transaction['description']}\n"
        f"Reason: {input.reason}\n"
        f"Please review and approve/reject this refund request."
    )

    print("response", response)
    print("## task_id after interrupt:", task_id)

    try:
        # Step 3 & 4: Process response and update task
        if response["type"] == "accept":
            supabase.table("transactions").update({
                "status": "refunded",
                "refund_amount": input.refund_amount,
                "refund_date": datetime.now().isoformat()
            }).eq("id", input.transaction_id).execute()
            
            # Update task to completed/approved status
            supabase.table("tasks").update({
                "status": "approved",
                "approved_by": "human_operator",
                "updated_at": datetime.now().isoformat()
            }).eq("id", task_id).execute()
            
            return f"Refund of ${input.refund_amount:.2f} approved and processed for transaction {input.transaction_id}. Task ID: {task_id}. Reason: {input.reason}"
            
        else:
            # Rejection - update task as rejected
            supabase.table("tasks").update({
                "status": "rejected",
                "rejected_by": "human_operator",
                "updated_at": datetime.now().isoformat()
            }).eq("id", task_id).execute()
            
            return f"Refund request for transaction {input.transaction_id} has been rejected by human operator. Task ID: {task_id}"
            
    except Exception as e:
        return f"Error processing refund: {str(e)}"

def assess_refund_eligibility(input: AssessRefundEligibilityInput) -> str:
    """Assess if a refund request meets business eligibility criteria."""
    try:
        # Get transaction details directly using the transaction_id
        result = supabase.table("transactions").select("*").eq("id", input.transaction_id).execute()
        
        if not result.data:
            return f"Transaction {input.transaction_id} not found for eligibility assessment"
        
        transaction = result.data[0]
        
        # Business rules for refund eligibility
        eligibility_issues = []
        
        # Check transaction age (example: no refunds after 90 days)
        transaction_date = datetime.fromisoformat(transaction['created_at'].replace('Z', '+00:00'))
        days_since_transaction = (datetime.now(transaction_date.tzinfo) - transaction_date).days
        
        if days_since_transaction > 90:
            eligibility_issues.append(f"Transaction is {days_since_transaction} days old (limit: 90 days)")
        
        # Check if already refunded
        if transaction['status'] == 'refunded':
            eligibility_issues.append("Transaction has already been refunded")
        
        # Check minimum refund amount (example: $1 minimum)
        if transaction['amount'] < 1.0:
            eligibility_issues.append(f"Transaction amount ${transaction['amount']:.2f} below minimum refund threshold")
        
        # Return assessment
        if eligibility_issues:
            return f"ELIGIBILITY ISSUES FOUND for transaction {input.transaction_id}:\n" + "\n".join(f"- {issue}" for issue in eligibility_issues)
        else:
            return f"Transaction {input.transaction_id} is ELIGIBLE for refund. Amount: ${transaction['amount']:.2f}, Date: {transaction['created_at']}"
            
    except Exception as e:
        return f"Error assessing refund eligibility: {str(e)}"

agent = create_react_agent(
    model="openai:gpt-4o-mini",
    prompt="""You are a professional customer service refund specialist AI assistant. Your role is to help customers with refund requests in a helpful, empathetic, and efficient manner.

## Workflow Guidelines

1. **Information Gathering**: Always start by understanding the customer's request and gathering necessary details (customer email, transaction details, refund reason)

2. **Transaction Lookup**: Use query_transactions to find the relevant transaction(s)

3. **Eligibility Check**: Use assess_refund_eligibility to verify the transaction meets refund criteria

4. **Refund Processing**: If eligible, use execute_refund to initiate the approval process

## Your Capabilities

You have access to three specialized tools:

1. **query_transactions**: Search and retrieve customer transaction history
   - Use this to find specific transactions or review purchase history
   - Can filter by date range (30 days, 90 days, 1 year) and description keywords
   - This is a read-only operation that doesn't require approval

2. **assess_refund_eligibility**: Check if a transaction meets refund criteria
   - Use this to verify business rules (transaction age, amount limits, refund status)
   - Helps determine if a refund request can be processed
   - Provides clear feedback on any eligibility issues

3. **execute_refund**: Process actual refund requests
   - Requires human approval for all refund transactions
   - Creates a task record and triggers approval workflow
   - Only use after confirming eligibility and gathering all necessary information

## Communication Style

- Be professional, empathetic, and solution-oriented
- Clearly explain each step of the process
- Set proper expectations about approval requirements and timing
- Provide specific transaction details and reference numbers
- If issues arise, explain them clearly and offer alternatives when possible

## Important Notes

- All refund executions require human approval - this is a security feature
- You cannot override business eligibility rules
- Always verify transaction details before processing
- Maintain customer privacy and handle sensitive information appropriately

Remember: Your goal is to provide excellent customer service while following proper procedures and security protocols.""",
    tools=[query_transactions, execute_refund, assess_refund_eligibility],
)
