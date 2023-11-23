# Use the official Packer Docker image as the base
FROM hashicorp/packer:1.9

# Create a non-root user with a home directory
RUN addgroup -S jenkins && adduser -S -G jenkins jenkins

# Set the working directory
WORKDIR /home/jenkins

# Switch to the non-root user
USER jenkins

# Entry point to run bash when the container starts
CMD ["/bin/bash"]
