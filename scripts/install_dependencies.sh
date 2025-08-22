#!/bin/bash
set -e

cd /home/ubuntu/flask-ci-cd-app

# Update and install Python packages
sudo apt-get update -y
sudo apt-get install -y python3-pip python3-venv

# Create virtual environment if it doesn't exist
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# Install dependencies inside venv
pip install -r requirements.txt
