# ned-chtsh.nvim

**`ned-chtsh.nvim`** is a Neovim plugin that allows users to query [cht.sh](https://cht.sh) directly from Neovim to quickly access cheat sheets on various programming languages, tools, and commands.

## Features

- Seamlessly query `cht.sh` from within Neovim.
- Display cheat sheet results in a new split window.
- Supports key mappings and custom commands for quick access.
- Removes ANSI escape sequences from the results for better readability in the Neovim buffer.

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

1. Install `lazy.nvim` plugin manager, if you haven't already.
2. Add the following line to your Neovim configuration file (`init.lua`):

```lua
    -- from remote
    require("lazy").setup({
        {
            "nedelcu-ioan/ned-chtsh.nvim", 
        },
    })

    -- from source
    require("lazy").setup({
       {
            "ned-chtsh.nvim", 
            dir = "~/path/to/local/ned-chtsh",  -- Point this to your cloned repo
       },
    })
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

1. Install `packer.nvim` plugin manager, if you haven't already.
2. Add the following line to your `packer` setup in `init.lua`:

```lua
use '~/path/to/local/ned-chtsh' -- Use the path to your local cloned plugin
use 'nedelcu-ioan/ned-chtsh.nvim'
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

1. Install `vim-plug` if it's not already installed.
2. Add this line to your `init.vim` or `init.lua`:

```vim
    Plug '~/path/to/local/ned-chtsh' -- Replace with your actual plugin path
    Plug 'nedelcu-ioan/ned-chtsh.nvim'
```

### Manual Installation

1. Clone the plugin into your Neovim configuration directory:

```bash
    git clone https://github.com/your-username/ned-chtsh.nvim ~/.config/nvim/pack/plugins/start/ned-chtsh
```

2. Add the following to your `init.lua` or `init.vim`:

```lua
   require('ned-chtsh')
```

## Usage

1. Create a custom command and key mapping in your Neovim configuration:

   ```lua
   vim.api.nvim_create_user_command('Cht', function()
      require("ned-chtsh").getCheatSheet()
   end, { desc = "Query cht.sh" })

   vim.keymap.set('n', '<leader>cs', ':Cht<CR>', { desc = "[C]ht.[s]h query" })
   ```

2. Once you've set it up, you can use the plugin as follows:
   
   - Run the `:Cht` command to query a cheat sheet.
   - Use the key mapping `<leader>cs` to quickly open a prompt for the query.

## Examples

### Query Python Cheat Sheet

1. Type `:Cht python` in Neovim and hit Enter.
2. The cheat sheet will open in a new vertical split window.

## Development

If you want to contribute or test changes locally, follow these steps:

1. Clone the repository:

```bash
   git clone https://github.com/your-username/ned-chtsh.nvim
```

2. Set up a Docker environment for testing:

   - Build the container:

 ```bash
     ./build-test-container
 ```

   - Run the test container:

 ```bash
     ./run-test-container
 ```

3. Make your changes and test them in the isolated Docker environment.

## Acknowledgments

- [cht.sh](https://cht.sh) for providing a useful service for quick cheat sheet access.

