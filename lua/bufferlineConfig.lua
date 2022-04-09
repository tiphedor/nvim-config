require("bufferline").setup{
  options = {
    diagnostics = "coc",
    show_close_icon = false,
    show_buffer_close_icons = false,
    offsets = {{
      filetype = "nerdtree",
      text = function()
        return vim.fn.getcwd()
      end,
    }}
  }
}
