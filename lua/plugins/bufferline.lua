local settings = require("core.settings")
return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-web-devicons", "ojroques/nvim-bufdel" },
    event = "BufReadPost",
    keys = require("core.keymaps").buffer,
    config = function()
      local opts = {
        options = {
          number = nil,
          modified_icon = "✥",
          buffer_close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 14,
          max_prefix_length = 13,
          tab_size = 20,
          show_buffer_close_icons = true,
          show_buffer_icons = true,
          show_tab_indicators = false,
          diagnostics = "nvim_lsp",
          always_show_bufferline = true,
          separator_style = "thin",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              padding = 1,
            },
            {
              filetype = "lspsagaoutline",
              text = "Lspsaga Outline",
              text_align = "center",
              padding = 1,
            },
          },
          diagnostics_update_in_insert = settings.diagnostics_update_in_insert,
          diagnostics_indicator = function(_, _, diagnostics_dict, _)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " " or (e == "warning" and " " or "")
              s = s .. n .. sym
            end
            return s
          end,
        },
        -- Change bufferline's highlights here! See `:h bufferline-highlights` for detailed explanation.
        -- Note: If you use catppuccin then modify the colors below!
        highlights = {},
      }
      require("bufferline").setup(opts)
    end,
  },
}
