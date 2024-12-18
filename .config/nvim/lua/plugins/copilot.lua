return {
    {
        "AndreM222/copilot-lualine",
        dependencies = {
            "zbirenbaum/copilot.lua",
        }
    },
    {
        "zbirenbaum/copilot.lua",
        opts = {
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = false,
                }
            }
        }
    }
}
