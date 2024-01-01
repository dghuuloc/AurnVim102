return {
	'winston0410/commented.nvim',
	dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },

  config = function()
    local commented = require("commented")

    commented.setup({
      hooks = {
        before_comment = require("ts_context_commentstring.internal").update_commentstring,
      }

    })
  end,
}
