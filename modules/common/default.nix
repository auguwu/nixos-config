# This module is common for ALL hosts.
{
  pkgs,
  machine,
  ...
}: {
  time.timeZone = "America/Los_Angeles";

  # Configure `nix` itself.
  nix = {
    # Prefer the stable version of Nix
    package = pkgs.nixVersions.stable;

    # Optimise /nix automatically per build
    optimise.automatic = true;

    # Set garbage collection to run weekly
    gc = {
      automatic = true;
      dates = "weekly";
    };

    settings = {
      # Allow the "experimental" flakes command to be allowed.
      experimental-features = "nix-command flakes";
      sandbox = machine == "miki";
      trusted-users = ["noel"];
      auto-optimise-store = true;

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

  fonts = {
    fontDir.enable = machine != "miki";
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

  programs.gnupg.agent = {
    enableSSHSupport = true;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    (wrapHelm kubernetes-helm {
      plugins = [charted-helm-plugin];
    })

    minio-client
    minikube
    opentofu
    kubectl

    # lsps
    terraform-ls
    alejandra
    nil

    # other utilities
    nix-output-monitor
    ripgrep
    direnv
    netcat
    unzip
    tokei
    whois
    which
    nano
    gzip
    tree
    file
    htop
    dig
    zip
    git
    yq
    jq
    uv

    # C++/Protobuf
    clang-tools_18
    clang_18
    protobuf

    # Bazel
    bazel-buildtools
    bazel_7

    # Rust
    cargo-whatfeatures
    cargo-upgrades
    cargo-nextest
    cargo-machete
    cargo-cache
    cargo-deny
    rustup

    # Node.js
    nodejs_latest

    # Other utilties
    # noelctl
    # noeldoc

    ume
  ];
}
