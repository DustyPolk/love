local GameState = require("src.core.gamestate")
local Input = require("src.core.input")
local Menu = require("src.ui.menu")
local CombatUI = require("src.ui.combat_ui")
local Character = require("src.systems.character")
local Constants = require("src.utils.constants")
local Logger = require("src.utils.logger")

local game = {
    player = nil,
    enemy = nil,
    combatLog = {},
    currentTurn = "player",
    font = nil
}

function love.load()
    love.window.setTitle(Constants.GAME.TITLE)
    game.font = love.graphics.newFont(Constants.UI.FONT_SIZE)
    love.graphics.setFont(game.font)
    
    Logger.info("Game started - %s v%s", Constants.GAME.TITLE, Constants.GAME.VERSION)
    
    game.player = Character.new("Hero", true)
    game.enemy = Character.new("Goblin", false)
    
    Input.registerHandler(GameState.states.MENU, function(key)
        Menu.handleInput(key, game)
    end)
    
    Input.registerHandler(GameState.states.COMBAT, function(key)
        CombatUI.handleInput(key, game)
    end)
    
    game.addToLog("Welcome to D&D Combat!")
    game.addToLog("Press SPACE to start combat, R to roll a test die")
    
    Logger.info("Game initialization complete")
end

function love.update(dt)
    
end

function love.draw()
    love.graphics.clear(Constants.UI.COLORS.BACKGROUND)
    
    if GameState.isState(GameState.states.MENU) then
        Menu.draw(game)
    elseif GameState.isState(GameState.states.COMBAT) then
        CombatUI.draw(game)
    end
end

function love.keypressed(key)
    Logger.debug("Key pressed: %s in state: %s", key, GameState.getCurrentState())
    Input.handleKeyPressed(key, GameState.getCurrentState())
end

function game.addToLog(message)
    table.insert(game.combatLog, message)
    Logger.info("Combat Log: %s", message)
    
    if #game.combatLog > Constants.GAME.COMBAT_LOG_MAX_LINES then
        table.remove(game.combatLog, 1)
    end
end

function getGame()
    return game
end