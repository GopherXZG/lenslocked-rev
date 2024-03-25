require("xzg.remap")
vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- use packer for managing plugins
require('packer').startup(function()
    -- plugin definitions here
    use 'neovim/nvim-lspconfig' -- language server protocol support
    use 'nvim-telescope/telescope.nvim' -- fuzzy finder
    use 'voldikss/vim-floaterm' -- floating terminal
    use 'preservim/nerdtree' -- file explorer
    use 'fatih/vim-go' -- Go development plugin
    use 'nvim-lua/plenary.nvim'
    use { 'Shadorain/shadotheme' }
    use 'nvim-treesitter/nvim-treesitter'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/cmp-vsnip'
    use 'rafamadriz/friendly-snippets'
    use "olimorris/onedarkpro.nvim"
end)

-- go language server setup
vim.g.go_path = os.getenv("GOPATH")
vim.g.go_bin = os.getenv("GOBIN")
require'lspconfig'.gopls.setup{
    cmd = {"gopls", "--remote=auto"}, 
    filetypes = {"go", "gomod"}, 
    flags = {
        debounce_text_changes = 150,
    }
}
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- 或者选择特定的语言
  highlight = {
    enable = true, -- 启用 Treesitter 高亮
  },
}
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- 使用 vim-vsnip
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-1),
    ['<C-f>'] = cmp.mapping.scroll_docs(1),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vim-vsnip users.
    { name = 'buffer' },
  })
})

require'lspconfig'.clangd.setup{}
-- 强制 .gohtml 文件使用 html 的高亮
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.gohtml",
  command = "set filetype=html",
})
vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
-- key mapping to copy selected text to Windows clipboard in visual mode
vim.cmd("colorscheme onedark_vivid")
vim.g.go_highlight_types = true
vim.g.go_highlight_fields = true
vim.g.go_highlight_functions = true
vim.g.go_highlight_function_calls = true
vim.g.go_highlight_operators = true
vim.g.go_highlight_extra_types = true
vim.g.go_highlight_build_constraints = true
vim.g.go_highlight_generate_tags = true

vim.cmd([[autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4]])

vim.o.termguicolors = true
