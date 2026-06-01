#!/usr/bin/env bash

set -e

echo "Starting full build + test process..."

if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

echo "Activating virtual environment..."
source venv/bin/activate


echo "Upgrading pip..."
pip install --upgrade pip


echo "Installing dependencies..."
pip install -r requirements.txt


echo "Running app.py..."
python app.py


echo "Checking good.json..."
python3 -m json.tool good.json > /dev/null
echo "good.json is VALID"


echo "Checking bad.json..."
set +e
python3 -m json.tool bad.json > /dev/null

if [ $? -ne 0 ]; then
    echo "bad.json is INVALID (expected behavior)"
else
    echo "WARNING: bad.json should have failed but didn't"
fi
set -e


echo "Build + app run + JSON tests completed!"