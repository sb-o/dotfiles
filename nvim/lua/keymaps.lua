local keymap = vim.api.nvim_set_keymap

keymap("n", "H", "^", { desc = "Start of line", noremap = false })
keymap("v", "H", "^", { desc = "Start of line", noremap = false })
keymap("n", "L", "$", { desc = "End of line", noremap = false })
keymap("v", "L", "$", { desc = "End of line", noremap = false })

keymap("n", "<leader>a", "<cmd>b#<CR>", { desc = "Switch buffer" })

keymap("n", "<leader>s", "<cmd>Telescope current_buffer_fuzzy_find <CR>", { desc = "Telescope fuzzy current file" })
keymap("n", "<leader>d", "<cmd>Telescope buffers<CR>", { desc = "Telescope navigate buffers" })
keymap("n", "<leader>f", "<cmd>Telescope find_files <CR>", { desc = "Telescope find files" })
keymap("n", "<leader>F", "<cmd>Telescope git_files<CR>", { desc = "Telescope find files in git" })
keymap("n", "<leader>g", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })

-- <leader>q -> unassigned
-- <leader>w -> unassigned
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle tree" })
-- <leader>r -> unassigned
-- <leader>t -> unassigned

keymap("n", "<leader>y", "\"+y", { desc = "Copy to external clipboard" })
keymap("n", "<leader>p", "\"+p", { desc = "Paste from external clipboard" })

-- <leader>b -> unassigned
-- <leader>c -> code actions

keymap("n", "<leader>*", "<cmd>luafile $HOME/.config/nvim/init.lua<CR>", { desc = "Source init.lua" })
keymap("n", "<leader>;", "<cmd>Telescope commands<CR>", { desc = "Telescope commands" })
keymap("n", "<leader>/", "<cmd>noh<CR>", { desc = "Clear highlights" })

keymap("n", "<leader>zl", "<cmd>Lazy<CR>", { desc = "Lazy" })
keymap("n", "<leader>zm", "<cmd>Mason<CR>", { desc = "Mason" })
keymap("n", "<leader>zt", "<cmd>Telescope<CR>", { desc = "Telescope (general)" })

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


