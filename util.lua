local util = {}

function util.within(point, box)
    return point.x >= box.x0 and
        point.x <= box.x1 and
        point.y >= box.y0 and
        point.y <= box.y1
end

function util.overlap(boxA, boxB)
    return util.within({x = boxA.x0, y = boxA.y0}, boxB) or
        util.within({x = boxA.x0, y = boxA.y1}, boxB) or 
        util.within({x = boxA.x1, y = boxA.y0}, boxB) or
        util.within({x = boxA.x1, y = boxA.y1}, boxB)
end

-- vector to move boxA by to avoid overlapping boxB
function util.unOverlap(boxA, boxB)
    if util.within({x = boxA.x0, y = boxA.y0}, boxB) then
        return {dx = boxB.x1 - boxA.x0,
                dy = boxB.y1 - boxA.y0}
    elseif util.within({x = boxA.x0, y = boxA.y1}, boxB) then
        return {dx = boxB.x1 - boxA.x0,
                dy = boxB.y0 - boxA.y1}
    elseif util.within({x = boxA.x1, y = boxA.y0}, boxB) then
        return {dx = boxB.x0 - boxA.x1,
                dy = boxB.y1 - boxA.y0}
    elseif util.within({x = boxA.x1, y = boxA.y1}, boxB) then
        return {dx = boxB.x0 - boxA.x1,
                dy = boxB.y0 - boxA.y1}
    else
        return {dx = 0, dy = 0}
    end
end

return util
