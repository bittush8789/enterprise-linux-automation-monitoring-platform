from fastapi import FastAPI
from database import engine, Base
from routers import auth, servers

# Create database tables (in production use Alembic migrations instead)
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Enterprise Linux Automation & Monitoring API",
    description="API for managing Linux servers, monitoring, and automation.",
    version="1.0.0"
)

app.include_router(auth.router)
app.include_router(servers.router)

@app.get("/")
def root():
    return {"message": "Welcome to Enterprise Linux Automation API"}

@app.get("/health")
def health_check():
    return {"status": "ok"}
