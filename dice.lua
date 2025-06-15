Dice = {}

math.randomseed(os.time())

function Dice.roll(sides, count, modifier)
    count = count or 1
    modifier = modifier or 0
    
    local total = 0
    local rolls = {}
    
    for i = 1, count do
        local roll = math.random(1, sides)
        table.insert(rolls, roll)
        total = total + roll
    end
    
    total = total + modifier
    
    return total, rolls
end

function Dice.rollWithAdvantage(sides, modifier)
    modifier = modifier or 0
    
    local roll1 = math.random(1, sides)
    local roll2 = math.random(1, sides)
    local result = math.max(roll1, roll2) + modifier
    
    return result, {roll1, roll2}, "advantage"
end

function Dice.rollWithDisadvantage(sides, modifier)
    modifier = modifier or 0
    
    local roll1 = math.random(1, sides)
    local roll2 = math.random(1, sides)
    local result = math.min(roll1, roll2) + modifier
    
    return result, {roll1, roll2}, "disadvantage"
end

function Dice.rollAbilityScore()
    local rolls = {}
    for i = 1, 4 do
        table.insert(rolls, math.random(1, 6))
    end
    
    table.sort(rolls, function(a, b) return a > b end)
    
    local total = rolls[1] + rolls[2] + rolls[3]
    
    return total, rolls
end

function Dice.getModifier(score)
    return math.floor((score - 10) / 2)
end

function Dice.rollAttack(attackBonus, advantage)
    advantage = advantage or "normal"
    
    if advantage == "advantage" then
        return Dice.rollWithAdvantage(20, attackBonus)
    elseif advantage == "disadvantage" then
        return Dice.rollWithDisadvantage(20, attackBonus)
    else
        return Dice.roll(20, 1, attackBonus)
    end
end

function Dice.rollDamage(damageDice, damageModifier)
    local total = 0
    local allRolls = {}
    
    for dieType, count in pairs(damageDice) do
        local result, rolls = Dice.roll(dieType, count)
        total = total + result
        for _, roll in ipairs(rolls) do
            table.insert(allRolls, dieType .. ":" .. roll)
        end
    end
    
    total = total + (damageModifier or 0)
    
    return total, allRolls
end

return Dice