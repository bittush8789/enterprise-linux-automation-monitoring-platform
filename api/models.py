from sqlalchemy import Boolean, Column, Integer, String, DateTime, ForeignKey, Text
from sqlalchemy.orm import relationship
from datetime import datetime
from database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
    hashed_password = Column(String)
    role = Column(String, default="viewer") # admin, operator, viewer
    is_active = Column(Boolean, default=True)

class Server(Base):
    __tablename__ = "servers"

    id = Column(Integer, primary_key=True, index=True)
    hostname = Column(String, unique=True, index=True)
    ip_address = Column(String, unique=True)
    os_version = Column(String)
    status = Column(String, default="active")
    last_seen = Column(DateTime, default=datetime.utcnow)

class Backup(Base):
    __tablename__ = "backups"

    id = Column(Integer, primary_key=True, index=True)
    server_id = Column(Integer, ForeignKey("servers.id"))
    file_path = Column(String)
    s3_url = Column(String)
    status = Column(String) # success, failed
    timestamp = Column(DateTime, default=datetime.utcnow)

    server = relationship("Server")
