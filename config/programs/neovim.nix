{ config, pkgs, ... }:

with pkgs.lib;
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      auto-pairs
      vim-surround
      {
        plugin = (import <nixos-unstable> {}).vimPlugins.vim-hexokinase; 
        config = ''
          let g:Hexokinase_highlighters = ['virtual']
          set termguicolors
        '';
      }
      nerdcommenter
      { 
        plugin = nord-vim;
        config = "colorscheme nord";
      }
      {
        plugin = vim-airline;
        config = ''
          let g:airline_powerline_fonts = 1
          let g:airline#extensions#whitespace#enabled = 0
          let g:airline#extensions#tabline#enabled = 1
          if !exists('g:airline_symbols')
             let g:airline_symbols = {}
          endif
          let g:airline_left_sep = ''
          let g:airline_left_alt_sep = ''
          let g:airline_right_sep = ''
          let g:airline_right_alt_sep = ''
          let g:airline_symbols.branch = ''
          let g:airline_symbols.readonly = ''
          let g:airline_symbols.linenr = ''
        '';
      }
      { 
        plugin = vim-airline;
        config = "let g:airline_theme = 'nord'";
      }
    ];
    extraConfig = ''
      set clipboard+=unnamed,unnamedplus
      let mapleader = ","
      set runtimepath^=~/.config/nvim/ftplugin
      map <Leader>p "+p
      map <Leader>y "+y
      nnoremap <leader><Space> @d 
      nmap <leader>e :exit <CR>
      nmap <leader>w :wg <CR>
      cmap w!! w !sudo tee %
      set cursorline
      set noshowmode
      set signcolumn=yes
      set expandtab
      set tabstop=4
      set softtabstop=4
      set shiftwidth=4
      set nu
      set nowrap
      set fillchars+=vert:\ 
      let base16colorspace=256  
    '';
  };

}
