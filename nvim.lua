vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.api.nvim_set_keymap('n', '<leader>b', ':buffers<CR>:b ', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>y', ':%y+<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>s', 'yiw:%s/<C-r>"/', { noremap = true })

vim.keymap.set("n", "<CR>", function()
  if vim.v.count > 0 then
    vim.cmd("buffer " .. vim.v.count)
  end
end)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.lsp.config('lua_ls', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.git' },
})
vim.lsp.config('ts_ls', {
	cmd = { 'typescript-language-server', '--stdio' },
	filetypes = { 'javascript', 'typescript' },
	root_markers = { 'package.json', '.git' },
})

vim.lsp.config('expert', {
	cmd = { 'expert', '--stdio' },
	filetypes = { 'elixir', 'eelixir', 'heex' },
	root_markers = { 'mix.exs', '.git' },
})

vim.lsp.config('gopls', {
	cmd = { 'gopls' },
	filetypes = { 'go' },
	root_markers = { 'go.mod', '.git' },
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
})

vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', '.git' },
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
            },
        }
    }
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        vim.lsp.buf.format()
    end,
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('expert')
vim.lsp.enable('gopls')
vim.lsp.enable('rust_analyzer')
