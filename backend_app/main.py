import os
from fastapi import FastAPI
from dotenv import load_dotenv
# from pydantic_ai import PydanticAI # Example import, uncomment if used

# Load environment variables from .env file if present (optional, Docker Compose handles this)
# load_dotenv()

app = FastAPI(title="AI Agent Backend")

# Example: Accessing environment variable for database connection
# DATABASE_URL = os.getenv("DATABASE_URL")
# print(f"Database URL: {DATABASE_URL}") # For debugging, remove in production

@app.get("/")
async def read_root():
    """
    Root endpoint providing a welcome message.
    """
    return {"message": "Welcome to the AI Agent Backend API!"}

@app.get("/health")
async def health_check():
    """
    Health check endpoint.
    """
    return {"status": "ok"}

# Add your PydanticAI and other agent-related endpoints below
# Example:
# @app.post("/process-query/")
# async def process_query(query: str):
#     # Initialize PydanticAI or your agent logic here
#     # Connect to Supabase using DATABASE_URL if needed
#     # ... agent processing ...
#     return {"response": "Processed query result"}

if __name__ == "__main__":
    import uvicorn
    # This block is for local development without Docker, if needed.
    # Uvicorn is run via CMD in Dockerfile for container deployment.
    uvicorn.run(app, host="0.0.0.0", port=8000)