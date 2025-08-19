#!/bin/bash
cd /home/ubuntu/flask-ci-cd-app
nohup python3 app.py > app.log 2>&1 &
