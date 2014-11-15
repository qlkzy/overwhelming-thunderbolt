local Player = {}
Player.__index = Player

local Hurtable = require "hurtable"
local Bullet = require "bullet"

setmetatable(Player, {
    __index = Hurtable
})

function Player.new()
    local self = Hurtable.new(300, 300, 0, 0, 500)
    setmetatable(self, Player)
    return self
end

function Player:boundingBox()
    return {x0 = self.x - 15, y0 = self.y - 15, x1 = self.x + 15, y1 = self.y + 15}
end

function Player:draw()
    love.graphics.circle('fill', self.x, self.y, 20, 32)
end

function Player:decay(dt)
    self.health = self.health - 10 * dt
end

function Player:gainHealth(dt)
    self.health = self.health + 30
end

function Player:drawHPbar()
    local healthPercent = self.health / 500
    local scrWidth = love.graphics.getWidth()
    local scrHeight = love.graphics.getHeight()
    local r, g, b, a = love.graphics.getColor( )
    love.graphics.setColor(255, healthPercent * 255, healthPercent * 255)
    love.graphics.rectangle("fill", 0, scrHeight - 20, scrWidth * healthPercent, 20 )
    love.graphics.setColor(r, g, b, a)
    if self:isDead() then
        love.graphics.print("YOU DIED.", 350, scrHeight - 50)
    else
        love.graphics.print(math.floor(self.health), 400, scrHeight - 50)
    end
end

function Player:death()
    -- should fix
    self.vy = -10000000
    self.vx = 0

    -- Only available since LÖVE 0.9.2
    -- local x, y, _ = love.window.getPosition()
    -- love.window.setPosition(x + 5, y)
    -- love.window.setPosition(x, y)
    -- love.window.setPosition(x - 5, y)
end

function Player:up()
    self.vy = -100
end

function Player:down()
    self.vy = 100
end

function Player:left()
    self.vx = -100
end

function Player:right()
    self.vx = 100
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
