local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set

keymap("n", "<space>s", ":w<CR>")
keymap("n", "<C-space>", ":e ~/")

-- https://jovicailic.org/2015/05/saving-read-only-files-in-vim-sudo-trick/
keymap("c", "w!!", "w !sudo tee % >/dev/null")

-- j and k don't skip over wrapped lines in following FileTypes,
-- unless given a count (helpful since I display relative line numbers
-- in these file types)
autocmd("FileType", {
  pattern = "markdown",
  command = "nnoremap <expr> j v:count ? 'j' : 'gj'"
})
autocmd("FileType", {
  pattern = "markdown",
  command = "nnoremap <expr> k v:count ? 'k' : 'gk'"
})

-- Move between split windows by using the four directiJns H, L, K, J
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Resize windows with arrow keys
keymap("n", "<M-Up>", "<C-w>+")
keymap("n", "<M-Down>", "<C-w>-")
keymap("n", "<M-Left>", "<C-w><")
keymap("n", "<M-Right>", "<C-w>>")

-- Create window splits easier
keymap("n", "vv", "<C-w>v")
keymap("n", "ss", "<C-w>s")

-- Clear current search highlight by tapping Esc
keymap("n", "<Esc>", ":nohlsearch<CR>")

-- Type ,hl to toggle highlighting on/off, and show current value.
keymap("n", "<leader>hl", ":set hlsearch! hlsearch?<CR>")

-- (v)im (r)eload
keymap("n", "<leader>vr", ":so %<CR>")

-- ,qc to close quickfix window (where you have stuff like Ag)
-- ,qo to open it back up (rare)
keymap("n", "<leader>qc", ":cclose<CR>")
keymap("n", "<leader>qo", ":copen<CR>")
keymap('n', '<leader>ql', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Move back and forth through previous and next buffers
-- with ,y and ,x (I'm using qwertz keyboard)
keymap("n", "<leader>y", ":bp<CR>")
keymap("n", "<leader>x", ":bn<CR>")

-- Go to the last buffer
keymap("n", "<leader><space>", ":b#<CR>")

-- These are very similar keys. Typing 'a will jump to the line in the current
-- file marked with ma. However, `a will jump to the line and column marked
-- with ma.  It’s more useful in any case I can imagine, but it’s located way
-- off in the corner of the keyboard. The best way to handle this is just to
-- swap them: http://items.sjbach.com/319/configuring-vim-right
keymap("n", "'", "`")
keymap("n", "`", "'")

-- Go to last edit location with ,.
keymap("n", "<leader>.", "'.")

-- Have the indent commands re-highlight the last visual selection to make
-- multiple indentations easier
keymap("v", ">", ">gv")
keymap("v", "<", "<gv")

-- Quickly select the text that was just pasted. This allows you to, e.g.,
-- indent it after pasting.
keymap("n", "gV", "`[v`]")

-- Allows you to easily replace the current word and all its occurrences.
keymap("n", "<Leader>rw", ":%s/\\<<C-r><C-w>\\>/")
keymap("v", "<Leader>rw", "y:%s/<C-r>\"/")

-- Allows you to easily change the current word and all occurrences to something
-- else. The difference between this and the previous mapping is that the mapping
-- below pre-fills the current word for you to change.
keymap("n", "<Leader>cw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>")
keymap("v", "<Leader>cw", "y:%s/<C-r>\"/<C-r>\"")

-- Paste from system clipboard
keymap("n", "<leader>p", "\"+p")
keymap("n", "<leader>P", "\"+P")

-- Delete without yanking
keymap("n", "<leader>d", "\"_dd")
keymap("v", "<leader>d", "\"_d")

-- "st" for Start
-- keymap("n", "<leader>st", ":Alpha<CR>")
keymap("n", "<leader>st", "<cmd>lua Snacks.dashboard()<CR>")

keymap("n", "-",  ":e .<CR>")

keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])
keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])

keymap("n", "<F2>",  ":NvimTreeToggle<CR>")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
