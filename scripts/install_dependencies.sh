#!/bin/bash
cd /home/ubuntu/flask-ci-cd-app
sudo apt-get update -y
sudo apt-get install -y python3-pip python3-venv
pip3 install -r requirements.txt
