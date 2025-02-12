# This module is common for the `floofbox` and `kotoha` machines. `miki` doesn't
# deserve this right since this is tailoured for NixOS rather than `nix-darwin`.
{pkgs, ...}: {
  # Set the timezone to `America/Los_Angeles`
  time.timeZone = "America/Los_Angeles";

  # Set our default locale, which is English (UK) even though
  # I live in the states but whatever?
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure `nix` itself.
  nix = {
    # Prefer the stable version of Nix
    package = pkgs.nixVersions.stable;

    # Set garbage collection to run weekly
    gc = {
      automatic = true;
      dates = "weekly";
    };

    settings = {
      # Allow the "experimental" flakes command to be allowed.
      experimental-features = "nix-command flakes";
      sandbox = false;

      # A list of trusted binary caches that we will use for Nix packages.
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://noel.cachix.org" # TODO: move to nix.floofy.dev
        "https://noelware.cachix.org" # TODO: move to nix.noelware.org
      ];

      # List of public keys used to sign binary caches.
      trusted-public-keys = [
        "noel.cachix.org-1:pQHbMJOB5h5VqYi3RV0Vv0EaeHfxARxgOhE9j013XwQ="
        "noelware.cachix.org-1:22A8ELRjkqEycSHz+R5A5ReX2jyjU3rftsBmlD6thn0="
      ];

      substituters = [
        "https://noel.cachix.org"
        "https://noelware.cachix.org"
      ];
    };
  };

  # Enable fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.geist-mono

      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts

      jetbrains-mono
      inter
    ];
  };

  services = {
    gnome.gnome-keyring.enable = true;
    openssh.enable = true;
  };

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

  # We will also configure the DE and sound here since both
  # systems are near identical on how they're configured.

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

  programs.gnupg.agent = {
    enableSSHSupport = true;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    vulkan-tools
    terraform
    minikube
    opentofu
    kubectl

    (wrapHelm kubernetes-helm {
      plugins = [charted-helm-plugin];
    })

    terraform-ls
    alejandra
    nixd

    wireguard-tools
    postgresql_16
    minio-client
    pkg-config
    libarchive
    hyfetch
    pciutils
    tcpdump
    ripgrep
    gnumake
    direnv
    hclfmt
    gnutar
    netcat
    unzip
    tokei
    whois
    which
    mold
    llvm
    nano
    gzip
    tree
    file
    htop
    dig
    zip
    git
    gcc
    yq
    jq
    uv

    # Zig
    zls
    zig

    # C++/Protobuf tools
    clang-tools_18
    clang_18
    protobuf

    # Bazel
    bazel_7
    bazel-buildtools

    # Rust - https://rust-lang.org
    cargo-whatfeatures
    cargo-machete
    cargo-nextest
    cargo-expand
    cargo-cache
    cargo-deny
    rustup

    # Node.js - https://nodejs.org/en
    nodePackages."@tailwindcss/language-server"
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server

    nodePackages.typescript # for tsc
    nodePackages.prettier # for prettier
    nodePackages.pnpm # pnpm > *
    nodejs

    # Bun - https://bun.sh
    bun

    # noelctl
    # noeldoc
    ume

    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
  ];
}
