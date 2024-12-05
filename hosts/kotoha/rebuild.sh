#!/usr/bin/env bash

(cd /etc/nixos && git pull origin master) >/dev/null
sudo nixos-rebuild switch --flake /etc/nixos#kotoha --show-trace
