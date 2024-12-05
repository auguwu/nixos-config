{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [cnijfilter2];
  };

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
    # kde packages
    plasma5Packages.print-manager
    plasma5Packages.filelight
    plasma5Packages.krdc

    # fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    jetbrains-mono
    noto-fonts
    fira-code
    inter

    # apps
    hunspellDicts.en_US
    kubernetes-helm
    libreoffice-qt
    vulkan-tools
    terraform
    opentofu
    minikube
    hunspell
    kubectl

    # lsp
    terraform-ls
    alejandra
    nixd

    # external
    wireguard-tools
    postgresql_16
    minio-client
    clang-tools
    pkg-config
    libarchive
    coreutils
    neofetch # a must need
    pciutils
    tcpdump
    ripgrep
    gnumake
    cachix
    direnv
    hclfmt
    gnutar
    netcat
    redis
    cmake
    ninja
    unzip
    tokei
    whois
    which
    mold
    llvm
    nano
    gzip
    glab
    tree
    file
    htop
    dig
    zip
    lld
    git
    gcc
    yq
    jq
    uv
  ];
}
