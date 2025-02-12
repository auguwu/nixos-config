{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    termius
    flameshot
    telegram-desktop
    (discord-canary.override {
      withVencord = true;
    })

    spotify
    thunderbird
    slack
    # cattle
    # seoul
  ];
}
