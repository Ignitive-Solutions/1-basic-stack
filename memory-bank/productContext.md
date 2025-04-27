# Product Context

**Initialization Timestamp:** 4/27/2025, 1:28:05 PM (Asia/Singapore, UTC+8:00)

## Project Overview

This project, "Self-hosted AI Package," is a Docker Compose template designed to quickly set up a local AI and low-code development environment. It integrates several open-source tools for building and experimenting with AI workflows.

## Key Components

- **n8n:** Low-code platform for workflow automation.
- **Supabase:** Database, vector store, and authentication.
- **Ollama:** Platform for running local LLMs.
- **Open WebUI:** ChatGPT-like interface.
- **Flowise:** No/low-code AI agent builder.
- **Qdrant:** High-performance vector store.
- **SearXNG:** Privacy-respecting metasearch engine.
- **Caddy:** Server for managed HTTPS/TLS.

## Architecture

The services are orchestrated using Docker Compose (`docker-compose.yml`). A Python script (`start_services.py`) manages the startup process, including cloning Supabase, configuring SearXNG, and starting containers with hardware-specific profiles for Ollama. Data persistence is handled via Docker volumes.

## Goals

The primary goal is to provide a pre-configured and easily deployable stack for local AI development and experimentation.