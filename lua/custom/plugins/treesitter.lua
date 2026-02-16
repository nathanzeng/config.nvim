return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local filetypes = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'vue',
      'typescript',
      'javascript',
      'tsx',
      'jsx',
      'css',
      'php',
      'phpdoc',
      'json',
      'gitcommit',
      'gitignore',
      'git_rebase',
      'yaml',
      'graphql',
    }
    require('nvim-treesitter').install(filetypes)

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter', { clear = true }),
      pattern = filetypes,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
