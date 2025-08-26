#!/bin/bash

source ./.github/scripts/setup.sh

# Run tests
nox

# Exit virtual environment
deactivate