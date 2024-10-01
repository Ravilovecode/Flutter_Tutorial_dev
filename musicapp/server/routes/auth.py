# Route to handle user signups
import uuid
import bcrypt
from fastapi import Depends, HTTPException
from fastapi import APIRouter
from models.user import User
from pydantic_schemas.user_create import UserCreate
from database import get_db
from sqlalchemy.orm import Session

router = APIRouter()
@router.post("/signup")
def signup_user(user: UserCreate, db: Session = Depends(get_db)):
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