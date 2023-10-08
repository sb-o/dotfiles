local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>a", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>d", "<cmd>bnext<CR>", { desc = "Next buffer" })

keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle tree" })
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files()<CR>", { desc = "Telescope find files"})
keymap("n", "<leader>F", "<cmd>Telescope git_files<CR>", { desc = "Telescope find files in git" })
keymap("n", "<leader>g", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })

keymap("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Lazy plugin manager" })

keymap("n", "<leader>tt", "<cmd>Telescope<CR>", { desc = "Telescope (general)" })
