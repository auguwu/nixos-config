{pkgs, ...}: {
  networking.firewall = {
    allowedUDPPorts = [53 51820];
  };
  networking.wireguard.interfaces.wg0 = {
    ips = ["192.168.1.2/24"];
    listenPort = 51820;
    privateKeyFile = "/home/noel/.wg/privatekey";
    peers = [
      # Noel
      {
        publicKey = "/bV0YGaaUExYv4YBcXQp7BuLj1EVTpLYTQC6oi18gwY=";
        allowedIPs = ["192.168.1.1/32"];
      }
    ];
  };
}
