from alembic import op
import sqlalchemy as sa

revision = "0001"
down_revision = None
branch_labels = None
depends_on = None


def upgrade():

    op.create_table(
        "department",
        sa.Column("dept_id", sa.Integer(), primary_key=True),
        sa.Column("dept_name", sa.String(100), nullable=False)
    )

    op.create_table(
        "student",
        sa.Column("student_id", sa.Integer(), primary_key=True),
        sa.Column("student_name", sa.String(100)),
        sa.Column("email", sa.String(100)),
        sa.Column("enrollment_year", sa.Integer()),
        sa.Column("dept_id", sa.Integer(), sa.ForeignKey("department.dept_id"))
    )

    op.create_table(
        "professor",
        sa.Column("professor_id", sa.Integer(), primary_key=True),
        sa.Column("professor_name", sa.String(100)),
        sa.Column("email", sa.String(100)),
        sa.Column("salary", sa.Numeric(10, 2))
    )

    op.create_table(
        "course",
        sa.Column("course_id", sa.Integer(), primary_key=True),
        sa.Column("course_name", sa.String(100)),
        sa.Column("credits", sa.Integer())
    )

    op.create_table(
        "enrollment",
        sa.Column("enrollment_id", sa.Integer(), primary_key=True),
        sa.Column("student_id", sa.Integer(), sa.ForeignKey("student.student_id")),
        sa.Column("course_id", sa.Integer(), sa.ForeignKey("course.course_id")),
        sa.Column("enrollment_date", sa.Date())
    )


def downgrade():

    op.drop_table("enrollment")
    op.drop_table("course")
    op.drop_table("professor")
    op.drop_table("student")
    op.drop_table("department")