local Class = require "libs.hump.class"
local Anim8 = require "libs.anim8"
local Tween = require "libs.tween"

local idleSprite = love.graphics.newImage(
    "graphics/char/Idle-Sheet.png")
local idleGrid = Anim8.newGrid(64,80,
    idleSprite:getWidth(),idleSprite:getHeight())
local idleAnim = Anim8.newAnimation( idleGrid('1-4',1), 0.3)

local runSprite = love.graphics.newImage(
    "graphics/char/Run-Sheet.png")
local runGrid = Anim8.newGrid(80,80,
    runSprite:getWidth(),runSprite:getHeight())
local runAnim = Anim8.newAnimation( runGrid('1-8',1), 0.1)

local jumpSprite = love.graphics.newImage(
    "graphics/char/Jump-All-Sheet.png")
local jumpGrid = Anim8.newGrid(64,64,
    jumpSprite:getWidth(),jumpSprite:getHeight())
local jumpAnim = Anim8.newAnimation( jumpGrid('1-15',1), 0.1)

local Player = Class{}
function Player:init(x,y)
    self.x = x
    self.y = y

    self.state = "idle"
    self.dir = "r" -- r for right, l for left
    self.speedY = 0

    self.animations = {}
    self.sprites = {}
    self:createAnimations()
end

function Player:reset()
end

function Player:createAnimations() -- fill up the animations & sprites
    self.animations["idle"] = idleAnim
    self.sprites["idle"] = idleSprite

    self.animations["run"] = runAnim
    self.sprites["run"] = runSprite
end

function Player:update(dt, stage)
    if love.keyboard.isDown("d","right") then
        -- move right
        self.state = "run"
        self.x = self.x + 96*dt
        self:setDirection("r")
    elseif love.keyboard.isDown("a","left") then
        -- move left
        self.state = "run"
        self.x = self.x -96*dt
        self:setDirection("l")
    else
        self.state = "idle"
        -- stands stills
    end

    self.animations[self.state]:update(dt)
end

function Player:draw()
    self.animations[self.state]:draw(self.sprites[self.state],
        math.floor(self.x), math.floor(self.y) )
end

function Player:keypressed(key)

end

function Player:keyreleased(key)
    
end

function Player:setCoords(x,y)
    self.x = x
    self.y = y
end

function Player:setDirection(newdir)
    if self.dir ~= newdir then
        self.dir = newdir
        for states,anim in pairs(self.animations) do
            anim:flipH()
        end -- end for
    end -- end if
end

return Player