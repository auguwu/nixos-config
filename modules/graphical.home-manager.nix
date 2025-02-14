{
  pkgs,
  machine,
  ...
}: {
  programs.ghostty = {
    # on macOS, ghostty is currently broken!
    enable = machine != "miki";
    installBatSyntax = true;
    enableZshIntegration = true;
    settings = {
      font-family = "JetBrains Mono";
      theme = "rose-pine";
      font-size = 14;
    };
  };

  # view above; move to ghostty once it is not broken
  programs.alacritty = {
    enable = machine == "miki";
    settings = {
      terminal.shell = "${pkgs.zsh}/bin/zsh";

      # Rose Pine
      colors = {
        primary.background = "0x191724";
        primary.foreground = "0xe0def4";

        cursor.text = "0xe0def4";
        cursor.cursor = "0x524f67";

        selection.text = "0xe0def4";
        selection.background = "0x403d52";

        normal.black = "0x26233a";
        normal.red = "0xeb6f92";
        normal.green = "0x31748f";
        normal.yellow = "0xf6c177";
        normal.blue = "0x9ccfd8";
        normal.magenta = "0xc4a7e7";
        normal.cyan = "0xebbcba";
        normal.white = "0xe0def4";

        bright.black = "0x6e6a86";
        bright.red = "0xeb6f92";
        bright.green = "0x31748f";
        bright.yellow = "0xf6c177";
        bright.blue = "0x9ccfd8";
        bright.magenta = "0xc4a7e7";
        bright.cyan = "0xebbcba";
        bright.white = "0xe0def4";
        hints = {
          start.foreground = "#908caa";
          start.background = "#1f1d2e";

          end.foreground = "#6e6a86";
          end.background = "#1f1d2e";
        };
      };

      # font configuration
      font.size = 16;
      font.normal = {
        family = "JetBrains Mono";
        style = "Regular";
      };

      font.italic = {
        family = "JetBrains Mono";
        style = "Italic";
      };

      font.bold = {
        family = "JetBrains Mono";
        style = "Bold";
      };

      font.bold_italic = {
        family = "JetBrains Mono";
        style = "Bold Italic";
      };
    };
  };

  programs.vscode = {
    enable = machine != "miki";
    package =
      (pkgs.vscode.override {
        isInsiders = true;
      })
      .overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [pkgs.krb5];
        version = "latest";
        pname = "vscode-insiders";
        src = builtins.fetchTarball {
          sha256 = "sha256:0kd30ydwn1bkaf5jmwwy5rb83jrpnd48saahacg0acn57100x1h7";
          url = "https://vscode.download.prss.microsoft.com/dbazure/download/insider/f80816ab8e21c65ed7f1f7e08ccdbffae63610c6/code-insider-x64-1736506030.tar.gz";
        };
      });

    extensions = with pkgs.vscode-extensions;
      [
        kamadorueda.alejandra
        astro-build.astro-vscode
        llvm-vs-code-extensions.vscode-clangd
        ms-vscode-remote.remote-containers
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        bradlc.vscode-tailwindcss
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode
        mkhl.direnv
        ms-azuretools.vscode-docker
        github.vscode-github-actions
        tamasfe.even-better-toml
        golang.go
        hashicorp.terraform
        ms-kubernetes-tools.vscode-kubernetes-tools
        pkief.material-icon-theme
        ms-vscode-remote.remote-ssh
        redhat.vscode-yaml
        xaver.clang-format
        biomejs.biome
        skellock.just
        unifiedjs.vscode-mdx
        mesonbuild.mesonbuild
        bazelbuild.vscode-bazel
        # auguwu.buf-vscode
        # noelware.noeldoc
        # noelware.provisionerd
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "discord-vscode";
          publisher = "icrawl";
          version = "5.8.0";
          sha256 = "sha256-IU/looiu6tluAp8u6MeSNCd7B8SSMZ6CEZ64mMsTNmU=";
        }

        {
          name = "hcl";
          publisher = "hashicorp";
          version = "0.6.0";
          sha256 = "sha256-Za2ODrsHR/y0X/FOhVEtbg6bNs439G6rlBHW84EZS60=";
        }

        {
          name = "iconify";
          publisher = "antfu";
          version = "0.9.5";
          sha256 = "sha256-n3JYH4oFhoQh6QXZqo7y+Y4eRIboq9DzeFQei23SZC4=";
        }

        {
          name = "vscode-github-actions";
          publisher = "me-dutour-mathieu";
          version = "3.0.1";
          sha256 = "sha256-I5qZk/svJIlnV2ggwMLu5Bfvly3vyshT5y51V4/nQLI=";
        }

        {
          name = "pretty-ts-errors";
          publisher = "yoavbls";
          version = "0.6.0";
          sha256 = "sha256-JSCyTzz10eoUNu76wNUuvPVVKq4KaVKobS1CAPqgXUA=";
        }

        {
          name = "remote-explorer";
          publisher = "ms-vscode";
          version = "0.5.2024081309";
          sha256 = "sha256-YExf9Yyo7Zp0Nfoap8Vvtas11W9Czslt55X9lb/Ri3s=";
        }

        {
          name = "volar";
          publisher = "Vue";
          version = "2.1.8";
          sha256 = "sha256-EfRK5LFk3IPgNPvibxiWwHq+7tkLPIPawM1WdwM5P8A=";
        }

        {
          name = "theme-vitesse";
          publisher = "antfu";
          version = "0.8.3";
          sha256 = "sha256-KkpJgJBcnMeQ1G97QS/E6GY4/p9ebZRaA5pUXPd9JB0=";
        }

        {
          name = "lalrpop-syntax-highlight";
          publisher = "guyutongxue";
          version = "0.0.5";
          sha256 = "sha256-VJBvR9pM0NPYi/RUoVQcL1tt2PZCKohwX8Dd1nz0UGY=";
        }
      ];

    userSettings = {
      "telemetry.telemetryLevel" = "off";

      "workbench.colorTheme" = "Vitesse Dark";
      "workbench.iconTheme" = "eq-material-theme-icons-ocean";
      "workbench.startupEditor" = "none";

      "editor.tabSize" = 4;
      "editor.insertSpaces" = true;
      "editor.parameterHints.enabled" = false;
      "editor.inlineSuggest.enabled" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.formatOnSave" = true;
      "editor.formatOnPaste" = true;
      "editor.bracketPairColorization.enabled" = false;
      "editor.fontFamily" = "'JetBrains Mono', Consolas, 'Courier New', monospace";
      "editor.fontSize" = 17;
      "editor.minimap.enabled" = false;
      "editor.detectIndentation" = false;
      "editor.largeFileOptimizations" = false;
      "editor.semanticHighlighting.enabled" = false;
      "editor.stickyScroll.enabled" = false;
      "editor.quickSuggestions" = {
        "other" = true;
        "comments" = false;
        "strings" = false;
      };

      "update.mode" = "off";

      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;
      "files.insertFinalNewline" = true;
      "files.associations" = {
        ".*-version" = "plaintext";
      };

      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;

      "debug.javascript.codelens.npmScripts" = "never";

      "git.timeline.showAuthor" = false;

      "diffEditor.ignoreTrimWhitespace" = false;

      "typescript.updateImportsOnFileMove.enabled" = "never";

      "discord.detailsEditing" = "Editing file {file_name}";
      "discord.detailsIdling" = "Idling... zzz~";
      "discord.largeImageIdling" = "Idling... zzz~";
      "discord.lowerDetailsNoWorkspaceFound" = "(no workspace?!)";

      "terminal.integrated.defaultProfile.windows" = "PowerShell";
      "terminal.integrated.tabs.enabled" = true;

      "eslint.validate" = [
        "typescript"
        "javascript"
        "typescriptreact"
        "javascriptreact"
        "html"
        "vue"
        "astro"
      ];

      "eslint.probe" = [
        "typescript"
        "javascript"
        "typescriptreact"
        "javascriptreact"
        "html"
        "vue"
        "astro"
      ];

      "security.workspace.trust.untrustedFiles" = "open";
      "notebook.Unable to find PowerShell! Do you have it installed? You can also configure custom installations with the 'powershell.powerShellAdditionalExePaths' setting.cellToolbarLocation" = {
        "juypter-notebook" = "left";
        "default" = "right";
      };

      "prettier.vueIndentScriptAndStyle" = true;
      "prettier.requireConfig" = true;

      "redhat.telemetry.enabled" = false;

      "go.toolsManagement.autoUpdate" = true;

      "javascript.updateImportsOnFileMove.enabled" = "never";

      "vs-kubernetes"."vs-kubernetes.crd-code-completion" = "enabled";

      "[yaml]"."editor.quickSuggestions" = {
        other = true;
        comments = true;
        strings = true;
      };

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
      "terraform.languageServer.path" = "${pkgs.terraform-ls}/bin/terraform-ls";
      "clang-format.executable" = "${pkgs.clang-tools}/bin/clang-format";

      "zig.zls.enabled" = "on";
      "zig.zls.path" = "${pkgs.zls}/bin/zls";

      "[terraform-vars]"."editor.defaultFormatter" = "hashicorp.terraform";
      "[terraform]"."editor.defaultFormatter" = "hashicorp.terraform";
      "[toml]"."editor.defaultFormatter" = "tamasfe.even-better-toml";
      "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
      "[cpp]"."editor.defaultFormatter" = "xaver.clang-format";
      "[zig]"."editor.defaultFormatter" = "ziglang.vscode-zig";
      "[c]"."editor.defaultFormatter" = "xaver.clang-format";
      "[h]"."editor.defaultFormatter" = "xaver.clang-format";

      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
        "editor.tabSize" = 2;
      };

      "window.zoomLevel" = 0.7;
      "window.titleBarStyle" = "custom";

      "terminal.integrated.fontSize" = 16;

      # unfortunately i need powershell to exist
      # i wish it didn't tho but life is life
      "powershell.powerShellDefaultVersion" = "nixpkgs";
      "powershell.powerShellAdditionalExePaths" = {
        "nixpkgs" = "${pkgs.powershell}/bin/pwsh";
      };

      "cmake.pinnedCommands" = [
        "workbench.action.tasks.configureTaskRunner"
        "workbench.action.tasks.runTask"
      ];
    };
  };
}
