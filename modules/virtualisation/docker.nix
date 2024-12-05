{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      ipv6 = true;
      fixed-cidr-v6 = "fd00::/80";

      experimental = true;
      insecure-registries = [
        # tests for `registry.noel.pink`
        "docker-registry.august.svc.cluster.local:5000"

        # tests for `docker.noelware.org`
        "docker-registry.noelware.svc.cluster.local:5000"
      ];
    };
  };

  environment.systemPackages = [
    (pkgs.docker.override {
      composeSupport = true; # installs and enables Docker Compose v2
      buildxSupport = true; # uses buildx for building images
    })
  ];
}
