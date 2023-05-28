#!/bin/bash

# Set your Docker Hub username
DOCKER_USERNAME="jjziets"

# Path to the version file
VERSION_FILE="./minecraft_bedrock_version"

# Initial version
VERSION=""

# Navigate to the directory containing your docker-compose.yml file
#cd /path/to/your/docker-compose/directory

while true; do
    if [ -f "$VERSION_FILE" ]; then
        NEW_VERSION=$(cat $VERSION_FILE)

        # If the version has changed
        if [ "$NEW_VERSION" != "$VERSION" ]; then
            # Update the Dockerfile with the new version
            sed -i "s/^ENV MINECRAFT_VERSION=.*/ENV MINECRAFT_VERSION=${NEW_VERSION}/" Dockerfile

            # Build the new Docker image with the latest version
            if docker build -t ${DOCKER_USERNAME}/minecraft-bedrock:latest . ; then
                echo "Docker build successful"

                # Push the new image to Docker Hub
                if docker push ${DOCKER_USERNAME}/minecraft-bedrock:latest ; then
                    echo "Docker push successful"

                    # Pull the latest image, remove old images, and recreate the containers
                    if docker-compose down --remove-orphans  && docker image prune -a -f && docker-compose up -d ; then
                        echo "Server update successful"
                    else
                        echo "Server update failed, please check the docker-compose file and the network connection."
                    fi

                    # Update the version
                    VERSION="$NEW_VERSION"
                else
                    echo "Docker push failed, please check your Docker Hub credentials and network connection."
                fi
            else
                echo "Docker build failed, please check the Dockerfile and the network connection."
            fi
        fi
    fi

    # Sleep for 1 minute
    sleep 60
done
