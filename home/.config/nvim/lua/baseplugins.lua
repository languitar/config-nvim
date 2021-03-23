local paq = require'paq-nvim'.paq

-- lua utilities
paq{'nvim-lua/plenary.nvim'}
paq{'nvim-lua/popup.nvim'}

-- text object basics
paq{'kana/vim-textobj-user'}
paq{'glts/vim-textobj-comment'}

-- icon support
paq{'kyazdani42/nvim-web-devicons'}
require'nvim-web-devicons'.setup {
  default = true;
}
