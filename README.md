# Donor and Event Management Database
In my project, I designed and implemented a relational database using MySQL for managing donors, donations, employees, students, and events. The database stores information about these different entities and their relationships, allowing employees and donors to be connected with events and donations while maintaining the relationships between the different tables.

## Database Design
In this project, I created several tables to organise the information, including employee, employeeEmail, employeePhone, donor, donorEmail, donation, student, event, eventEmployee, and donorEvent. I used primary keys to uniquely identify records and foreign keys to establish relationships between the tables.

Another thing I implemented is different constraints to maintain data integrity, such as NOT NULL, UNIQUE, CHECK, and DEFAULT constraints. I also used ON UPDATE CASCADE and different ON DELETE actions such as CASCADE and SET NULL to control what happens to related records when an existing record is updated or deleted.

## Views
I created several views to retrieve information from multiple tables and perform calculations without having to write the same queries repeatedly. For example, the donationDetails view calculates the total, average, minimum, and maximum donation amount for each donor, as well as the number of donations.

Another view I created is donationDonorsDetails, which combines donor information with their donation records using joins. I also created donorEmpDetails to display the relationship between donors and employees, and eventDonor to retrieve events together with their associated donors.

## Stored Procedures
In this project, I implemented stored procedures to perform different database operations. For example, employeeInfoByName retrieves employee information based on their first and last names, while studentsByAge retrieves students whose age is greater than or equal to a specified value.

I also implemented insertinEvent to insert new events into the database and getDonorByName to retrieve donor information based on their names.

## Database Users and Permissions
Another part of my project was implementing database users and managing their permissions using CREATE USER and GRANT statements. I created two different users, emp and donor_1, and assigned different privileges to each one depending on the operations they are allowed to perform.

For example, the emp user has permissions to perform operations such as SELECT, INSERT, UPDATE, and DELETE on selected tables, while donor_1 has more limited permissions. I also used SHOW GRANTS to check the permissions assigned to each user.

## Project Documentation

I have also included a PDF containing a trimmed version of my original university project report. I removed unnecessary assignment material while keeping the main technical documentation.

## Technologies Used
- MySQL
- SQL

## Project Information
- **Type:** Academic Project
- **Course:** Database Design & Development
- **Semester:** Fall 2024/2025
