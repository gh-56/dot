return {
  "askfiy/smart-translate.nvim",
  cmd = { "Translate" },
  dependencies = {
    "askfiy/http.nvim", -- a wrapper implementation of the Python aiohttp library that uses CURL to send requests.
  },

  config = function()
    require("smart-translate").setup({
      default = {
        cmds = {
          source = "auto",
          target = "ko",
          handle = "float",
          engine = "google",
        },
        cache = true,
      },
      engine = {
        deepl = {
          -- Support SHELL variables, or fill in directly
          api_key = "$DEEPL_API_KEY",
          base_url = "https://api-free.deepl.com/v2/translate",
        },
      },
      hooks = {
        ---@param opts SmartTranslate.Config.Hooks.BeforeCallOpts
        ---@return string[]
        before_translate = function(opts)
          return opts.original
        end,
        ---@param opts SmartTranslate.Config.Hooks.AfterCallOpts
        ---@return string[]
        after_translate = function(opts)
          return opts.translation
        end,
      },
      translator = {
        engine = {
          {
            name = "translate-shell",
            ---@param source string
            ---@param target string
            ---@param original string[]
            ---@param callback fun(translation: string[])
            translate = function(source, target, original, callback)
              -- 1. Optional: Do you need to convert the command line input language to the language supported by the translator?
              source = "en"
              target = "ko"
              -- 2. Add your custom processing logic
              vim.system(
                {
                  "trans",
                  "-b",
                  ("%s:%s"):format(source, target),
                  table.concat(original, "\n"),
                },
                { text = true },
                ---@param completed vim.SystemCompleted
                vim.schedule_wrap(function(completed)
                  -- 3. Call callback for rendering processing, the translation needs to return string[]
                  callback(vim.split(completed.stdout, "\n", { trimempty = false }))
                end)
              )
            end,
          },
        },
        handle = {
          {
            name = "echo",
            ---@param translator SmartTranslate.Translator
            render = function(translator)
              vim.print(translator.translation)

              --[[
                        SmartTranslate.Translator is an object that contains a lot of useful information:

                        ---@class SmartTranslate.Translator
                        ---@field public namespace integer                          -- Namespace
                        ---@field public special string[]                           -- Special operations, e.g., --comment/--cleanup
                        ---@field public buffer buffer                              -- The buffer the original text came from
                        ---@field public window window                              -- The window the original text came from
                        ---@field public mode string                                -- Mode when translation was invoked
                        ---@field public source string                              -- Source language
                        ---@field public target string                              -- Target language
                        ---@field public handle string                              -- Handler
                        ---@field public engine string                              -- Translation engine
                        ---@field public original string[]                          -- Original text
                        ---@field public public translation string[]                -- Translated text
                        ---@field public use_cache_translation boolean              -- Whether cache was hit
                        ---@field public range table<string, integer>[]             -- Original text range
                    ]]
            end,
          },
        },
      },
    })
  end,
}
