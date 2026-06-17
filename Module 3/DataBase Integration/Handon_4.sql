EXPLAIN FORMAT=JSON

SELECT
    s.student_name,
    c.course_name
FROM enrollments e
JOIN students s
ON s.student_id = e.student_id
JOIN courses c
ON c.course_id = e.course_id;


CREATE UNIQUE INDEX idx_student_course
ON enrollments(student_id,course_id);

