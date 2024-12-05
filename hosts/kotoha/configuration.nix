# Edit this configuration file to define what should be installed on
# your system.  Help is avaliable in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{pkgs, ...}: {
  imports = [
    ../../software/development.nix
    ../../software/graphical.nix
    ../../software/system.nix

    ../../modules/virtualisation/docker.nix
    ../../modules/bluetooth.nix
    ../../modules/windowing.nix
    ../../modules/system.nix
    ../../modules/sound.nix

    ../../users/noel
    ./hardware.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      efiSupport = true;
      device = "nodev"; # required for EFI usage
      enable = true;
      configurationLimit = 1;
    };
  };

  # use latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking stuff
  networking = {
    hostName = "kotoha";
    nameservers = ["1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4"];
    networkmanager.enable = true;
  };

  # Enable fwupd service since BIOS updates are through
  # LVFS.
  services.fwupd = {
    enable = true;
    package =
      (import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
          sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
        }) {
          inherit (pkgs) system;
        })
      .fwupd;
  };

  # Enable this for fingerprint scanner
  services.fprintd.enable = true;

  # enable OpenSSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      TcpKeepAlive = true;
      KbdInteractiveAuthentication = false;
    };
  };

  # Graphics configuration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [mesa.drivers];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
