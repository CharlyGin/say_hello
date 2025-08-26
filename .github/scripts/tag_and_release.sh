#!/bin/bash

# Usage: ./tag_and_release.sh [pre-release]

PRE_RELEASE=$1

if [ -z "$GH_TOKEN" ]; then
  echo "Error: GH_TOKEN is not set."
  exit 1
fi

BASE_DIR=$(pwd)
VERSION=$(awk -F'"' '/^version/ {print $2}' pyproject.toml)

echo "Cloning pipelines repository..."
git clone https://github.com/CharlyGin/pipelines.git ~/pipelines

# Setting up virtual environment
cd ~/pipelines
source $BASE_DIR/.github/scripts/setup.sh

cd $BASE_DIR
if [ "$PRE_RELEASE" = "true" ]; then
  uv run ~/pipelines/scripts/tag_and_release.py --pre-release --tag $VERSION --app $BASE_DIR
else
  uv run ~/pipelines/scripts/tag_and_release.py --tag $VERSION --app $BASE_DIR
fi

# Deactivating virtual environment
deactivate