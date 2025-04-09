{pkgs, ...}: {
  # Set our default locale, which is English (UK) even though
  # I live in the states but whatever?
  i18n.defaultLocale = "en_GB.UTF-8";

  # use zsh as our shell
  environment.shells = [pkgs.zsh];

  # configure zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      grep = "rg";
      cat = "bat -p";
      ls = "eza -l -S -F -a";
      dc = "docker compose";
      tf = "terraform";
    };
  };

  # disable pulseaudio
  services.pulseaudio.enable = false;

  # sound (PipeWire)
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;

  services.xserver = {
    xkb.layout = "us";

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    desktopManager.gnome.enable = true;
  };

  programs.dconf.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      openssl
      fuse3
      glibc
      curl
      zlib
      icu
      nss
    ];
  };
}
