#!/bin/bash

echo "Starting container with none network..."

docker run -dit --name none-test --network none busybox sh

echo "Checking network interfaces inside container..."
docker exec none-test ip addr

echo "Testing internet connectivity (expected to fail)..."
docker exec none-test ping -c 2 google.com || echo "Ping failed as expected"

echo "Cleaning up..."
docker stop none-test
docker rm none-test

echo "None network verification completed"