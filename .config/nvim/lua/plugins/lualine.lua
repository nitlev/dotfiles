return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        sections = {
            lualine_x = {
                {
                    'copilot',
                    show_colors = true
                },
                'encoding',
                'fileformat',
                'filetype'
            },
        }
    },
}
