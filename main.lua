local GameState = {
    MENU = "menu",
    COMBAT = "combat",
    CHARACTER_CREATION = "character_creation"
}

local game = {
    state = GameState.MENU,
    font = nil,
    player = nil,
    enemy = nil,
    combatLog = {},
    currentTurn = "player"
}

function love.load()
    love.window.setTitle("D&D Combat System")
    game.font = love.graphics.newFont(16)
    love.graphics.setFont(game.font)
    
    require("dice")
    require("character")
    require("combat")
    
    game.player = Character.new("Hero", true)
    game.enemy = Character.new("Goblin", false)
    
    addToLog("Welcome to D&D Combat!")
    addToLog("Press SPACE to start combat, R to roll a test die")
end

function love.update(dt)
    
end

function love.draw()
    love.graphics.clear(0.1, 0.1, 0.2, 1)
    
    if game.state == GameState.MENU then
        drawMenu()
    elseif game.state == GameState.COMBAT then
        drawCombat()
    end
end

function love.keypressed(key)
    if game.state == GameState.MENU then
        if key == "space" then
            game.state = GameState.COMBAT
            Combat.startCombat(game.player, game.enemy)
        elseif key == "r" then
            local roll = Dice.roll(20)
            addToLog("Test d20 roll: " .. roll)
        end
    elseif game.state == GameState.COMBAT then
        Combat.handleInput(key)
    end
end

function drawMenu()
    love.graphics.print("D&D Combat System", 50, 50)
    love.graphics.print("Press SPACE to start combat", 50, 100)
    love.graphics.print("Press R to test dice rolling", 50, 120)
    
    love.graphics.print("Combat Log:", 50, 180)
    for i, log in ipairs(game.combatLog) do
        love.graphics.print(log, 50, 200 + (i - 1) * 20)
    end
end

function drawCombat()
    love.graphics.print("=== COMBAT ===", 50, 20)
    
    love.graphics.print("Player:", 50, 60)
    love.graphics.print(game.player:getStatusString(), 50, 80)
    
    love.graphics.print("Enemy:", 50, 140)
    love.graphics.print(game.enemy:getStatusString(), 50, 160)
    
    love.graphics.print("Turn: " .. game.currentTurn, 50, 200)
    love.graphics.print("A - Attack, D - Defend, ESC - Back to menu", 50, 220)
    
    love.graphics.print("Combat Log:", 50, 260)
    local startIndex = math.max(1, #game.combatLog - 8)
    for i = startIndex, #game.combatLog do
        love.graphics.print(game.combatLog[i], 50, 280 + (i - startIndex) * 18)
    end
end

function addToLog(message)
    table.insert(game.combatLog, message)
    if #game.combatLog > 20 then
        table.remove(game.combatLog, 1)
    end
end

function getGame()
    return game
end