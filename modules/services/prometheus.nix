{ ... }:

{
  services.prometheus = {
    enable = true;

    globalConfig = {
      scrape_interval = "10s";
      scrape_timeout = "5s";
    };

    exporters = {
      node = {
        enable = true;
      };
    };

    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = [ "localhost:9100" ];
          }
        ];
      }
      {
        job_name = "prometheus";
        static_configs = [
          {
            targets = [ "localhost:9090" ];
          }
        ];
      }
    ];
  };

  services.traefik.dynamicConfigOptions = {
    http.routers.prometheus = {
      rule = "Host(`prometheus.nixos.local`)";
      service = "prometheus";
      entryPoints = [ "web" "websecure" ];
      tls = true;
    };

    http.services.prometheus = { 
      loadBalancer.servers = [ { url = "http://127.0.0.1:9090"; } ];
    };
  };
}
