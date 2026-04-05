#!/bin/bash

echo "Starting Docker cleanup..."
echo "==========================="
docker container prune -f
docker network prune -f
docker builder prune -f
echo "============================"
echo "Docker cleanup completed successfully."
