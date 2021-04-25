{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        geometry = "300x5-30+50";
        allow_markup = "yes";
        format = "<b>%s</b>\\n%b";
        sort = "yes";
        word_wrap = "yes";
        ignore_newline = "no";
        transparency = 10;
        follow = "mouse";
        max_icon_size = 64;
        min_icon_size = 64;
        frame_width = "3";
        font = "Envy Code R 11";
        padding = 5;
        horizontal_padding = 5;
        text_icon_padding = 10;
        show_indicators = "no";
      };

      urgency_low = {
        background = "#434c5e";
        foreground = "#d8dee9";
        frame_color = "#2e3440";
        timeout = 5;
      };

      urgency_normal = {
        background = "#434c5e";
        foreground = "#d8dee9";
        frame_color = "#2e3440";
        timeout = 20;
      };
      urgency_critical = {
        background = "#434c5e";
        foreground = "#d8dee9";
        frame_color = "#bf616a";
        timeout = 0;
      };
    };
  };
}
