return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["kubernetes"] = "*.yaml",
              },
            },
          },
        },
      },
    },
  },
}
