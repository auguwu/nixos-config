#!/usr/bin/env bash

(cd /etc/nixos && git pull origin master) >/dev/null
(set -euo pipefail && sudo nixos-rebuild switch --flake /etc/nixos#floofbox \
    --show-trace \
    --log-format internal-json 2>&1 |& nom --json)
