# Start from a Debian base image
FROM debian:stable-slim

# Install dependencies
RUN apt-get update && apt-get install -y wget unzip libcurl4 openssl

# Set the Minecraft version
ENV MINECRAFT_VERSION=1.19.83.01

# Create the server directory
RUN mkdir /minecraft
RUN cd /minecraft

# Download the Bedrock server files and move them to the server directory
RUN wget https://minecraft.azureedge.net/bin-linux/bedrock-server-${MINECRAFT_VERSION}.zip 
RUN unzip -l bedrock-server-${MINECRAFT_VERSION}.zip 
RUN unzip bedrock-server-${MINECRAFT_VERSION}.zip -d /minecraft 
#RUN rm bedrock-server-${MINECRAFT_VERSION}.zip

RUN touch /minecraft/test

RUN chmod +x /minecraft/bedrock_server

# List the contents of the server directory
RUN ls -la /minecraft

# Expose the server port
EXPOSE 19132/udp

# Change to the server directory
WORKDIR /minecraft

# Copy the configuration files into the image
COPY server-survival.properties .
COPY server-creative.properties .

# Start the server
CMD pwd && ls && cp $SERVER_PROPERTIES server.properties && LD_LIBRARY_PATH=. ./bedrock_server
