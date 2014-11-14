local Barrier = {}
Barrier.__index = Barrier

function Barrier.new(x0, y0, x1, y1)
    local self = {
        x0 = x0,
        y0 = y0,
        x1 = x1,
        y1 = y1,
    }
    setmetatable(self, Barrier)
    return self
end

function Barrier:boundingBox()
    return {x0 = self.x0, y0 = self.y0,
            x1 = self.x1, y1 = self.y1}
end

function Barrier:draw()
    love.graphics.rectangle('fill',
                            self.x0, self.y0, 
                            self.x1-self.x0,
                            self.y1-self.y0)
end

return Barrier
