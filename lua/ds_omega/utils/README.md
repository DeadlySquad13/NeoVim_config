# Utils
## Logging

Usage:

```lua
--  Create logger instance using builder pattern. Defined log-group name "Logseq"
-- will be used in all logs later on.
local logger = get_logger("Logseq"):build()
logger:info("Test")
logger:warning("Warning")
logger:debug("Debug")
logger:info("Info")

-- Messages for user. Will also be passed into logger for easier debugging.
local notifier = logger:get_notifier({
    title = "Authorization issue", -- Otherwise will inherit log-group name from `logger`.
    -- ...other notify-specific opts...
})

-- Will notify user with message: "Authorization error, please contact support", and title: "Authorization issue",
-- and also log: "16:53:33: [ERROR] Logseq: Authorization error, please contact support ds13" { extra_debug_info = "token is mismatched, E43222"} { ...whole response obj.. }
local user = "ds13"
notifier:error(
    string.format("Authorization error, please contact support %s", user),
    { extra_debug_info = response.error },
    response,
    -- Any number of variables to log
)

```
