
DROP TABLE IF EXISTS ServiceRecords;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Salespersons;
DROP TABLE IF EXISTS Cars;
DROP TABLE IF EXISTS Customers;

-- 1) Create tables
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(50),
    State VARCHAR(50),
    JoinDate DATE
);

CREATE TABLE Cars (
    CarID SERIAL PRIMARY KEY,
    Model VARCHAR(100) NOT NULL,
    Brand VARCHAR(50) NOT NULL,
    Year INT,
    Price NUMERIC(12,2),
    Color VARCHAR(30),
    InventoryCount INT
);

CREATE TABLE Salespersons (
    SalespersonID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50),
    HireDate DATE
);

CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    CarID INT REFERENCES Cars(CarID),
    SaleDate DATE,
    SalePrice NUMERIC(12,2),
    SalespersonID INT REFERENCES Salespersons(SalespersonID)
);

CREATE TABLE ServiceRecords (
    RecordID SERIAL PRIMARY KEY,
    CarID INT REFERENCES Cars(CarID),
    ServiceDate DATE,
    ServiceType VARCHAR(50),
    Cost NUMERIC(10,2),
    TechnicianID INT
);

-- 2) Insert sample Customers
INSERT INTO Customers (CustomerID, CustomerName, City, State, JoinDate) VALUES
(1,'Ali Khan','Karachi','Sindh','2022-01-10'),
(2,'Sara Ahmed','Lahore','Punjab','2022-02-20'),
(3,'Usman Malik','Islamabad','ICT','2022-03-15'),
(4,'Aisha Siddiq','Multan','Punjab','2022-04-10'),
(5,'Bilal Qureshi','Faisalabad','Punjab','2022-05-05'),
(6,'Fatima Noor','Peshawar','KPK','2022-06-12'),
(7,'Omar Farooq','Quetta','Balochistan','2022-07-22'),
(8,'Hina Raza','Sukkur','Sindh','2022-08-01'),
(9,'Kamran Ali','Hyderabad','Sindh','2022-09-11'),
(10,'Nadia Khan','Gujranwala','Punjab','2022-10-02');

-- 3) Insert sample Cars
-- Note: Toyota has 6 models (to demonstrate "brands with >5 models")
INSERT INTO Cars (CarID, Model, Brand, Year, Price, Color, InventoryCount) VALUES
(1,'Corolla','Toyota',2021,25000.00,'Red',50),
(2,'Camry','Toyota',2022,30000.00,'White',20),
(3,'Prius','Toyota',2020,22000.00,'Silver',15),
(4,'RAV4','Toyota',2023,28000.00,'Blue',18),
(5,'Highlander','Toyota',2021,35000.00,'Black',8),
(6,'Yaris','Toyota',2019,18000.00,'Green',12),
(7,'Civic','Honda',2022,24000.00,'White',20),
(8,'Accord','Honda',2021,27000.00,'Black',10),
(9,'Mustang','Ford',2020,55000.00,'Yellow',5),
(10,'Focus','Ford',2018,19000.00,'Grey',7),
(11,'Model S','Tesla',2023,90000.00,'Red',3),
(12,'3 Series','BMW',2021,45000.00,'Blue',2),
(13,'A4','Audi',2020,42000.00,'Black',3),
(14,'Explorer','Ford',2022,36000.00,'White',4),
(15,'Rogue','Nissan',2021,26000.00,'Silver',9);

-- 4) Insert sample Salespersons
INSERT INTO Salespersons (SalespersonID, Name, Department, HireDate) VALUES
(1,'Ahmed Ali','Sales','2020-05-10'),
(2,'Zara Khan','Sales','2021-07-01'),
(3,'Bilal Ahmed','Sales','2019-11-20'),
(4,'Sana Iqbal','Sales','2022-02-15');

-- 5) Insert sample Sales
-- We'll create many sales in June 2023 (so a month can have >20 sales) and multiple sales for Corolla (CarID = 1)
INSERT INTO Sales (SaleID, CustomerID, CarID, SaleDate, SalePrice, SalespersonID) VALUES
-- 12 Corolla sales (June 2023)
(1,1,1,'2023-06-01',25500.00,1),
(2,2,1,'2023-06-01',25200.00,1),
(3,3,1,'2023-06-02',25000.00,2),
(4,4,1,'2023-06-03',25800.00,2),
(5,5,1,'2023-06-04',25150.00,1),
(6,6,1,'2023-06-05',25300.00,1),
(7,7,1,'2023-06-06',25050.00,2),
(8,8,1,'2023-06-07',25400.00,1),
(9,9,1,'2023-06-08',25600.00,2),
(10,10,1,'2023-06-09',25700.00,1),
(11,1,1,'2023-06-10',25550.00,2),
(12,2,1,'2023-06-11',25900.00,1),

-- Additional June 2023 sales (to reach >20 in June)
(13,3,7,'2023-06-12',24000.00,2),   -- Civic
(14,4,2,'2023-06-12',29800.00,1),   -- Camry
(15,5,3,'2023-06-13',21900.00,1),   -- Prius
(16,6,9,'2023-06-13',54000.00,3),   -- Mustang (expensive, sold by SP3)
(17,7,11,'2023-06-14',92000.00,3),  -- Model S (expensive, SP3)
(18,8,12,'2023-06-14',44500.00,3),  -- 3 Series (SP3)
(19,9,13,'2023-06-15',41500.00,2),  -- A4
(20,10,14,'2023-06-15',35500.00,2), -- Explorer
(21,1,15,'2023-06-16',25900.00,1),
(22,2,8,'2023-06-16',26900.00,2),

-- A couple of sales in other months (to have earliest/latest variety)
(23,3,5,'2023-05-10',34500.00,1),
(24,4,4,'2023-07-20',27900.00,2);

-- 6) Insert sample ServiceRecords
INSERT INTO ServiceRecords (RecordID, CarID, ServiceDate, ServiceType, Cost, TechnicianID) VALUES
(1,1,'2023-06-20','Oil Change',120.00,201),
(2,2,'2023-06-21','Engine Repair',1500.00,202),
(3,3,'2023-06-22','Battery Replacement',700.00,203),
(4,7,'2023-06-23','Tire Replacement',400.00,204),
(5,9,'2023-06-24','Engine Repair',1800.00,202),
(6,11,'2023-06-25','Battery Replacement',800.00,203),
(7,12,'2023-06-26','Oil Change',110.00,201),
(8,15,'2023-06-27','Transmission Repair',2500.00,205),
(9,1,'2023-06-28','Oil Change',130.00,201),
(10,4,'2023-06-29','Engine Tuning',600.00,206);

-- 7) Reset serial sequences so future INSERTs without IDs work correctly
SELECT setval(pg_get_serial_sequence('Customers','CustomerID'), COALESCE((SELECT MAX(CustomerID) FROM Customers), 1));
SELECT setval(pg_get_serial_sequence('Cars','CarID'), COALESCE((SELECT MAX(CarID) FROM Cars), 1));
SELECT setval(pg_get_serial_sequence('Salespersons','SalespersonID'), COALESCE((SELECT MAX(SalespersonID) FROM Salespersons), 1));
SELECT setval(pg_get_serial_sequence('Sales','SaleID'), COALESCE((SELECT MAX(SaleID) FROM Sales), 1));
SELECT setval(pg_get_serial_sequence('ServiceRecords','RecordID'), COALESCE((SELECT MAX(RecordID) FROM ServiceRecords), 1));

-- ============================
-- PART 1: Basic Aggregate Functions
-- ============================

-- 1. Find the total number of customers in the database.
SELECT COUNT(*) AS total_customers FROM Customers;

-- 2. Calculate the average sale price of all car sales.
SELECT ROUND(AVG(SalePrice),2) AS avg_sale_price FROM Sales;

-- 3. Find the most expensive car ever sold.
SELECT MAX(SalePrice) AS most_expensive_sale FROM Sales;

-- 4. Determine the total inventory count of all cars in the showroom.
SELECT SUM(InventoryCount) AS total_inventory FROM Cars;

-- 5. Find the earliest and most recent sale dates.
SELECT MIN(SaleDate) AS earliest_sale, MAX(SaleDate) AS latest_sale FROM Sales;

-- ============================
-- PART 2: GROUP BY Exercises
-- ============================

-- 1. Group cars by brand and count how many models each brand has.
SELECT Brand, COUNT(DISTINCT Model) AS model_count
FROM Cars
GROUP BY Brand
ORDER BY model_count DESC;

-- 2. Calculate the total sales amount for each salesperson.
SELECT sp.SalespersonID, sp.Name, COALESCE(SUM(s.SalePrice),0) AS total_sales
FROM Salespersons sp
LEFT JOIN Sales s ON sp.SalespersonID = s.SalespersonID
GROUP BY sp.SalespersonID, sp.Name
ORDER BY total_sales DESC;

-- 3. Find the average sale price for each car model.
SELECT c.Model, ROUND(AVG(s.SalePrice),2) AS avg_sale_price
FROM Sales s
JOIN Cars c ON s.CarID = c.CarID
GROUP BY c.Model
ORDER BY avg_sale_price DESC;

-- 4. For each service type, find the average service cost.
SELECT ServiceType, ROUND(AVG(Cost),2) AS avg_cost
FROM ServiceRecords
GROUP BY ServiceType
ORDER BY avg_cost DESC;

-- 5. Find the count of cars by brand and color combination from the cars table.
SELECT Brand, Color, COUNT(*) AS count_by_brand_color
FROM Cars
GROUP BY Brand, Color
ORDER BY Brand, Color;

-- ============================
-- PART 3: HAVING Clause Exercises
-- ============================

-- 1. Identify brands that offer more than five different car models.
SELECT Brand, COUNT(DISTINCT Model) AS model_count
FROM Cars
GROUP BY Brand
HAVING COUNT(DISTINCT Model) > 5;

-- 2. List car models that have been sold more than 10 times.
SELECT c.Model, COUNT(s.SaleID) AS times_sold
FROM Sales s
JOIN Cars c ON s.CarID = c.CarID
GROUP BY c.Model
HAVING COUNT(s.SaleID) > 10
ORDER BY times_sold DESC;

-- 3. Find salespersons whose average sale price is greater than 50,000.
SELECT sp.SalespersonID, sp.Name, ROUND(AVG(s.SalePrice),2) AS avg_sale
FROM Salespersons sp
JOIN Sales s ON sp.SalespersonID = s.SalespersonID
GROUP BY sp.SalespersonID, sp.Name
HAVING AVG(s.SalePrice) > 50000
ORDER BY avg_sale DESC;

-- 4. Identify months that had more than 20 sales.
-- We use YYYY-MM format grouping to count per month
SELECT TO_CHAR(SaleDate, 'YYYY-MM') AS sale_month, COUNT(*) AS sales_count
FROM Sales
GROUP BY sale_month
HAVING COUNT(*) > 20
ORDER BY sale_month;

-- 5. Find service types where the average cost is greater than 500.
SELECT ServiceType, ROUND(AVG(Cost),2) AS avg_cost
FROM ServiceRecords
GROUP BY ServiceType
HAVING AVG(Cost) > 500
ORDER BY avg_cost DESC;

