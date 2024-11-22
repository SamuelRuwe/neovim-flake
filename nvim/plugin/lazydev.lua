local lazydev = require("lazydev").setup({
	library = {
		{ path = vim.fn.expand("~/workspace/nvim_stuff/luvit-meta/library"), words = { "vim%.uv" } },
	},
})
