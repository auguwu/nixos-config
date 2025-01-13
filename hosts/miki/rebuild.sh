#!/usr/bin/env bash

(cd /etc/nix-darwin && git pull origin master) >/dev/null
darwin-rebuild switch --flake /etc/nix-darwin#miki --show-trace
