{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # IntelliJ - used for Java development :>
    jetbrains.idea-ultimate
  ];
}
