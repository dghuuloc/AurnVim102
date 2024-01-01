return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        initial_mode = "normal",

        sorting_strategy = "ascending",

        layout_strategy = "horizontal",         -- value: {horizontal, vertical}

        layout_config = {
						--  prompt_position = 'top',
						width = 200
            --  width = 0.5
        },

        preview = { ls_short = true },
        path_display = { "truncate " },

        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    -- TODO: now is not working
    --  telescope.load_extension("fzf")
  end,
}
