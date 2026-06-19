from alembic import op
import sqlalchemy as sa

revision = "0003"
down_revision = "0002"
branch_labels = None
depends_on = None


def upgrade():

    op.create_table(
        "course_schedule",

        sa.Column(
            "schedule_id",
            sa.Integer(),
            primary_key=True
        ),

        sa.Column(
            "course_id",
            sa.Integer(),
            sa.ForeignKey("course.course_id")
        ),

        sa.Column(
            "day_of_week",
            sa.String(20)
        ),

        sa.Column(
            "start_time",
            sa.Time()
        ),

        sa.Column(
            "end_time",
            sa.Time()
        )
    )


def downgrade():

    op.drop_table("course_schedule")