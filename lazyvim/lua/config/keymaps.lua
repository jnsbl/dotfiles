local map = vim.keymap.set

map("n", ",s", "<Cmd>w<CR><Esc>", { desc = "Save File", remap = true })

-- https://jovicailic.org/2015/05/saving-read-only-files-in-vim-sudo-trick/
map("c", "w!!", "w !sudo tee % >/dev/null", { desc = "Save File using sudo", remap = true })

-- Create window splits easier
map("n", "vv", "<C-w>v", { desc = "Vertical Split (right)", remap = true })
map("n", "ss", "<C-w>s", { desc = "Horizontal Split (below)", remap = true })

-- Go to last edit location with ,.
map("n", ",.", "'.", { desc = "Go to Last Edit Location", remap = true })

-- Quickly select the text that was just pasted. This allows you to, e.g.,
-- indent it after pasting.
map("n", "gV", "`[v`]", { desc = "Select the Pasted Text", remap = true })

-- Delete without yanking
map("n", ",d", '"_dd', { desc = "Delete Line without Yanking", remap = true })
map("v", ",d", '"_d', { desc = "Delete without Yanking", remap = true })

-- "st" for Start
map("n", ",st", "<Cmd>lua Snacks.dashboard()<CR>", { desc = "Show Start Dashboard", remap = true })
