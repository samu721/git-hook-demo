#!/bin/bash
# clone-and-setup.sh

git clone "$@"
repo_name=$(basename "$1" .git)
cd "$repo_name"
git config core.hooksPath .githooks
bash build.bash