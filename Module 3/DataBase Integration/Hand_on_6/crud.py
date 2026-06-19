

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, joinedload

from models import Department, Student, Course, Enrollment
from datetime import date

engine = create_engine(
    "postgresql://postgres:password@localhost/college_db_orm",
    echo=True
)

Session = sessionmaker(bind=engine)
session = Session()

# -------------------------
# INSERT DEPARTMENTS
# -------------------------

d1 = Department(dept_name="Computer Science")
d2 = Department(dept_name="Mechanical")
d3 = Department(dept_name="Civil")

session.add_all([d1, d2, d3])
session.commit()

# -------------------------
# INSERT STUDENTS
# -------------------------

s1 = Student(
    student_name="Rahul",
    email="rahul@gmail.com",
    enrollment_year=2022,
    department=d1
)

s2 = Student(
    student_name="Anjali",
    email="anjali@gmail.com",
    enrollment_year=2023,
    department=d1
)

s3 = Student(
    student_name="Karthik",
    email="karthik@gmail.com",
    enrollment_year=2022,
    department=d2
)

s4 = Student(
    student_name="Priya",
    email="priya@gmail.com",
    enrollment_year=2024,
    department=d3
)

s5 = Student(
    student_name="Vijay",
    email="vijay@gmail.com",
    enrollment_year=2023,
    department=d1
)

session.add_all([s1, s2, s3, s4, s5])
session.commit()

# -------------------------
# INSERT COURSES
# -------------------------

c1 = Course(course_name="Python", credits=4)
c2 = Course(course_name="DBMS", credits=3)
c3 = Course(course_name="Machine Learning", credits=5)

session.add_all([c1, c2, c3])
session.commit()

# -------------------------
# INSERT ENROLLMENTS
# -------------------------

e1 = Enrollment(
    student=s1,
    course=c1,
    enrollment_date=date(2025, 1, 10)
)

e2 = Enrollment(
    student=s2,
    course=c2,
    enrollment_date=date(2025, 1, 12)
)

e3 = Enrollment(
    student=s3,
    course=c3,
    enrollment_date=date(2025, 1, 14)
)

e4 = Enrollment(
    student=s5,
    course=c1,
    enrollment_date=date(2025, 1, 15)
)

session.add_all([e1, e2, e3, e4])
session.commit()

print("\nDepartments, Students, Courses and Enrollments Added.\n")

# =====================================================
# READ 1
# =====================================================

print("\nStudents in Computer Science Department\n")

students = (
    session.query(Student)
    .join(Department)
    .filter(Department.dept_name == "Computer Science")
    .all()
)

for s in students:
    print(s.student_name, s.email)

# =====================================================
# READ 2 (N+1)
# =====================================================

print("\nEnrollments (N+1 Problem)\n")

enrollments = session.query(Enrollment).all()

for e in enrollments:
    print(
        e.student.student_name,
        "->",
        e.course.course_name
    )

# =====================================================
# UPDATE
# =====================================================

student = session.query(Student).filter(
    Student.email == "rahul@gmail.com"
).first()

student.enrollment_year = 2025

session.commit()

print("\nStudent Updated Successfully\n")

# =====================================================
# DELETE
# =====================================================

enrollment = session.query(Enrollment).first()

session.delete(enrollment)

session.commit()

print("\nEnrollment Deleted Successfully\n")

# =====================================================
# TASK 3
# EAGER LOADING
# =====================================================

print("\nUsing joinedload()\n")

enrollments = (
    session.query(Enrollment)
    .options(
        joinedload(Enrollment.student),
        joinedload(Enrollment.course)
    )
    .all()
)

for e in enrollments:
    print(
        e.student.student_name,
        "->",
        e.course.course_name
    )

session.close()