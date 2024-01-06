#!/bin/bash

# Parameters
desired_hostname="emerson"
user_name="adminuser"
log_file="/home/$user_name/customdata.log"

# Function for error handling and logging
handle_error() {
  local exit_code=$?
  local command="$BASH_COMMAND"
  local timestamp=$(date +"%Y-%m-%d %T")
  echo "[ERROR][$timestamp] Command '$command' exited with status $exit_code: $1" | tee -a "$log_file"
  exit $exit_code
}

# Function for logging
log_message() {
  local message="$1"
  local timestamp=$(date +"%Y-%m-%d %T")
  echo "[$timestamp] $message" | tee -a "$log_file"
}

# Function to update packages
update_packages() {
  log_message "Updating and installing packages..."
  sudo apt-get update -y || handle_error "Failed to update packages."
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common || handle_error "Failed to install packages."
  log_message "Packages updated and installed successfully."
}

# Function to add user to the Docker group
add_user_to_docker() {
  local user="$1"
  log_message "Adding the user '$user' to the Docker group..."
  sudo usermod -aG docker "$user" || handle_error "Failed to add user to the Docker group."
  log_message "User '$user' has been added to the Docker group successfully."
}

# Function to change the hostname
change_hostname() {
  local hostname="$1"
  log_message "Changing the hostname to '$hostname'..."
  sudo hostnamectl set-hostname "$hostname" || handle_error "Failed to change hostname."
  log_message "Hostname has been changed successfully to '$hostname'."
}

# Function to add Docker
add_docker() {
  log_message "Adding Docker repository and installing Docker..."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - || handle_error "Failed to add Docker GPG key."
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" || handle_error "Failed to add Docker repository."
  sudo apt-get update -y || handle_error "Failed to update packages for Docker installation."
  sudo DEBIAN_FRONTEND=noninteractive apt-get install docker-ce docker-ce-cli containerd.io -y || handle_error "Failed to install Docker."
  log_message "Docker repository added, and Docker packages installed successfully."
}

# Redirect all output to the log file
exec > >(tee -a "$log_file") 2>&1

# Trap errors and call the error handler
trap 'handle_error' ERR

# Main script starts here
timestamp=$(date +"%Y-%m-%d %T")
log_message "This is a post-deployment script running on the VM."

# Describe the purpose of the script
log_message "This script updates packages, installs Docker, adds a user to the Docker group, and changes the hostname."

# Update and install packages
update_packages

# Add Docker
add_docker

# Add the user to the Docker group
add_user_to_docker "$user_name"

# Set hostname
change_hostname "$desired_hostname"

# Script execution completed successfully
timestamp=$(date +"%Y-%m-%d %T")
log_message "Script execution completed successfully."
exit 0
