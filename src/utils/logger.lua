local Logger = {}

Logger.levels = {
    DEBUG = 1,
    INFO = 2,
    WARNING = 3,
    ERROR = 4
}

Logger.currentLevel = Logger.levels.INFO
Logger.enabled = true

function Logger.setLevel(level)
    Logger.currentLevel = level
end

function Logger.enable()
    Logger.enabled = true
end

function Logger.disable()
    Logger.enabled = false
end

function Logger.log(level, message, ...)
    if not Logger.enabled or level < Logger.currentLevel then
        return
    end
    
    local levelNames = {
        [Logger.levels.DEBUG] = "DEBUG",
        [Logger.levels.INFO] = "INFO",
        [Logger.levels.WARNING] = "WARN",
        [Logger.levels.ERROR] = "ERROR"
    }
    
    local timestamp = os.date("%H:%M:%S")
    local formattedMessage = string.format(message, ...)
    local logLine = string.format("[%s] %s: %s", timestamp, levelNames[level], formattedMessage)
    
    print(logLine)
end

function Logger.debug(message, ...)
    Logger.log(Logger.levels.DEBUG, message, ...)
end

function Logger.info(message, ...)
    Logger.log(Logger.levels.INFO, message, ...)
end

function Logger.warning(message, ...)
    Logger.log(Logger.levels.WARNING, message, ...)
end

function Logger.error(message, ...)
    Logger.log(Logger.levels.ERROR, message, ...)
end

return Logger