# Low Level Design (LLD)

## Database Schema (PostgreSQL)

### Table: users
- `id`: Integer, Primary Key
- `username`: String, Unique
- `hashed_password`: String
- `role`: String
- `is_active`: Boolean

### Table: servers
- `id`: Integer, Primary Key
- `hostname`: String
- `ip_address`: String
- `os_version`: String
- `status`: String

### Table: backups
- `id`: Integer, Primary Key
- `server_id`: Foreign Key to servers.id
- `file_path`: String
- `s3_url`: String

## API Endpoints (FastAPI)

- `POST /auth/token`: Retrieve JWT for authentication.
- `GET /servers/`: List all registered servers.
- `POST /servers/`: Register a new server (Admin only).

## Security Measures
- Authentication via JWT.
- RBAC implemented at the endpoint level.
- UFW rules strictly limiting access (SSH, specific API ports).
- Passwords hashed using bcrypt.
