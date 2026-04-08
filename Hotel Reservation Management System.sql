-- Database Creation
CREATE DATABASE HotelReservationSystem;
USE HotelReservationSystem;


-- Droping All Tables

DROP TABLE Payments;
DROP TABLE Bookings;
DROP TABLE Rooms;
DROP TABLE Customers;


-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);

-- Rooms Table
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Available'
);

-- Bookings Table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    booking_date DATE NOT NULL,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),
    payment_status VARCHAR(20),

    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);



-- Customers Data
INSERT INTO Customers (first_name, last_name, email, phone, address) VALUES
('Rahul', 'Sharma', 'rahul.sharma@gmail.com', '9876543210', 'Delhi, India'),
('Priya', 'Verma', 'priya.verma@yahoo.com', '9123456780', 'Mumbai, India'),
('Amit', 'Singh', 'amit.singh@hotmail.com', '9988776655', 'Lucknow, India'),
('Sneha', 'Patel', 'sneha.patel@gmail.com', '9871234567', 'Ahmedabad, India'),
('Rohit', 'Gupta', 'rohit.gupta@gmail.com', '9765432109', 'Jaipur, India'),
('Anjali', 'Mehta', 'anjali.mehta@yahoo.com', '9812345678', 'Pune, India'),
('Vikram', 'Reddy', 'vikram.reddy@gmail.com', '9900112233', 'Hyderabad, India'),
('Neha', 'Kapoor', 'neha.kapoor@gmail.com', '9898989898', 'Chandigarh, India'),
('Arjun', 'Das', 'arjun.das@gmail.com', '9001122334', 'Kolkata, India'),
('Pooja', 'Nair', 'pooja.nair@yahoo.com', '9112233445', 'Kochi, India');

-- Rooms Data
INSERT INTO Rooms (room_number, room_type, price_per_night, status) VALUES
('101', 'Single', 1500.00, 'Available'),
('102', 'Double', 2500.00, 'Occupied'),
('103', 'Suite', 5000.00, 'Available'),
('104', 'Single', 1600.00, 'Available'),
('105', 'Double', 2600.00, 'Maintenance'),
('106', 'Suite', 5200.00, 'Available'),
('107', 'Single', 1400.00, 'Occupied'),
('108', 'Double', 2700.00, 'Available'),
('109', 'Suite', 5500.00, 'Occupied'),
('110', 'Single', 1550.00, 'Available');

-- Bookings Data
INSERT INTO Bookings (customer_id, room_id, check_in_date, check_out_date, booking_date, total_amount) VALUES
(1, 2, '2026-04-01', '2026-04-03', '2026-03-28', 5000.00),
(2, 3, '2026-04-02', '2026-04-05', '2026-03-30', 15000.00),
(3, 1, '2026-04-03', '2026-04-04', '2026-03-29', 1500.00),
(4, 4, '2026-04-04', '2026-04-06', '2026-03-31', 3200.00),
(5, 5, '2026-04-05', '2026-04-07', '2026-04-01', 5200.00),
(6, 6, '2026-04-06', '2026-04-09', '2026-04-02', 15600.00),
(7, 7, '2026-04-07', '2026-04-08', '2026-04-03', 1400.00),
(8, 8, '2026-04-08', '2026-04-10', '2026-04-04', 5400.00),
(9, 9, '2026-04-09', '2026-04-12', '2026-04-05', 16500.00),
(10, 10, '2026-04-10', '2026-04-11', '2026-04-06', 1550.00);

-- Payments Data
INSERT INTO Payments (booking_id, payment_date, amount, payment_method, payment_status) VALUES
(1, '2026-03-28', 5000.00, 'Credit Card', 'Completed'),
(2, '2026-03-30', 15000.00, 'Debit Card', 'Completed'),
(3, '2026-03-29', 1500.00, 'UPI', 'Completed'),
(4, '2026-03-31', 3200.00, 'Cash', 'Completed'),
(5, '2026-04-01', 5200.00, 'Net Banking', 'Pending'),
(6, '2026-04-02', 15600.00, 'Credit Card', 'Completed'),
(7, '2026-04-03', 1400.00, 'UPI', 'Completed'),
(8, '2026-04-04', 5400.00, 'Debit Card', 'Completed'),
(9, '2026-04-05', 16500.00, 'Net Banking', 'Completed'),
(10, '2026-04-06', 1550.00, 'Cash', 'Completed');


-- Select All Data from Tables
SELECT * FROM Customers;
SELECT * FROM Rooms;
SELECT * FROM Bookings;
SELECT * FROM Payments;


-- CRUD Operation
-- Insert New Customer
INSERT INTO Customers (first_name, last_name, email, phone, address)
VALUES ('Karan', 'Malhotra', 'karan.malhotra@gmail.com', '9887766554', 'Delhi, India');
SELECT * FROM Customers;

-- Update Room Status
UPDATE Rooms
SET status = 'Occupied'
WHERE room_id = 1;
select * from Rooms;

-- Delete a Customers
DELETE FROM Customers
WHERE customer_id = 11;
SELECT * FROM Customers;


-- Join Queries
-- Get Customer Booking Details with Room Info
SELECT 
    c.first_name,
    c.last_name,
    r.room_number,
    r.room_type,
    b.check_in_date,
    b.check_out_date
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Rooms r ON b.room_id = r.room_id;

-- Get Booking Details with Payment Status
SELECT 
    b.booking_id,
    c.first_name,
    r.room_number,
    p.payment_status
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Rooms r ON b.room_id = r.room_id
LEFT JOIN Payments p ON b.booking_id = p.booking_id;


-- Aggregation Queries
-- Get Total Revenue Generated
SELECT SUM(amount) AS total_revenue
FROM Payments
WHERE payment_status = 'Completed';

-- Get Number of Bookings per Room Type
SELECT 
    r.room_type,
    COUNT(b.booking_id) AS total_bookings
FROM Bookings b
JOIN Rooms r ON b.room_id = r.room_id
GROUP BY r.room_type;

-- Get Average Room Price by Type
SELECT 
    room_type,
    AVG(price_per_night) AS avg_price
FROM Rooms
GROUP BY room_type;


-- Advanced Business Logic Queries
-- Get Customers with Highest Spending
SELECT 
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM Customers c
JOIN Bookings b ON c.customer_id = b.customer_id
JOIN Payments p ON b.booking_id = p.booking_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

-- Get Most Booked Room
SELECT 
    r.room_number,
    COUNT(b.booking_id) AS total_bookings
FROM Rooms r
JOIN Bookings b ON r.room_id = b.room_id
GROUP BY r.room_id
ORDER BY total_bookings DESC
LIMIT 1;

-- Get Customers with Multiple Bookings
SELECT 
    c.first_name,
    c.last_name,
    COUNT(b.booking_id) AS booking_count
FROM Customers c
JOIN Bookings b ON c.customer_id = b.customer_id
GROUP BY c.customer_id
HAVING COUNT(b.booking_id) > 1;