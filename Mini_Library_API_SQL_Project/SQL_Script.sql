CREATE DATABASE IF NOT EXISTS audiobook_library;


USE audiobook_library;

CREATE TABLE IF NOT EXISTS audiobooks
(Book_ID INT AUTO_INCREMENT,
Name VARCHAR(100) NOT NULL,
Author VARCHAR(50) NOT NULL,
Genre VARCHAR(50),
Stock_Availability INT,
PRIMARY KEY (Book_ID));



-- Inserting Values into Tables

INSERT INTO audiobooks
(Book_ID, Name, Author, Genre, Stock_Availability)
VALUES
(1, 'Fourth Wing', 'Rebecca Yarros', 'Fantasy', 1),
(NULL, 'Deep End', 'Ali Hazelwood', 'Fiction', 0),
(NULL, 'Ahsoka', 'E.K. Johnston', 'Sci-Fi', 1),
(NULL, 'Takeaway', 'Angela Hui', NULL, 0),
(NULL, 'A Court of Thorns and Roses', 'Sarah J. Maas', 'Fantasy', 1),
(NULL, 'Timekeepers', 'Simon Garfield', NULL, 1),
(NULL, 'The Lost Bookshop', 'Evie Woods', 'Fiction', 1),
(NULL, 'Atomic Habits', 'James Clear', 'Business', 1),
(NULL, 'Rewitched', 'Lucy Jane Wood', 'Fantasy', 0),
(NULL, 'Two Can Play', 'Ali Hazelwood', 'Fiction', 0)
;


SELECT * FROM audiobooks; -- To ensure all correct









CREATE TABLE IF NOT EXISTS customers
(Customer_ID INT AUTO_INCREMENT,
Forename VARCHAR(100) NOT NULL,
Surname VARCHAR(100) NOT NULL,
Book_ID INT,
PRIMARY KEY (Customer_ID),
FOREIGN KEY (Book_ID) REFERENCES audiobooks(Book_ID));

-- Inserting Values into Tables

INSERT INTO customers
(Customer_ID, Forename, Surname, Book_ID)
VALUES
(1, 'Lola', 'Aldrette', NULL),
(NULL, 'Callum', 'Ditton', NULL),
(NULL, 'Rhys', 'Fileda', NULL),
(NULL, 'Jacques', 'Hamora', NULL),
(NULL, 'Alice', 'Little', NULL),
(NULL, 'Ibrahim', 'Kamulegeya', NULL)
;


SELECT * FROM customers;













DELIMITER //

CREATE PROCEDURE CheckoutBook(
    IN p_CustomerID INT,
    IN p_BookID INT
)
BEGIN
    DECLARE v_Stock_Availability INT;
    DECLARE v_Current_Book INT;

    -- Check if the book is in stock
    SELECT Stock_Availability INTO v_Stock_Availability 
    FROM audiobooks 
    WHERE Book_ID = p_BookID;

    -- Check if the customer has already checked out a book
    SELECT Book_ID INTO v_Current_Book
    FROM customers
    WHERE Customer_ID = p_CustomerID;

    IF v_Stock_Availability > 0 THEN
        IF v_Current_Book IS NULL THEN
            -- Deduct 1 from stock
            UPDATE audiobooks 
            SET Stock_Availability = Stock_Availability - 1 
            WHERE Book_ID = p_BookID;

            -- Assign the book to the customer
            UPDATE customers 
            SET Book_ID = p_BookID 
            WHERE Customer_ID = p_CustomerID;

            SELECT 'Book checked out successfully' AS Message;
        ELSE
            SELECT 'Customer has already checked out a book' AS Message;
        END IF;
    ELSE
        SELECT 'Book is out of stock' AS Message;
    END IF;
END //

DELIMITER ;




CALL CheckoutBook(1, 3); 