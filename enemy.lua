local Enemy = {}
Enemy.__index = Enemy

local Hurtable = require "hurtable"

setmetatable(Enemy, {
    __index = Hurtable
})

function Enemy.new(x, y)
    local max_x = love.graphics.getWidth()
    local max_y = love.graphics.getHeight()
    
    local self = Hurtable.new(x, y, 0, 0, 100)
    setmetatable(self, Enemy)
    return self
end

function Enemy:draw()
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle('fill', self.x, self.y, 10, 16)
    love.graphics.setColor(r,g,b,a)
end

function Enemy:boundingBox()
    return {x0 = self.x, y0 = self.y, x1 = self.x + 10, y1 = self.y + 10}
end

function Enemy:update(player, dt)
    vx = player.x - self.x
    vy = player.y - self.y
    mag = math.sqrt(vx * vx + vy * vy)
    vx = vx / mag
    vy = vy / mag

    self.x = self.x + vx * 50 * dt
    self.y = self.y + vy * 50 * dt
end

return Enemy
