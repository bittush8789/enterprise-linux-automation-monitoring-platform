from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
import crud, schemas, database, auth

router = APIRouter(prefix="/servers", tags=["Servers"])

@router.post("/", response_model=schemas.ServerResponse)
def create_server(server: schemas.ServerCreate, db: Session = Depends(database.get_db), current_user = Depends(auth.get_current_user)):
    if current_user.role not in ["admin", "operator"]:
        raise HTTPException(status_code=403, detail="Not enough permissions")
    return crud.create_server(db=db, server=server)

@router.get("/", response_model=List[schemas.ServerResponse])
def read_servers(skip: int = 0, limit: int = 100, db: Session = Depends(database.get_db), current_user = Depends(auth.get_current_user)):
    servers = crud.get_servers(db, skip=skip, limit=limit)
    return servers
