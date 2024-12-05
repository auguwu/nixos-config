{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Noel";
    userEmail = "cutie@floofy.dev";
    lfs.enable = true;
    extraConfig = {
      user.signingkey = "63182D5FE7A237C9";
      init.defaultBranch = "master";
      pull.rebase = true; # i am getting better at this :>
      safe.directory = "*"; # i don't care, even though i probably should
      push.autoSetupRemote = true;
      includeIf."gitdir:/workspaces/Noelware/Internal/".path = "/workspaces/Noelware/.gitconfig";
      includeIf."gitdir:/workspaces/Noel/Internal/".path = "/workspaces/Noel/.gitconfig";
    };
  };
}
