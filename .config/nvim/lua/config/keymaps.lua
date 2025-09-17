-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local kak_normal = true

ESC = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)

local function batch_action(action)
	if vim.o.lazyredraw == false then
		vim.o.lazyredraw = true
		vim.schedule(function()
			vim.o.lazyredraw = false
		end)
	end
	action()
end

local function kak_word_motion(motion)
	local count = vim.v.count > 0 and vim.v.count or 1
	if kak_normal then
		batch_action(function()
			vim.api.nvim_feedkeys(ESC, "n", true)
			if count > 1 then
				vim.cmd('normal! ' .. count - 1 .. motion)
			end
			vim.api.nvim_feedkeys("v" .. motion, "n", true)
		end)
	else
		vim.cmd('normal! ' .. count .. motion)
	end
end

for i, motion in pairs({'b', 'B', 'w', 'W', 'e', 'E'}) do
	vim.keymap.set('n', motion, function()
		kak_word_motion(motion)
	end, { noremap = true, silent = true })
	vim.keymap.set('v', motion, function()
		kak_word_motion(motion)
	end, { noremap = true, silent = true })
end

local function kak_char_motion(motion)
	local count = vim.v.count > 0 and vim.v.count or 1
	local mode = vim.api.nvim_get_mode().mode
	if kak_normal and (mode == "v") then
		batch_action(function()
			vim.api.nvim_feedkeys(ESC, "n", true)
			vim.cmd('normal! ' .. count .. motion)
		end)
	else
		vim.cmd('normal! ' .. count .. motion)
	end
end

for i, motion in pairs({'h', 'j', 'k', 'l'}) do
	vim.keymap.set('n', motion, function()
		kak_char_motion(motion)
	end, { noremap = true, silent = true })
	vim.keymap.set('v', motion, function()
		kak_char_motion(motion)
	end, { noremap = true, silent = true })
end

vim.keymap.set('n', 'n', 'gn', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'gN', { noremap = true, silent = true })
vim.keymap.set('v', 'n', function()
	if kak_normal then
		batch_action(function()
			vim.api.nvim_feedkeys(ESC .. "gn", "n", true)
		end)
	else
		vim.api.nvim_feedkeys("n", "n", true)
	end
end, { noremap = true, silent = true })
vim.keymap.set('v', 'N', function()
	if kak_normal then
		batch_action(function()
			vim.api.nvim_feedkeys(ESC .. "NgN", "n", true)
		end)
	else
		vim.api.nvim_feedkeys("N", "n", true)
	end
end, { noremap = true, silent = true })

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

vim.keymap.set('n', 'v', kak_toggle_visual, { noremap = true, silent = true })
vim.keymap.set('v', 'v', kak_toggle_visual, { noremap = true, silent = true })

vim.keymap.set('v', '<Esc>', function()
	if kak_normal then
		vim.api.nvim_feedkeys(ESC, "n", true)
	else
		kak_normal = true
	end
end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = {"v:n*", "v:i*"},
    callback = function()
		kak_normal = true
    end,
})

-- make cursor act like gui editors
vim.keymap.set("i", "<Esc>", function()
	if vim.fn.col('.') > 1 then
		batch_action(function()
			vim.api.nvim_feedkeys(ESC .. "l", "n", true)
		end)
	else
		vim.cmd("stopinsert")
	end
end, { noremap = true, silent = true })

vim.keymap.set('n', 'd', '"_x', { noremap = true, silent = true })
vim.keymap.set('n', 'c', '"_xi', { noremap = true, silent = true })
vim.keymap.set('n', 'p', 'Pl', { noremap = true, silent = true })
vim.keymap.set('n', 'P', '"+Pl', { noremap = true, silent = true })

vim.keymap.set('v', 'i', function()
	vim.api.nvim_feedkeys(ESC .. "i", "n", true)
end, { noremap = true, silent = true, nowait = true })
vim.keymap.set('v', 'a', function()
	vim.api.nvim_feedkeys("o" .. ESC .. "i", "n", true)
end, { noremap = true, silent = true, nowait = true })

vim.keymap.set('n', 'gl', '$', { noremap = true, silent = true })
vim.keymap.set('n', 'gs', '^', { noremap = true, silent = true })
vim.keymap.set('n', 'U', ':redo<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'J', '<PageDown>', { noremap = true, silent = true })
vim.keymap.set('n', 'K', '<PageUp>', { noremap = true, silent = true })
vim.keymap.set('v', 'gl', '$', { noremap = true, silent = true })
vim.keymap.set('v', 'gs', '^', { noremap = true, silent = true })
vim.keymap.set('v', 'U', ':redo<cr>', { noremap = true, silent = true })
vim.keymap.set('v', 'J', '<PageDown>', { noremap = true, silent = true })
vim.keymap.set('v', 'K', '<PageUp>', { noremap = true, silent = true })