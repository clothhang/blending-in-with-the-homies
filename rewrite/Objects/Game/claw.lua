local claw = Class:extend("claw")

function claw:new(parent)
    self.parent = parent
    self.leftPosition,self.rightPosition = 50, Inits.GameWidth - 50
    self.x,self.y = Inits.GameWidth/2, 0


    self.width,self.height = 0.4, 0.4
    self.imageOpen = love.graphics.newImage("Assets/Images/blending/clawOpen.png")
    self.imageClosed = love.graphics.newImage("Assets/Images/blending/clawClosed.png")
    self.isOpen = false
    self:tween(self.parent.clawSpeed)
end

function claw:tween(time)
    -- determine if we are going to tween left or right 
    local targetX = (self.x > Inits.GameWidth/2) and self.leftPosition or self.rightPosition
    if self._tween then Timer.cancel(self._tween) end
    self._tween = Timer.tween(time, self, {x = targetX}, "in-out-quad", function() self:tween(time) end)  -- calling the tween again immediately is temporary!
end

function claw:open()
    self.isOpen = true 
    self.stopped = true

    Timer.after(0.5, function() self.isOpen = false; self.stopped = false end)
    Timer.after(0.8, function() self:tween(self.parent.clawSpeed) end)
end
function claw:update()
    if self.stopped then if self.tween then Timer.cancel(self._tween) end end
end

function claw:draw()
    local image = (self.isOpen and self.imageOpen) or self.imageClosed 
    love.graphics.draw(image, self.x, self.y, nil, self.width, self.height, self.imageOpen:getWidth()/2,0)
end

return claw