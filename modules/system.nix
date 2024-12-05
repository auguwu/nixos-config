{pkgs, ...}: {
  imports = [
    ./shell.nix
  ];

  # timezone :Nod:
  time.timeZone = "America/Los_Angeles";

  # i18n stuff
  i18n.defaultLocale = "en_GB.UTF-8";

  # Nix settings
  nix = {
    package = pkgs.nixVersions.stable;
    gc = {
      automatic = true;
      dates = "weekly";
    };

    settings = {
      experimental-features = "nix-command flakes";
      sandbox = false;
      trusted-substituters = ["https://noel.cachix.org" "https://noelware.cachix.org" "https://cache.nixos.org"];
      trusted-public-keys = ["noel.cachix.org-1:pQHbMJOB5h5VqYi3RV0Vv0EaeHfxARxgOhE9j013XwQ=" "noelware.cachix.org-1:22A8ELRjkqEycSHz+R5A5ReX2jyjU3rftsBmlD6thn0="];
      substituters = ["https://noelware.cachix.org" "https://noel.cachix.org"];
    };
  };

  # fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [nerd-fonts.jetbrains-mono nerd-fonts.geist-mono];
  };

  # services
  services = {
    gnome.gnome-keyring.enable = true;
    vscode-server.enable = true;
    openssh.enable = true;
  };

  # allow unfree licenses
  nixpkgs.config.allowUnfree = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #system.copySystemConfiguration = true;
}
