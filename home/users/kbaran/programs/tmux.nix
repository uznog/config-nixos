{ pkgs, ... }:

with pkgs.lib;

{
programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    shortcut = "a";
    terminal = "screen-256color";
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      tmuxPlugins.nord
    ];
    extraConfig = ''
      # Bindings
      bind -n M-\\ split-window -h -c "#{pane_current_path}"
      bind -n M-- split-window -v -c "#{pane_current_path}"

      bind | split-window -h
      bind _ split-window -v

      bind C new-window -c "#{pane_current_path}"

      bind -n M-t new-window

      unbind '"'
      unbind %

      bind r source-file ~/.tmux.conf

      bind -n C-h select-pane -L
      bind -n C-l select-pane -R
      bind -n C-k select-pane -U
      bind -n C-j select-pane -D

      bind -r K resize-pane -U 2
      bind -r J resize-pane -D 2
      bind -r H resize-pane -L 2
      bind -r L resize-pane -R 2

      bind -n M-j  previous-window
      bind -n M-k next-window

      bind -n M-w kill-pane

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

      bind-key -T copy-mode-vi 's' send -X 'alacritty'

      # Other configuration
      set -ga terminal-overrides ',*256col*:Tc'
      setw -g mouse on
      setw -g monitor-activity on
      set-window-option -g automatic-rename on
    '';
  };
}
