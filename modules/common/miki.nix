{pkgs, ...}: {
  # Configure `nix` itself.
  nix = {
    # Prefer the stable version of Nix
    package = pkgs.nixVersions.stable;

    # Optimise /nix automatically per build
    optimise.automatic = true;

    # Set garbage collection to run weekly
    gc = {
      automatic = true;
      interval.Day = 7;
    };

    settings = {
      # Allow the "experimental" flakes command to be allowed.
      experimental-features = "nix-command flakes";
      sandbox = true;
      trusted-users = ["noel"];

      # A list of trusted binary caches that we will use for Nix packages.
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://noel.cachix.org" # TODO: move to nix.floofy.dev
        "https://noelware.cachix.org" # TODO: move to nix.noelware.org
      ];

      # List of public keys used to sign binary caches.
      trusted-public-keys = [
        "noel.cachix.org-1:pQHbMJOB5h5VqYi3RV0Vv0EaeHfxARxgOhE9j013XwQ="
        "noelware.cachix.org-1:22A8ELRjkqEycSHz+R5A5ReX2jyjU3rftsBmlD6thn0="
      ];

      substituters = [
        "https://noel.cachix.org"
        "https://noelware.cachix.org"
      ];
    };
  };
}
