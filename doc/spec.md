# Spec for 2d rts game with round based campaign map
- it should work for modern times and for medival settings and inbetween (Landsknecht style)

## Camptrail Mode
- a collections of camapign maps (scenarios) to play after each other with one faction
- simple list of theaters to play through (one after the other)

## Theater Mode
- turn based, grid based (squares) Overworld map
- Factions fight for control of territories
- Like a board game factions create, upgrade and move armies
- Factions have diplomatic relations
- Campaigns can be loaded and saved

## Battle Mode
- Real-time strategy battles on a 2d grid based map
- Players fight for control of the map
- resources and units to call in are limited by the Campaign Map Armies
- The result of the battle affects the Campaign Map

## Game Assets
- Sprite-Atlases
- Unit-Definitions in LUA-Format
- Theater-definitions in LUA-Format
- Theater-Maps in csv format
- Camptrail-definitions in LUA-Format

## Loading and Saving
- all entitities can be saved and loaded from files

## Menus 
- Main Menu
  - Start New Camptrail
  - Load Camptrail
  - Options
  - Credits
  - Exit

## Camera
- we use the same camera for both modes
- Drag the camera around with the middle mouse button
- move the cam with wasd
- zoom with mouse wheel
- movement of wasd should scale with zoom level

## Battle Details

- Map
- Chunk: chunks are used to make the calculations more efficient; units track on which chunk they are on
- Tile

- Unit
- Unit-Type: All units haev a unit type that defines their stats and abilities
- Contorl Groups
- Formations
- Units of different sizes

- Out of Map support: Players can call air strikes, atrillery strikes or drop supplies from out of map, as well as paratroopers

- Drones: drones can move in a straight line and can move over obstacles and units
 
- Stationary Units: some units can be deployed as stationary units (like MG nests, AA guns, etc)

- Buildings: there can be buildings on the map that can be captured or destroyed

- Pathfinding

- Spawingn Units: What you can spawn is limited by the Army you started this fight with
- Spawn-List; but it needs time to call in the units, and also it depennds on the deploy phase
- Deploy phase: you need ti capture ground to increase in deploy pahses, so you can deploy your more powerful troops
- You can deploy heavy units at the start,m but it would take way to long, but with a higher deploy pahse calling in gets faster
- capturing terretory increases your deploy phase or strategic points like railways stations, radio towers, bridges, etc

- Effects: thre is fire on the battle map that can spread and damage units, alos other effects  like gas, or magic (later)

- Projectiles: arrows, rockets, granades, etc.

- Direct Shooting weapons: a handgun does not create a projectile, it hits directly (or misses)
- if it misses is calculated with a raycast (based on skill of the unit, movement, cover, weapon tech type, etc.)

- Meelee: units can fight meelee when in range; meele puhses the enemies back
- real physics for meelee combat: more units should push back less units
- Formations are very important for meelee combat

- Abilities: units have abilities, like throwing granadesm healing others, etc. They have cooldowns and units choose when to use them

- Debugging Information: we should be able to click everything and pressing space and get a popup with all the relevant information
- we should also keep a detialed change log of state for each unit/object/buidling/tile in debugging mode and proitn those to files, if we click a button un the debugging window
- A battel has up to 4 Factions, and minimal 2 Factions, 3 factions are ai controlled - AT least one faction is player controlled

## Theater Details

- Army: a army can onle be increased in size and updated in tech if it is near a city or supply-base if the distance is smaller is cheaper
- supply-Mechanic

- Tile: tiles can be of different terrain types (like forest, plains, hills, mountains, water, etc) and can have cities, resources, etc on them

- resoures: tiles give resources based on different factors like terrain type, buildings on it, etc.
- all resources are represented by a single resource type (like money) for simplicity

- Faction: factions have a civilization type which defines their units and buildings and abilities (f.e. germany, russia, usa, etc. or medival kingdoms, etc)
- Diplomacy: factions have a dynamic diplomacy system where they can make alliances, declare war, trade, etc.
- Faction-Relation
- Faction-Relation-Event: if sth happens like adding units at the border, attacking a unit, positive trade, etc. relations change
- Diplomacy Views: there are multiple views on diplomacy, like military, economic, etc.
- there is off-map trade on the theater map, where factions can trade resources

## Pathfinding
- use astar
- use direct path approximation for long distances (we dont have maze maps)
- use direct path approximation as default, but fall back to astar if obstacles are in the way
- if a path needs to be caclulated mark the unit as needs_a_path but only calc n paths per frame to avoid frame drops
- paths dont need to bne perfect, since soldiers on the battlefield are not perfect r