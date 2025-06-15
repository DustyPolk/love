local GameState = {}

GameState.states = {
    MENU = "menu",
    COMBAT = "combat",
    CHARACTER_CREATION = "character_creation",
    GAME_OVER = "game_over"
}

GameState.current = GameState.states.MENU
GameState.previous = nil

function GameState.setState(newState)
    if GameState.states[newState] or newState == GameState.states.MENU or 
       newState == GameState.states.COMBAT or newState == GameState.states.CHARACTER_CREATION or
       newState == GameState.states.GAME_OVER then
        GameState.previous = GameState.current
        GameState.current = newState
        return true
    end
    return false
end

function GameState.getCurrentState()
    return GameState.current
end

function GameState.getPreviousState()
    return GameState.previous
end

function GameState.isState(state)
    return GameState.current == state
end

function GameState.returnToPrevious()
    if GameState.previous then
        GameState.current = GameState.previous
        GameState.previous = nil
    end
end

return GameState