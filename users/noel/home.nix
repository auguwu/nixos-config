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

  laptop-dconf = {
    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };

    "org/gnome/shell" = {
      last-selected-power-profile = "performance";
    };
  };

  buildAutoStartFiles = applications: builtins.listToAttrs(
    lib.map (pkg: {
      name = ".config/autostart/${pkg.pname}.desktop";
      value = if pkg ? desktopItem
        then {
          text = pkg.desktopItem.text;
        }
        else {
          source = "${pkg}/share/applications/${pkg.pname}.desktop";
        };
    }) applications
  );
in {
  imports = lib.flatten (lib.optional graphical ../../modules/graphical.home-manager.nix);
  home.sessionVariables = {
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
  } // (buildAutoStartFiles (with pkgs; [
    (discord-canary.override {
      withVencord = true;
    })

    telegram-desktop
    slack
  ]));

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
      includeIf."gitdir:/Workspaces/Noelware/Internal/".path = "/Workspaces/Noelware/.gitconfig";
      includeIf."gitdir:/Workspaces/Noel/Internal/".path = "/Workspaces/Noel/.gitconfig";
    };
  };

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

  programs.eza = {
    enable = true;
    git = true;
  };

  programs.bat = {
    enable = true;
    config.theme = "Nord";
  };

  dconf = {
    enable = machine != "miki";
    settings = {
      "org/gnome/desktop/screensaver" = {
        picture-uri = if machine == "floofbox"
          then "file://${../../wallpapers/furry.jpg}"
          else "file://${../../wallpapers/zzz.png}";
      };

      "org/gnome/desktop/background" = {
        picture-uri = if machine == "floofbox"
          then "file://${../../wallpapers/furry.jpg}"
          else "file://${../../wallpapers/zzz.png}";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = "Adwaita";
        accent-color = "pink";
        show-battery-percentage = machine == "kotoha";
      };

      "org/gnome/shell" = {
        enabled-extensions = [
          pkgs.gnomeExtensions.dash-to-dock.extensionUuid
          pkgs.gnomeExtensions.appindicator.extensionUuid

          "docker@stickman_0x00.com"
          "status-icons@gnome-shell-extensions.gcampax.github.com"
          "system-monitor@gnome-shell-extensions.gcampax.github.com"
        ];

        favorite-apps = [
          "firefox.desktop"
          "discord-canary.desktop"
          "code-insiders.desktop"
          "spotify.desktop"
          "org.gnome.Nautilus.desktop"
          "org.telegram.desktop.desktop"
          "slack.desktop"
          "com.mitchellh.ghostty.desktop"
          "thunderbird.desktop"
        ];
      };

      "org/gnome/shell/extensions/system-monitor" = {
        show-download = false;
        show-upload = false;
      };

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-schedule-automatic = false;
        night-light-enabled = true;
        night-light-temperature = 3500;
      };
    } // laptop-dconf;
  };
}
