

from sqlalchemy import TEXT, VARCHAR, Column, LargeBinary

from models.base import Base


class User(Base):
   __tablename__ = "users"
   id = Column(TEXT, primary_key=True, default=lambda: str(uuid.uuid4()))  # Generate UUID automatically
   name = Column(VARCHAR(100))
   email = Column(VARCHAR(100), unique=True)  # Ensure email uniqueness
   password = Column(LargeBinary) 