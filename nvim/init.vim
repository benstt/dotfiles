set number
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set encoding=UTF-8
set termguicolors
set undodir=$HOME/.vim/undo
set undofile


" Neovide specific
if exists("g:neovide")
	" set guifont=FiraCode\ Nerd\ Font\ Mono:h16:b
	set guifont=FantasqueSansMono\ Nerd\ Font\ Mono:h16
	let g:neovide_cursor_vfx_mode = "ripple"
	let g:neovide_cursor_animation_length=0.05
endif

call plug#begin('~/.config/nvim/plugged')

" Tools, colors and stuff
Plug 'tpope/vim-surround' " Surrounding ysw)
Plug 'tpope/vim-commentary' " For commenting with gcc & gc
Plug 'EdenEast/nightfox.nvim' " Fox colors~
Plug 'windwp/nvim-autopairs' " Autopairs
Plug 'ixru/nvim-markdown' " Markdown
Plug 'hrsh7th/nvim-cmp' " Completion
Plug 'simrat39/rust-tools.nvim' " Rust tools
Plug 'ray-x/lsp_signature.nvim' " Show function signature when typing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Treesitter
Plug 'onsails/lspkind-nvim' " Show icons and type on LSP
Plug 'lewis6991/gitsigns.nvim' " Git blame etc.
Plug 'nvim-lua/plenary.nvim' " Lua helper funcs
Plug 'saecki/crates.nvim', { 'tag': 'v0.3.0' } " Completion for crates.io
Plug 'kyazdani42/nvim-web-devicons' " Icons <3
Plug 'folke/trouble.nvim' " Show pretty diagnostics
Plug 'folke/lsp-colors.nvim' " More colors!
Plug 'nvim-lualine/lualine.nvim' " Airline, but pure lua
Plug 'xiyaowong/nvim-transparent' " Transparent background
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } " Fzf but with syntax highlighting!
Plug 'lukas-reineke/indent-blankline.nvim' " A little line on indents
Plug 'karb94/neoscroll.nvim' " Smooth scrolling
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' } " Bar on top
Plug 'nvim-tree/nvim-tree.lua' " Nerd tree
Plug 'ziglang/zig.vim' " Zig syntax highlighting
Plug 'eandrju/cellular-automaton.nvim' " ... :)

" Snippets
Plug 'hrsh7th/cmp-vsnip' 
Plug 'hrsh7th/vim-vsnip'

" LSP config and stuff
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

call plug#end()

set completeopt=menu,menuone,noselect " Some plugin thingy

colorscheme duskfox

" Indent left and right
vmap < <gv
vmap > >gv

" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <c-k> <c-w>k<CR>
" nnoremap <silent> <c-j> <c-w>j<CR>
nnoremap <silent> <c-h> <c-w>h<CR>
nnoremap <silent> <c-l> <c-w>l<CR>

" Go back to normal mode with 'jk'
inoremap jk <Esc>

" Set tab to comment lines
nmap <Tab><Tab> gcc
vmap <Tab><Tab> gc

" Space bindings
" Clear searches
map <silent> <Space>h :noh<CR>

" Fuzzy search
nmap <Space><Space> :Telescope find_files<CR>
" Live grep everything!
nmap <Space>g :Telescope live_grep<CR>

" Toggle file tree
nmap <Space><Tab> :NvimTreeToggle<CR>

" Open Trouble
nnoremap <Space>tt :TroubleToggle<CR>

nmap <Space>fml :CellularAutomaton make_it_rain<CR>

:lua <<EOF
	-- nvim-tree specific
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin =1

	-- ============ PLUGIN SETUPS ============ -- 
	require('gitsigns').setup()
	require('crates').setup()
	require('trouble').setup()
	require('nvim-autopairs').setup()
	require('rust-tools').setup()
	require('rust-tools').inlay_hints.enable() -- Enable hints by default
	require('lualine').setup()
	require('nvim-tree').setup()
	require('bufferline').setup({
		options = {
			separator_style = "thick"
		}
	})
	require('lsp_signature').setup({
		bind = true,
		hint_prefix = "🌼 ",
		handler_opts = {
			border = "rounded"
		},
	})
	require('nightfox').setup({
		options = {
			transparent = true,
			styles = {
				comments = "italic",
				keywords = "bold",
				types = "bold",
			}
		}
	})
	require('neoscroll').setup({
		easing_function = "quadratic"
	})
	require('nvim-treesitter.configs').setup({
		ensure_installed = { "c", "go", "rust" },

		highlight = {
			enable = true,
		}
	})

	local cmp = require('cmp')
	local lspkind = require('lspkind')
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')

	-- ============ VSCODE SYMBOLS ============ --
	require('lspkind').init({
		symbol_map = {
		  Text = "",
		  Method = "",
		  Function = "",
		  Constructor = "",
		  Field = "",
		  Variable = "",
		  Class = "",
		  Interface = "",
		  Module = "",
		  Property = "",
		  Unit = "",
		  Value = "",
		  Enum = "",
		  Keyword = "",
		  Snippet = "",
		  Color = "",
		  File = "",
		  Reference = "",
		  Folder = "",
		  EnumMember = "",
		  Constant = "",
		  Struct = "",
		  Event = "",
		  Operator = "",
		  TypeParameter = ""
		}
	})

	-- ============ TRANSPARENT WINDOW ============ --
	require("transparent").setup({
		enable = true, -- boolean: enable transparent
		extra_groups = { -- table/string: additional groups that should be cleared
			-- In particular, when you set it to 'all', that means all available groups

			-- example of akinsho/nvim-bufferline.lua
			"BufferLineTabClose",
			"BufferlineBufferSelected",
			"BufferLineFill",
			"BufferLineBackground",
			"BufferLineSeparator",
			"BufferLineIndicatorSelected",
		},
		exclude = {}, -- table: groups you don't want to clear
	})

	-- ============ HELPER FUNCS ============ --
	local has_words_before = function()
		unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local feedkey = function(key, mode)
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
	end

	local current_signature = function(width)
		if not pcall(require, 'lsp_signature') then return end
		local sig = require("lsp_signature").status_line(width)
		return sig.label .. "🐼" .. sig.hint
	end

	-- ============ CMP SETUP ============ --
	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},

		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},

		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

			-- Use <Tab> and <S-Tab> to navigate between completions
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
		}),

		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' }, -- For vsnip users.
			-- { name = 'luasnip' }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = 'buffer' },
		}),

		-- ============ LSPKind ============ --
		formatting = {
			format = lspkind.cmp_format({
				mode = 'symbol_text', -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

				-- The function below will be called before any actual modifications from lspkind
				-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
				before = function (entry, vim_item)
					return vim_item
				end
			})
		}
	})

	-- ============ FILETYPE SPECIFIC ============ --
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
			{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
		}, {
			{ name = 'buffer' },
		})
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
	})

	-- Set up lspconfig.
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	require('lspconfig').rust_analyzer.setup {
		capabilities = capabilities
	}

	-- ============ LSP CONFIG SPECIFICS ============ --
	-- Mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local opts = { noremap=true, silent=true }
	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap=true, silent=true, buffer=bufnr }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
		vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
	end

	local lsp_flags = {
		-- This is the default in Nvim 0.7+
		debounce_text_changes = 150,
	}

	-- Rust
	require('lspconfig')['rust_analyzer'].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		-- Server-specific settings...
		settings = {
			["rust-analyzer"] = {}
		}
	})

	require('lspconfig')['zls'].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		settings = {
			["zls"] = {}
		}
	})

	require('lspconfig')['pyright'].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		settings = {
			["pyright"] = {}
		}
	})

	require('lspconfig')['gopls'].setup({})
	require('lspconfig')['clangd'].setup({})
EOF
