#!/usr/bin/env bash
set -euo pipefail

# Deactivate virtual environment
function cleanup {
    echo
    echo "Cleaning up..."
    if [[ "$VIRTUAL_ENV" != "" ]]; then
        echo "Deactivating virtual environment..."
        deactivate || echo "Already deactivated."
    else
        echo "No active virtual environment found."
    fi
}
trap cleanup EXIT

# Create and activate virtual environment
echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install dependencies
if [[ -f requirements.txt ]]; then
    echo "Installing dependencies..."
    pip install --upgrade pip >/dev/null
    pip install -r requirements.txt
else
    echo "requirements.txt not found. Skipping install."
fi

# Run the task
echo "Running task.py..."
python task.py
