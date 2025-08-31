#!/usr/bin/env bash
set -e

echo "Starting TypeScript Express server..."
ts-node task.ts &  # Starts server in background
SERVER_PID=$!

sleep 1
echo "Running generic tests..."
python3 ../autotester/test.py ts

kill $SERVER_PID
