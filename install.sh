#!/bin/bash

ROOT=~/.certbot-src

# Remove older versions if existing, for a simple re-install/update.
rm -rf $ROOT

# Clone certbot source.
git clone https://github.com/certbot/certbot $ROOT

# Check if python3-venv is installed, and install it otherwise.
CHECK_PACKAGES='python3-venv git'
if ! dpkg -s $CHECK_PACKAGES >/dev/null 2>&1; then
  echo "The packages '$CHECK_PACKAGES' are not installed. "
  echo "They will now be installed automatically with 'sudo apt-get install $CHECK_PACKAGES'."
  sudo apt-get install -y $CHECK_PACKAGES
fi

# Setup virtual environment for certbot.
cd $ROOT
sudo apt-get install -y python3-dev python3-venv gcc libaugeas0 libssl-dev libffi-dev ca-certificates openssl
python3 tools/venv.py

# Link installed certbot version, so it can used everywhere.
sudo ln -s $ROOT/venv/bin/certbot /usr/local/bin/
