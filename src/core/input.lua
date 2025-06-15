local Input = {}

Input.keyMappings = {
    attack = "a",
    defend = "d",
    back = "escape",
    start = "space",
    test = "r",
    quit = "q"
}

Input.handlers = {}

function Input.registerHandler(state, handler)
    Input.handlers[state] = handler
end

function Input.handleKeyPressed(key, gameState)
    local handler = Input.handlers[gameState]
    if handler then
        handler(key)
    end
end

function Input.getKeyForAction(action)
    return Input.keyMappings[action]
end

function Input.setKeyMapping(action, key)
    Input.keyMappings[action] = key
end

return Input