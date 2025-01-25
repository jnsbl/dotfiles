local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set
local g = vim.g

g.mapleader = ","

keymap("n", "<space>s", ":w<CR>")

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

-- Clear current search highlight by double tapping /
keymap("n", "//", ":nohlsearch<CR>")

-- Type ,hl to toggle highlighting on/off, and show current value.
keymap("n", "<leader>hl", ":set hlsearch! hlsearch?<CR>")

-- (v)im (r)eload
keymap("n", "<leader>vr", ":so %<CR>")

-- ,qc to close quickfix window (where you have stuff like Ag)
-- ,qo to open it back up (rare)
keymap("n", "<leader>qc", ":cclose<CR>")
keymap("n", "<leader>qo", ":copen<CR>")

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

-- "st" for Startify
-- keymap("n", "<leader>st", ":Alpha<CR>")
keymap("n", "<leader>st", "<cmd>lua Snacks.dashboard()<CR>")

-- keymap("n", "<leader>T",  ":Telescope builtin<CR>")
-- keymap("n", "<leader>b",  ":Telescope buffers<CR>")
-- keymap("n", "<leader>F",  ":Telescope find_files<CR>")
-- keymap("n", "<leader>gf", ":Telescope git_files<CR>")
-- keymap("n", "<leader>gs", ":Telescope git_status<CR>")
-- keymap("n", "<leader>gc", ":Telescope git_commits<CR>")
-- keymap("n", "<leader>gb", ":Telescope git_bcommits<CR>")
-- keymap("n", "<leader>gB", ":Telescope git_branches<CR>")
-- keymap("n", "<leader>tm", ":Telescope man_pages<CR>")
-- keymap("n", "<leader>tc", ":Telescope colorscheme<CR>")
-- keymap("n", "<leader>tf", ":Telescope filetypes<CR>")
-- keymap("n", "<leader>ts", ":Telescope treesitter<CR>")
-- keymap("n", "<leader>tz", ":Telescope zoxide list<CR>")
-- keymap("n", "<leader>rg", ":Telescope live_grep<CR>")

keymap("n", "<leader>T",  ":FzfLua builtin<CR>")
keymap("n", "<leader>b",  ":FzfLua buffers<CR>")
keymap("n", "<leader>F",  ":FzfLua files<CR>")
keymap("n", "<leader>gf", ":FzfLua git_files<CR>")
keymap("n", "<leader>gs", ":FzfLua git_status<CR>")
keymap("n", "<leader>gc", ":FzfLua git_commits<CR>")
keymap("n", "<leader>gb", ":FzfLua git_bcommits<CR>")
keymap("n", "<leader>gB", ":FzfLua git_branches<CR>")
keymap("n", "<leader>tm", ":FzfLua manpages<CR>")
keymap("n", "<leader>tc", ":FzfLua colorschemes<CR>")
keymap("n", "<leader>tf", ":FzfLua filetypes<CR>")
keymap("n", "<leader>ts", ":FzfLua treesitter<CR>")
keymap("n", "<leader>rg", ":FzfLua live_grep<CR>")

keymap({ "n", "v", "i" }, "<C-x><C-f>",
  function() require("fzf-lua").complete_path() end,
  { silent = true, desc = "Fuzzy complete path" })

-- "ff" for File Finder
keymap("n", "<leader>ff",  ":FzfLua files cwd=~/<CR>")

-- "fc" for Files in Code directory
keymap("n", "<leader>fc",  ":FzfLua files cwd=~/code<CR>")

-- "fh" for Files in Hobby directory
keymap("n", "<leader>fh",  ":FzfLua files cwd=~/code/hobby<CR>")

-- "fd" for Files in Dotfiles directory
keymap("n", "<leader>fd",  ":FzfLua files cwd=~/code/hobby/dotfiles<CR>")

-- "fw" for Files in Work directory
keymap("n", "<leader>fw",  ":FzfLua files cwd=~/code/work<CR>")

-- "fG" for Files in work Git directory
keymap("n", "<leader>fG",  ":FzfLua files cwd=~/code/work/git<CR>")

-- "fg" for Files in confiG directory
keymap("n", "<leader>fg",  ":FzfLua files cwd=~/.config<CR>")

keymap("n", "-",  ":e .<CR>")

keymap("n", "<space><space>", ":HopAnywhere<CR>")

keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])
keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])

keymap("n", "<F2>",  ":NvimTreeToggle<CR>")

-- LSP mappings
keymap('n', '<space>d', vim.diagnostic.open_float)
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
keymap('n', '<space>q', vim.diagnostic.setloclist)
