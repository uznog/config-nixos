{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gopls
    pyright
    rnix-lsp
    solargraph
    yaml-language-server
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      auto-pairs
      vim-surround
      vim-yaml
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-vsnip
      vim-vsnip
      nvim-lspconfig
      {
        plugin = nvim-cmp;
        config = ''
          lua <<EOF
            -- Setup nvim-cmp.
            local cmp = require'cmp'

            local has_words_before = function()
              local line, col = unpack(vim.api.nvim_win_get_cursor(0))
              return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local feedkey = function(key, mode)
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end

            cmp.setup({
              snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                end,
              },
              mapping = {
                ["<Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif vim.fn["vsnip#available"](1) == 1 then
                    feedkey("<Plug>(vsnip-expand-or-jump)", "")
                  elseif has_words_before() then
                    cmp.complete()
                  else
                    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                  end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function()
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                    feedkey("<Plug>(vsnip-jump-prev)", "")
                  end
                end, { "i", "s" }),
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-e>'] = cmp.mapping({
                  i = cmp.mapping.abort(),
                  c = cmp.mapping.close(),
                }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
              },
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
              }, {
                { name = 'path' },
                { name = 'buffer' },
              })
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
              sources = {
                { name = 'buffer' }
              }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
              sources = cmp.config.sources({
                { name = 'path' }
              }, {
                { name = 'cmdline' }
              })
            })

            -- Add additional capabilities supported by nvim-cmp
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

            local lspconfig = require('lspconfig')

            -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
            local servers = { 'pyright', 'gopls', 'rnix', 'solargraph'}
            for _, lsp in ipairs(servers) do
              lspconfig[lsp].setup {
                -- on_attach = my_custom_on_attach,
                capabilities = capabilities,
              }
            end

            lspconfig['solargraph'].setup {
              filetypes = { "ruby", "Vagrantfile" }              
            }

            lspconfig['yamlls'].setup {
              capabilities = capabilities;
              settings = {
                yaml = {
                  schemas = {
                    ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.20.9-standalone-strict/all.json"] = "/*.yaml",
                  }
                }

              }
            }

          EOF
        '';
      }
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
        plugin = nerdcommenter;
        config = "let NERDSpaceDelims=1";
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
