#!/usr/bin/env bash

set -e

VENV_DIR="${1:-venv}"

echo "SPBOT SETUP STARTING..."

echo "Checking python3..."
if ! command -v python3 >/dev/null 2>&1; then
echo "python3 not found"
exit 1
fi

echo "Creating virtual environment..."
python3 -m venv "$VENV_DIR"

echo "Activating venv..."
source "$VENV_DIR/bin/activate"

echo "Upgrading pip..."
pip install --upgrade pip wheel

echo "Fixing setuptools pkg_resources..."
pip uninstall setuptools -y || true
pip install setuptools==69.5.1

echo "Installing dependencies..."
pip install python-dotenv cryptography httpx
pip install "python-telegram-bot>=22.0,<23.0"
pip install instagrapi psutil
pip install playwright playwright-stealth==1.0.6

echo "Installing browsers..."
playwright install

echo "Starting bot..."
python3 spbot5.py
