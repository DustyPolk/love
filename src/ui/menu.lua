local Menu = {}

function Menu.draw(game)
    love.graphics.print("D&D Combat System", 50, 50)
    love.graphics.print("Press SPACE to start combat", 50, 100)
    love.graphics.print("Press R to test dice rolling", 50, 120)
    love.graphics.print("Press Q to quit", 50, 140)
    
    love.graphics.print("Combat Log:", 50, 180)
    for i, log in ipairs(game.combatLog) do
        love.graphics.print(log, 50, 200 + (i - 1) * 20)
    end
end

function Menu.handleInput(key, game)
    if key == "space" then
        local GameState = require("src.core.gamestate")
        GameState.setState(GameState.states.COMBAT)
        local Combat = require("src.systems.combat")
        Combat.startCombat(game.player, game.enemy)
    elseif key == "r" then
        local Dice = require("src.systems.dice")
        local roll = Dice.roll(20)
        game.addToLog("Test d20 roll: " .. roll)
    elseif key == "q" then
        love.event.quit()
    end
end

return Menu