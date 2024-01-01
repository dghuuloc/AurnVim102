
return {
  "glepnir/galaxyline.nvim",
  config = function()
    local utils = {}
    local gl = require('galaxyline')
    local gls = gl.section
    local extension = require('galaxyline.provider_extensions')
    -- Built-in conditions
    local condition = require("galaxyline.condition")

    function utils.is_buffer_empty()
        -- Check whether the current buffer is empty
        return vim.fn.empty(vim.fn.expand('%:t')) == 1
    end

    function utils.has_width_gt(cols)
        -- Check if the windows width is greater than a given number of columns
        return vim.fn.winwidth(0) / 2 > cols
    end

    gl.short_line_list = {
      'LuaTree',
      'vista',
      'dbui',
      'startify',
      'term',
      'nerdtree',
      'fugitive',
      'fugitiveblame',
      'plug',
      'NvimTree',
      'DiffviewFiles',
    }

    -- Colors
    local colors = {
      bg = '#282a36',
      -- bg = '#282c34',
      fg = '#f8f8f2',
      -- fg = '#8FBCBB',
      section_bg = '#4f4f4f',
    ---------------------------
      line_bg = '#353644',
      bg_light = '#444b59',
      black = '#222222',
      white = '#abb2bf',
      yellow = '#f1fa8c',
      cyan = '#8be9fd',
      green = '#50fa7b',
      orange = '#ffb86c',
      magenta = '#ff79c6',
      blue = '#8be9fd',
      red = '#ff5555',
     -------------------------
     -- orange = '#FF8800',
      bgm = '#292D38',
      info_yellow = '#FFCC66',
      error_red = '#F44747',
      vivid_blue = '#4FC1FF',
    }

    require ('galaxyline').section.short_line_left = {
      {
        ShortLineLeftBufferType = {
          highlight = {colors.cyan, colors.line_bg},
          provider = function ()
            local BufferTypeMap = {
              ['Mundo'] = 'Mundo History',
              ['MundoDiff'] = 'Mundo Diff',
              --  ['NvimTree'] = '󰙅 NvimTree',
              --  ['NvimTree'] = '󰟐 NvimTree',
              ['fugitive'] = ' Fugitive',
              ['fugitiveblame'] = ' Fugitive Blame',
              ['help'] = '󰘥 Help',
              ['minimap'] = 'Minimap',
              ['qf'] = '󰁨 Quick Fix',
              ['tabman'] = 'Tab Manager',
              ['tagbar'] = 'Tagbar',
              ['toggleterm'] = 'Terminal',
              ['FTerm'] = 'Terminal',
              ['NeogitStatus'] = ' Neogit Status',
              ['NeogitPopup'] = ' Neogit Popup',
              ['NeogitCommitMessage'] = ' Neogit Commit',
              ['DiffviewFiles'] = ' Diff View'
            }
            local name = BufferTypeMap[vim.bo.filetype] or ' AurnVim'
            return string.format('  %s ', name)
          end,
          separator_highlight = {colors.line_bg, colors.dark}
        }
      },
    }

    -- Local helper functions
    local buffer_not_empty = function()
      return not utils.is_buffer_empty()
    end

    local in_git_repo = function ()
      local vcs = require('galaxyline.provider_vcs')
      local branch_name = vcs.get_git_branch()

      return branch_name ~= nil
    end

    local checkwidth = function()
      return utils.has_width_gt(40) and in_git_repo()
    end


    local mode_color = function()
      local mode_colors = {
        n = colors.cyan,
        i = colors.green,
        c = colors.orange,
        V = colors.magenta,
        [''] = colors.magenta,
        v = colors.magenta,
        R = colors.red,
      }

      local color = mode_colors[vim.fn.mode()]

      if color == nil then
        color = colors.red
      end

      return color
    end

    --- LEFT STATUSLINE ---
    gls.left[1] = {
      ViModeIcon = {
        separator = '  ',
        separator_highlight = {colors.black, colors.bg_light},
        highlight = {colors.white, colors.black},
        provider = function() return "   " end,
      }
    }

    gls.left[2] = {
      ViMode = {
        provider = function()
          local alias = {
            n = 'NORMAL',
            i = 'INSERT',
            c = 'COMMAND',
            V = 'VISUAL',
            [''] = 'VISUAL',
            v = 'VISUAL',
            R = 'REPLACE',
          }
          vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color())
          local alias_mode = alias[vim.fn.mode()]
          if alias_mode == nil then
            alias_mode = vim.fn.mode()
          end
          return ' '..alias_mode..' '
        end,
        highlight = { colors.bg, colors.bg },
        separator_highlight = {colors.bg, colors.section_bg},
      },

    }

    gls.left[3] ={
      FileIcon = {
        provider = 'FileIcon',
        condition = buffer_not_empty,
        highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.section_bg },
      },
    }

    gls.left[4] = {
      FileName = {
        provider = 'FileName',
        condition = buffer_not_empty,
        highlight = { colors.fg, colors.section_bg },
        separator = ' ',
        separator_highlight = {colors.section_bg, colors.bg},
      }
    }

    gls.left[5] = {
      GitIcon = {
        provider = function() return ' ' end,
        condition = in_git_repo,
        highlight = {colors.red,colors.bg},
      }
    }

    gls.left[6] = {
      GitBranch = {
        provider = function()
          local vcs = require('galaxyline.provider_vcs')
          local branch_name = vcs.get_git_branch()
          if (string.len(branch_name) > 28) then
            return string.sub(branch_name, 1, 25)..'...'
          end
          return branch_name .. ' '
        end,
        condition = in_git_repo,
        highlight = {colors.fg,colors.bg},
      }
    }
    gls.left[7] = {
        DiffAdd = {
            provider = 'DiffAdd',
            condition = checkwidth,
            icon = '  ',
            highlight = { colors.green, colors.bg },
        }
    }
    gls.left[8] = {
      DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = ' ',
        highlight = { colors.orange, colors.bg },
      }
    }
    gls.left[9] = {
      DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '  ',
        highlight = { colors.red,colors.bg },
      }
    }

    --- MIDDLE STATUSLINE ---
    gls.mid[1] = {
      DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.error_red, 'NONE'}
      }
    }

    gls.mid[2] = {
      DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.orange, 'NONE'},
      }
    }

    gls.mid[3] = {
      DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = ' 󰠠 ',
        highlight = {colors.vivid_blue, 'NONE'}
      },
    }

    gls.mid[4] = {
      DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  ',
        highlight = {colors.info_yellow, 'NONE'},
      }
    }

    --- RIGHT STATUSLINE ---
    gls.right[1]= {
      FileFormat = {
        provider = function() return vim.bo.filetype end,
        highlight = { colors.grey,colors.bg },
        separator_highlight = { colors.fg,colors.line_bg },
      }
    }

    gls.right[2] = {
      FileSize = {
        provider = 'FileSize',
        condition = buffer_not_empty,
        highlight = {colors.grey,colors.bg},
        separator = ' | '
      }
    }

    gls.right[3] = {
      --[[
      Linux = {
        -- provider = function() return ' ' end,
        provider = function() return ' ' end,
        highlight = { colors.grey, colors.bg },
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg },
      }
      --]]
      Windows = {
        -- provider = function() return ' ' end,
        provider = function() return ' ' end,
        highlight = { colors.grey, colors.bg },
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg },
      }
    }

    gls.right[4] = {
      FileEncode = {
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = '',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
      }
    }

    gls.right[5] = {
      ShowLspClient = {
        provider = function()
          local msg = ''
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then return msg end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return "[" .. client.name .. "]"
            end
          end
          return msg end,
        highlight = {colors.cyan, colors.bg},
        separator = ' '
      }
    }

    gls.right[6] = {
      LineColumn = {
        provider = function ()
          local max_lines = vim.fn.line('$')
          local line = vim.fn.line('.')
          local column = vim.fn.col('.')
          local ld = " "
          if string.len(max_lines) > 3 then
            ld = string.format("  %5d/%2d :%6d ", line, column, max_lines)
          end
          ld =string.format("  %3d/%2d :%2d ", line, column, max_lines)
          return ld
        end,
        highlight = {colors.grey, colors.bg},
      }
    }

    gl.section.right[7] = {
      FileLocation = {
        icon = ' ',
        separator_highlight = {colors.bg_dim, colors.bg},
        highlight = {colors.gray, colors.bg_dim},
        provider = function()
          local current_line = vim.fn.line('.')
          local total_lines = vim.fn.line('$')

          if current_line == 1 then
            return 'Top'
          elseif current_line == total_lines then
            return 'Bottom'
          end

          local percent, _ = math.modf((current_line / total_lines) * 100)
          return '' .. percent .. '%'
        end,
      }
    }

    gls.right[10] = {
      RightEnd = {
        provider = function() return '' end,
        condition = buffer_not_empty,
        highlight = {colors.cyan,colors.bg},
        separator = ' ',
      }
    }

  end,
}
