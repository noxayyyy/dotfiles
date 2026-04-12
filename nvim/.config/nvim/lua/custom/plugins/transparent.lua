return {
  'xiyaowong/transparent.nvim',
  lazy = false,
  name = 'transparent',
  config = function()
    require('transparent').setup { -- Optional, you don't have to run setup.
      groups = { -- table: default groups
        'Normal',
        'NormalNC',
        'LineNr',
        'NonText',
        'CursorLine',
        'CursorLineNr',
        'StatusLine',
        'StatusLineNC',
        'SignColumn',
        'DiagnosticVirtualTextError',
        'DiagnosticVirtualTextWarn',
        'DiagnosticVirtualTextInfo',
        'DiagnosticVirtualTextHint',
      },
      -- 'Comment', 'Constant', 'Special', 'Identifier',
      -- 'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
      -- 'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
      -- 'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
      -- 'EndOfBuffer',
      extra_groups = {}, -- table: additional groups that should be cleared
      exclude_groups = {}, -- table: groups you don't want to clear
    }
  end,
}
