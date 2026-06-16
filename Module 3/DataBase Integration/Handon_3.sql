--task 1
SELECT student_id,
       student_name
FROM students
WHERE student_id IN
(
    SELECT student_id
    FROM enrollments
    GROUP BY student_id
    HAVING COUNT(*) >
    (
        SELECT AVG(course_count)
        FROM
        (
            SELECT COUNT(*) AS course_count
            FROM enrollments
            GROUP BY student_id
        ) AS avg_table
    )
);

SELECT c.course_id,
       c.course_name
FROM courses c
WHERE EXISTS
(
    SELECT *
    FROM enrollments e
    WHERE e.course_id=c.course_id
)
AND NOT EXISTS
(
    SELECT *
    FROM enrollments e
    WHERE e.course_id=c.course_id
    AND e.grade<>'A'
);

ALTER TABLE professors
ADD salary DECIMAL(10,2);

UPDATE professors
SET salary=90000
WHERE professor_id=1;

UPDATE professors
SET salary=85000
WHERE professor_id=2;

UPDATE professors
SET salary=92000
WHERE professor_id=3;

UPDATE professors
SET salary=88000
WHERE professor_id=4;


--task 2
CREATE VIEW vw_student_enrollment_summary AS

SELECT

s.student_id,
s.student_name,
d.department_name,

COUNT(e.course_id) AS total_courses,

ROUND
(
AVG
(
CASE

WHEN grade='A' THEN 4
WHEN grade='B' THEN 3
WHEN grade='C' THEN 2
WHEN grade='D' THEN 1
WHEN grade='F' THEN 0

END
),2

) AS GPA

FROM students s

LEFT JOIN departments d
ON s.department_id=d.department_id

LEFT JOIN enrollments e
ON s.student_id=e.student_id

GROUP BY
s.student_id,
s.student_name,
d.department_name;

CREATE VIEW vw_course_stats AS

SELECT

c.course_id,

c.course_name,

COUNT(e.student_id) AS total_enrollments,

ROUND
(
AVG
(
CASE

WHEN grade='A' THEN 4
WHEN grade='B' THEN 3
WHEN grade='C' THEN 2
WHEN grade='D' THEN 1
WHEN grade='F' THEN 0

END

),2

) AS avg_gpa

FROM courses c

LEFT JOIN enrollments e

ON c.course_id=e.course_id

GROUP BY

c.course_id,
c.course_name;

--task 3

DELIMITER $$

CREATE PROCEDURE sp_enroll_student(

IN p_student INT,

IN p_course INT,

IN p_semester VARCHAR(20)

)

BEGIN

IF EXISTS

(

SELECT *

FROM enrollments

WHERE student_id=p_student

AND course_id=p_course

)

THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Student already enrolled';

ELSE

INSERT INTO enrollments

(student_id,course_id,semester)

VALUES

(p_student,p_course,p_semester);

END IF;

END$$

DELIMITER ;