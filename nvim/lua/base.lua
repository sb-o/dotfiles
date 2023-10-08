vim.wo.number = true
vim.wo.relativenumber = true

local options = {
	clipboard = "unnamedplus",
	cmdheight = 2,
	fileencoding = "utf-8",
	hlsearch = true,
	ignorecase = true,
	numberwidth = 4,
	smartindent = true,
	expandtab = false,
	tabstop = 4,
	shiftwidth = 0,
	softtabstop = 0,
	smarttab = true
}
for k,v in pairs(options) do
	vim.opt[k] = v
end

