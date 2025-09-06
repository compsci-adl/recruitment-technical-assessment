#!/usr/bin/env bash
set -euo pipefail

# Cleanup function to run on EXIT
function cleanup {
    echo
    echo "Cleaning up..."
    if [[ -n "${SERVER_PID:-}" ]]; then
        echo "Killing Flask server (PID $SERVER_PID)..."
        kill "$SERVER_PID" 2>/dev/null || true
    fi
    if [[ -n "${VIRTUAL_ENV:-}" ]]; then
        echo "Deactivating virtual environment..."
        deactivate || echo "Already deactivated."
    fi
}
trap cleanup EXIT

# Create and activate venv
echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install dependencies
if [[ -f requirements.txt ]]; then
    echo "Installing dependencies..."
    pip install --upgrade pip >/dev/null
    pip install -r requirements.txt >/dev/null
else
    echo "requirements.txt not found, skipping install."
fi

# Start the Flask server in background
echo "Starting Flask server..."
python task.py &  # task.py must define the Flask app
SERVER_PID=$!

# Give the server a moment to start
sleep 1

# Run autotester
echo "Running autotester..."
pytest ../autotester/test.py
