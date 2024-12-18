-- Git related plugins
return {
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Actions
				map('n', 'ghs', gs.stage_hunk, { desc = "Stage hunk" })
				map('n', 'ghu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
				map('n', 'ghr', gs.reset_hunk, { desc = "Reset hunk" })
				map('v', 'ghs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "Stage hunk" })
				map('v', 'ghr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "Reset hunk" })
				map('n', 'ghp', gs.preview_hunk_inline, { desc = "Preview hunk" })
				map('n', 'ghd', gs.diffthis, { desc = "Diff this" })
				map('n', 'ghb', function() gs.blame_line { full = true } end, { desc = "Blame line" })
				map('n', 'gb', gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
				map('n', '[h', gs.prev_hunk, { desc = "Previous hunk" })
				map('n', ']h', gs.next_hunk, { desc = "Next hunk" })

				-- Text object
				map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
			end
		},
	},
}
