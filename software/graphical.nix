{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Browser
    firefox

    # Terminal for other servers
    termius

    # Password Management
    bitwarden-cli
    bitwarden

    # Flameshot
    flameshot

    # chat applications
    telegram-desktop
    (discord-canary.override {
      withVencord = true;
    })

    # always need my music
    spotify

    # Mail Client
    thunderbird
    slack
  ];
}
