{
  config,
  pkgs,
  lib,
  ...
}: let
  mkGroups = with lib; groups: flatten (concatMap (value: optional (head value) (tail value)) groups);
in {
  users.users.noel = {
    isNormalUser = true;
    extraGroups =
      mkGroups [
        [config.networking.networkmanager.enable "networkmanager"]
        [config.virtualisation.docker.enable "docker"]
        [config.virtualisation.libvirtd.enable "libvirtd"]
        [config.hardware.bluetooth.enable "bluetooth"]
      ]
      ++ ["wheel"];

    openssh.authorizedKeys.keys = [
      # laptop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOqqqAoViwgSCdS5XOoAbCfjtqeBwO4MHtkA6AknMjMQ noel@kotoha"

      # desktop
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2sOlKwQOgqsI+owBJ7+47tCyjXZP53Q1euVO8wk7fSLAOALMGHMktqq4ogUgF63/f8dqNIK0eJpYl3wHC0j2foV9zxXiswy7mSh37skPsNpKSF0uEayJkoN/+2bn84oKPdAfvJQSK1TNxcbjiNOnXPr5d+8JIVBZFeWAQKsI5PZjHttgodfjK/+aEIFmmOS+sVceVh7dSO/fwGFwmiC39l9ZkfPxIECq+bVBdMlVuVeYxVmaxGMaPJE4GUZSUcEVNWjDMF96qGbzb6HZEPIVaEjoZNOI+2XMlgQjLRK58cWWo2aYgxw5HJCwWcY/YKDiPcvBoA7jhO4sciJ0GREjSZ9GXRhFSpRmHEnE/GlhlKUJohIzwFYrIAFmjr7cMzo3Ozl1CuoaVPabF9Vs1ciJ4mjWtUhNogeyuH8yCgVF/PFhENeX8CGMUxc9hj5inFf+QmGqjyz+tg39cnxXVEA4JQHNUYX8ox4u7qoKEl/I//E6IRPc47QP7Zy7kFr9e7u8= noel@floofbox"
    ];

    shell = pkgs.zsh;
  };
}
