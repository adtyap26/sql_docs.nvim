local M = {}

-- Import the SQL keywords documentation
local keywords = require("sql-docs.keywords")

-- Function to display SQL documentation
function M.show_sql_doc()
  local word = vim.fn.expand("<cword>"):upper()
  
  if keywords[word] then
    local doc = keywords[word]
    local lines = {}
    
    table.insert(lines, "SQL Documentation: " .. word)
    table.insert(lines, "")
    table.insert(lines, doc.description)
    table.insert(lines, "")
    table.insert(lines, "Syntax: " .. doc.syntax)
    
    if doc.examples then
      table.insert(lines, "")
      table.insert(lines, "Examples:")
      for _, line in ipairs(vim.split(doc.examples, "\n")) do
        table.insert(lines, line)
      end
    end
    
    -- Create a floating window
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
    
    -- Set buffer options
    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    
    -- Calculate window size and position
    local width = 80
    local height = #lines
    local win_height = vim.api.nvim_get_option("lines")
    local win_width = vim.api.nvim_get_option("columns")
    local row = math.floor((win_height - height) / 2)
    local col = math.floor((win_width - width) / 2)
    
    -- Window options
    local opts = {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
      border = "rounded"
      title = " SQL Documentation: " .. cursor_word:upper() .. " ",
      title_pos = "center",
    }
    
    -- Create the window
    local win = vim.api.nvim_open_win(buf, true, opts)
    
    -- Set mappings to close the window
    vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":close<CR>", {noremap = true, silent = true})
    
    -- Highlight the title
    vim.api.nvim_buf_add_highlight(buf, -1, "Title", 0, 0, -1)
  else
    vim.notify("No SQL documentation found for: " .. word, vim.log.levels.WARN)
  end
end

-- Setup function with configuration options
function M.setup(opts)
  opts = opts or {}
  
  -- Default options
  local default_opts = {
    filetypes = {"sql"},
    mapping = "K",
  }
  
  -- Merge user options with defaults
  for k, v in pairs(opts) do
    default_opts[k] = v
  end
  
  -- Create an autocommand group
  vim.api.nvim_create_augroup("SQLDocs", { clear = true })
  
  -- Set up the mapping for specified filetypes
  vim.api.nvim_create_autocmd("FileType", {
    group = "SQLDocs",
    pattern = default_opts.filetypes,
    callback = function()
      vim.api.nvim_buf_set_keymap(0, "n", default_opts.mapping, 
        ":lua require('sql-docs').show_sql_doc()<CR>", 
        {noremap = true, silent = true, desc = "Show SQL documentation"})
    end
  })
end

return M


