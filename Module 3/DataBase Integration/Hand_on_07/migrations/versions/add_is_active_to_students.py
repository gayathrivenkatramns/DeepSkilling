from alembic import op
import sqlalchemy as sa

revision = "0002"
down_revision = "0001"
branch_labels = None
depends_on = None


def upgrade():

    op.add_column(
        "student",
        sa.Column(
            "is_active",
            sa.Boolean(),
            server_default=sa.true()
        )
    )


def downgrade():

    op.drop_column(
        "student",
        "is_active"
    )