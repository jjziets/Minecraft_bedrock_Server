# Minecraft Bedrock Docker Server
This project allows you to easily set up and maintain a Minecraft Bedrock server using Docker and Docker Compose.

## Features

- Fully containerized Minecraft Bedrock server using Docker.
- Utilizes Docker Compose for easy management of server configurations and version updates.
- Automatic server version updating through a custom shell script.
- Pre-configured to run both Survival and Creative modes with the ability to easily add more.
- Uses volumes to persist game data across container lifecycle.

## Quick Start

1. Clone this repository.
2. Make sure you have Docker and Docker Compose installed.
3. Update the `minecraft_bedrock_version` file with the latest Minecraft Bedrock version.
4. Run the `update-minecraft.sh` script to build and push your Docker image.
5. Run `docker-compose up -d` to start your Minecraft Bedrock servers.

## Disclaimer

This project is not affiliated with Mojang, Microsoft or any of their affiliates.

---

