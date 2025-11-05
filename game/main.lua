-- Utils
require "utils/T"
require "utils/Camera"
require "utils/AStar"
require "utils/Animation"
require "utils/AnimationState"

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
end

function love.update(dt)
    if App.MODES.MENU == App.current_mode then
        App.current_menu:update(dt)
    end
end

function love.draw()
    love.graphics.print("Hello, World!", 400, 300)
    if App.MODES.MENU == App.current_mode then
        App.current_menu:render()
    end
end