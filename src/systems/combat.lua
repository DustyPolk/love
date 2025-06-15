local Dice = require("src.systems.dice")
local Constants = require("src.utils.constants")

local Combat = {}

local game = nil

function Combat.startCombat(player, enemy)
    game = getGame()
    
    local playerInit = Dice.roll(Constants.COMBAT.INITIATIVE_DIE, 1, player.initiative)
    local enemyInit = Dice.roll(Constants.COMBAT.INITIATIVE_DIE, 1, enemy.initiative)
    
    if playerInit >= enemyInit then
        game.currentTurn = "player"
        game.addToLog(string.format("Initiative: %s (%d) vs %s (%d) - %s goes first!", 
            player.name, playerInit, enemy.name, enemyInit, player.name))
    else
        game.currentTurn = "enemy"
        game.addToLog(string.format("Initiative: %s (%d) vs %s (%d) - %s goes first!", 
            player.name, playerInit, enemy.name, enemyInit, enemy.name))
    end
    
    game.addToLog("Combat begins!")
    
    if game.currentTurn == "enemy" then
        Combat.enemyTurn()
    end
end

function Combat.handleInput(key)
    if not game then return end
    
    if key == "escape" then
        game.state = "menu"
        addToLog("Returned to menu")
        return
    end
    
    if game.currentTurn == "player" then
        if key == "a" then
            Combat.playerAttack()
        elseif key == "d" then
            Combat.playerDefend()
        end
    end
end

function Combat.playerAttack()
    if not game or not game.player:isAlive() or not game.enemy:isAlive() then
        return
    end
    
    local hit, message, damage = game.player:attack(game.enemy)
    game.addToLog(message)
    
    if not game.enemy:isAlive() then
        game.addToLog(string.format("%s is defeated! Victory!", game.enemy.name))
        return
    end
    
    Combat.endTurn()
end

function Combat.playerDefend()
    if not game or not game.player:isAlive() then
        return
    end
    
    local message = game.player:defend()
    game.addToLog(message)
    game.player.armorClass = game.player.armorClass + Constants.COMBAT.DEFEND_AC_BONUS
    
    Combat.endTurn()
end

function Combat.enemyTurn()
    if not game or not game.enemy:isAlive() or not game.player:isAlive() then
        return
    end
    
    local action = math.random()
    
    if action <= Constants.COMBAT.ENEMY_ATTACK_CHANCE then
        local hit, message, damage = game.enemy:attack(game.player)
        game.addToLog(message)
        
        if not game.player:isAlive() then
            game.addToLog(string.format("%s is defeated! Game Over!", game.player.name))
            return
        end
    else
        local message = game.enemy:defend()
        game.addToLog(message)
        game.enemy.armorClass = game.enemy.armorClass + Constants.COMBAT.DEFEND_AC_BONUS
    end
    
    Combat.endTurn()
end

function Combat.endTurn()
    if not game then return end
    
    if game.player.armorClass > (Constants.CHARACTER.BASE_AC + game.player.dexMod) then
        game.player.armorClass = Constants.CHARACTER.BASE_AC + game.player.dexMod
    end
    if game.enemy.armorClass > (Constants.CHARACTER.BASE_AC + game.enemy.dexMod + Constants.ENEMY_STATS.GOBLIN.ac_bonus) then
        game.enemy.armorClass = Constants.CHARACTER.BASE_AC + game.enemy.dexMod + Constants.ENEMY_STATS.GOBLIN.ac_bonus
    end
    
    if game.currentTurn == "player" then
        game.currentTurn = "enemy"
        if game.enemy:isAlive() then
            love.timer.sleep(1)
            Combat.enemyTurn()
        end
    else
        game.currentTurn = "player"
    end
end

function Combat.isCombatOver()
    if not game then return true end
    return not game.player:isAlive() or not game.enemy:isAlive()
end

return Combat