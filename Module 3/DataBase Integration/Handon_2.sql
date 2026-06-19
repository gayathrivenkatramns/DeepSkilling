

INSERT INTO departments
(department_id, department_name, head_of_dept)
VALUES
(1,'Computer Science','Dr. Kumar'),
(2,'Electronics','Dr. Priya'),
(3,'Mechanical','Dr. Ravi'),
(4,'Civil','Dr. Anitha');

INSERT INTO students
(student_id, student_name, email, department_id)
VALUES
(1,'Amit Sharma','amit@college.edu',1),
(2,'Priya Singh','priya@college.edu',2),
(3,'Rahul Verma','rahul@college.edu',1),
(4,'Sneha Rao','sneha@college.edu',3),
(5,'Arjun Das','arjun@college.edu',1),
(6,'Kiran Patel','kiran@college.edu',4),
(7,'Meena Iyer','meena@college.edu',2),
(8,'Vikram Gupta','vikram@college.edu',3);



INSERT INTO students
(student_id, student_name, email, department_id)
VALUES
(9,'Gayathri Venkatraman','gayathri@college.edu',1),
(10,'Rohit Kumar','rohit@college.edu',2);


INSERT INTO courses
(course_id, course_name, credits, department_id, max_seats)
VALUES
(1,'CS101',4,1,60),
(2,'DBMS',4,1,60),
(3,'Digital Electronics',3,2,60),
(4,'Thermodynamics',4,3,60),
(5,'Engineering Drawing',2,4,60);



INSERT INTO professors
(professor_id, professor_name, email, department_id)
VALUES
(1,'Dr. Kumar','kumar@college.edu',1),
(2,'Dr. Priya','priya@college.edu',2),
(3,'Dr. Ravi','ravi@college.edu',3),
(4,'Dr. Anitha','anitha@college.edu',4);



INSERT INTO enrollments
(enrollment_id, student_id, course_id, semester, grade)
VALUES
(1,1,1,'Odd','A'),
(2,2,3,'Odd','B'),
(3,3,2,'Odd','A'),
(4,4,4,'Odd','B'),
(5,5,1,'Odd','C'),
(6,6,5,'Odd',NULL),
(7,7,3,'Odd','A'),
(8,8,4,'Odd',NULL);



SELECT COUNT(*) AS Student_Count FROM students;
SELECT COUNT(*) AS Enrollment_Count FROM enrollments;



UPDATE enrollments
SET grade='B'
WHERE student_id=5
AND course_id=1;


SELECT *
FROM enrollments
WHERE grade IS NULL;


DELETE FROM enrollments
WHERE grade IS NULL;



SELECT COUNT(*) FROM enrollments;



SELECT *
FROM students
ORDER BY student_name;


SELECT *
FROM courses
WHERE credits>3
ORDER BY credits DESC;



SELECT *
FROM professors;


SELECT *
FROM students
WHERE email LIKE '%@college.edu';



SELECT department_id,
COUNT(*) AS Total_Students
FROM students
GROUP BY department_id;



SELECT
student_name,
department_name
FROM students
INNER JOIN departments
ON students.department_id=departments.department_id;



SELECT
student_name,
course_name,
semester,
grade
FROM enrollments
INNER JOIN students
ON enrollments.student_id=students.student_id
INNER JOIN courses
ON enrollments.course_id=courses.course_id;



SELECT
student_name
FROM students
LEFT JOIN enrollments
ON students.student_id=enrollments.student_id
WHERE enrollments.student_id IS NULL;



SELECT
course_name,
COUNT(enrollment_id) AS Student_Count
FROM courses
LEFT JOIN enrollments
ON courses.course_id=enrollments.course_id
GROUP BY courses.course_id,course_name;


SELECT
department_name,
professor_name
FROM departments
LEFT JOIN professors
ON departments.department_id=professors.department_id;



SELECT
course_name,
COUNT(enrollment_id) AS Enrollment_Count
FROM courses
LEFT JOIN enrollments
ON courses.course_id=enrollments.course_id
GROUP BY courses.course_id,course_name;


SELECT
department_name,
COUNT(professor_id) AS Total_Professors
FROM departments
LEFT JOIN professors
ON departments.department_id=professors.department_id
GROUP BY department_name;



SELECT *
FROM departments;



SELECT
grade,
COUNT(*) AS Grade_Count
FROM enrollments
WHERE course_id=1
GROUP BY grade;



SELECT
department_name,
COUNT(student_id) AS Student_Count
FROM departments
LEFT JOIN students
ON departments.department_id=students.department_id
GROUP BY department_name
HAVING COUNT(student_id)>2;