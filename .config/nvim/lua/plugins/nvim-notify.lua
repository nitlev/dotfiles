return {
    'rcarriga/nvim-notify',
    config = function ()
        require('notify').setup({
            background_colour = '#282c34',
        })
    end
}
