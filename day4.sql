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
CREATE TABLE coursess (
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


               --Part 3: DELETE (Removing Data)
---These questions practice safely (and sometimes dangerously!) removing records.
-- 12.Simple Delete: Write a query to delete the student named 'Evan Wright' from the Students table. 
--(Thought exercise: What error might you encounter if he is in the enrollment table, and how would you fix it?)
DELETE FROM Enrollment
WHERE student_id = 5;

SELECT *FROM enrollment;

DELETE FROM Students
WHERE student_id = 5;
SELECT *FROM students;

--13.Delete with Condition: Write a query to delete any course from the courses table that has fewer than 3 credit_hours.

DELETE FROM Courses
WHERE credit_hour < 3;

SELECT *FROM courses;

--14.Delete Related Records (Handling Foreign Keys): Charlie Brown (student_id = 3) is dropping out of the university. 
--Write the necessary queries to first remove his enrollments from the enrollment table, and then delete his record from the Students table.

DELETE FROM Enrollment
WHERE student_id = 3;

SELECT *FROM enrollment;

DELETE FROM Students
WHERE student_id = 3;

SELECT *FROM students;

--15.Clear a Table Write a query to delete all records from the enrollment table without deleting the table structure itself.

DELETE FROM Enrollment;

SELECT *FROM enrollment

        --Aggregate Functions
--8.Count the total number of students currently in the database
SELECT COUNT(*) AS total_students
FROM Students;

--9.Calculate the average age of all students.
SELECT AVG(age) AS average_age
FROM Students;

--10.Find the maximum credit hours offered by any single course.
SELECT MAX(credit_hour) AS max_credit_hour
FROM courses;

--11.Find the age of the youngest student in the database.
SELECT MIN(age) AS youngest_age
FROM Students;

--12.Calculate the total sum of credit hours for all available courses combined.
SELECT SUM(credit_hour) AS total_credit_hours
FROM courses;
     

     --Grouping Data
--13.Count how many students are enrolled in each course. Display the course_id and the total count.
SELECT course_id, COUNT(student_id) AS total_students
FROM enrollment
GROUP BY course_id;

--14.Find the total number of courses each student is enrolled in. Display the student_id and the enrollment count.
SELECT student_id, COUNT(course_id) AS enrollment_count
FROM enrollment
GROUP BY student_id;

--15.List the course_ids of courses that have more than 2 students enrolled (Use HAVING).
SELECT course_id, COUNT(student_id) AS total_students
FROM enrollment
GROUP BY course_id
HAVING COUNT(student_id) > 2;

---16.Find the student_ids of students who are enrolled in exactly 2 courses.
SELECT student_id
FROM enrollment
GROUP BY student_id
HAVING COUNT(course_id) = 2;


      --Table Relations and Joins

--17.Write a query to display the name of each student alongside the course_ids they are enrolled in.
SELECT s.name, e.course_id
FROM Students s
JOIN enrollment e
ON s.student_id = e.student_id;

--18.Retrieve the names of students and the names of the courses they are enrolled in
SELECT s.name AS student_name,
       c.name AS course_name
FROM Students s
JOIN enrollment e
    ON s.student_id = e.student_id
JOIN courses c
    ON e.course_id = c.course_id;

--19.List all courses and the number of students enrolled in each. Ensure courses with zero students are also included in the result
SELECT c.course_id,
       c.name AS course_name,
       COUNT(e.student_id) AS student_count
FROM coursess c
LEFT JOIN enrollment e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.name;

--20.Find the names of all students who are actively taking 'Database Management Systems'.
SELECT Students.name
FROM Students
INNER JOIN enrollment
ON Students.student_id = enrollment.student_id
INNER JOIN coursess
ON enrollment.course_id = coursess.course_id
WHERE coursess.name = 'Database Management Systems';

---21.Identify any students who are not enrolled in any course.
SELECT Students.student_id, Students.name
FROM Students
LEFT JOIN enrollment
ON Students.student_id = enrollment.student_id
WHERE enrollment.student_id IS NULL;

--22.Calculate the total credit hours each student is currently taking. Display the student's name and their total credit hours.
SELECT Students.name,
       SUM(coursess.credit_hour) AS total_credit_hours
FROM Students
INNER JOIN enrollment
ON Students.student_id = enrollment.student_id
INNER JOIN coursess
ON enrollment.course_id = coursess.course_id
GROUP BY Students.student_id, Students.name;

       ---Subqueries and Advanced Logic


--23.Find the names of students who are enrolled in the course with the highest credit hours 
SELECT DISTINCT Students.name
FROM Students
INNER JOIN enrollment
ON Students.student_id = enrollment.student_id
INNER JOIN coursess
ON enrollment.course_id = courses.course_id
WHERE coursess.credit_hour = (
    SELECT MAX(credit_hour)
    FROM coursess
);

--24.List the courses that have an enrollment count strictly higher than the average enrollment count across all courses.
SELECT c.course_id, c.name
FROM coursess c
LEFT JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.name
HAVING COUNT(e.student_id) >
(
    SELECT AVG(enrollment_count)
    FROM
    (
        SELECT COUNT(student_id) AS enrollment_count
        FROM enrollment
        GROUP BY course_id
    ) AS avg_table
);

---25.Find the names of students whose age is strictly greater than the average age of all students.
SELECT name
FROM Students
WHERE age > (
    SELECT AVG(age)
    FROM Students
);


        ---Stored Procedures and DML

---26.Write a Stored Procedure named GetStudentCourses that accepts a student_id as an input parameter and returns the names of all courses that specific student is enrolled in.
 DELIMITER //

CREATE PROCEDURE GetStudentCourses(IN p_student_id INT)
BEGIN
    SELECT coursess.name AS course_name
    FROM coursess
    INNER JOIN enrollment
        ON coursess.course_id = enrollment.course_id
    WHERE enrollment.student_id = p_student_id;
END //

DELIMITER ;

---27.Write a Stored Procedure named EnrollStudent that takes p_student_id and p_course_id as inputs, and inserts a new record into the enrollment table.

DELIMITER //

CREATE PROCEDURE EnrollStudent(
    IN p_student_id INT,
    IN p_course_id INT
)
BEGIN
    INSERT INTO enrollment (enrollment_id, course_id, student_id)
    VALUES (
        (SELECT COALESCE(MAX(enrollment_id), 1000) + 1 FROM enrollment),
        p_course_id,
        p_student_id
    );
END //

DELIMITER ;

--28.Write an UPDATE statement to increase the credit hours of 'Web Development' by 1.

UPDATE coursess
SET credit_hour = credit_hour + 1
WHERE name = 'Web Development';