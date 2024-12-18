vim.keymap.set({'n'}, '<leader>e', ':NvimTreeToggle<Cr>')

vim.keymap.set({'n'}, '<leader>w', ':w<Cr>', { desc = 'Quick write'} )
vim.keymap.set({'n'}, '<leader>x', ':x<Cr>', { desc = 'Quick write'} )

-- keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<space>', '<nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- vim fugitive
vim.keymap.set('n', '<leader>gs', ':G<Cr>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gp', ':G push<Cr>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>ga', ':G add %<Cr>', { desc = 'Git add current file' })
vim.keymap.set('n', '<leader>gc', ':G commit<Cr>', { desc = 'Git commit' })
require('which-key').add( {
  { '<leader>g', group = 'Git' },
  { 'gh', group = 'Git hunk'}
})

-- Toggleterm
vim.keymap.set({'n'}, '<leader>t', ':ToggleTerm<Cr>', { desc = 'Toggleterm' })
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Move lines around in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Merge lines with a single stroke
vim.keymap.set("n", "J", "mzJ`z")

-- Keep the screen centered while moving around
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever: paste without copying deleted text in register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without copying deleted text in register" })

-- delete to black hole register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- next greatest remap ever: copy to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

-- No one uses Q
vim.keymap.set("n", "Q", "<nop>")

-- Move around the quicklist
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")

-- Better search and replace
vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Autofill search and replace with word under cursor" }
)

-- Copilot auto-complete with tab but does not mess up default tab behavior
vim.keymap.set('i', '<Tab>', function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, { desc = "Super Tab" })


-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {desc = 'Find files'})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = 'Help tags' })
vim.keymap.set('n', '<leader>fr', telescope.oldfiles, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>fb', telescope.git_branches, { desc = 'Git branches' })
vim.keymap.set('n', '<leader>fs', telescope.lsp_document_symbols, { desc = 'Document symbols' })
vim.keymap.set('n', 'gr', telescope.lsp_references, { desc = 'LSP References' })


-- nvim-tree - recipe taken from 
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#git-stage-unstage-files-and-directories-from-the-tree
local api = require("nvim-tree.api")

local git_add = function()
  local node = api.tree.get_node_under_cursor()
  local gs = node.git_status.file

  -- If the current node is a directory get children status
  if gs == nil then
    gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1]) 
         or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
  end

  -- If the file is untracked, unstaged or partially staged, we stage it
  if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
    vim.cmd("silent !git add " .. node.absolute_path)

  -- If the file is staged, we unstage
  elseif gs == "M " or gs == "A " then
    vim.cmd("silent !git restore --staged " .. node.absolute_path)
  end

  api.tree.reload()
end

vim.keymap.set('n', 'ga', git_add, {desc = 'Git Add'})


-- nvim-tree - Open the newly created file
-- Recipe taken from https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#automatically-open-file-upon-creation
local api = require("nvim-tree.api")
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. file.fname)
end)
