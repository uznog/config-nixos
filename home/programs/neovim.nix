{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gopls
    pyright
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      auto-pairs
      vim-surround
      vim-yaml
      nerdcommenter
      {
        plugin = vim-hexokinase; 
        config = ''
          let g:Hexokinase_highlighters = ['virtual']
          set termguicolors
        '';
      }
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
      {
        plugin = nvim-lspconfig;
        config = ''
          lua << EOF
          require'lspconfig'.pyright.setup{}
          require'lspconfig'.gopls.setup{}
          EOF
        '';
      }
      {
        plugin = nvim-compe;
        config = ''
          lua << EOF
          require'compe'.setup {
            enabled = true;
            autocomplete = true;
            debug = false;
            min_length = 1;
            preselect = 'enable';
            throttle_time = 80;
            source_timeout = 200;
            incomplete_delay = 400;
            max_abbr_width = 100;
            max_kind_width = 100;
            max_menu_width = 100;
            documentation = true;

            source = {
              path = true;
              nvim_lsp = true;
            };
          }

          local t = function(str)
            return vim.api.nvim_replace_termcodes(str, true, true, true)
          end

          local check_back_space = function()
              local col = vim.fn.col('.') - 1
              if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                  return true
              else
                  return false
              end
          end

          -- Use (s-)tab to:
          --- move to prev/next item in completion menuone
          --- jump to prev/next snippet's placeholder
          _G.tab_complete = function()
            if vim.fn.pumvisible() == 1 then
              return t "<C-n>"
            elseif check_back_space() then
              return t "<Tab>"
            else
              return vim.fn['compe#complete']()
            end
          end
          _G.s_tab_complete = function()
            if vim.fn.pumvisible() == 1 then
              return t "<C-p>"
            else
              return t "<S-Tab>"
            end
          end

          vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
          vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
          vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
          vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
          EOF
        '';
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
      nmap <leader>w :wq <CR>
      nnoremap // <esc> :noh<return><esc>
      cmap w!! w !sudo tee %
      set cursorline
      set noshowmode
      set signcolumn=yes
      set expandtab
      set tabstop=4
      set softtabstop=2
      set shiftwidth=2
      set number
      set relativenumber
      set nowrap
      set fillchars+=vert:\ 
      let base16colorspace=256  
      set undofile
      set noswapfile
    '';
  };

}
