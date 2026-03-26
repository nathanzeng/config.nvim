-- TODO: make this a dependency of dap instead
return {
  'igorlfs/nvim-dap-view',
  version = '*',
  -- let the plugin lazy load itself
  lazy = false,
  opts = {
    auto_toggle = true,
  },
}
