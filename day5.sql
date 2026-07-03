CREATE USER 'john' IDENTIFIED BY 'john123';

GRANT SELECT
ON Students
TO 'john';

SELECT *from students;

GRANT INSERT
ON Students
TO 'john';

INSERT INTO students (StudentId,StudentName,Courses,Instructor) VALUES(
    's4','ram','aos','drsay'
)

SELECT *from students;

REVOKE SELECT
ON Students
FROM 'john';



