# System Patterns

**Last Updated:** 4/27/2025, 1:37:29 PM (Asia/Singapore, UTC+8:00)

## Observed Patterns

- **Initial Project (example-code):**
    - Utilizes Docker Compose for defining and managing a multi-container local AI stack (n8n, Ollama, Supabase, etc.).
    - Uses a Python script (`start_services.py`) to orchestrate startup and handle hardware profiles.
    - Relies heavily on environment variables (`.env`) for configuration.
    - Includes comprehensive README documentation.
- **New Development Stack:**
    - Also uses Docker Compose for service definition (`backend_api`, `n8n`).
    - Employs a multi-stage Dockerfile for optimizing the FastAPI backend image.
    - Connects to an external Supabase instance via environment variables (`DATABASE_URL`).
    - Uses `.env.template` and `.env` for managing secrets and configuration.
    - Provides a shell script (`setup_do_droplet.sh`) for deployment automation on Ubuntu.
- **Tooling:**
    - The `filesystem` MCP tool seems to require absolute paths for reliable operation in this environment.

## Potential Improvements/Refactoring

- **Initial Project:**
    - Centralize environment variable management further.
    - Improve error handling in the startup script.
    - Consider a more robust method for managing SearXNG secrets.
- **New Development Stack:**
    - Add health checks in `docker-compose.yml` for better service dependency management.
    - Enhance the `setup_do_droplet.sh` script with more error checking or options (e.g., non-interactive setup).
- **General:**
    - Investigate the root cause of the `filesystem` tool's path issues.