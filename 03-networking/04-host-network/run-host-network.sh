#!/bin/bash

echo "Running Nginx container using host network..."

docker run -d --name host-net-demo --network host nginx

sleep 3

echo "Access Nginx at: http://localhost"
echo "Stopping container in 10 seconds..."

sleep 10

docker stop host-net-demo
docker rm host-net-demo

echo "Host network demo completed"