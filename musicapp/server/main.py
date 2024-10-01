from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from sqlalchemy import TEXT, VARCHAR, Column, LargeBinary, create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import uuid
import bcrypt  # Import bcrypt for password hashing

# Initialize FastAPI app
app = FastAPI()

# Database configuration
DATABASE_URL = 'postgresql://postgres:ravi@localhost:5432/fluttermusicapp'
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
db = SessionLocal()

# Pydantic model for request validation
class UserCreate(BaseModel):
   name: str
   email: str
   password: str

# SQLAlchemy base and model definitions
Base = declarative_base()

class User(Base):
   __tablename__ = "users"
   id = Column(TEXT, primary_key=True, default=lambda: str(uuid.uuid4()))  # Generate UUID automatically
   name = Column(VARCHAR(100))
   email = Column(VARCHAR(100), unique=True)  # Ensure email uniqueness
   password = Column(LargeBinary)  # Store hashed password as binary

# Route to handle user signups
@app.post("/signup")
def signup_user(user: UserCreate):
   # Check if the user already exists in the database
   user_db = db.query(User).filter(User.email == user.email).first()
   if user_db:
      raise HTTPException(status_code=400, detail="User already exists")
    

   # Hash the password and encode it as binary
   hashed_password = bcrypt.hashpw(user.password.encode('utf-8'), bcrypt.gensalt())

   # Create a new user entry with hashed password
   new_user = User(id=str(uuid.uuid4()), name=user.name, email=user.email, password=hashed_password)
   db.add(new_user)
   db.commit()
   db.refresh(new_user)  # Refresh instance to reflect saved data (such as ID)
   
   return {"id": new_user.id, "name": new_user.name, "email": new_user.email}

# Create the database tables
Base.metadata.create_all(engine)
