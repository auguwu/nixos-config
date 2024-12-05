{pkgs, ...}: {
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
}
