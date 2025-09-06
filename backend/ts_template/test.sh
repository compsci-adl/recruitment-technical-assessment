#!/usr/bin/env bash
set -euo pipefail

# Cleanup function to run on EXIT
function cleanup {
    echo
    echo "Cleaning up..."
    if [[ -n "${SERVER_PID:-}" ]]; then
        echo "Killing Express server (PID $SERVER_PID)..."
        kill "$SERVER_PID" 2>/dev/null || true
    fi
    if [[ -n "${VIRTUAL_ENV:-}" ]]; then
        echo "Deactivating virtual environment..."
        deactivate || echo "Already deactivated."
    fi
}
trap cleanup EXIT

# Create and activate venv for autotester
VENV_DIR="../autotester/.venv"
if [ ! -d "$VENV_DIR" ]; then
	echo "Creating virtual environment for autotester..."
	python3 -m venv "$VENV_DIR"
fi
source "$VENV_DIR/bin/activate"
echo "Installing dependencies into venv..."
pip install -r ../autotester/requirements.txt

echo "Starting TypeScript Express server..."
ts-node task.ts &  # Starts server in background
SERVER_PID=$!

# Give the server a moment to start
sleep 1

# Run autotester
echo "Running autotester..."
pytest ../autotester/test.py
