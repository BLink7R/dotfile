-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local kak_normal = true

ESC = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
BS = vim.api.nvim_replace_termcodes("<BS>", true, false, true)
DEL = vim.api.nvim_replace_termcodes("<Del>", true, false, true)

local function batch_action(action)
	if vim.o.lazyredraw == false then
		vim.o.lazyredraw = true
		vim.schedule(function()
			vim.o.lazyredraw = false
		end)
	end
	action()
end

-- modechagne
local function kak_toggle_visual()
	local mode = vim.api.nvim_get_mode().mode
	if mode == "v" then
		if kak_normal then
			kak_normal = false -- start extend selection
		else
			kak_normal = true
		end
	elseif mode == "V" or mode == "n" then
		vim.api.nvim_feedkeys("v", "n", true)
		kak_normal = false -- start extend selection
	end
end

vim.keymap.set({ 'n', 'x' }, 'v', kak_toggle_visual, { noremap = true, silent = true })

vim.keymap.set('v', '<Esc>', function()
	if kak_normal then
		vim.api.nvim_feedkeys(ESC, "n", true)
	else
		kak_normal = true
	end
end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = { "v:n*", "v:i*" },
	callback = function()
		kak_normal = true
	end,
})

-- helix like word motions
local function kak_word_motion(motion)
    local count = vim.v.count > 0 and vim.v.count or 1
	if kak_normal then
		batch_action(function()
			vim.api.nvim_feedkeys(ESC, "n", true)
			if count > 1 then
				vim.api.nvim_feedkeys(count - 1 .. motion, "n", true)
			end
			vim.api.nvim_feedkeys("v" .. motion, "n", true)
		end)
	else
		vim.api.nvim_feedkeys(count .. motion, "n", true)
	end
end

for i, motion in pairs({ 'b', 'B', 'w', 'W', 'e', 'E' }) do
	vim.keymap.set({ 'n', 'x' }, motion, function()
		kak_word_motion(motion)
	end, { noremap = true, silent = true })
end

-- helix like hjkl
local function kak_char_motion(motion)
	local count = vim.v.count > 0 and vim.v.count or 1
	local mode = vim.api.nvim_get_mode().mode
	if kak_normal and (mode == "v") then
		batch_action(function()
			vim.api.nvim_feedkeys(ESC, "n", true)
			vim.api.nvim_feedkeys(count .. motion, "n", true)
		end)
    else
		vim.api.nvim_feedkeys(count .. motion, "n", true)
	end
end

for i, motion in pairs({ 'h', 'j', 'k', 'l' }) do
	vim.keymap.set({ 'n', 'x' }, motion, function()
		kak_char_motion(motion)
	end, { noremap = true, silent = true })
end

-- helix like goto motions
local function kak_normal_visual_goto(key, cmd, desc)
	vim.keymap.set({ 'n', 'x' }, key, function()
		local mode = vim.api.nvim_get_mode().mode
		if kak_normal and (mode == "v") then
			vim.api.nvim_feedkeys(ESC .. cmd, "n", true)
		else
			vim.api.nvim_feedkeys(cmd, "n", true)
		end
	end, { noremap = true, silent = true, desc = desc })
end

kak_normal_visual_goto('gl', '$', "Move to line end")
kak_normal_visual_goto('gs', '^', "Move to line start")
kak_normal_visual_goto('gf', 'gf', "Go to file under cursor")
kak_normal_visual_goto('gi', 'gi', "Go to last insert")
kak_normal_visual_goto('gp',
	ESC .. vim.api.nvim_replace_termcodes('<C-o>', true, false, true),
	"Prev jumplist position")
kak_normal_visual_goto('gn',
	ESC .. vim.api.nvim_replace_termcodes('<C-i>', true, false, true),
	"Next jumplist position")
vim.keymap.set({ 'n', 'x' }, 'gv', 'gv', { noremap = true, silent = true, desc = "Last visual selection" })

-- helix like search
vim.keymap.set('n', 'n', 'gn', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'gN', { noremap = true, silent = true })
vim.keymap.set('x', 'n', function()
	if kak_normal then
		batch_action(function()
			vim.api.nvim_feedkeys(ESC .. "gn", "n", true)
		end)
	else
		vim.api.nvim_feedkeys("n", "n", true)
	end
end, { noremap = true, silent = true })
vim.keymap.set('x', 'N', function()
	if kak_normal then
		batch_action(function()
			vim.api.nvim_feedkeys(ESC .. "NgN", "n", true)
		end)
	else
		vim.api.nvim_feedkeys("N", "n", true)
	end
end, { noremap = true, silent = true })
for i, motion in pairs({ 'f', 'F' }) do
	vim.keymap.set({ 'n', 'x' }, motion, function()
		local count = vim.v.count > 0 and vim.v.count or 1
		if kak_normal then
			vim.api.nvim_feedkeys(ESC .. "v" .. count .. motion, "n", true)
		else
			vim.api.nvim_feedkeys(count .. motion, "n", true)
		end
	end, { noremap = true, silent = true })
end

-- make cursor act like gui editors
vim.keymap.set("i", "<Esc>", function()
	if vim.fn.col('.') > 1 then
		batch_action(function()
			vim.api.nvim_feedkeys(ESC .. "l", "n", true)
		end)
	else
		vim.api.nvim_feedkeys(ESC, "n", true)
	end
end, { noremap = true, silent = true })

vim.keymap.set('n', 'd', '"_x', { noremap = true, silent = true })
vim.keymap.set('n', 'c', '"_xi', { noremap = true, silent = true })
vim.keymap.set("n", "<BS>", function()
	vim.api.nvim_feedkeys('i' .. BS, "n", true)
	vim.api.nvim_feedkeys(ESC, "m", true) -- use map
end, { noremap = true, silent = true })
vim.keymap.set('x', '<BS>', '"_x', { noremap = true, silent = true })
vim.keymap.set('n', 'y', 'yy', { noremap = true, silent = true })
vim.keymap.set('n', 'p', 'Pl', { noremap = true, silent = true })
vim.keymap.set('n', 'P', '"+Pl', { noremap = true, silent = true })
vim.keymap.set('x', 'i', function()
	vim.api.nvim_feedkeys(ESC .. "i", "n", true)
end, { noremap = true, silent = true, nowait = true })
vim.keymap.set('x', 'a', function()
	vim.api.nvim_feedkeys("o" .. ESC .. "i", "n", true)
end, { noremap = true, silent = true, nowait = true })
vim.keymap.set('x', 'o', '<ESC>o', { noremap = true, silent = true, nowait = true })
vim.keymap.set('x', 'O', '<ESC>O', { noremap = true, silent = true, nowait = true })
vim.keymap.set('n', '<', '<<', { noremap = true, silent = true })
vim.keymap.set('x', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('n', '>', '>>', { noremap = true, silent = true })
vim.keymap.set('x', '>', '>gv', { noremap = true, silent = true })

-- quit
vim.keymap.set({ 'n', 'x' }, "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
vim.keymap.set({ 'n', 'x' }, "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
vim.keymap.set({ 'n', 'x' }, "<leader>uI", function()
	vim.treesitter.inspect_tree()
	vim.api.nvim_input("I")
end, { desc = "Inspect Tree" })

-- LazyVim
vim.keymap.set({ 'n', 'x' }, "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
vim.keymap.set({ 'n', 'x' }, "<leader>L", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })

-- commenting
vim.keymap.del({ 'n' }, "gcc")
vim.keymap.set({ 'x' }, "gc", function()
    require('vim._comment').operator()
	vim.api.nvim_feedkeys("g@gv", "n", true)
end, { desc = "Toggle Line Comment" })
vim.keymap.set({ 'n' }, "gc", function()
    require('vim._comment').operator()
	vim.api.nvim_feedkeys("g@_", "n", true)
end, { desc = "Toggle Line Comment" })

-- new file
vim.keymap.set({ 'n', 'x' }, "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- location list
vim.keymap.set({ 'n', 'x' }, "<leader>xl", function()
	local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Location List" })

-- quickfix list
vim.keymap.set({ 'n', 'x' }, "<leader>xq", function()
	local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Quickfix List" })

vim.keymap.set({ 'n', 'x' }, "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set({ 'n', 'x' }, "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- formatting
vim.keymap.set({ 'n', 'x' }, "<leader>cf", function()
	LazyVim.format({ force = true })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
vim.keymap.set({ 'n', 'x' }, "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set({ 'n', 'x' }, "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set({ 'n', 'x' }, "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set({ 'n', 'x' }, "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set({ 'n', 'x' }, "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set({ 'n', 'x' }, "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set({ 'n', 'x' }, "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- move lines
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
vim.keymap.set({ 'n', 'x' }, "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set({ 'n', 'x' }, "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set({ 'n', 'x' }, "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set({ 'n', 'x' }, "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set({ 'n', 'x' }, "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set({ 'n', 'x' }, "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set({ 'n', 'x' }, "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set({ 'n', 'x' }, "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
vim.keymap.set({ 'n', 'x' }, "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- tabs
vim.keymap.set({ 'n', 'x' }, "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set({ 'n', 'x' }, "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
vim.keymap.set({ 'n', 'x' }, "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set({ 'n', 'x' }, "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set({ 'n', 'x' }, "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set({ 'n', 'x' }, "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set({ 'n', 'x' }, "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- custom
vim.keymap.set({ 'n' }, 'U', '<cmd>redo<cr>', { noremap = true, silent = true })
vim.keymap.set({ 'x' }, 'U', ESC .. '<cmd>redo<cr>', { noremap = true, silent = true })
vim.keymap.set({ 'x' }, 'u', ESC .. '<cmd>undo<cr>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'J', '<PageDown>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'K', '<PageUp>', { noremap = true, silent = true })
vim.keymap.set({ 'n' }, '<C-s>', '<cmd>update<cr>', { noremap = true, silent = true })
vim.keymap.set({ 'x' }, '<C-s>', ESC .. '<cmd>update<cr>gv', { noremap = true, silent = true })
vim.keymap.set({ 'i' }, '<C-s>', ESC .. '<cmd>update<cr>', { noremap = true, silent = true })
