local Constants = {}

Constants.GAME = {
    TITLE = "D&D Combat System",
    VERSION = "1.0.0",
    WINDOW_WIDTH = 1024,
    WINDOW_HEIGHT = 768,
    COMBAT_LOG_MAX_LINES = 20,
    COMBAT_LOG_DISPLAY_LINES = 8
}

Constants.DICE = {
    SIDES = {
        D4 = 4,
        D6 = 6,
        D8 = 8,
        D10 = 10,
        D12 = 12,
        D20 = 20
    }
}

Constants.CHARACTER = {
    MIN_ABILITY_SCORE = 3,
    MAX_ABILITY_SCORE = 18,
    BASE_AC = 10,
    ABILITY_SCORE_MODIFIER_BASE = 10,
    ABILITY_SCORE_MODIFIER_DIVISOR = 2,
    PROFICIENCY_BONUS_LEVEL_1 = 2,
    HIT_DIE_PLAYER = 8,
    HIT_DIE_ENEMY = 6
}

Constants.COMBAT = {
    DEFEND_AC_BONUS = 2,
    ENEMY_ATTACK_CHANCE = 0.8,
    INITIATIVE_DIE = 20
}

Constants.UI = {
    FONT_SIZE = 16,
    LINE_HEIGHT = 20,
    COMBAT_LOG_LINE_HEIGHT = 18,
    MARGIN = 50,
    COLORS = {
        WHITE = {1, 1, 1, 1},
        RED = {1, 0, 0, 1},
        GREEN = {0, 1, 0, 1},
        BLUE = {0, 0, 1, 1},
        BACKGROUND = {0.1, 0.1, 0.2, 1}
    }
}

Constants.WEAPONS = {
    PLAYER = {
        name = "Longsword",
        damage = {[8] = 1},
        type = "slashing"
    },
    ENEMY = {
        name = "Scimitar",
        damage = {[6] = 1},
        type = "slashing"
    }
}

Constants.ENEMY_STATS = {
    GOBLIN = {
        strength = 12,
        dexterity = 14,
        constitution = 12,
        intelligence = 8,
        wisdom = 10,
        charisma = 8,
        ac_bonus = 2
    }
}

return Constants