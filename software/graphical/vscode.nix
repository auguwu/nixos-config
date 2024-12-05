{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package =
      (pkgs.vscode.override {
        isInsiders = true;
      })
      .overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [pkgs.krb5];
        version = "latest";
        pname = "vscode-insiders";
        src = builtins.fetchTarball {
          sha256 = "sha256:1wl5fz5zb1llnhv63fd58dlrh39kvwb7xjpfpqgchwv6r3sr9a0i";
          url = "https://vscode.download.prss.microsoft.com/dbazure/download/insider/d7c7d5bd66efeaebded9fada08500da3816d80cf/code-insider-x64-1730127569.tar.gz";
        };
      });

    extensions = with pkgs.vscode-extensions;
      [
        kamadorueda.alejandra
        astro-build.astro-vscode
        llvm-vs-code-extensions.vscode-clangd
        vadimcn.vscode-lldb
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
        ms-python.python
        biomejs.biome
        vadimcn.vscode-lldb
        skellock.just
        unifiedjs.vscode-mdx
        mesonbuild.mesonbuild
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
      "editor.fontFamily" = "'Geist Mono', Consolas, 'Courier New', monospace";
      "editor.fontSize" = 17;
      "editor.minimap.enabled" = false;
      "editor.detectIndentation" = false;
      "editor.largeFileOptimizations" = false;
      "editor.semanticHighlighting.enabled" = false;
      "editor.quickSuggestions" = {
        "other" = true;
        "comments" = false;
        "strings" = false;
      };

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

      # use nix store path for nixd
      "nix.serverPath" = "${pkgs.nixd}/bin/nixd";

      # use nix store path for terraform-ls
      "terraform.languageServer.path" = "${pkgs.terraform-ls}/bin/terraform-ls";

      "clang-format.executable" = "${pkgs.clang-tools}/bin/clang-format";

      "[terraform-vars]"."editor.defaultFormatter" = "hashicorp.terraform";
      "[terraform]"."editor.defaultFormatter" = "hashicorp.terraform";
      "[toml]"."editor.defaultFormatter" = "tamasfe.even-better-toml";
      "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
      "[cpp]"."editor.defaultFormatter" = "xaver.clang-format";
      "[nix]"."editor.defaultFormatter" = "kamadorueda.alejandra";
      "[c]"."editor.defaultFormatter" = "xaver.clang-format";

      "window.zoomLevel" = 0.7;
      "window.titleBarStyle" = "custom";

      "terminal.integrated.fontSize" = 16;
    };
  };
}
