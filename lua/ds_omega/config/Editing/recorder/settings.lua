local MACRO_KEYS = { "j", "J", "<C-j>" }

return {
    mapping = {
        startStopRecording = MACRO_KEYS[1],
        playMacro = MACRO_KEYS[2],
        switchSlot = MACRO_KEYS[3],
        editMacro = "m"..MACRO_KEYS[1],
        yankMacro = "f"..MACRO_KEYS[1],
        deleteAllMacros = "l"..MACRO_KEYS[1],
        addBreakPoint = '<Leader>db', -- 'Debug add Break point'.
    },
}
