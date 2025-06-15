# D&D Combat System - Love2D Game

A turn-based D&D-style combat system built with Love2D framework in Lua.

## Project Structure

```
/love/
├── main.lua              # Entry point and game loop
├── conf.lua              # Love2D configuration
├── CLAUDE.md             # This file - project documentation
├── README.md             # Project overview
├── assets/               # Game assets
│   ├── music/           # Background music and sound effects
│   ├── fonts/           # Custom fonts
│   └── images/          # Sprites and UI images
├── src/                 # Source code
│   ├── core/            # Core game systems
│   │   ├── gamestate.lua # Game state management
│   │   └── input.lua     # Input handling
│   ├── systems/         # Game logic systems
│   │   ├── dice.lua      # Dice rolling mechanics
│   │   ├── character.lua # Character stats and abilities
│   │   └── combat.lua    # Combat mechanics
│   ├── ui/              # User interface
│   │   ├── menu.lua      # Main menu UI
│   │   ├── combat_ui.lua # Combat interface
│   │   └── character_sheet.lua # Character display
│   └── utils/           # Utility functions
│       ├── logger.lua    # Debug logging
│       └── constants.lua # Game constants and balance
└── tests/               # Unit tests (future)
```

## Development Commands

### Running the Game
```bash
# Run from the project directory
love .

# Or specify the directory explicitly
love /path/to/love/
```

### Testing
```bash
# Currently no automated tests - manual testing only
# Future: lua test_runner.lua
```

## Game Features

### Core D&D Mechanics
- **Ability Scores**: STR, DEX, CON, INT, WIS, CHA with proper modifiers
- **Dice Rolling**: Standard D&D dice (d4, d6, d8, d10, d12, d20)
- **Advantage/Disadvantage**: Roll twice, take higher/lower
- **Combat**: Turn-based with initiative, attack rolls vs AC
- **Character Generation**: 4d6 drop lowest for ability scores

### Current Systems
- Character creation with random stats
- Turn-based combat with initiative
- Attack/defend actions
- HP and AC tracking
- Basic enemy AI

### Game Controls
- **Menu**: SPACE = start combat, R = test dice roll
- **Combat**: A = attack, D = defend, ESC = back to menu

## Technical Details

### Dependencies
- Love2D 11.x+ framework
- Lua 5.1+ (included with Love2D)

### Key Components
- **GameState**: Manages menu, combat, character creation states
- **Dice System**: Handles all random number generation with D&D rules
- **Character System**: Full D&D 5e character representation
- **Combat System**: Turn-based combat with proper action economy

## Future Enhancements
- [ ] Spell system with spell slots
- [ ] Inventory and equipment
- [ ] Multiple enemy types
- [ ] Character classes and races
- [ ] Leveling system
- [ ] Save/load functionality
- [ ] Multiple party members
- [ ] Dungeon exploration

## Code Style
- Use 4 spaces for indentation
- PascalCase for module names
- camelCase for functions and variables
- Clear, descriptive function names
- Minimal comments (code should be self-documenting)

## Debugging
- Combat log shows all rolls and actions
- Press R in menu to test dice rolling
- Character stats displayed during combat