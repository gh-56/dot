-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- buffers
map("n", "<leader>'", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Move Lines
map("n", "<leader>j", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<leader>k", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<leader>j", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<leader>k", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<leader>j", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<leader>k", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- windows
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>w%", "<C-W>v", { desc = "Split Window Right", remap = true })

-- ciw
map("n", "<C-c>", "ciw", { desc = "ciw" })
map("i", "<C-c>", "<C-o>ciw", { desc = "ciw" })

-- translate (smart-translate.lua)
map(
  "n",
  "<leader>t",
  ":normal! viw<cr>:Translate --target=ko --source=en --handle=float<cr>",
  { desc = "Translate to Korean" }
)

map("v", "<leader>t", ":Translate --target=ko --source=en --handle=float<cr>", { desc = "Translate to Korean" })

map("n", "x", '"_x')

-- Increment/decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Delete a word backwards
map("n", "dw", 'vb"_d')

-- Split window
map("n", "ss", ":split<Return><C-w>w")
map("n", "sv", ":vsplit<Return><C-w>w")
map("n", "sh", "<C-w><")
map("n", "sl", "<C-w>>")
map("n", "sk", "<C-w>+")
map("n", "sj", "<C-w>-")
