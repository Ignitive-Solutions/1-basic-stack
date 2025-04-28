# Self-hosted AI Package

**Self-hosted AI Package** is an open, docker compose template that
quickly bootstraps a fully featured AI development environment using Docker. It includes Open WebUI for an interface to chat with your LLMs, Flowise for building AI agents, Qdrant for a local vector store, and connects to your **Supabase Cloud project** for database and authentication needs. This setup is designed to connect to external LLM providers like OpenAI, Gemini, and OpenRouter.

This is Cole's version with a couple of improvements and the addition of Supabase (Cloud), Open WebUI, Flowise, Langfuse, SearXNG, and Caddy!

## Important Links

- [Local AI community](https://thinktank.ottomator.ai/c/local-ai/18) forum over in the oTTomator Think Tank

- [GitHub Kanban board](https://github.com/users/coleam00/projects/2/views/1) for feature implementation and bug squashing.

- [Original Local AI Starter Kit](https://github.com/n8n-io/self-hosted-ai-starter-kit) by the n8n team

Curated by <https://github.com/coleam00>, it combines a curated list of compatible AI products and components to quickly get started with building self-hosted AI workflows.

### What’s included

✅ [**Open WebUI**](https://openwebui.com/) - ChatGPT-like interface to
privately interact with your LLMs

✅ [**Flowise**](https://flowiseai.com/) - No/low code AI agent
builder

✅ [**Qdrant**](https://qdrant.tech/) - Open source, high performance vector
store with an comprehensive API. Even though you can use Supabase for RAG, this was
kept unlike Postgres since it's faster than Supabase so sometimes is the better option.

✅ [**SearXNG**](https://searxng.org/) - Open source, free internet metasearch engine which aggregates 
results from up to 229 search services. Users are neither tracked nor profiled, hence the fit with the local AI package.

✅ [**Caddy**](https://caddyserver.com/) - Managed HTTPS/TLS for custom domains

✅ [**Langfuse**](https://langfuse.com/) - Open source LLM engineering platform for agent observability

## Prerequisites

Before you begin, make sure you have the following software installed:

- [Python](https://www.python.org/downloads/) - Required to run the setup script
- [Git/GitHub Desktop](https://desktop.github.com/) - For easy repository management
- [Docker/Docker Desktop](https://www.docker.com/products/docker-desktop/) - Required to run all services

## Installation

Clone the repository and navigate to the project directory:
```bash
git clone https://github.com/coleam00/local-ai-packaged.git
cd local-ai-packaged
```

Before running the services, you need to configure the connection to your Supabase Cloud project.

1. Make a copy of `.env.example` and rename it to `.env` in the root directory of the project.
2. Obtain your Supabase Cloud connection details:
   - **Database Connection:**
     - Go to your Supabase project dashboard.
     - Navigate to **Project Settings** > **Database**.
     - Under **Connection string**, select the **URI** tab.
     - Note down the Host, Port, Database name, User (usually `postgres`), and Password.
   - **API Keys:**
     - Navigate to **Project Settings** > **API**.
     - Under **Project API keys**, note down the `anon` (public) key and the `service_role` (secret) key. **Keep the service_role key confidential!**
3. Set the following required environment variables in your `.env` file:
   ```bash
   ############
   # Supabase Cloud Connection Details
   ############
   SUPABASE_CLOUD_HOST= # Your Supabase project host (e.g., db.xxxxxxxx.supabase.co)
   SUPABASE_CLOUD_PORT=5432
   SUPABASE_CLOUD_DB=postgres
   SUPABASE_CLOUD_USER=postgres
   SUPABASE_CLOUD_PASSWORD= # Your Supabase project database password
   SUPABASE_ANON_KEY= # Your Supabase project Anon Key (public)
   SUPABASE_SERVICE_ROLE_KEY= # Your Supabase project Service Role Key (secret) - KEEP THIS SECRET!

   ############
   # Langfuse credentials
   ############
   CLICKHOUSE_PASSWORD= # Generate a secure random string
   MINIO_ROOT_PASSWORD= # Generate a secure random string
   LANGFUSE_SALT= # Generate a secure random string
   NEXTAUTH_SECRET= # Generate a secure random string
   ENCRYPTION_KEY= # Generate via `openssl rand -hex 32`
   ```

> [!IMPORTANT]
> Make sure to generate secure random values for all secrets. Never use the example values in production.

3. Set the following environment variables if deploying to production, otherwise leave commented:
   ```bash
   ############
   # Caddy Config
   ############

   WEBUI_HOSTNAME=:openwebui.yourdomain.com
   FLOWISE_HOSTNAME=:flowise.yourdomain.com
   SEARXNG_HOSTNAME=searxng.yourdomain.com
   LETSENCRYPT_EMAIL=your-email-address
   ```   

---

The project includes a `start_services.py` script that handles starting the AI services.

Run the following command to start all services:
```bash
python start_services.py
```

## Deploying to the Cloud

### Prerequisites for the below steps

- Linux machine (preferably Unbuntu) with Nano, Git, and Docker installed

### Extra steps

Before running the above commands to pull the repo and install everything:

1. Run the commands as root to open up the necessary ports:
   - ufw enable
   - ufw allow 3000 && ufw allow 3002 && ufw allow 80 && ufw allow 443 # Open WebUI, Langfuse, Caddy HTTP/HTTPS
   - ufw allow 3001 (if you want to expose Flowise, you will have to set up the [environment variables](https://docs.flowiseai.com/configuration/environment-variables) to enable authentication)
   - ufw allow 8080 (if you want to expose SearXNG)
   - ufw reload

2. Set up A records for your DNS provider to point your subdomains you'll set up in the .env file for Caddy
to the IP address of your cloud instance.

   For example, A record to point openwebui to [cloud instance IP] for openwebui.yourdomain.com

## ⚡️ Quick start and usage

The main component of the self-hosted AI starter kit is a docker compose file pre-configured with network and disk. After completing the installation steps above, follow the steps below to get started.

1. Open <http://localhost:3000/> in your browser to set up Open WebUI. You’ll only have to do this once. You are NOT creating an account with Open WebUI in the setup here, it is only a local account for your instance!
2. Configure Open WebUI to connect to your desired external LLM providers (see "Configuring External LLM Providers" section below).
3. (Optional) Open <http://localhost:3001/> to access Flowise and build AI agents.
4. (Optional) Open <http://localhost:3002/> to access Langfuse for observability.
5. (Optional) Open <http://localhost:8080/> to access SearXNG for private search.

To open Open WebUI at any time, visit <http://localhost:3000/>.

> [!NOTE]
> This starter kit is designed to help you get started with self-hosted AI workflows using external LLM providers. While it’s not fully optimized for production environments, it combines robust components that work well together for proof-of-concept projects. You can customize it to meet your specific needs.

## ⚙️ Configuring External LLM Providers

This setup is designed to work with external LLM APIs. Here's how to configure Open WebUI:
### Open WebUI Configuration

Open WebUI can connect to OpenAI-compatible API endpoints. This makes it easy to integrate with services like OpenRouter or potentially others that offer compatible interfaces.

1.  Navigate to your Open WebUI instance (e.g., <http://localhost:3000/>).
2.  Go to **Settings** -> **Connections**.
3.  Under **LLM Connections**, you can add or modify connections.
4.  To connect to an OpenAI-compatible endpoint (like OpenRouter):
    *   Set the **API Base URL** to the provider's endpoint (e.g., `https://openrouter.ai/api/v1`).
    *   Enter your **API Key** for that provider.
    *   You might need to adjust other settings based on the provider's requirements.
5.  Save the connection. You should now be able to select models from this provider in the main chat interface.

*Note: Direct integration with Gemini API in Open WebUI might require specific configurations or might not be directly supported depending on the Open WebUI version. Using an OpenAI-compatible endpoint like OpenRouter is often the most straightforward way to access various models, including Gemini models available through OpenRouter.*

## Upgrading

To update all containers to their latest versions (Open WebUI, Flowise, etc.), run these commands:

```bash
# Stop all services
docker compose -p localai -f docker-compose.yml down

# Pull latest versions of all containers
docker compose -p localai -f docker-compose.yml pull

# Start services again
python start_services.py
```

Note: The `start_services.py` script itself does not update containers - it only restarts them or pulls them if you are downloading these containers for the first time. To get the latest versions, you must explicitly run the `docker compose pull` command above.

## Troubleshooting

Here are solutions to common issues you might encounter:

## 🎥 Video walkthrough

- [Cole's Guide to the Original Local AI Starter Kit (includes n8n)](https://youtu.be/pOsO40HSbOo) - Note: This video covers the original version which included n8n.

## 📜 License

This project (originally created by the n8n team, link at the top of the README) is licensed under the Apache License 2.0 - see the
[LICENSE](LICENSE) file for details.
