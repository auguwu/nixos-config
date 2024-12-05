{pkgs, ...}: {
  programs.gh = {
    enable = true;
    settings = {
      # workaround for https://github.com/nix-community/home-manager/issues/4744
      version = 1;
      git_protocol = "ssh";
      editor = "${pkgs.nano}/bin/nano"; # use `nano` for the editor
    };

    extensions = with pkgs; [
      gh-actions-cache
    ];
  };
}
