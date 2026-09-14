return {
    {
        "mfussenegger/nvim-dap",

        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "mfussenegger/nvim-dap-python",
            "leoluz/nvim-dap-go",
            "jbyuki/one-small-step-for-vimkind",
        },

        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "debugpy",
                    "codelldb",
                    "delve",
                    "bash-debug-adapter",
                },

                automatic_installation = true,

                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                },
            })

            require("dap-python").setup("python")
            require("dap-go").setup()

            dap.configurations.lua = {
                {
                    type = "nlua",
                    request = "attach",
                    name = "Attach to running Neovim instance",
                    host = "127.0.0.1",
                    port = 8086,
                },
            }

            dap.adapters.nlua = function(callback, config)
                callback({
                    type = "server",
                    host = config.host or "127.0.0.1",
                    port = config.port or 8086,
                })
            end

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end

            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
}
