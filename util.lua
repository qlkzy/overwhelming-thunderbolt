local util = {}

function util.within(point, box)
    return point.x >= box.x0 and
        point.x <= box.x1 and
        point.y >= box.y0 and
        point.y <= box.y1
end

function util.overlap(box0, box1)
    return util.witin({x = box0.x0, y = box0.y0}, box1) or
        util.within({x = box0.x0, y = box0.y1}, box1) or 
        util.within({x = box0.x1, y = box0.y0}, box1) or
        util.within({x = box0.x1, y = box0.y1}, box1)
end

return util
