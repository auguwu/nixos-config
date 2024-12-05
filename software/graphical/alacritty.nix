{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
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
      font.size = 14;
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
}
