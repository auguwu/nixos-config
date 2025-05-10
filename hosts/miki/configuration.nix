{pkgs, ...}: {
  imports = [
    ../../modules/common/miki.nix
    ../../modules/common
  ];

  # networking stuff
  networking = {
    hostName = "miki";
    computerName = "Noel's Mac Mini";
  };

  # service stuff
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
  };

  environment.systemPackages = with pkgs; [
    # graphical
    telegram-desktop
    flameshot
    raycast
    spotify
    slack
  ];

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      autoUpdate = true;
    };

    # nixpkgs for the software on Darwin is kinda
    # fucked in a way, so we'll use Homebrew for now.
    casks = [
      "discord@canary"
      "firefox"
      "visual-studio-code@insiders"
    ];
  };

  # The value is used to backwards‐incompatible changes in default settings.
  # You should usually set this once when installing nix-darwin on a new system
  # and then never change it (at least without reading all the relevant
  # entries in the changelog using `darwin-rebuild changelog`).
  system.stateVersion = 5;
}
