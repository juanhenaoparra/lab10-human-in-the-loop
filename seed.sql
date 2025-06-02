-- Seed Data for Refund Agent Testing
-- Inserts 120 example transactions with varied scenarios

INSERT INTO transactions (user_email, amount, description, status, created_at) VALUES
-- Recent transactions (last 30 days)
('alice.smith@email.com', 29.99, 'Premium subscription monthly', 'completed', NOW() - INTERVAL '5 days'),
('bob.jones@email.com', 149.99, 'Wireless headphones', 'completed', NOW() - INTERVAL '3 days'),
('carol.wilson@email.com', 79.99, 'Online course enrollment', 'completed', NOW() - INTERVAL '1 day'),
('david.brown@email.com', 199.99, 'Gaming mouse and keyboard set', 'completed', NOW() - INTERVAL '7 days'),
('emma.davis@email.com', 49.99, 'Book bundle pack', 'completed', NOW() - INTERVAL '2 days'),
('frank.miller@email.com', 299.99, 'Fitness tracker watch', 'completed', NOW() - INTERVAL '10 days'),
('grace.garcia@email.com', 19.99, 'Mobile app premium features', 'completed', NOW() - INTERVAL '4 days'),
('henry.rodriguez@email.com', 89.99, 'Bluetooth speaker', 'completed', NOW() - INTERVAL '8 days'),
('irene.martinez@email.com', 39.99, 'Video editing software', 'completed', NOW() - INTERVAL '6 days'),
('jack.anderson@email.com', 129.99, 'Mechanical keyboard', 'completed', NOW() - INTERVAL '12 days'),

-- Medium-aged transactions (30-60 days)
('alice.smith@email.com', 59.99, 'Design software license', 'completed', NOW() - INTERVAL '35 days'),
('bob.jones@email.com', 24.99, 'Streaming service subscription', 'completed', NOW() - INTERVAL '42 days'),
('carol.wilson@email.com', 349.99, 'Professional camera lens', 'completed', NOW() - INTERVAL '38 days'),
('david.brown@email.com', 99.99, 'External hard drive 1TB', 'completed', NOW() - INTERVAL '45 days'),
('emma.davis@email.com', 15.99, 'E-book collection', 'completed', NOW() - INTERVAL '33 days'),
('frank.miller@email.com', 179.99, 'Smart home device', 'completed', NOW() - INTERVAL '48 days'),
('grace.garcia@email.com', 69.99, 'Yoga mat and accessories', 'completed', NOW() - INTERVAL '41 days'),
('henry.rodriguez@email.com', 119.99, 'Wireless charger station', 'completed', NOW() - INTERVAL '37 days'),
('irene.martinez@email.com', 199.99, 'Monitor stand with USB hub', 'completed', NOW() - INTERVAL '44 days'),
('jack.anderson@email.com', 79.99, 'Gaming headset', 'completed', NOW() - INTERVAL '39 days'),

-- Older transactions (60-90 days) - still refundable
('alice.smith@email.com', 449.99, 'Laptop cooling pad premium', 'completed', NOW() - INTERVAL '65 days'),
('bob.jones@email.com', 89.99, 'Portable power bank', 'completed', NOW() - INTERVAL '72 days'),
('carol.wilson@email.com', 34.99, 'Phone case with wallet', 'completed', NOW() - INTERVAL '68 days'),
('david.brown@email.com', 259.99, 'Wireless router mesh system', 'completed', NOW() - INTERVAL '75 days'),
('emma.davis@email.com', 29.99, 'Productivity app annual', 'completed', NOW() - INTERVAL '61 days'),
('frank.miller@email.com', 139.99, 'Desk organizer set', 'completed', NOW() - INTERVAL '78 days'),
('grace.garcia@email.com', 199.99, 'Air purifier compact', 'completed', NOW() - INTERVAL '69 days'),
('henry.rodriguez@email.com', 49.99, 'LED desk lamp', 'completed', NOW() - INTERVAL '82 days'),
('irene.martinez@email.com', 299.99, 'Electric standing desk', 'completed', NOW() - INTERVAL '71 days'),
('jack.anderson@email.com', 119.99, 'Webcam 4K resolution', 'completed', NOW() - INTERVAL '77 days'),

-- Very old transactions (over 90 days) - outside refund window
('alice.smith@email.com', 599.99, 'Professional microphone', 'completed', NOW() - INTERVAL '95 days'),
('bob.jones@email.com', 149.99, 'Smart thermostat', 'completed', NOW() - INTERVAL '105 days'),
('carol.wilson@email.com', 79.99, 'Ergonomic mouse pad', 'completed', NOW() - INTERVAL '120 days'),
('david.brown@email.com', 399.99, 'Ultra-wide monitor', 'completed', NOW() - INTERVAL '110 days'),
('emma.davis@email.com', 59.99, 'Language learning app', 'completed', NOW() - INTERVAL '98 days'),

-- Additional customers and varied scenarios
('lisa.thompson@email.com', 199.99, 'Kitchen appliance blender', 'completed', NOW() - INTERVAL '15 days'),
('mike.johnson@email.com', 89.99, 'Running shoes premium', 'completed', NOW() - INTERVAL '22 days'),
('nina.white@email.com', 349.99, 'Tablet with keyboard', 'completed', NOW() - INTERVAL '18 days'),
('oscar.lee@email.com', 129.99, 'Coffee machine single-serve', 'completed', NOW() - INTERVAL '11 days'),
('paula.clark@email.com', 79.99, 'Skincare routine kit', 'completed', NOW() - INTERVAL '9 days'),

-- High-value transactions
('alice.smith@email.com', 1299.99, 'Professional graphics card', 'completed', NOW() - INTERVAL '25 days'),
('bob.jones@email.com', 899.99, 'Smart TV 55 inch', 'completed', NOW() - INTERVAL '14 days'),
('carol.wilson@email.com', 1599.99, 'Laptop workstation grade', 'completed', NOW() - INTERVAL '19 days'),
('david.brown@email.com', 749.99, 'Home theater system', 'completed', NOW() - INTERVAL '27 days'),

-- Low-value transactions (below $1 threshold)
('emma.davis@email.com', 0.99, 'Mobile game currency', 'completed', NOW() - INTERVAL '5 days'),
('frank.miller@email.com', 0.49, 'Digital sticker pack', 'completed', NOW() - INTERVAL '3 days'),
('grace.garcia@email.com', 0.99, 'App theme download', 'completed', NOW() - INTERVAL '8 days'),

-- Already refunded transactions
('henry.rodriguez@email.com', 159.99, 'Bluetooth earbuds', 'refunded', NOW() - INTERVAL '20 days'),
('irene.martinez@email.com', 299.99, 'Smart watch fitness', 'refunded', NOW() - INTERVAL '16 days'),
('jack.anderson@email.com', 79.99, 'Car phone mount', 'refunded', NOW() - INTERVAL '13 days'),

-- More recent transactions for testing
('lisa.thompson@email.com', 49.99, 'Subscription box monthly', 'completed', NOW() - INTERVAL '2 days'),
('mike.johnson@email.com', 199.99, 'Winter jacket waterproof', 'completed', NOW() - INTERVAL '4 days'),
('nina.white@email.com', 89.99, 'Bluetooth keyboard compact', 'completed', NOW() - INTERVAL '6 days'),
('oscar.lee@email.com', 139.99, 'Security camera wireless', 'completed', NOW() - INTERVAL '1 day'),
('paula.clark@email.com', 69.99, 'Essential oils diffuser', 'completed', NOW() - INTERVAL '7 days'),

-- Additional varied transactions
('quinn.taylor@email.com', 249.99, 'Electric toothbrush premium', 'completed', NOW() - INTERVAL '12 days'),
('ryan.moore@email.com', 179.99, 'Portable projector mini', 'completed', NOW() - INTERVAL '17 days'),
('sarah.hall@email.com', 99.99, 'Massage gun therapy', 'completed', NOW() - INTERVAL '21 days'),
('tom.allen@email.com', 329.99, 'Robot vacuum cleaner', 'completed', NOW() - INTERVAL '26 days'),
('una.young@email.com', 59.99, 'Resistance bands workout', 'completed', NOW() - INTERVAL '31 days'),

-- Software and digital products
('alice.smith@email.com', 79.99, 'Photo editing software', 'completed', NOW() - INTERVAL '8 days'),
('bob.jones@email.com', 149.99, 'Antivirus software premium', 'completed', NOW() - INTERVAL '15 days'),
('carol.wilson@email.com', 199.99, 'CAD software license', 'completed', NOW() - INTERVAL '23 days'),
('david.brown@email.com', 99.99, 'Cloud storage 2TB annual', 'completed', NOW() - INTERVAL '29 days'),

-- Fashion and accessories
('emma.davis@email.com', 129.99, 'Designer sunglasses', 'completed', NOW() - INTERVAL '11 days'),
('frank.miller@email.com', 89.99, 'Leather wallet premium', 'completed', NOW() - INTERVAL '16 days'),
('grace.garcia@email.com', 199.99, 'Winter boots waterproof', 'completed', NOW() - INTERVAL '24 days'),
('henry.rodriguez@email.com', 149.99, 'Casual dress shirt set', 'completed', NOW() - INTERVAL '28 days'),

-- Health and wellness
('irene.martinez@email.com', 79.99, 'Vitamin supplement set', 'completed', NOW() - INTERVAL '9 days'),
('jack.anderson@email.com', 259.99, 'Air quality monitor', 'completed', NOW() - INTERVAL '14 days'),
('lisa.thompson@email.com', 189.99, 'Sleep tracking device', 'completed', NOW() - INTERVAL '19 days'),
('mike.johnson@email.com', 99.99, 'Posture corrector belt', 'completed', NOW() - INTERVAL '22 days'),

-- Gaming and entertainment
('nina.white@email.com', 59.99, 'Indie game bundle', 'completed', NOW() - INTERVAL '3 days'),
('oscar.lee@email.com', 299.99, 'Gaming chair ergonomic', 'completed', NOW() - INTERVAL '18 days'),
('paula.clark@email.com', 79.99, 'Board game collection', 'completed', NOW() - INTERVAL '25 days'),
('quinn.taylor@email.com', 149.99, 'VR headset accessories', 'completed', NOW() - INTERVAL '30 days'),

-- Office and productivity
('ryan.moore@email.com', 199.99, 'Document scanner portable', 'completed', NOW() - INTERVAL '13 days'),
('sarah.hall@email.com', 129.99, 'Ergonomic office chair', 'completed', NOW() - INTERVAL '20 days'),
('tom.allen@email.com', 89.99, 'Desk pad large waterproof', 'completed', NOW() - INTERVAL '27 days'),
('una.young@email.com', 249.99, 'Sit-stand desk converter', 'completed', NOW() - INTERVAL '32 days'),

-- More customers with recent purchases
('victor.king@email.com', 169.99, 'Wireless charging pad', 'completed', NOW() - INTERVAL '5 days'),
('wendy.wright@email.com', 99.99, 'Portable hard drive 2TB', 'completed', NOW() - INTERVAL '10 days'),
('xavier.lopez@email.com', 229.99, 'Smart doorbell camera', 'completed', NOW() - INTERVAL '15 days'),
('yara.hill@email.com', 79.99, 'Bluetooth headphones sport', 'completed', NOW() - INTERVAL '20 days'),
('zoe.green@email.com', 139.99, 'Electric kettle smart', 'completed', NOW() - INTERVAL '25 days'),

-- Edge cases and test scenarios
('alice.smith@email.com', 999.99, 'High-value electronics bundle', 'completed', NOW() - INTERVAL '2 days'),
('bob.jones@email.com', 1.00, 'Minimal amount transaction', 'completed', NOW() - INTERVAL '1 day'),
('carol.wilson@email.com', 50.00, 'Exact amount test', 'completed', NOW() - INTERVAL '6 days'),
('david.brown@email.com', 100.00, 'Round number transaction', 'completed', NOW() - INTERVAL '11 days'),

-- Additional recent transactions to reach 100+
('emma.davis@email.com', 219.99, 'Smart home security kit', 'completed', NOW() - INTERVAL '4 days'),
('frank.miller@email.com', 159.99, 'Noise canceling headphones', 'completed', NOW() - INTERVAL '7 days'),
('grace.garcia@email.com', 89.99, 'Fitness tracker band', 'completed', NOW() - INTERVAL '9 days'),
('henry.rodriguez@email.com', 279.99, 'Electric scooter accessories', 'completed', NOW() - INTERVAL '12 days'),
('irene.martinez@email.com', 119.99, 'Smart water bottle', 'completed', NOW() - INTERVAL '14 days'),
('jack.anderson@email.com', 199.99, 'Portable monitor 15 inch', 'completed', NOW() - INTERVAL '16 days'),
('lisa.thompson@email.com', 69.99, 'Car dash cam', 'completed', NOW() - INTERVAL '18 days'),
('mike.johnson@email.com', 149.99, 'Smart luggage tracker', 'completed', NOW() - INTERVAL '21 days'),
('nina.white@email.com', 249.99, 'Home weather station', 'completed', NOW() - INTERVAL '23 days'),
('oscar.lee@email.com', 179.99, 'Electric bike accessories', 'completed', NOW() - INTERVAL '26 days'),
('paula.clark@email.com', 99.99, 'Smart plant care system', 'completed', NOW() - INTERVAL '28 days'),
('quinn.taylor@email.com', 329.99, 'Professional microphone set', 'completed', NOW() - INTERVAL '31 days'),
('ryan.moore@email.com', 189.99, 'Digital art tablet', 'completed', NOW() - INTERVAL '33 days'),
('sarah.hall@email.com', 259.99, 'Smart mirror fitness', 'completed', NOW() - INTERVAL '35 days'),
('tom.allen@email.com', 139.99, 'Wireless presentation remote', 'completed', NOW() - INTERVAL '37 days'),
('una.young@email.com', 299.99, 'Smart coffee maker', 'completed', NOW() - INTERVAL '39 days'),
('victor.king@email.com', 79.99, 'Phone gimbal stabilizer', 'completed', NOW() - INTERVAL '41 days'),
('wendy.wright@email.com', 219.99, 'Air fryer smart', 'completed', NOW() - INTERVAL '43 days'),
('xavier.lopez@email.com', 169.99, 'Smart light bulb starter kit', 'completed', NOW() - INTERVAL '45 days'),
('yara.hill@email.com', 399.99, 'Professional lighting kit', 'completed', NOW() - INTERVAL '47 days'),
('zoe.green@email.com', 129.99, 'Smart pet feeder', 'completed', NOW() - INTERVAL '49 days');

-- Update some refunded transactions with refund details
UPDATE transactions 
SET refund_amount = amount, refund_date = created_at + INTERVAL '5 days'
WHERE status = 'refunded'; 