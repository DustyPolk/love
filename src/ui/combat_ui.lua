local CombatUI = {}

function CombatUI.draw(game)
    love.graphics.print("=== COMBAT ===", 50, 20)
    
    love.graphics.print("Player:", 50, 60)
    love.graphics.print(game.player:getStatusString(), 50, 80)
    
    love.graphics.print("Enemy:", 50, 140)
    love.graphics.print(game.enemy:getStatusString(), 50, 160)
    
    love.graphics.print("Turn: " .. game.currentTurn, 50, 200)
    
    if game.currentTurn == "player" then
        love.graphics.print("A - Attack, D - Defend, ESC - Back to menu", 50, 220)
    else
        love.graphics.print("Enemy is thinking...", 50, 220)
    end
    
    love.graphics.print("Combat Log:", 50, 260)
    local startIndex = math.max(1, #game.combatLog - 8)
    for i = startIndex, #game.combatLog do
        love.graphics.print(game.combatLog[i], 50, 280 + (i - startIndex) * 18)
    end
    
    if not game.player:isAlive() then
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.print("GAME OVER - Press ESC to return to menu", 50, 500)
        love.graphics.setColor(1, 1, 1, 1)
    elseif not game.enemy:isAlive() then
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.print("VICTORY! - Press ESC to return to menu", 50, 500)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function CombatUI.handleInput(key, game)
    if key == "escape" then
        local GameState = require("src.core.gamestate")
        GameState.setState(GameState.states.MENU)
        game.addToLog("Returned to menu")
        return
    end
    
    if game.currentTurn == "player" and game.player:isAlive() and game.enemy:isAlive() then
        local Combat = require("src.systems.combat")
        if key == "a" then
            Combat.playerAttack()
        elseif key == "d" then
            Combat.playerDefend()
        end
    end
end

return CombatUI