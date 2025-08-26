#!/bin/bash

# Usage: ./publish.sh [pre-release]

PRE_RELEASE=$1

# Check UV_PUBLISH_TOKEN is set
if [ -z "$UV_PUBLISH_TOKEN" ]; then
  echo "Error: UV_PUBLISH_TOKEN is not set."
  exit 1
fi

source .github/scripts/setup.sh

uv build

if [ "$PRE_RELEASE" = "true" ]; then
  uv publish --index testpypi
else
  uv publish
fi

# Exit virtual environment
deactivate