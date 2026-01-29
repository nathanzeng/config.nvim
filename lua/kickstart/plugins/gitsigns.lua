-- NOTE: there is a good note about opts vs the setup function in kickstart with gitsigns
return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      preview_config = {
        -- Options passed to nvim_open_win
        -- Makes it so that I get borders on inline hunk preview and blame
        border = 'rounded',
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            -- bang makes it so that when you are in a diff it executes native ]c
            -- because ]c is a mapping used by this plugin
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- NOTE: I removed many actions I don't use

        -- visual mode
        -- map('v', '<leader>hs', function()
        --   gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        -- end, { desc = 'git [s]tage hunk' })
        -- map('v', '<leader>hr', function()
        --   gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        -- end, { desc = 'git [r]eset hunk' })

        -- normal mode
        -- map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[r]eset hunk' })
        -- map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        -- map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
        -- map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[p]review hunk' })
        map('n', '<leader>gl', function()
          -- blame_line with the full commit message and hunk changes
          gitsigns.blame_line { full = true }
        end, { desc = '[l]ine git blame' })
        -- map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        -- map('n', '<leader>hD', function()
        --   gitsigns.diffthis '@'
        -- end, { desc = 'git [D]iff against last commit' })

        -- I found this line blame to be useless, there are more config options though
        -- map('n', '<leader>gl', gitsigns.toggle_current_line_blame, { desc = 'Toggle git blame [l]ine' })
        -- TODO: I want it to toggle off blame too, have to figure out how to delete the buffer
        map('n', '<leader>gb', gitsigns.blame, { desc = '[b]lame file' })

        -- this was like a worse version of the normal preview
        -- map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
