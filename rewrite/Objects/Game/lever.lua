local lever = Class:extend("lever")

function lever:new(x,y,w,h,parent)
    self.parent = parent
    self.x,self.y = x,y 
    self.down = false
    self.width,self.height = w,h
    self.imageUp = love.graphics.newImage("Assets/Images/blending/leverUp.png")
        self.imageDown = love.graphics.newImage("Assets/Images/blending/leverDown.png")

end

function lever:update()
end

function lever:switch()
    self.down = true 
    Timer.after(0.4, function() self.down = false end)
end

function lever:draw()
    local image = (self.down and self.imageDown) or self.imageUp
    love.graphics.draw(image, self.x, self.y, nil, self.width, self.height)
end

return lever