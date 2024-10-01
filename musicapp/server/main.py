from fastapi import FastAPI 
from models.base import Base
from  routes import auth
from database import engine

# Initialize FastAPI app
app = FastAPI()


app.include_router(auth.router, prefix="/auth")
# Create the database tables
Base.metadata.create_all(engine)
