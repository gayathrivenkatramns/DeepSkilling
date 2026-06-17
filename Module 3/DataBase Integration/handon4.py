import mysql.connector
import time

conn=mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="college_db"
)

cursor=conn.cursor()

start=time.time()

query_count=0

cursor.execute("SELECT * FROM enrollments")

query_count+=1

rows=cursor.fetchall()

for row in rows:

    student=row[1]

    cursor.execute(
        "SELECT student_name FROM students WHERE student_id=%s",
        (student,)
    )

    cursor.fetchone()

    query_count+=1

end=time.time()

print("Queries Executed :",query_count)

print("Time :",end-start)