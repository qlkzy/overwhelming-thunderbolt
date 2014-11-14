local Hurtable = {}
Hurtable.__index = Hurtable

local Entity = require "entity"

setmetatable(Hurtable, {
    __index = Entity
})

function Hurtable.new(x, y, vx, vy, health)
    local self = Entity.new(x, y, vx, vy)
    self.health = health or 100
    setmetatable(self, Hurtable)
    return self
end

function Hurtable:hurt(damage)
   self.health = self.health - damage
end

function Hurtable:isDead()
   return self.health <= 0
end

return Hurtable
