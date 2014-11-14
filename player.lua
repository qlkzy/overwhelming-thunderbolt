local Player = {}
Player.__index = Player

local Hurtable = require "hurtable"
local Bullet = require "bullet"

setmetatable(Player, {
    __index = Hurtable
})

function Player.new()
    local self = Hurtable.new(300, 300, 0, 0)
    setmetatable(self, Player)
    return self
end

function Player:draw()
    love.graphics.circle('fill', self.x, self.y, 20, 32)
end

function Player:up()
    self.vy = -50
end

function Player:down()
    self.vy = 50
end

function Player:left()
    self.vx = -50
end

function Player:right()
    self.vx = 50
end

function Player:stopX()
    self.vx = 0
end

function Player:stopY()
    self.vy = 0
end

function Player:fire(x, y)
    vx = x - self.x
    vy = y - self.y
    mag = math.sqrt(vx * vx + vy * vy)
    vx = vx / mag
    vy = vy / mag
    return Bullet.new(self.x, self.y, vx * 200, vy * 200)
end

return Player
