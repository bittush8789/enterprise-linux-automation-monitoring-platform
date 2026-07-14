from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime

# Users
class UserBase(BaseModel):
    username: str
    role: Optional[str] = "viewer"
    is_active: Optional[bool] = True

class UserCreate(UserBase):
    password: str

class UserResponse(UserBase):
    id: int

    class Config:
        orm_mode = True

# Servers
class ServerBase(BaseModel):
    hostname: str
    ip_address: str
    os_version: str

class ServerCreate(ServerBase):
    pass

class ServerResponse(ServerBase):
    id: int
    status: str
    last_seen: datetime

    class Config:
        orm_mode = True

# Token
class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: Optional[str] = None
