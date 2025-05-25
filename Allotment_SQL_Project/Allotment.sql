
-- The following queries are for a database called Allotment 2025.
-- They will help the gardener with stock management, what plants are best to grow with their soil and fertiliser/soil management to aid better crop output.
-- Each query is noted with a description including the skills used.


CREATE DATABASE IF NOT EXISTS allotment2025;

USE allotment2025;


-- Creating Tables
-- The seeds and bulbs information are split into separate tables to aid data normalisation.
 
CREATE TABLE Seeds
(Seed_ID VARCHAR(5),
Name VARCHAR(50) UNIQUE,
Sow_Month DATE,
Sow_Depth_cm FLOAT,
Harvest_Month DATE,
Stock_Amount INT CHECK(Stock_Amount > 0),
Year_Purchased YEAR,
PRIMARY KEY (Seed_ID)
);


CREATE TABLE Bulbs
(Bulb_ID VARCHAR(5),
Name VARCHAR(50) UNIQUE,
Sow_Month DATE,
Sow_Depth_cm FLOAT,
Flower_Month DATE,
Stock_Amount INT CHECK(Stock_Amount > 0),
Year_Purchased YEAR,
PRIMARY KEY (Bulb_ID)
);


CREATE TABLE Soil_Conditions
(Soil_Type VARCHAR(20),
pH_Level FLOAT,
Additive VARCHAR(20),
PRIMARY KEY (Soil_Type)
);


CREATE TABLE Seed_Conditions
(Seed_ID VARCHAR(5),
Soil_Type VARCHAR(20),
Sun VARCHAR(20),
Fertiliser BOOLEAN NOT NULL,
Fertiliser_Type VARCHAR(20),
Water_Schedule VARCHAR(20),
FOREIGN KEY (Seed_ID) REFERENCES Seeds(Seed_ID),
FOREIGN KEY (Soil_Type) REFERENCES Soil_Conditions(Soil_Type)
);


CREATE TABLE Bulb_Conditions
(Bulb_ID VARCHAR(5),
Soil_Type VARCHAR(20),
Sun VARCHAR(20),
Fertiliser BOOLEAN NOT NULL,
Fertiliser_Type VARCHAR(20),
Water_Schedule VARCHAR(20),
FOREIGN KEY (Bulb_ID) REFERENCES Bulbs(Bulb_ID),
FOREIGN KEY (Soil_Type) REFERENCES Soil_Conditions(Soil_Type)
);




-- Inserting Values Into Tables 

INSERT INTO
Seeds
VALUES
('S1', 'Beefsteak Tomato', '25-02-01', 1.0, '25-08-31', 3, 2022),
('S2', 'Black Opal Tomato', '25-03-01', 0.5, '25-08-31', 2, 2025),
('S3', 'Basil', '25-04-01', 0.5, '25-05-31', 4.0, 2024),
('S4', 'Purple Carrot', '25-07-01', 1.0, '25-10-31', 2, 2023),
('S5', 'Gherkin Cucumber', '25-03-01', 2.5, '25-07-31', 1, 2025),
('S6', 'Red Radish', '25-04-01', 1.0, '25-05-31', 4, 2024),
('S7', 'Beetroot Boltardy', '25-07-01', 1.0, '25-07-31', 3, 2024),
('S8', 'Leek', '25-05-01', 1.0, '25-10-31', 1, NULL),
('S9', 'Curly Kale', '25-08-01', 1.5, '25-12-31', 2, 2025),
('S10', 'Brussel Sprout', '25-05-01', 2.0, '25-12-31', 3, 2023)
;

-- Ensure add the below update as the harvest date for a value was incorrect at input.
UPDATE seeds
SET 
harvest_month = '25-10-31'
WHERE Seed_ID = 'S7';


-- SELECT * FROM Seeds; -- To ensure completed correctly 


INSERT INTO
Bulbs
VALUES
('B1', 'Daffodil', '24-09-01', 8.0, '25-03-31', 4, 2023),
('B2', 'Begonia Red', '25-03-01', 5.0, '25-06-30', 1, 2022),
('B3', 'Begonia Yellow', '25-03-01', 5.0, '25-06-30', 2, 2025),
('B4', 'Dahlia Red', '25-04-01', 0.5, '25-07-31', 6, 2025),
('B5', 'Dahlia Orange', '25-04-01', 0.5, '25-07-31', 5, 2023),
('B6', 'Lilly Yellow', '24-10-01', 8.0, '25-05-31', 3, 2022),
('B7', 'Lilly Orange', '24-10-01', 8.0, '25-05-31', 4, 2022),
('B8', 'Allium Giganteum', '24-11-01', 20.0, '25-07-31', 2, 2024),
('B9', 'Anemone Blanda', '24-09-01', 6.0, '25-03-31', 5, 2023),
('B10', 'Crocus Purple', '24-09-01',15.0, '25-02-28', 1, 2024)
;

-- SELECT * FROM Bulbs; -- To ensure completed correctly 


INSERT INTO
Soil_Conditions
VALUES
('Chalk', 7.5, 'Manure'),
('Clay', 8.75, 'Compost'),
('Loam', 7.0, NULL),
('Sand', 5.25, 'Compost'),
('Silt', 6.0, 'Manure'),
('Peat', 4.5, 'Lime'),
('Columnar', 7.5, 'Compost'),
('Prismatic', 6.0, NULL)
;

-- SELECT * FROM Soil_Conditions; -- To ensure completed correctly 


INSERT INTO
Seed_Conditions
VALUES
('S1', 'Silt', 'Full', True, 'Seaweed', 'Daily'),
('S2', 'Silt', 'Full', True, 'Seaweed', 'Daily'),
('S3', 'Silt', 'Full', True, 'Nitrogen', 'Weekly'),
('S4', 'Loam', 'Full', True, 'Potassium', 'Daily'),
('S5', 'Loam', 'Mixed', True, 'Compost', 'Weekly'),
('S6', 'Chalk', 'Mixed', False, NULL, 'Bi-Weekly'),
('S7', 'Chalk', 'Full', True, 'Nitrogen', 'Weekly'),
('S8', 'Silt', 'Mixed', True, 'Phosphorus', 'Daily'),
('S9', 'Clay', 'Full', True, 'Nitrogen', 'Bi-Weekly'),
('S10', 'Columnar', 'Shade', True, 'Nitrogen', 'Weekly')
;

-- SELECT * FROM Seed_Conditions; -- To ensure completed correctly 


INSERT INTO
Bulb_Conditions
VALUES
('B1', 'Peat', 'Full', True, 'Seaweed', 'Daily'),
('B2', 'Sand', 'Full', True, 'Seaweed', 'Daily'),
('B3', 'Sand', 'Full', True, 'Nitrogen', 'Weekly'),
('B4', 'Clay', 'Full', True, 'Potassium', 'Daily'),
('B5', 'Clay', 'Mixed', True, 'Compost', 'Weekly'),
('B6', 'Prismatic', 'Mixed', False, NULL, 'Bi-Weekly'),
('B7', 'Prismatic', 'Full', True, 'Nitrogen', 'Weekly'),
('B8', 'Sand', 'Mixed', True, 'Phosphorus', 'Daily'),
('B9', 'Peat', 'Full', True, 'Nitrogen', 'Bi-Weekly'),
('B10', 'Sand', 'Shade', True, 'Nitrogen', 'Weekly')
;

-- SELECT * FROM Bulb_Conditions; -- To ensure completed correctly 




-- -- -- QUERIES -- -- --




-- QUERY 1 - Identify how many packets of seeds and bulbs the gardener has available for planting.
-- Using 1 type of aggregate function. 

SELECT 
	((SELECT SUM(s.stock_amount)
	FROM seeds AS s)
	+
	(SELECT SUM(b.stock_amount)
	FROM bulbs AS b))  AS Total_Number_Packets
FROM DUAL;




-- Query 2 - Identify what seeds and bulbs have the most stock available.
-- Using 1 aggregate function, 1 union (+ 1 view).

CREATE VIEW vw_most_seeds
AS
SELECT s.name, s.stock_amount FROM seeds AS s
UNION
SELECT b.name, b.stock_amount FROM bulbs AS b
ORDER BY stock_amount DESC;

-- SELECT * FROM vw_most_seeds; -- Can uncomment this line to ensure the VIEW is working correctly.
 
SELECT name, stock_amount
FROM vw_most_seeds
WHERE stock_amount IN (SELECT MAX(stock_amount) FROM vw_most_seeds);




-- Query 3 - Identify what seeds/bulbs will grow in clay soil.
-- Using JOIN.

(SELECT s.name, sc.soil_type
FROM seeds AS s
INNER JOIN
seed_conditions AS sc
ON s.seed_ID = sc.seed_ID
WHERE soil_type = 'clay')
UNION
(SELECT b.name, bc.soil_type
FROM bulbs AS b
INNER JOIN
bulb_conditions AS bc
ON b.bulb_ID = bc.bulb_ID
WHERE soil_type = 'clay')
ORDER BY name;




-- Query 4 - Identify whether Daffodils require a fertiliser, and what it is.
-- Using in-built (IF) function and LEFT JOIN.

SELECT b.name, IF(bc.fertiliser, 'Yes', 'No') AS require_fertiliser, bc.fertiliser_type
FROM bulb_conditions AS bc
LEFT JOIN
bulbs AS b
ON bc.bulb_ID = b.bulb_ID
WHERE b.name = 'Daffodil';




-- Query 5 - The gardener has used their last crocus bulbs so needs to delete this from the relevant tables.

-- SET FOREIGN_KEY_CHECKS=0; -- may need to uncomment and run this line in order to be able to delete row.

DELETE bc.*, b.*
FROM bulb_conditions AS bc
INNER JOIN
bulbs AS b
ON bc.bulb_id = b.bulb_id
WHERE b.name = 'Crocus Purple'
;

-- SELECT * FROM bulb_conditions AS bc; -- To check the code has been run correctly.
-- SELECT * FROM bulbs AS b;

-- SET FOREIGN_KEY_CHECKS=1; -- To enable safety key again.




-- Query 6 - Identify the current month and what seeds/bulbs should be planted.
-- Using (CURDATE) and (MONTH) functions, inside a stored procedure.
-- The stored procedure can be run on a monthly basis so the gardener always gets a current list.
-- Using month over specific dates as this is how growing guidance on seeds is provided.

DELIMITER //
CREATE PROCEDURE sow_now()
BEGIN
DECLARE name VARCHAR(50);
DECLARE sow_month VARCHAR(50);
DECLARE CURDATE DATE;
(SELECT s.name AS Sow_This_Month
FROM seeds AS s
WHERE MONTH(s.sow_month) = MONTH(CURDATE()))
UNION
(SELECT b.name AS sow_this_month
FROM bulbs AS b
WHERE MONTH(b.sow_month) = MONTH(CURDATE())
ORDER BY name);
END//
DELIMITER ;


CALL sow_now;








