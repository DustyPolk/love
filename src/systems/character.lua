local Dice = require("src.systems.dice")
local Constants = require("src.utils.constants")

local Character = {}
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
    
    self.proficiencyBonus = Constants.CHARACTER.PROFICIENCY_BONUS_LEVEL_1
    self.hitDie = Constants.CHARACTER.HIT_DIE_PLAYER
end

function Character:generateEnemyStats()
    local stats = Constants.ENEMY_STATS.GOBLIN
    self.strength = stats.strength
    self.dexterity = stats.dexterity
    self.constitution = stats.constitution
    self.intelligence = stats.intelligence
    self.wisdom = stats.wisdom
    self.charisma = stats.charisma
    
    self.proficiencyBonus = Constants.CHARACTER.PROFICIENCY_BONUS_LEVEL_1
    self.hitDie = Constants.CHARACTER.HIT_DIE_ENEMY
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
    
    self.armorClass = Constants.CHARACTER.BASE_AC + self.dexMod
    if not self.isPlayer then
        self.armorClass = self.armorClass + Constants.ENEMY_STATS.GOBLIN.ac_bonus
    end
    
    self.initiative = self.dexMod
    
    self.attackBonus = self.proficiencyBonus + (self.isPlayer and self.strMod or self.dexMod)
    self.damageBonus = self.isPlayer and self.strMod or self.dexMod
    
    if self.isPlayer then
        self.weapon = Constants.WEAPONS.PLAYER
    else
        self.weapon = Constants.WEAPONS.ENEMY
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
    return string.format("%s takes a defensive stance (+%d AC until next turn)", 
        self.name, Constants.COMBAT.DEFEND_AC_BONUS)
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