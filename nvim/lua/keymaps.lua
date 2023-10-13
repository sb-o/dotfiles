local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>w", "<cmd>wa<CR>", { desc = "Save files" })
keymap("n", "<leader>a", "<cmd>b#<CR>", { desc = "Switch buffer" })
keymap("n", "<leader>s", "\"+p", { desc = "Paste from external clipboard" })
keymap("n", "<leader>d", "<cmd>Telescope current_buffer_fuzzy_find <CR>", { desc = "Telescope fuzzy current file" })

keymap("n", "<leader>q", "<cmd>Telescope buffers<CR>", { desc = "Telescope navigate buffers" })
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle tree" })

-- <leader>b -> unassigned
-- <leader>c -> code actions
keymap("n", "<leader>f", "<cmd>Telescope find_files <CR>", { desc = "Telescope find files" })
keymap("n", "<leader>F", "<cmd>Telescope git_files<CR>", { desc = "Telescope find files in git" })
keymap("n", "<leader>g", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })

keymap("n", "<leader>*", "<cmd>luafile $HOME/.config/nvim/init.lua<CR>", { desc = "Source init.lua" })
keymap("n", "<leader>;", "<cmd>Telescope commands<CR>", { desc = "Telescope commands" })

keymap("n", "<leader>!l", "<cmd>Lazy<CR>", { desc = "Lazy" })
keymap("n", "<leader>!m", "<cmd>Mason<CR>", { desc = "Mason" })
keymap("n", "<leader>!t", "<cmd>Telescope<CR>", { desc = "Telescope (general)" })


-- Close telescope on single Esc
local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
})


