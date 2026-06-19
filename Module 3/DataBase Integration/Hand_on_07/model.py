from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, Date, Numeric, Boolean, Time
from sqlalchemy.orm import declarative_base, relationship

DATABASE_URL = "postgresql://postgres:password@localhost/college_db_orm"

engine = create_engine(DATABASE_URL, echo=True)

Base = declarative_base()


class Department(Base):
    __tablename__ = "department"

    dept_id = Column(Integer, primary_key=True)
    dept_name = Column(String(100), nullable=False)

    students = relationship("Student", back_populates="department")


class Student(Base):
    __tablename__ = "student"

    student_id = Column(Integer, primary_key=True)
    student_name = Column(String(100), nullable=False)
    email = Column(String(100), unique=True)
    enrollment_year = Column(Integer)

    # New Column
    is_active = Column(Boolean, default=True)

    dept_id = Column(Integer, ForeignKey("department.dept_id"))

    department = relationship("Department", back_populates="students")
    enrollments = relationship("Enrollment", back_populates="student")


class Professor(Base):
    __tablename__ = "professor"

    professor_id = Column(Integer, primary_key=True)
    professor_name = Column(String(100))
    email = Column(String(100))
    salary = Column(Numeric(10, 2))


class Course(Base):
    __tablename__ = "course"

    course_id = Column(Integer, primary_key=True)
    course_name = Column(String(100))
    credits = Column(Integer)

    enrollments = relationship("Enrollment", back_populates="course")
    schedules = relationship("CourseSchedule", back_populates="course")


class Enrollment(Base):
    __tablename__ = "enrollment"

    enrollment_id = Column(Integer, primary_key=True)

    student_id = Column(Integer, ForeignKey("student.student_id"))
    course_id = Column(Integer, ForeignKey("course.course_id"))

    enrollment_date = Column(Date)

    student = relationship("Student", back_populates="enrollments")
    course = relationship("Course", back_populates="enrollments")


class CourseSchedule(Base):
    __tablename__ = "course_schedule"

    schedule_id = Column(Integer, primary_key=True)

    course_id = Column(Integer, ForeignKey("course.course_id"))

    day_of_week = Column(String(20))
    start_time = Column(Time)
    end_time = Column(Time)

    course = relationship("Course", back_populates="schedules")


if __name__ == "__main__":
    Base.metadata.create_all(engine)
    print("Tables Created Successfully")