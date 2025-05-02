return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({})

    vim.g.mapleader = ","
    local keymap = vim.keymap.set

    keymap("n", "<leader>F",  ":FzfLua builtin<CR>", { desc = "[F]zfLua builtin" })
    keymap("n", "<leader>b",  ":FzfLua buffers<CR>", { desc = "[B]uffer list" })
    keymap("n", "<leader>gf", ":FzfLua git_files<CR>", { desc = "[G]it [F]iles" })
    keymap("n", "<leader>gs", ":FzfLua git_status<CR>", { desc = "[G]it [S]tatus" })
    keymap("n", "<leader>gc", ":FzfLua git_commits<CR>", { desc = "[G]it [C]ommits" })
    keymap("n", "<leader>gb", ":FzfLua git_bcommits<CR>", { desc = "[G]it [B]uffer commits" })
    keymap("n", "<leader>gB", ":FzfLua git_branches<CR>", { desc = "[G]it [B]branches" })
    keymap("n", "<leader>sh", ":FzfLua helptags<CR>", { desc = "[S]earch [H]elptags" })
    keymap("n", "<leader>sm", ":FzfLua manpages<CR>", { desc = "[S]earch [M]anpages" })
    keymap("n", "<leader>sc", ":FzfLua colorschemes<CR>", { desc = "[S]earch [C]olorschemes" })
    keymap("n", "<leader>sf", ":FzfLua filetypes<CR>", { desc = "[S]earch [F]iletypes" })
    keymap("n", "<leader>sr", ":FzfLua oldfiles<CR>", { desc = "[S]earch [R]ecent files" })
    keymap("n", "<leader>sl", ":FzfLua blines<CR>", { desc = "[S]earch buffer [L]ines" })
    keymap("n", "<leader>sk", ":FzfLua keymaps<CR>", { desc = "[S]earch [K]eymap" })
    keymap("n", "<leader>ts", ":FzfLua treesitter<CR>", { desc = "[T]ree[S]itter" })
    keymap("n", "<leader>lg", ":FzfLua live_grep<CR>", { desc = "[L]ive [G]rep" })
    keymap("n", "<leader>sg", ":FzfLua grep_project<CR>", { desc = "[S]earch with [G]rep" })

    keymap({ "n", "v", "i" }, "<C-x><C-f>", function()
      fzf.complete_path()
    end, { silent = true, desc = "Fuzzy complete path" })

    keymap("n", "<space><space>",  function ()
      fzf.files()
    end, { desc = "[F]ind [F]iles" })
    keymap("n", "<leader>ff", ":FzfLua files cwd=~/<CR>", { desc = "[F]ind [F]iles" })
    keymap("n", "<leader>fc", ":FzfLua files cwd=~/code<CR>", { desc = "[F]ind files in [C]ode directory" })
    keymap("n", "<leader>fh", ":FzfLua files cwd=~/code/hobby<CR>", { desc = "[F]ind files in [H]obby directory" })
    keymap("n", "<leader>fd", ":FzfLua files cwd=~/code/hobby/dotfiles<CR>", { desc = "[F]ind files in [D]otfiles directory" })
    keymap("n", "<leader>fw", ":FzfLua files cwd=~/code/work<CR>", { desc = "[F]ind files in [W]ork directory" })
    keymap("n", "<leader>fG", ":FzfLua files cwd=~/code/work/git<CR>", { desc = "[F]ind files in [G]it directory" })
    keymap("n", "<leader>fg", ":FzfLua files cwd=~/.config<CR>", { desc = "[F]ind files in confi[G] directory" })

    keymap("n", "<leader>ds", ":FzfLua lsp_document_symbols<CR>", { desc = "[D]ocument [S]ymbols" })
    keymap("n", "<leader>ws", ":FzfLua lsp_live_workspace_symbols<CR>", { desc = "[W]orkspace [S]ymbols" })
  end,
}
