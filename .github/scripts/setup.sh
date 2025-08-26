#!/bin/bash

echo "Setting up virtual environment..."

if [ ! -d .venv ]; then
  echo "Creating virtual environment..."
  uv venv .venv
fi

echo "Activating virtual environment..."
source .venv/bin/activate

echo "Installing dependencies..."
uv sync --active --locked --all-extras --dev