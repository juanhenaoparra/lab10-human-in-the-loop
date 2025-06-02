# Refund Agent - Human-in-the-Loop Processing System

A professional customer service refund specialist AI assistant that processes refund requests with human approval workflows. Built with LangGraph and Supabase for secure, auditable refund processing.

## Features

- **Transaction Lookup**: Search and filter customer transaction history
- **Eligibility Assessment**: Automated refund eligibility checking based on business rules
- **Human-in-the-Loop**: All refund executions require human approval for security
- **Audit Trail**: Complete task tracking and approval workflow in Supabase
- **Professional AI Agent**: Empathetic, solution-oriented customer service interactions

## Prerequisites

### Python Installation

This project requires Python 3.8 or higher. 

#### macOS
```bash
# Using Homebrew (recommended)
brew install python

# Or download from python.org
# Visit https://www.python.org/downloads/
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install python3 python3-pip python3-venv
```

#### Windows
Download and install Python from [python.org](https://www.python.org/downloads/windows/)

### Environment Variables

You'll need a Supabase account and project. Create a `.env` file in the project root, you can copy the `.env.example`:

```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
OPENAI_API_KEY=your_openai_api_key
```

## Installation

1. **Clone the repository**
   ```bash
   git clone <repository_url>
   cd hil
   ```

2. **Create a virtual environment**
   ```bash
   python -m venv .venv
   ```

3. **Activate the virtual environment**
   ```bash
   # macOS/Linux
   source .venv/bin/activate
   
   # Windows
   .venv\Scripts\activate
   ```

4. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

## Database Setup

1. Create a [new Supabase project](https://supabase.com/).
2. Copy the `schema.sql` content in the editor and the click in run. To create the tables.
3. Copy the `seed.sql` content in the editor and the click in run. To create records example.

## Running the Application

Start the LangGraph development server:

```bash
.venv/bin/langgraph dev
```

# Examples

1. Straightforward Eligible Refund
   1. `Hi, I need to request a refund for my recent purchase. I bought wireless headphones for $149.99 about 3 days ago, but they arrived damaged - the left speaker doesn't work at all. My email is bob.jones@email.com. Can you please process a full refund? I've already returned the item to the original packaging.`
2. High-Value Transaction (Requires Extra Scrutiny)
   1. `Hello, I would like to return my laptop workstation that I purchased for $1,599.99 about 19 days ago. The performance isn't meeting my professional needs as advertised. My email is carol.wilson@email.com. I'm requesting a full refund as this was a significant investment that isn't working for my business requirements.`
3. Edge Case - Old Transaction (Likely Ineligible)
   1. `I need help with a refund for a professional microphone I bought for $599.99. It's been about 3 months since I purchased it, but I just realized it doesn't work with my recording setup. My email is alice.smith@email.com. Is it still possible to get a refund even though it's been a while? I haven't used it much.`