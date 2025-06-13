#!/bin/bash

curl -fsSL https://raw.githubusercontent.com/magidandrew/infra-scripts/main/bootstrap/debian/podman_install.sh | bash
curl -fsSL https://raw.githubusercontent.com/magidandrew/infra-scripts/main/bootstrap/debian/app-deps.sh | bash
curl -fsSL https://raw.githubusercontent.com/magidandrew/infra-scripts/main/bootstrap/debian/setup-gh-repo.sh | bash