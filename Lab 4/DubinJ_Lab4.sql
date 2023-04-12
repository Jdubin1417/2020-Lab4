/* 
Programmer's Name: Justin Dubin
Course: CSCI 2020 Section Number: 940 
Creation Date: 02/03/2022 Date of Last Modification: 02/17/2022
E-mail Address: dubinj@etsu.edu 
Purpose - 
Lab 4 – SELECT & Other DML 
Identifier dictionary - 
Not Applicable 
 
Notes and Assumptions ? 
*/
-----------------------------------------------------------------
-- A1. List of all Collie dogs
SELECT name, color, breed, listprice
FROM petstore.animal
WHERE breed LIKE '%Collie';

-- A2. Number of animals in each category
SELECT category, COUNT (*) "count"
FROM petstore.animal
GROUP BY category
ORDER BY "count" DESC;

-- A3. Customers phone numbers with area code 502
SELECT *
FROM petstore.CUSTOMER
WHERE phone LIKE '(502)%';

-- A4. Average sale price per item sold
SELECT description, AVG (s.saleprice) "Average Sale Price"
FROM petstore.merchandise m
INNER JOIN petstore.saleitem s
ON m.itemid = s.itemid 
GROUP BY description
HAVING AVG (s.saleprice) > 10
ORDER BY "Average Sale Price" DESC;

-- A5. Total number of items ordered from suppliers
SELECT description "Item Name", COUNT (*) "Number of Orders", SUM (quantity) "Total Quantity of Item Ordered"
FROM petstore.merchandise m
INNER JOIN petstore.orderitem o
ON m.itemid = o.itemid
GROUP BY description
ORDER BY "Total Quantity of Item Ordered" DESC;

-- A6. Most popular breed of animals
SELECT a.category, a.breed, COUNT (s.ANIMALID) "Number of Breed Sold"
FROM petstore.animal a
INNER JOIN petstore.saleanimal s
ON a.animalid = s.animalid
GROUP BY a.category, a.breed
ORDER BY "Number of Breed Sold" DESC;

-- A7. Employee’s full address
SELECT e.lastname "Employee Last Name", e.address || ', ' || c.city || ', ' || c.state || ' ' ||e.zipcode "Full Address"
FROM petstore.employee e
INNER JOIN petstore.city c
ON e.cityid = c.cityid
GROUP BY e.lastname, e.address || ', ' || c.city || ', ' || c.state || ' ' ||e.zipcode;

-- A8. New email IDs for employees
SELECT lastname "Employee Last Name", firstname "Employee First Name", LOWER(SUBSTR(firstname, 1, 1) || lastname || '@pethaven.com') "New Email ID"
FROM petstore.employee;

-- A9. Average time taken for animal orders by suppliers
SELECT s.name, AVG(a.RECEIVEDATE - a.ORDERDATE) 
FROM petstore.supplier s
INNER JOIN petstore.animalorder a
ON s.supplierid = a.supplierid 
group by s.name;

-- A10. Animal list price greater than max purchase cost
SELECT a.category, a.breed, a.listprice 
FROM petstore.animal a
WHERE a.listprice > 
 (SELECT MAX(cost) 
 FROM petstore.animalorderitem)
 ORDER BY listprice ASC;
 
-- B1. New customer added to database
INSERT INTO customer
VALUES ('101', '(123) 456-7890', 'Justin', 'Dubin', '1276 Gilbreath Dr', '37614', '9999');

-- B2. New animal added to database
INSERT INTO animal (animalid, name, breed, dateborn, gender, color, listprice)
VALUES (202, 'Pickles', 'Scottish Fold', '03-MAR-20', 'Male', 'Gray', '112.5');

-- B3. New merchandise order added to database
INSERT INTO merchandiseorder (ponumber, orderdate, receivedate, supplierid, employeeid)
VALUES (26, '02-FEB-22', '10-FEB-22', '14', '3');

-- B4. Updates to list prices for merchandise
UPDATE MERCHANDISE
SET listprice = 8.5
WHERE description = 'Dog Food-Dry-10 pound';

UPDATE MERCHANDISE
SET listprice = 10
WHERE description = 'Cat Litter-10 pound';

-- B5. Delete Shark from the database
DELETE FROM animalorderitem
WHERE animalid = '5';
-- Seperate Query
DELETE FROM saleanimal
WHERE animalid = '5';
-- Seperate Query
DELETE FROM animal
WHERE animalid = '5';