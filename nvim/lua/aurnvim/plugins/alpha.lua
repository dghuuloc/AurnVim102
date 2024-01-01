return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {

      [[                                                           ]],
      [[  █████╗ ██╗   ██╗██████╗ ███╗   ██╗██╗   ██╗██╗███╗   ███╗]],
      [[ ██╔══██╗██║   ██║██╔══██╗████╗  ██║██║   ██║██║████╗ ████║]],
      [[ ███████║██║   ██║██████╔╝██╔██╗ ██║██║   ██║██║██╔████╔██║]],
      [[ ██╔══██║██║   ██║██╔══██╗██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
      [[ ██║  ██║╚██████╔╝██║  ██║██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║]],
      [[ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],

    }

    -- Set menu
    dashboard.section.buttons.val = {
      --  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
      --  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      --  dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
      --  dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
      --  dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
      -- dashboard.button("s", "  Find Session", ":Telescope sessions save_current=false <CR>"),
      -- dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua <CR>"),
      --  dashboard.button("q", "  Quit", ":qa<CR>"),

      dashboard.button("a", "  > New File", "<cmd>ene<CR>"),
      dashboard.button("ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
      --  dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
      --  dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
      --  dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
      dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
    }

    local function footer()
      return "暑 @dghuuloc 暑"
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    -- dashboard.section.header.opts.hl = pick_color()
    dashboard.section.buttons.opts.hl = "Keyword"

    dashboard.opts.opts.noautocmd = true
    --  alpha.setup(dashboard.opts)

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

  end,
}

