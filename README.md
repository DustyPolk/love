# D&D Combat System

A turn-based combat system inspired by D&D 5e mechanics, built with the Love2D framework in Lua.

## What is this?

This is a simple D&D-style combat simulator that implements core tabletop RPG mechanics in a digital format. It features character creation with ability scores, dice rolling with advantage/disadvantage, and tactical turn-based combat.

## Features

- **Authentic D&D Mechanics**: Ability scores (STR, DEX, CON, INT, WIS, CHA), attack rolls vs AC, initiative system
- **Dice Rolling**: All standard RPG dice (d4-d20) with advantage/disadvantage support
- **Character System**: Random stat generation using 4d6 drop lowest method
- **Turn-Based Combat**: Initiative-based combat with attack/defend actions
- **Real-time Combat Log**: See all rolls and actions as they happen

## How to Play

1. **Install Love2D** - Download from [love2d.org](https://love2d.org)
2. **Run the game** - Execute `love .` in the project directory
3. **Controls**:
   - **Menu**: SPACE = start combat, R = test dice roll, Q = quit
   - **Combat**: A = attack, D = defend, ESC = return to menu

## Project Status

This is an exploration project - expect rough edges and incomplete features. It's primarily used for learning game development concepts and D&D mechanics implementation.

## Technical Details

- **Framework**: Love2D 11.x
- **Language**: Lua
- **Architecture**: Modular design with separated systems, UI, and utilities

For detailed documentation, see [CLAUDE.md](CLAUDE.md). 