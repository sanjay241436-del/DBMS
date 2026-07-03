create database students;

use students;
-- Create Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

-- Create Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credit_hour INT
);

-- Create Enrollment Table
CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY,
    course_id INT,
    student_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);
-- Insert Data into Students
INSERT INTO Students (student_id, name, age, email, phone_number) VALUES
(1, 'Alice Smith', 20, 'alice@example.com', '555-0101'),
(2, 'Bob Johnson', 22, 'bob@example.com', '555-0102'),
(3, 'Charlie Brown', 19, 'charlie@example.com', '555-0103'),
(4, 'Diana Prince', 21, 'diana@example.com', '555-0104'),
(5, 'Evan Wright', 23, 'evan@example.com', '555-0105');

-- Insert Data into Courses
INSERT INTO courses (course_id, name, credit_hour) VALUES
(101, 'Introduction to Computer Science', 3),
(102, 'Data Structures', 4),
(103, 'Database Management Systems', 3),
(104, 'Web Development', 3),
(105, 'Artificial Intelligence', 4);

-- Insert Data into Enrollment
INSERT INTO enrollment (enrollment_id, course_id, student_id) VALUES
(1001, 101, 1),
(1002, 103, 1),
(1003, 102, 2),
(1004, 104, 2),
(1005, 101, 3),
(1006, 105, 4),
(1007, 103, 5),
(1008, 105, 5),
(1009, 102, 1);

SELECT *FROM students

--List only the name and email of all students.
SELECT name,email
FROM students

--Find all students who are strictly older than 20 years.
SELECT *FROM students
WHERE age>20;

--Retrieve the names of students whose name starts with the letter 'A' (Use the LIKE operator).
SELECT name 
FROM students
WHERE name LIKE 'A%';

--Find all courses that have the word 'Science' anywhere in their name.
SELECT name 
FROM courses
WHERE name LIKE '%science%';

--List all students sorted by their age in descending order.
SELECT *FROM students
ORDER BY age DESC;

--Retrieve the details of the student with the exact phone number '555-0103'.
SELECT *FROM students
WHERE phone_number ='555-0103';

        --CRUD Operations

--Part 1: ALTER (Modifying Table Structures)
--These questions practice changing the structure of your existing tables.
 

--1.Add a Column: Write a query to add a new column named address (VARCHAR 255) to the Students table.
ALTER TABLE students
ADD address VARCHAR(255)

SELECT *FROM students

--2.Add a Column with Default: Add a new column called is_active (BOOLEAN) to the Students table and set its default value to TRUE (or 1).

ALTER Table students
ADD is_active BOOLEAN DEFAULT true;

SELECT *FROM students

--3.Modify a Column Data Type: The phone_number column in the Students table is currently VARCHAR(20). Write a query to increase its size to VARCHAR(50).
ALTER TABLE students
MODIFY COLUMN phone_number VARCHAR(60);

SELECT *FROM students

--4.Rename a Column: Write a query to rename the column name in the courses table to course_name.
ALTER TABLE courses
CHANGE name course_name VARCHAR(255);

--5.Drop a Column: Write a query to completely remove the age column from the Students table.
 ALTER TABLE students
 DROP COLUMN age;

 --6.Add a Constraint: Write a query to ensure that the credit_hour in the courses table can never be less than 1 (Add a CHECK constraint).

 ALTER TABLE courses
 ADD Constraint chk_credit_hour
 CHECK (credit_hour >= 1);


--Part 2: UPDATE (Modifying Existing Data)
--These questions practice changing the actual data stored inside your tables.

--7.Simple Update: Alice Smith (student_id = 1) got a new phone number. Write a query to update her phone_number to '555-9999'.
UPDATE Students
SET phone_number = '555-9999'
WHERE student_id = 1;

SELECT *FROM students

--8.Update Multiple Columns: Bob Johnson (student_id = 2) had a birthday and changed his email. Update his age to 23 and his email to 'bob.j@newemail.com' in a single query.
 UPDATE Students
SET phone_number='555-01112',
 email='bob.j@newemail.com'
 WHERE student_id =2;

 SELECT *FROM students

--9.Conditional Update (Math): The university decided to increase the credit hours for all 3-credit courses. Write a query to add 1 to the credit_hour of any course currently worth exactly 3 credits.
UPDATE courses
SET credit_hour = credit_hour + 1
WHERE credit_hour = 3;

SELECT *FROM courses

--10.Bulk Update with String Function: Write a query to convert all student emails in the Students table to completely lowercase (using the LOWER() function).
UPDATE students
SET email=LOWER(email);

SELECT *FROM students

--11.Update with a Subquery (Advanced): Write a query to update the credit_hour of 'Data Structures' to 5, but only look it up using the course's name, not its course_id.

UPDATE courses
SET credit_hour = 5
WHERE course_name = 'Data Structures';

SELECT *FROM courses


--some other question in day 4 file
