#!/bin/bash
set -e
cd /home/ubuntu/flask-ci-cd-app
source venv/bin/activate
nohup python app.py > app.log 2>&1 &
