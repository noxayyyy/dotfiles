-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.keymap.set('n', '<leader>w', '<cmd>w<cr><esc>', { desc = '[W]rite File' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr><esc>', { desc = '[Q]uit File' })
vim.opt.colorcolumn = '100'

-- setting up .razor and .cshtml detection
-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
-- 	desc = 'Add support for .razor and .cshtml files',
-- 	pattern = { '*.cshtml', '*.razor' },
-- 	callback = function()
-- 		vim.bo.filetype = "html.cshtml.razor"
-- 	end
-- })

local utils = require 'telescope.utils'
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Change directory to the the script first opened on startup for the tab',
  group = vim.api.nvim_create_augroup('change-directory', { clear = true }),
  callback = function()
    vim.cmd.tcd(utils.buffer_dir())
  end,
})

local function getWords()
  -- the third string here is the string for visual-block mode (^V)
  if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' or vim.fn.mode() == '' then
    return vim.fn.wordcount().visual_words .. ' words'
  else
    return vim.fn.wordcount().words .. ' words'
  end
end

-- Word Wrap Toggle
vim.cmd [[
let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist
  if s:wrapenabled
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    unmap dd
	set colorcolumn=100
    let s:wrapenabled = 0
  else
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
	set colorcolumn=0
    let s:wrapenabled = 1
  endif
endfunction
map <leader>o :call ToggleWrap()<CR>
]]

return {}
