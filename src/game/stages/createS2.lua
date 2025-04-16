local Stage = require "src.game.stages.Stage"
local BasicTileset = require "src.game.tiling.BasicTileset"
local Background = require "src.game.tiling.Background"
local Boar = require "src.game.mobs.Boar"
local Sounds = require "src.game.Sounds"

local function createS2()
    -- 1000 cells
    local stage = Stage(20, 50, BasicTileset) 

    local mapdata = require "src.game.maps.map2"
    stage:readMapData(mapdata)

    local objdata = require "src.game.maps.map2objects"
    stage:readObjectsData(objdata)

    -- Backgrounds
    local bg1 = Background("graphics/tilesets/FreeCute/BG1.png")
    local bg2 = Background("graphics/tilesets/FreeCute/BG2.png")
    local bg3 = Background("graphics/tilesets/FreeCute/BG3.png")

    stage:addBackground(bg1)
    stage:addBackground(bg2)
    stage:addBackground(bg3)

    -- Initial Player Pos
    stage.initialPlayerX = 2 * 16
    stage.initialPlayerY = 26 * 16

    -- Adding 3 Boars
    local b1 = Boar()
    b1:setCoord(15 * 16, 28 * 16)
    stage:addMob(b1)

    local b2 = Boar()
    b2:setCoord(30 * 16, 28 * 16)
    stage:addMob(b2)

    local b3 = Boar()
    b3:setCoord(45 * 16, 28 * 16)
    b3:changeDirection()
    stage:addMob(b3)

    -- Music
    stage:setMusic(Sounds["music_newlevel"])

    return stage
end

return createS2