local api = vim.api

local function open_superfile()
    local spf = vim.fn.exepath("spf")

    if spf == "" then
        vim.notify("Superfile executable not found", vim.log.levels.ERROR)
        return
    end

    local chooser_file = vim.fn.tempname()
    local origin_window = api.nvim_get_current_win()
    local origin_buffer = api.nvim_get_current_buf()

    vim.cmd("enew")

    local terminal_buffer = api.nvim_get_current_buf()
    vim.bo[terminal_buffer].bufhidden = "wipe"

    vim.fn.termopen({
        spf,
        "--chooser-file",
        chooser_file,
    }, {
        on_exit = function()
            vim.schedule(function()
                local selected_file = ""

                local file = io.open(chooser_file, "r")
                if file then
                    selected_file = file:read("*l") or ""
                    file:close()
                end

                os.remove(chooser_file)

                if api.nvim_win_is_valid(origin_window) then
                    api.nvim_set_current_win(origin_window)
                end

                if api.nvim_buf_is_valid(origin_buffer) then
                    api.nvim_set_current_buf(origin_buffer)
                end

                if api.nvim_buf_is_valid(terminal_buffer) then
                    api.nvim_buf_delete(terminal_buffer, { force = true })
                end

                if selected_file ~= "" then
                    vim.cmd("edit " .. vim.fn.fnameescape(selected_file))
                end
            end)
        end,
    })

    vim.cmd("startinsert")
end

return {
    {
        "anaypurohit0907/superfile.nvim",
        main = "superfile",

        opts = {
            key = false,
        },

        keys = {
            {
                "<leader>spf",
                open_superfile,
                mode = { "n", "t" },
                desc = "Open Superfile picker",
                silent = true,
            },
        },
    },
}
