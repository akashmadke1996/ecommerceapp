-- Sample seed data for testing

-- Insert sample users
INSERT INTO users (email, password, first_name, last_name, role, active) VALUES
('admin@ecommerce.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.nCvpSecGH4r8snFewB.P3K6V1TZeBUy', 'Admin', 'User', 'ADMIN', true),
('user@ecommerce.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.nCvpSecGH4r8snFewB.P3K6V1TZeBUy', 'John', 'Doe', 'USER', true),
('jane@ecommerce.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.nCvpSecGH4r8snFewB.P3K6V1TZeBUy', 'Jane', 'Smith', 'USER', true);

-- Insert sample products
INSERT INTO products (name, description, price, quantity, category, image_url) VALUES
('Laptop', 'High-performance laptop for professionals', 999.99, 10, 'Electronics','https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=600'),
('Mouse', 'Wireless mouse with ergonomic design', 29.99, 50, 'Electronics','https://images.unsplash.com/photo-1527814050087-3793815479db?w=600'),
('Keyboard', 'Mechanical keyboard with RGB lighting', 79.99, 30, 'Electronics','https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=600'),
('Monitor', '27-inch 4K monitor', 349.99, 15, 'Electronics','https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=600'),
('USB-C Cable', '6ft USB-C charging cable', 12.99, 100, 'Accessories','https://images.unsplash.com/photo-1625842268584-8f3296236761?w=600'),
('Phone Stand', 'Adjustable phone stand for desk', 19.99, 40, 'Accessories','https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=600'),
('Webcam', '1080p HD webcam with microphone', 49.99, 25, 'Electronics','https://images.unsplash.com/photo-1587826080692-f439cd0b70da?w=600'),
('Desk Lamp', 'LED desk lamp with adjustable brightness', 39.99, 35, 'Office','https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=600');
-- Insert sample orders
INSERT INTO orders (user_id, total_amount, status) VALUES
(2, 1059.97, 'DELIVERED'),
(3, 79.99, 'CONFIRMED');

-- Insert sample order items
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 999.99),
(1, 5, 1, 12.99),
(1, 6, 1, 46.99),
(2, 3, 1, 79.99);
