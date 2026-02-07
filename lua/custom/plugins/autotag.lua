-- Autotags for html style tags
return {
  'windwp/nvim-ts-autotag',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('nvim-ts-autotag').setup {
      opts = {
        enable_close_on_slash = true, -- Auto close on trailing </
      },
    }
  end,
}
