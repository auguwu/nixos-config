{pkgs, ...}: {
  # Configure time-related stuff
  time.timeZone = "America/Los_Angeles";

  # Next, configure Nix
  nix = {
    package = pkgs.nixVersions.stable;
    channel.enable = false;
    gc = {
      automatic = true;
      interval.Day = 7;
    };

    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = ["noel"];
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://noel.cachix.org" # TODO: replace with nix.floofy.dev
        "https://noelware.cachix.org" # TODO: replace with nix.noelware.org
      ];

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

  # networking stuff
  networking = {
    hostName = "miki";
    computerName = "Mac Mini";
  };

  # service stuff
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
  };

  # configure fonts
  fonts = {
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

  # Programs that are :3c
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    # applications
    kubernetes-helm
    opentofu
    minikube
    kubectl

    # LSPs
    terraform-ls
    alejandra
    nil

    # graphical
    telegram-desktop
    flameshot
    spotify
    slack

    # others
    clang-tools
    fastfetch
    ripgrep
    direnv
    hclfmt
    gnutar
    cmake
    ninja
    htop
    git
    yq
    jq
    uv

    clang_17
    protobuf

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
    nodejs_20
    eslint

    # Bun - https://bun.sh
    bun

    # noelctl
    # foxbuild
    # noeldoc
    # ume
  ];

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

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
