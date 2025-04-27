# 1-basic stack

This repository contains configurations for various basic development stacks.

## AI Development Stack (FastAPI + n8n + External Supabase)

This stack provides a foundation for developing AI agents using a FastAPI backend and n8n for workflow automation, connecting to an external Supabase PostgreSQL database.

### Overview

- **Backend API:** A FastAPI application (`./backend_app`) designed to host AI agent logic (e.g., using PydanticAI). Built using a multi-stage Dockerfile for optimization.
- **Workflow Automation:** An n8n service (`n8nio/n8n:latest`) for building and managing workflows.
- **Database:** Connects to your existing Supabase Cloud PostgreSQL instance (configured via `.env`).
- **Orchestration:** Uses Docker Compose (`docker-compose.yml`) to define and run the services.
- **Configuration:** Environment variables managed via `.env` (template provided in `.env.template`).
- **Deployment:** Includes a script (`setup_do_droplet.sh`) to facilitate setup on a DigitalOcean Ubuntu droplet.

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose V2](https://docs.docker.com/compose/install/) (usually included with Docker Desktop)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Local Setup

1.  **Clone the repository:**
    ```bash
    git clone <your-repository-url>
    cd 1-basic-stack
    ```
2.  **Create Environment File:**
    Copy the template to create your environment file:
    ```bash
    cp .env.template .env
    ```
3.  **Configure Environment Variables:**
    Edit the `.env` file with your actual credentials and settings:
    ```bash
    nano .env
    ```
    - Fill in your `DATABASE_URL` from Supabase.
    - Generate and add strong random strings for `N8N_ENCRYPTION_KEY` and `N8N_USER_MANAGEMENT_JWT_SECRET`.
    - Adjust `N8N_HOSTNAME` if needed (defaults to `localhost`).
    - Set `GENERIC_TIMEZONE`.

4.  **Build and Run Services:**
    ```bash
    docker compose up --build -d
    ```
    The `--build` flag ensures the FastAPI image is built. You can omit it on subsequent runs unless you change the backend code or Dockerfile.

5.  **Access Services:**
    - FastAPI Backend API: `http://localhost:8000`
    - n8n: `http://localhost:5678`

### Deployment to DigitalOcean Droplet

1.  **Create an Ubuntu Droplet:** Set up a standard Ubuntu droplet on DigitalOcean.
2.  **SSH into your Droplet.**
3.  **Run the Setup Script:**
    - Clone this repository onto the droplet.
    - Navigate into the repository directory.
    - Make the script executable: `chmod +x setup_do_droplet.sh`
    - Run the script: `./setup_do_droplet.sh`
    - **Important:** Log out and log back in after the script finishes for Docker group changes to take effect.
4.  **Configure `.env`:**
    - Follow the manual steps printed by the script:
    - `cp .env.template .env`
    - `nano .env` (Fill in your secrets, ensuring `N8N_HOSTNAME` is set to your droplet's IP or domain name).
5.  **Start Services:**
    ```bash
    docker compose up -d
    ```
6.  **Access Services:** Access FastAPI and n8n using your droplet's IP address or configured domain name on the respective ports (8000 and 5678). Ensure your droplet's firewall allows traffic on these ports.

---
*Created with switcheroo 1.0.0*
