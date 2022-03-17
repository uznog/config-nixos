{ config, ... }:

{
  sops.secrets."grafana/adminPassword" = {
    owner = "grafana";
    sopsFile = ../../secrets/grafana.yaml;
  };

  services.grafana = {
    enable = true;
    analytics.reporting.enable = false;
    port = 3000;

    security = {
      adminUser = "test";
      adminPasswordFile = config.sops.secrets."grafana/adminPassword".path;
    };
  };

  services.traefik.dynamicConfigOptions = {
    http.routers.grafana = {
      rule = "Host(`grafana.nixos.local`)";
      service = "grafana";
      entryPoints = [ "web" "websecure" ];
      tls = true;
    };

    http.services.grafana = { 
      loadBalancer.servers = [ { url = "http://127.0.0.1:3000"; } ];
    };
  };
}
