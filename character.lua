Character = {}
Character.__index = Character

function Character.new(name, isPlayer)
    local self = setmetatable({}, Character)
    
    self.name = name
    self.isPlayer = isPlayer
    self.level = 1
    
    if isPlayer then
        self:generatePlayerStats()
    else
        self:generateEnemyStats()
    end
    
    self:calculateDerivedStats()
    
    return self
end

function Character:generatePlayerStats()
    self.strength = Dice.rollAbilityScore()
    self.dexterity = Dice.rollAbilityScore()
    self.constitution = Dice.rollAbilityScore()
    self.intelligence = Dice.rollAbilityScore()
    self.wisdom = Dice.rollAbilityScore()
    self.charisma = Dice.rollAbilityScore()
    
    self.proficiencyBonus = 2
    self.hitDie = 8
end

function Character:generateEnemyStats()
    self.strength = 12
    self.dexterity = 14
    self.constitution = 12
    self.intelligence = 8
    self.wisdom = 10
    self.charisma = 8
    
    self.proficiencyBonus = 2
    self.hitDie = 6
end

function Character:calculateDerivedStats()
    self.strMod = Dice.getModifier(self.strength)
    self.dexMod = Dice.getModifier(self.dexterity)
    self.conMod = Dice.getModifier(self.constitution)
    self.intMod = Dice.getModifier(self.intelligence)
    self.wisMod = Dice.getModifier(self.wisdom)
    self.chaMod = Dice.getModifier(self.charisma)
    
    self.maxHP = self.hitDie + self.conMod
    self.currentHP = self.maxHP
    
    self.armorClass = 10 + self.dexMod
    if not self.isPlayer then
        self.armorClass = self.armorClass + 2
    end
    
    self.initiative = self.dexMod
    
    self.attackBonus = self.proficiencyBonus + (self.isPlayer and self.strMod or self.dexMod)
    self.damageBonus = self.isPlayer and self.strMod or self.dexMod
    
    if self.isPlayer then
        self.weapon = {
            name = "Longsword",
            damage = {[8] = 1},
            type = "slashing"
        }
    else
        self.weapon = {
            name = "Scimitar",
            damage = {[6] = 1},
            type = "slashing"
        }
    end
end

function Character:attack(target)
    local attackRoll, rolls = Dice.rollAttack(self.attackBonus)
    local hitMessage = string.format("%s attacks %s: rolled %d vs AC %d", 
        self.name, target.name, attackRoll, target.armorClass)
    
    if attackRoll >= target.armorClass then
        local damage, damageRolls = Dice.rollDamage(self.weapon.damage, self.damageBonus)
        target:takeDamage(damage)
        hitMessage = hitMessage .. string.format(" - HIT for %d damage!", damage)
        return true, hitMessage, damage
    else
        hitMessage = hitMessage .. " - MISS!"
        return false, hitMessage, 0
    end
end

function Character:takeDamage(damage)
    self.currentHP = math.max(0, self.currentHP - damage)
end

function Character:heal(amount)
    self.currentHP = math.min(self.maxHP, self.currentHP + amount)
end

function Character:isAlive()
    return self.currentHP > 0
end

function Character:defend()
    return string.format("%s takes a defensive stance (+2 AC until next turn)", self.name)
end

function Character:getStatusString()
    return string.format("%s - HP: %d/%d | AC: %d | STR: %d DEX: %d CON: %d", 
        self.name, self.currentHP, self.maxHP, self.armorClass,
        self.strength, self.dexterity, self.constitution)
end

function Character:getAbilityScores()
    return {
        STR = self.strength,
        DEX = self.dexterity,
        CON = self.constitution,
        INT = self.intelligence,
        WIS = self.wisdom,
        CHA = self.charisma
    }
end

function Character:getModifiers()
    return {
        STR = self.strMod,
        DEX = self.dexMod,
        CON = self.conMod,
        INT = self.intMod,
        WIS = self.wisMod,
        CHA = self.chaMod
    }
end

return Character