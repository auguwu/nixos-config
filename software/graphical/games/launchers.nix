{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    dolphin-emu
    prismlauncher
    lutris
  ];
}
