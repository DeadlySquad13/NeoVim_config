# Utils

## Logging

Usage:

```lua
--  Create logger instance using factory pattern. Defined log-group name "Logseq"
-- will be used in all logs later on.
local logger = get_logger("Logseq")
-- Optionally set options:
logger:set_log_into({ file = true, messages = true, notify = false })
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

In case you need to overwrite notify settings only for one call, there's no
need to create a new notifier instance, just use more verbose function
signature:
```lua
notifier:info({
    msg = "Auto save successful",
    title = "AutoSave plugin",
    -- No need to log these messages.
    skip_log = true,

    -- Nvim-notify settings:
    render = "compact",
    stages = "fade",
    -- - Hide this notification from the history.
    hide_from_history = true,
})
```

There's also two extra variants for each notifier method:

- throttled:

    ```lua
    -- Notifications are throttled on a leading edge with 5s time window.
    -- Userful when you want to make many tries until sure that error is unavoidable.
    notifier:warning_throttled("Repeated request error") -- Will show.
    notifier:warning_throttled("Repeated request error") -- won't show, waiing for window end.
    sleep(3000)
    notifier:warning_throttled("Repeated request error") -- won't show, waiting for window end.
    sleep(2000)
    -- 5 seconds have passed, time window is over, will show message.

    sleep(10000) -- Throttle has reset.

    notifier:warning_throttled("Repeated request error") -- new throttle cycle....
    sleep(2000)
    notifier:warning_throttled("Repeated request error")
    ```

- one-shot:

    ```lua
    notifier:info_once("Repeated error") -- Will show.
    notifier:info_once("Repeated error") -- Won't.
    notifier:info_once("Repeated error") -- Won't.
    notifier:info_once("Repeated error") -- Won't.

    notifier:info_once("Repeated error 2") -- Something new, will show.
    ```
