-- css modules support in react
return {
  on_attach = function(client)
    -- avoid accepting 'definitionProvider' responses from this lsp (vtsls owns gd)
    client.server_capabilities.definitionProvider = false
  end,
}
