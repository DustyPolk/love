local CharacterSheet = {}

function CharacterSheet.drawDetailed(character, x, y)
    local startY = y
    
    love.graphics.print(character.name .. " (Level " .. character.level .. ")", x, startY)
    startY = startY + 25
    
    love.graphics.print("HP: " .. character.currentHP .. "/" .. character.maxHP, x, startY)
    startY = startY + 20
    
    love.graphics.print("AC: " .. character.armorClass, x, startY)
    startY = startY + 20
    
    love.graphics.print("Weapon: " .. character.weapon.name, x, startY)
    startY = startY + 25
    
    love.graphics.print("Ability Scores:", x, startY)
    startY = startY + 20
    
    local abilities = character:getAbilityScores()
    local modifiers = character:getModifiers()
    
    for stat, value in pairs(abilities) do
        local modifier = modifiers[stat]
        local modStr = modifier >= 0 and "+" .. modifier or tostring(modifier)
        love.graphics.print(stat .. ": " .. value .. " (" .. modStr .. ")", x, startY)
        startY = startY + 18
    end
    
    return startY
end

function CharacterSheet.drawCompact(character, x, y)
    love.graphics.print(character:getStatusString(), x, y)
    return y + 20
end

return CharacterSheet