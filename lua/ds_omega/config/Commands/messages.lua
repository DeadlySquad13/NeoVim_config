return {
    "AckslD/messages.nvim",

    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local messages_is_available, messages = prequire('messages')

        if not messages_is_available then
          return
        end

        messages.setup(opts)
    end,
}
