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

  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transgender";
      mode = "rgb";
      color_align = {
        mode = "horizontal";
      };
    };
  };

  # programs.zed-editor = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     nil
  #     terraform-ls
  #     clang-tools
  #     zls
  #   ];

  #   userSettings = {
  #     vim_mode = false;
  #     format_on_save = "on";
  #     tab_size = 4;

  #     buffer_font_size = 19.6;
  #     buffer_font_family = "JetBrains Mono";

  #     current_line_highlight = "none";

  #     cursor_blink = true;

  #     ui_font_size = 16;
  #     ui_font_family = "Inter";

  #     theme = {
  #       mode = "system";
  #       light = "Vitesse Light";
  #       dark = "Vitesse Dark";
  #     };

  #     terminal = {
  #       font_family = "JetBrains Mono";
  #       font_size = 17;
  #     };

  #     features = {
  #       copilot = false;
  #     };

  #     telemetry = {
  #       metrics = false;
  #       diagnostics = true;
  #     };
  #   };
  # };

  programs.vscode = {
    enable = machine != "miki";
    package =
      (pkgs.vscode.override {
        isInsiders = true;
      })
      .overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [pkgs.krb5];
        version = "1.99.0-insiders";
        pname = "vscode-insiders";
        src = builtins.fetchTarball {
          sha256 = "sha256:1vad4rby7r4nfr9xqny49vavmrbh908h0n1f7bhjhq2igs7x325y";
          url = "https://vscode.download.prss.microsoft.com/dbazure/download/insider/ff52a0da2eeb3d4c590a85cf14ca13a9d6c1b2cd/code-insider-x64-1743053042.tar.gz";
        };
      });

    profiles.default = {
      extensions = with pkgs.vscode-extensions;
        [
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
          ms-vscode-remote.remote-ssh
          redhat.vscode-yaml
          xaver.clang-format
          skellock.just
          unifiedjs.vscode-mdx
          bazelbuild.vscode-bazel
          wakatime.vscode-wakatime
          ms-vscode.powershell
          catppuccin.catppuccin-vsc-icons

          # auguwu.buf-vscode
          # noelware.noeldoc
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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

          {
            name = "vscode-systemd-support";
            publisher = "hangxingliu";
            version = "3.0.0";
            sha256 = "sha256-K1fXE0AxkWdHsQC3uUFcJecJqB5PpJVzVdtfPSw4+eg=";
          }
        ];

      userSettings = {
        "telemetry.telemetryLevel" = "off";

        "workbench.colorTheme" = "Vitesse Dark";
        "workbench.iconTheme" = "catppuccin-latte";
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

        "update.mode" = "none";

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
        "notebook.cellToolbarLocation" = {
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
        "nix.serverSettings".nixd = {
          formatting.command = ["nix" "fmt" "--" "--"];
        };

        "clang-format.executable" = "${pkgs.clang-tools}/bin/clang-format";

        "[terraform-vars]"."editor.defaultFormatter" = "hashicorp.terraform";
        "[terraform]"."editor.defaultFormatter" = "hashicorp.terraform";
        "[toml]"."editor.defaultFormatter" = "tamasfe.even-better-toml";
        "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "[cpp]"."editor.defaultFormatter" = "xaver.clang-format";
        "[c]"."editor.defaultFormatter" = "xaver.clang-format";
        "[h]"."editor.defaultFormatter" = "xaver.clang-format";

        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.tabSize" = 2;
        };

        "window.zoomLevel" =
          if machine == "kotoha"
          then 0.6
          else 0.7;

        "window.titleBarStyle" = "custom";

        "terminal.integrated.fontSize" = 16;

        # unfortunately i need powershell to exist
        # i wish it didn't tho but life is life
        "powershell.powerShellDefaultVersion" = "nixpkgs";
        "powershell.powerShellAdditionalExePaths" = {
          "nixpkgs" = "${pkgs.powershell}/bin/pwsh";
        };
      };
    };
  };
}
