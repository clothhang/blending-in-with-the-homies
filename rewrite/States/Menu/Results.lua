local Results = State()

function Results:enter()
    background = love.graphics.newImage("Assets/Images/bg.png")
end

function Results:update(dt)
    if Input:pressed("GameClick") then
        State.switch(States.GameNormal)
    end
end

function Results:draw()
    
    love.graphics.draw(background)
    love.graphics.setColor(1,0,0,0.4)
    love.graphics.rectangle("fill", 0, 0, Inits.GameWidth, Inits.GameHeight)
end

return Results