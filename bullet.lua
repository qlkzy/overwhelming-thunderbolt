local Bullet = {}
Bullet.__index = Bullet

local Entity = require "entity"

setmetatable(Bullet, {
    __index = Entity
})

function Bullet.new(x, y, vx, vy)
    local self = {
        x = x,
        y = y,
        vx = vx,
        vy = vy,
    }
    setmetatable(self, Bullet)
    return self
end

function Bullet:draw()
    love.graphics.rectangle('fill', self.x, self.y, 2, 2)
end

return Bullet
