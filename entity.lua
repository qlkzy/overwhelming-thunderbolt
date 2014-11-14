local Entity = {}
Entity.__index = Entity


function Entity.new(x, y, vx, vy)
    local self = {
        x = x,
        y = y,
        vx = vx,
        vy = vy,
    }
    setmetatable(self, Entity)
    return self
end

function Entity:update(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
end

return Entity
