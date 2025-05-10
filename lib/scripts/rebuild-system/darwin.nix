{
  machine,
  pkgs,
}: let
  inherit
    (pkgs)
    darwin-rebuild
    git
    writeShellApplication
    ;
in
  writeShellApplication {
    name = "rebuild-system";
    runtimeInputs = [darwin-rebuild git];

    # We intentionally don't use any bash options
    bashOptions = [];

    text = ''
      (cd /etc/nixos && git pull origin master) 2>/dev/null
      darwin-rebuild switch --flake /etc/nix-darwin#${machine}
    '';
  }
