-- config for bufferline

local status, bufferline = pcall(require, "bufferline")
if not status then
  return
end

bufferline.setup({
  highlights = {
    fill = {
      bg = {
        attribute = "bg",
        highlight = "BufferLineFill",
      },
    },
  },
  options = {
    mode = "tabs",
    separator_style = "thick",
    always_show_bufferline = true,
    show_buffer_close_icons = false,
    show_close_icon = true,
    color_icons = true,
    diagnostics = "nvim_lsp",
  },
})
