# Menu System Implementation

## Overview
This document describes the implemented menu system for Mondspiel, a 2D RTS strategy game.

## Implemented Components

### 1. Button UI Component (`utils/Button.lua`)
A reusable button component with:
- Mouse hover detection
- Click handling
- Visual feedback (hover states)
- Callback functionality
- Rounded corners and borders

### 2. Main Menu (`menu/MainMenu.lua`)
The main entry point with the following options:
- **Start New Camptrail** - Navigate to campaign selection
- **Load Camptrail** - Navigate to load saved campaigns
- **Options** - Navigate to settings menu
- **Credits** - Display game credits
- **Exit** - Quit the game

Features:
- Clickable buttons with hover effects
- Centered layout
- Game title display

### 3. Start Campaign Menu (`menu/StartCampMenu.lua`)
Mock interface for starting new campaigns with:
- Three mock campaign options:
  - Medieval Campaign
  - Landsknecht Era
  - Modern Warfare
- Each campaign shows name and description
- Selectable campaign list (keyboard arrows or mouse click)
- Start Campaign button (mocked - prints selection)
- Back button to return to main menu

**TODO**: Will be connected to actual campaign loading system

### 4. Load Campaign Menu (`menu/LoadCampMenu.lua`)
Mock interface for loading saved campaigns with:
- Three mock saved games displaying:
  - Campaign name
  - Faction
  - Progress (scenarios completed)
  - Last played date/time
- Selectable save list (keyboard arrows or mouse click)
- Load Save button (mocked - prints selection)
- Delete Save button (mocked - prints selection)
- Back button to return to main menu
- Empty state message when no saves exist

**TODO**: Will be connected to actual save file system

### 5. Options Menu (`menu/AppSettingsMenu.lua`)
Settings interface with mock options:
- **Volume Controls** (sliders):
  - Master Volume
  - Music Volume
  - SFX Volume
- **Display Settings** (toggles):
  - Fullscreen
  - VSync
  - Show FPS
- **Resolution** (text display)

Features:
- Interactive sliders for volume controls
- Toggle switches for boolean settings
- Keyboard navigation (arrow keys)
- Apply Settings button (mocked)
- Back button to return to main menu

**TODO**: Will be connected to actual game settings

### 6. Credits Menu (`menu/CreditsMenu.lua`)
Displays game credits:
- Game design & programming
- Powered by LÖVE2D and Lua
- Special thanks section
- Copyright notice
- Back button to return to main menu

### 7. Input Handling (`main.lua`)
Added global input handlers:
- **Mouse Input**: `love.mousepressed()` for button clicks
- **Keyboard Input**: `love.keypressed()` for navigation
- **ESC Key**: Returns to main menu from any submenu

### 8. Application State (`App.lua`)
- Added `CREDITS` menu to the menu registry
- Initialized app to start with intro screen
- Proper menu state management

## Navigation Structure

```
Intro Screen (5 seconds)
    ↓
Main Menu
    ├── Start New Camptrail → Start Campaign Menu → (Back to Main)
    ├── Load Camptrail → Load Campaign Menu → (Back to Main)
    ├── Options → Options Menu → (Back to Main)
    ├── Credits → Credits Menu → (Back to Main)
    └── Exit → Quit Game
```

## Controls

### Mouse
- Click on any button to activate it
- Hover over buttons for visual feedback

### Keyboard
- **UP/DOWN arrows**: Navigate through lists and options
- **LEFT/RIGHT arrows**: Adjust slider values, toggle options
- **SPACE/ENTER**: Activate toggles
- **ESC**: Return to main menu

## Visual Design

### Color Scheme
- Dark backgrounds (various shades of dark blue/gray)
- White/light text for readability
- Blue accents for selected items
- Hover states with lighter button colors

### Layout
- Centered menus
- Consistent button sizing
- Clear visual hierarchy
- Help text at the bottom of screens

## Mock Data

All menus currently use mock data:
- Campaign lists are hardcoded examples
- Save files are mock data (not real files)
- Settings don't actually affect the game yet

## Future Integration Points

1. **Campaign System**: Connect Start/Load campaign menus to actual campaign files
2. **Save System**: Implement file I/O for saving/loading games
3. **Settings**: Connect options to actual game configuration
4. **Battle/Scenario Menus**: The stub menus (LoadBattleMenu, StartBattleMenu, etc.) need similar treatment

## Technical Notes

- All menus follow the same interface pattern: `new()`, `update(dt)`, `render()`, `mouse_pressed()`, `key_pressed()`
- Button component is reusable across all menus
- Type checking using `T` utility for all function parameters
- Menus maintain their state when switching between them (as they're all instantiated at app start)
