local util = {}

function util.within(point, box)
    return point.x >= box.x0 and
        point.x <= box.x1 and
        point.y >= box.y0 and
        point.y <= box.y1
end

function util.boxWithin(boxA, boxB)
    return util.within({x = boxA.x0, y = boxA.y0}, boxB) or
        util.within({x = boxA.x0, y = boxA.y1}, boxB) or 
        util.within({x = boxA.x1, y = boxA.y0}, boxB) or
        util.within({x = boxA.x1, y = boxA.y1}, boxB)
end

function util.overlap(boxA, boxB)
    return util.boxWithin(boxA, boxB) or util.boxWithin(boxB, boxA)
end

function util.centre(box)
    return {x = (box.x0 + box.x1) / 2,
            y = (box.y0 + box.y1) / 2}
end

-- vector to move boxA by to avoid overlapping boxB
function util.unOverlap(boxA, boxB)
    print("unOverlapping")
    local cA = util.centre(boxA)
    local cB = util.centre(boxB)
    local dx = cA.x - cB.x
    local dy = cA.y - cB.y
    local mag = math.sqrt(dx^2 + dy^2)
    dx = dx / mag
    dy = dy / mag
    local x = 0
    local y = 0
    while util.overlap({x0 = boxA.x0 + x,
                        y0 = boxA.y0 + y,
                        x1 = boxA.x1 + x,
                        y1 = boxA.y1 + y},
                       boxB) do
        x = x + dx
        y = y + dy
    end
    return {dx = x, dy = y}
end

return util
