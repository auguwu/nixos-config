{pkgs, ...}: {
  services.xserver = {
    xkb.layout = "us";
    enable = true;
  };

  # Enable KDE 6
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
  ];

  programs.dconf.enable = true;
}
