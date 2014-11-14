local Player = require "player"
local Enemy = require "enemy"

local player
local bullets = {}
local enemies = {}

function love.load()
    player = Player.new()
    love.graphics.setBackgroundColor(100, 100, 100)
    cursor = love.mouse.newCursor("crosshair.png", 10, 10)
    love.mouse.setCursor(cursor)
    table.insert(enemies, Enemy.new(10, 10))
end

function love.update(dt)
    -- simulate the passing of time---<dt> is the
    -- time (fraction of a second) that has passed
    -- since the last call to love.update
   player:update(dt)
   for _, bullet in pairs(bullets) do
       bullet:update(dt)
   end
   for ke, enemy in pairs(enemies) do
       enemy:update(dt)
       local bb = enemy:boundingBox()
       for kb, bullet in pairs(bullets) do
           local x, y = bullet.x, bullet.y
           if x > bb.x0 and x < bb.x1 and y > bb.y0 and y < bb.y1 then
               enemy:hurt(10)
               bullets[kb] = nil
           end
       end
       if enemy:isDead() then
           enemies[ke] = nil
       end
   end
end

function love.draw()
    player:draw()
    for _, bullet in pairs(bullets) do
        bullet:draw()
    end
    for _, enemy in pairs(enemies) do
        enemy:draw(dt)
    end
end

function love.keypressed(key)
    if key == "up" then
        player:up()
    elseif key == "down" then
        player:down()
    elseif key == "left" then
        player:left()
    elseif key == "right" then
        player:right()
    end
end

function love.keyreleased(key)
    if key == "up" or key == "down" then
        player:stopY()
    elseif key == "left" or key == "right" then
        player:stopX()
    end
end

function love.mousepressed(x, y, button)
    if button == "l" then
        table.insert(bullets, player:fire(x, y))
    end
end
 
function love.mousereleased(x, y, button)
    -- handle mouse button releases
end
