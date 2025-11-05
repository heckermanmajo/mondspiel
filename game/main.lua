-- Utils
require "utils/T"
require "utils/Camera"
require "utils/AStar"
require "utils/Animation"
require "utils/AnimationState"
require "utils/Button"

-- Menus
require "menu/Intro"
require "menu/MainMenu"
require "menu/StartCampMenu"
require "menu/LoadCampMenu"
require "menu/AppSettingsMenu"
require "menu/CreditsMenu"
require "menu/LoadBattleMenu"
require "menu/LoadScenarioMenu"
require "menu/StartBattleMenu"
require "menu/StartScenarioMenu"

-- Scenario/Theater Mode
require "scenario/Scenario"
require "scenario/ScenarioTile"
require "scenario/Army"
require "scenario/Faction"
require "scenario/FactionRelation"
require "scenario/DiplomacyView"

-- Campaign
require "camp/Campaign"

-- Battle Mode
require "battle/Battle"
require "battle/Tile"
require "battle/Chunk"
require "battle/Unit"
require "battle/UnitType"
require "battle/ControlGroup"
require "battle/Formation"
require "battle/Projectile"
require "battle/Effect"
require "StaticObject"
require "battle/SpawnList"
require "battle/Pathfinding"

require "App" -- loading app initializes all the juicy state


function love.load()
    -- Set window size
    love.window.setMode(1280, 720, {resizable=true, vsync=true})
    love.window.setTitle("Mondspiel - 2D RTS Strategy Game")
end

function love.update(dt)
    if App.MODES.MENU == App.current_mode then
        App.current_menu:update(dt)
    end
end

function love.draw()
    if App.MODES.MENU == App.current_mode then
        App.current_menu:render()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if App.MODES.MENU == App.current_mode then
        if App.current_menu.mouse_pressed then
            App.current_menu:mouse_pressed(x, y, button)
        end
    end
end

function love.keypressed(key)
    if App.MODES.MENU == App.current_mode then
        if App.current_menu.key_pressed then
            App.current_menu:key_pressed(key)
        end
    end

    -- Global keyboard shortcuts
    if key == "escape" then
        if App.current_mode == App.MODES.MENU and App.current_menu ~= App.MENUS.MAIN then
            -- Go back to main menu if not already there
            App.current_menu = App.MENUS.MAIN
        end
    end
end