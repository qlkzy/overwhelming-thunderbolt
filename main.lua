local Player = require "player"
local Enemy = require "enemy"
local Barrier = require "barrier"

local util = require "util"

local player
local bullets = {}
local enemies = {}
local barriers = {}
local max_enemies = 1

function love.load()
    love.window.setTitle("Overwhelming Thunderbolt")

    player = Player.new()
    love.graphics.setBackgroundColor(100, 100, 100)
    cursor = love.mouse.newCursor("crosshair.png", 10, 10)
    love.mouse.setCursor(cursor)
    table.insert(barriers, Barrier.new(100, 10, 105, 100))
end

function love.update(dt)
    local enemy_count = 0

    player:update(dt)
    local pbb = player:boundingBox()
    for _, bullet in pairs(bullets) do
        bullet:update(dt)
    end
    for ke, enemy in pairs(enemies) do
        local bb = enemy:boundingBox()

        enemy:update(player, dt)
        if util.overlap(bb, pbb) then
            player:hurt(10)
            local vec = util.unOverlap(bb, pbb)
            enemy.x = enemy.x + vec.dx
            enemy.y = enemy.y + vec.dy
        end

        if player:isDead() then
            love.window.setTitle("You Died!")
            player:death()
        end

        for kb, bullet in pairs(bullets) do
            if util.within(bullet, bb) then
                enemy:hurt(10)
                bullets[kb] = nil
            end
        end
        if enemy:isDead() then
            enemies[ke] = nil
            max_enemies = max_enemies + 1
        else
            enemy_count = enemy_count + 1
        end
    end

    for _, barrier in pairs(barriers) do
        local bb = barrier:boundingBox()
        for kb, bullet in pairs(bullets) do
            if util.within(bullet, bb) then
                bullets[kb] = nil
            end
        end
        if util.overlap(pbb, bb) then
            local vec = util.unOverlap(pbb, bb)
            player.x = player.x + vec.dx
            player.y = player.y + vec.dy
        end
    end

    if enemy_count < max_enemies then
        local edge = math.random(4)
        local max_x = love.graphics.getWidth()
        local max_y = love.graphics.getHeight()
        local ran_x = math.random(max_x)
        local ran_y = math.random(max_y)
        local enemy
        if edge == 1 then
            enemy = Enemy.new(0, ran_y)
        elseif edge == 2 then
            enemy = Enemy.new(ran_x, 0)
        elseif edge == 3 then
            enemy = Enemy.new(max_x, ran_y)
        else
            enemy = Enemy.new(ran_x, max_y)
        end
        table.insert(enemies, enemy)
    end
end

function love.draw()
    player:draw()
    player:drawHPbar()

    for _, bullet in pairs(bullets) do
        bullet:draw()
    end
    for _, enemy in pairs(enemies) do
        enemy:draw(dt)
    end
    for _, barrier in pairs(barriers) do
        barrier:draw(dt)
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
