CREATE DATABASE EDU;

CREATE TABLE eevent(
eventId INT,
eventTitle VARCHAR(100) unique,
eventDate DATE NOT NULL,
country VARCHAR(100) NOT NULL,
city VARCHAR(100) NOT NULL,
address VARCHAR(100) NOT NULL,
CONSTRAINT event_pk PRIMARY KEY(eventID)
);

CREATE TABLE employee(
employeeId INT,
Fname VARCHAR(20) NOT NULL,
Mname VARCHAR(20),
Lname VARCHAR(20) NOT NULL,
CONSTRAINT employee_pk PRIMARY KEY(employeeId)
);

CREATE TABLE employeeEmail(
employeeId INT,
email VARCHAR(100),
CONSTRAINT employeeEmail_pk PRIMARY KEY(employeeId, email),
CONSTRAINT employeeEmail_fk FOREIGN KEY(employeeId) REFERENCES employee(employeeId) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE employeePhone(
employeeId INT,
phone INT,
CONSTRAINT employeePhone_pk PRIMARY KEY(employeeId, phone),
CONSTRAINT employeePhone_fk FOREIGN KEY(employeeId) REFERENCES employee(employeeId) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE eventEmployee(
eventId int,
employeeId int,
CONSTRAINT eventEmployee_pk PRIMARY KEY(eventId, employeeId),
CONSTRAINT eventEmployee_event_fk FOREIGN KEY(eventId) REFERENCES eevent(eventId) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT eventEmployee_employee_fk FOREIGN KEY(employeeId) REFERENCES employee(employeeId) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE donor(
donorId INT,
employeeId INT,
Fname varchar(20) NOT NULL,
Mname VARCHAR(20),
Lname VARCHAR(20) NOT NULL,
OrganizationName VARCHAR(50),
CONSTRAINT donor_pk PRIMARY KEY(donorId),
CONSTRAINT donor_fk FOREIGN KEY(employeeId) REFERENCES employee(employeeId) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE donorEvent(
eventId INT,
donorId INT,
CONSTRAINT donorEvent_pk PRIMARY KEY(eventID, donorID),
CONSTRAINT donorEvent_event_fk FOREIGN KEY(eventId) REFERENCES eevent(eventId) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT donorEvent_donor_fk FOREIGN KEY(donorId) REFERENCES donor(donorId) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE donorEmail(
donorId INT,
email VARCHAR(100),
CONSTRAINT donorEmail_pk PRIMARY KEY(donorId, email),
CONSTRAINT donorEmail_fk FOREIGN KEY(donorId) REFERENCES donor(donorId) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE donation(
donationId INT,
donorId INT,
fundCost INT NOT NULL,
currency VARCHAR(25) NOT NULL default('USD'),
CONSTRAINT donation_pk PRIMARY KEY(donationId),
CONSTRAINT donation_fk FOREIGN KEY(donorId) REFERENCES donor(donorId) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE student(
studentId INT,
employeeId INT,
Fname VARCHAR(20) NOT NULL,
Mname VARCHAR(20),
Lname VARCHAR(20) NOT NULL,
age INT CHECK(age > 0),
gender ENUM('M','F'),
CONSTRAINT student_pk PRIMARY KEY(studentId),
CONSTRAINT student_fk FOREIGN KEY(employeeId) REFERENCES employee(employeeId) ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO eevent (eventId, eventTitle, eventDate, country, city, address)
VALUES 
(1, 'Charity Run', '2025-02-20', 'USA', 'New York', 'Central Park'),
(2, 'Charity donation', '2025-03-15', 'Canada', 'Toronto', 'Community Hall'),
(3, 'donation world', '2025-03-25', 'Jordan', 'Amman', 'Alnoyayry'),
(4, 'donations', '2025-07-12', 'Jordan', 'Irbid', 'Rainbow St.');

INSERT INTO employee (employeeId, Fname, Mname, Lname)
VALUES 
(1, 'John', 'Moe', 'Doe'),
(2, 'Jane', NULL, 'Smith'),
(3, 'Mark', 'rashed', 'Ahmad'),
(4, 'Mohammad', 'Fathi', 'Dghimat');

INSERT INTO employeeEmail (employeeId, email)
VALUES 
(1, 'john.doe@gmail.com'),
(2, 'jane.smith@gmail.com'),
(3, 'Mark.Ahmad@gmail.com'),
(4, 'Mohammad.Dghimat@gmail.com'),
(4, 'Mohammad.Fathi@gmail.com');

INSERT INTO employeePhone (employeeId, phone)
VALUES 
(1, 0798712509),
(2, 0782359104),
(2, 0782334578),
(3, 0779267584),
(4, 0798355281);

INSERT INTO donor (donorId, employeeId, Fname, Mname, Lname, OrganizationName)
VALUES 
(1, 1, 'Alice', 'B.', 'Brown', 'facebook'),
(2, 2, 'Bob', NULL, 'Johnson', NULL),
(3, 4, 'Rami', 'mohammad', 'Salem', 'cisco'),
(4, 3, 'Sara', 'John', 'Johnson', 'google');

INSERT INTO donorEmail (donorId, email)
VALUES 
(1, 'alice.brown@gmail.com'),
(2, 'bob.johnson@gmail.com'),
(3, 'Rami.mohammad@gmail.com'),
(4, 'Sara.Johnson@gmail.com'),
(1, 'Alice.B@gmail.com');

INSERT INTO donorEvent (eventId, donorId)
VALUES 
(1, 1),
(2, 2),
(2, 3),
(3, 2),
(4, 2),
(4, 3),
(4, 4);

INSERT INTO donation (donationId, donorId, fundCost, currency)
VALUES 
(1, 1, 1000, 'USD'),
(2, 2, 500, 'JOD'),
(3, 3, 2000, 'USD'),
(4, 4, 700, 'JOD'),
(5, 4, 25000, 'JOD'),
(6, 2, 7000, 'USD'),
(7, 1, 15000, 'EUR'),
(8, 1, 30000, 'JOD'),
(9, 3, 26000, 'USD'),
(10, 4, 1000000, 'EUR');

INSERT INTO student (studentId, employeeId, Fname, Mname, Lname, age, gender)
VALUES 
(1, 1, 'Chris', 'C.', 'Evans', 21, 'M'),
(2, 2, 'Emma', NULL, 'Watson', 18, 'F'),
(3, 3, 'Mohammad', 'mark', 'mishington', 17, 'M'),
(4, 3, 'vito', 'moe', 'corllion', 23, 'M'),
(5, 4, 'Sara', 'Walter', 'White', 19, 'F');

CREATE VIEW donationDetails AS 
SELECT donorId,
SUM(fundCost) AS SumOfDonations,
AVG(fundCost) As AvgOfDonations,
MIN(fundCost) AS MinimumDonation,
MAX(fundCost) AS MaximumDonation,
COUNT(fundCost) AS CountDonations
FROM donation
GROUP BY donorId
ORDER BY donorId ASC;

CREATE VIEW donationDonorsDetails AS
SELECT donor.donorId,
concat(donor.Fname, ' ', donor.Lname) AS donorName,
donor.OrganizationName,
donation.donationId,
donation.fundCost
FROM donor
LEFT JOIN donation ON
donor.donorId = donation.donorId
UNION
SELECT donor.donorId,
concat(donor.Fname, ' ', donor.Lname) AS donorName,
donor.OrganizationName,
donation.donationId,
donation.fundCost
FROM donor
RIGHT JOIN donation ON
donor.donorId = donation.donorId;

CREATE VIEW donorEmpDetails AS 
SELECT 
employee.employeeId,
concat(employee.Fname, ' ', employee.Lname) AS employeeName,
donor.donorId,
concat(donor.Fname, ' ', donor.Lname) AS donorName,
donor.OrganizationName
FROM employee
INNER JOIN donor ON
employee.employeeId = donor.employeeId;

CREATE VIEW eventDonor AS 
SELECT eevent.*, donorevent.donorId
FROM eevent
INNER JOIN donorevent ON
eevent.eventId = donorevent.eventId;

DELIMITER //
CREATE PROCEDURE employeeInfoByName(IN FirstName VARCHAR(20), IN LastName VARCHAR(20))
BEGIN
SELECT * FROM employee
WHERE Fname = FirstName
AND Lname = LastName;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE studentsByAge(IN ageTw int)
BEGIN
SELECT * FROM student
WHERE age >= ageTw;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insertinEvent(IN evId int, IN evTitle VARCHAR(100), 
                                IN evdate date, IN evCountry VARCHAR(100),
                                IN evCity VARCHAR(100), IN evAdd VARCHAR(100))
BEGIN
INSERT INTO eevent(eventId, eventTitle, eventDate, country, city, address)
VALUES (evId, evTitle, evdate, evCountry, evCity, evAdd);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE getDonorByName(IN FirstName VARCHAR(20), IN LastName VARCHAR(20))
BEGIN
SELECT * FROM donor
WHERE Fname = FirstName 
AND Lname = LastName;
END //
DELIMITER ;

CREATE USER emp IDENTIFIED BY '123';
GRANT SELECT, INSERT, UPDATE, DELETE ON student TO emp;
GRANT SELECT ON donation TO emp;
GRANT SELECT, INSERT, UPDATE, DELETE ON eevent TO emp;
GRANT SELECT ON donorEvent To emp;
GRANT SELECT, INSERT, UPDATE, DELETE ON donor To emp;
GRANT SELECT, INSERT, UPDATE, DELETE ON donorEmail To emp;
GRANT SELECT ON eventEmployee TO emp;
GRANT SELECT ON donationDetails TO emp;
GRANT SELECT ON donationDonorsDetails TO emp;
GRANT SELECT ON donorEmpDetails TO emp;
GRANT SELECT ON eventDonor TO emp;
GRANT EXECUTE ON PROCEDURE employeeInfoByName TO emp;
GRANT EXECUTE ON PROCEDURE studentsByAge TO emp;
GRANT EXECUTE ON PROCEDURE insertinEvent TO emp;
GRANT EXECUTE ON PROCEDURE getDonorByName TO emp;

CREATE USER donor_1 IDENTIFIED BY '321';
GRANT SELECT, INSERT ON donation TO donor_1;
GRANT SELECT ON eevent TO donor_1;
GRANT SELECT ON eventDonor TO donor_1;
GRANT EXECUTE ON PROCEDURE getDonorByName TO donor_1;

SELECT * FROM mysql.user;
SHOW GRANTS FOR emp;
SHOW GRANTS FOR donor_1;