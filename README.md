# sql-docs.nvim

A Neovim plugin that provides SQL documentation when pressing K over SQL keywords.

## Features

- Shows documentation for common SQL keywords
- Displays syntax information
- Includes examples for complex keywords
- Closes with 'q' or 'Esc'
- Only activates in SQL files by default

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "adtyap26/sql_docs.nvim",
  lazy = false,
  config = function()
    require("sql-docs").setup()
  end
}
```

## Configuration

You can customize the plugin with the following options:

```lua
require("sql-docs").setup({
  filetypes = {"sql", "mysql", "pgsql"}, -- Filetypes where the plugin is active
  mapping = "K", -- Key mapping to trigger documentation
})
```

## Usage

1. Open a SQL file
2. Place your cursor over a SQL keyword (e.g., SELECT, FROM, WHERE)
3. Press K to view documentation
