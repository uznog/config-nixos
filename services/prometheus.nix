{ config, pkgs, ... }:

{
  services.prometheus = {
    enable = config.settings.services.prometheus.enable;

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
}
