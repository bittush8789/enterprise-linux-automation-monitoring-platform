from sqlalchemy.orm import Session
import models, schemas
from auth import get_password_hash

def get_user(db: Session, username: str):
    return db.query(models.User).filter(models.User.username == username).first()

def create_user(db: Session, user: schemas.UserCreate):
    hashed_password = get_password_hash(user.password)
    db_user = models.User(username=user.username, hashed_password=hashed_password, role=user.role)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def get_servers(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Server).offset(skip).limit(limit).all()

def create_server(db: Session, server: schemas.ServerCreate):
    db_server = models.Server(**server.dict())
    db.add(db_server)
    db.commit()
    db.refresh(db_server)
    return db_server
