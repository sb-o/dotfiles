-- Treesitter setup
require('nvim-treesitter.configs').setup {
	ensure_installed = { "lua", "python", "typescript", "javascript", "tsx", "go" },
  	highlight = {
		enable = true
	}
}

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "pyright", "tsserver" }
})
local lspconfig = require("lspconfig")

-- Language servers
lspconfig.lua_ls.setup {}
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		-- Buffer local mappings.
		-- local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "get LSP definition" })
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "get LSP declaration" })
		vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations,
			{ buffer = ev.buf, desc = "get LSP implementations (Telescope)" })
		vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
			{ buffer = ev.buf, desc = "get LSP references (Telescope)" })
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "hover LSP" })
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
		vim.keymap.set('n', '<leader>cf', function()
			vim.lsp.buf.format { async = true }
		end, { buffer = ev.buf, desc = "code format" })
		vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = ev.buf, desc = "code rename" })
		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		-- vim.keymap.set('n', '<space>wl', function()
		--	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, opts)

		-- COQ_NVIM autocompletions
		vim.g.coq_settings = {
			auto_start = 'shut-up',
			display = {
				icons = {
					mode = 'none'
				}
			},
			keymap = {
				pre_select = false
			}
		}
		-- vim.api.nvim_set_keymap('i', '<TAB>', 'pumvisible() ? "<C-y>" : "<C-g>u<TAB>"', { expr = true, noremap = true }) -- autocomplete on tab instead
		vim.cmd('COQnow -s')
	end,
})
