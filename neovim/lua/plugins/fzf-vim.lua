-- "ff" for File Finder
vim.cmd('command! -bang -nargs=? HomeFiles call fzf#vim#files(\'~\', {\'options\': [\'--preview\', \'bat -n --color=always {}\']}, <bang>0)')
vim.keymap.set("n", "<leader>ff",  ":HomeFiles<CR>")

-- "fc" for Files in Code directory
vim.cmd('command! -bang -nargs=? CodeFiles call fzf#vim#files(\'~/code\', {\'options\': [\'--preview\', \'bat -n --color=always {}\']}, <bang>0)')
vim.keymap.set("n", "<leader>fc",  ":CodeFiles<CR>")

-- "fh" for Files in Hobby directory
vim.cmd('command! -bang -nargs=? HobbyFiles call fzf#vim#files(\'~/code/hobby\', {\'options\': [\'--preview\', \'bat -n --color=always {}\']}, <bang>0)')
vim.keymap.set("n", "<leader>fh",  ":HobbyFiles<CR>")

-- "fd" for Files in Dotfiles directory
vim.cmd('command! -bang -nargs=? Dotfiles call fzf#vim#files(\'~/code/hobby/dotfiles\', {\'options\': [\'--preview\', \'bat -n --color=always {}\']}, <bang>0)')
vim.keymap.set("n", "<leader>fd",  ":Dotfiles<CR>")

-- "fw" for Files in Work directory
vim.cmd('command! -bang -nargs=? WorkFiles call fzf#vim#files(\'~/code/work\', {\'options\': [\'--preview\', \'bat -n --color=always {}\']}, <bang>0)')
vim.keymap.set("n", "<leader>fw",  ":WorkFiles<CR>")

-- "fg" for Files in confiG directory
vim.cmd('command! -bang -nargs=? ConfigFiles call fzf#vim#files(\'~/.config\', {\'options\': [\'--preview\', \'bat -n --color=always {}\']}, <bang>0)')
vim.keymap.set("n", "<leader>fg",  ":ConfigFiles<CR>")
