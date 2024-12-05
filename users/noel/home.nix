{
  pkgs,
  lib,
  graphical ? false,
  machine,
  ...
}: let
  homedir =
    if pkgs.stdenv.isDarwin
    then "/Users/noel"
    else "/home/noel";
in {
  imports =
    [
      ../../software/bat.nix
      ../../software/git.nix
      ../../software/eza.nix
      ../../software/gh.nix
    ]
    ++ lib.flatten (lib.optional graphical ../../software/graphical/home-manager.nix);

  home.sessionVariables = {
    KUBECONFIG = lib.concatStringsSep ":" ["/etc/rancher/k3s/k3s.yaml" "${homedir}/.kube/config"];
    EDITOR = "nano";
    VISUAL = "code-insiders";
  };

  home.homeDirectory = homedir;
  home.stateVersion = "23.05";
  home.username = "noel";
  home.file = {
    ".scripts/actions-delete".source = ../../scripts/actions-delete;
    ".wallpapers/furry.jpg".source = ../../wallpapers/furry.jpg;
    ".scripts/rebuild".source = ../../hosts/${machine}/rebuild.sh;
    ".icons/noel.png".source = ../../icons/noel.png;
  };

  home.shellAliases = {
    grep = "rg";
    cat = "bat -p";
    ls = "eza -l -S -F -a";
    dc = "docker compose";
    tf = "terraform";
  };

  # allow home-manager to handle itself
  programs.home-manager.enable = true;

  # gpg stuff
  programs.gpg.enable = true;

  # oh my zsh stuff
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      plugins = [
        "terraform"
        "redis-cli"
        "postgres"
        "minikube"
        "kubectl"
        "gradle"
        "bazel"
        "docker"
        "helm"
        "rust"
        "git"
        "gh"
      ];

      enable = true;
      theme = "af-magic";
      extraConfig = ''
        zstyle ':omz:update' mode reminder
        zstyle ':omz:update' frequency 30

        # [docker] enable option stacking
        zstyle ':completion:*:*:docker-*:*' option-stacking yes
        zstyle ':completion:*:*:docker:*' option-stacking yes

        # add direnv hook
        eval "$(direnv hook zsh)"
      '';
    };
  };
}
