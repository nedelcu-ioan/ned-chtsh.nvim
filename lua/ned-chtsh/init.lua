local M = {}

local function ansi2txt(str)
	return str:gsub("\027%[[%d;]*%a", "")
end

local function expandTabs(str, tabSize)
	local expanded = str:gsub("\t", string.rep("", tabSize))
	return expanded
end

function isWindowValid(win_id)
	-- Check if the window exists and is valid
	if vim.fn.win_id2win(win_id) == -1 then
		return false
	end

	-- Check if the window is visible
	local visible = vim.fn.winbufnr(win_id) > 0
	return visible
end

-- Function to create a new vertical split
local function createNewVerticalSplit()
	vim.cmd("vnew")
	M.window_id = vim.fn.win_getid()
	vim.fn.win_gotoid(M.window_id)
end

-- Function to create or reuse the window
local function createOrReuseWindow()
	-- Check if the module already has a window ID
	if M.window_id and isWindowValid(M.window_id) then
		-- Switch to the existing window
		vim.fn.win_gotoid(M.window_id)
	else
		-- Create a new vertical split
		createNewVerticalSplit()
	end
end

-- Function to get cheat sheet
local function getCheatSheet(query)
	local command = "curl --silent " .. "cht.sh/" .. query

	-- Create or reuse the window
	createOrReuseWindow()

	-- Execute the curl command and capture the output
	local result = vim.fn.systemlist(command)

	-- Create a new empty buffer
	vim.cmd("enew")

	-- Switch to the new buffer
	local new_buf = vim.fn.bufnr()
	vim.api.nvim_buf_set_option(new_buf, "buftype", "nofile")
	vim.api.nvim_set_current_buf(new_buf)

	-- Insert the output of the curl command into the buffer
	local lines = {}
	for _, line in ipairs(result) do
		-- Remove ANSI escape codes
		line = ansi2txt(line)
		-- Expand tabs
		line = expandTabs(line, 4)
		-- Save current line
		table.insert(lines, line)
	end

	-- Replace the entire buffer content with the lines in correct order
	vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, lines)
end

M.getCheatSheet = function()
	local query = vim.fn.input("Ask for: ")
	getCheatSheet(query)
end

return M
