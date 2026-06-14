

CREATE DATABASE college_db;
USE college_db;


CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    hod_name VARCHAR(100) NOT NULL
);


CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT NOT NULL,

    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);



CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    department_id INT NOT NULL,

    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);


CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    semester VARCHAR(20) NOT NULL,
    grade CHAR(1),

    UNIQUE(student_id, course_id),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id),

    FOREIGN KEY (course_id)
    REFERENCES courses(course_id)
);



CREATE TABLE professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY,
    professor_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT NOT NULL,

    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);


DESCRIBE departments;
DESCRIBE students;
DESCRIBE courses;
DESCRIBE enrollments;
DESCRIBE professors;

-- ==========================================
-- TASK 2 : NORMALIZATION ANALYSIS
-- ==========================================

-- 1NF:
-- Every column stores atomic (single) values.
-- Example violation:
-- phone_numbers = '9876543210,9876543211'
-- Multiple phone numbers in one field would violate 1NF.

-- 2NF:
-- Every non-key attribute depends on the whole primary key.
-- In enrollments, the candidate key is (student_id, course_id).
-- Grade depends on both student and course together,
-- not on only student or only course.

-- 3NF:
-- No transitive dependencies exist.
-- Department name is stored only in departments table.
-- Students store only department_id.
-- If department_name were stored in students,
-- updating department names would create redundancy
-- and violate 3NF.

-- Enrollments 3NF Analysis:
-- enrollments contains only student_id,
-- course_id, semester and grade.
-- None of the non-key columns determine another
-- non-key column.
-- Therefore the table satisfies Third Normal Form (3NF).



ALTER TABLE students
ADD phone_number VARCHAR(15);


ALTER TABLE courses
ADD max_seats INT DEFAULT 60;


ALTER TABLE enrollments
ADD CONSTRAINT chk_grade
CHECK (grade IN ('A','B','C','D','F') OR grade IS NULL);


ALTER TABLE departments
RENAME COLUMN hod_name TO head_of_dept;

ALTER TABLE students
DROP COLUMN phone_number;



DESCRIBE departments;
DESCRIBE students;
DESCRIBE courses;
DESCRIBE enrollments;
DESCRIBE professors;


SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='college_db';