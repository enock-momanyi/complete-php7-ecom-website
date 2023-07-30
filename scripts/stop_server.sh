#!/bin/bash

# Find the process ID (PID) of the PHP server running on port 8000
server_pid=$(lsof -ti :8000)

if [ -z "$server_pid" ]; then
  echo "No PHP server running on port 8000."
else
  # Terminate the PHP server process
  kill "$server_pid"
  echo "PHP server stopped successfully."
fi
