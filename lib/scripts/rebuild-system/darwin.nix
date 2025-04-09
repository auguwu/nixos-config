{
  machine,
  pkgs,
}: let
  inherit
    (pkgs)
    darwin-rebuild
    git
    nix-output-monitor
    writeShellApplication
    ;
in
  writeShellApplication {
    name = "rebuild-system";
    runtimeInputs = [darwin-rebuild git nix-output-monitor];

    # We intentionally don't use any bash options
    bashOptions = [];

    text = ''
      (cd /etc/nixos && git pull origin master) 2>/dev/null
      (set -euo pipefail && darwin-rebuild switch --flake /etc/nixos#${machine} \
        --show-trace \
        --log-format internal-json 2>&1 |& nom --json)
    '';
  }
