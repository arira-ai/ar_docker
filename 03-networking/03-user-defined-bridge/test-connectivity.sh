#!/bin/bash

echo "Testing DNS-based connectivity from frontend to backend..."

docker exec frontend ping -c 3 backend

if [ $? -eq 0 ]; then
  echo "SUCCESS: frontend can reach backend using DNS name"
else
  echo "FAILURE: DNS resolution not working"
fi