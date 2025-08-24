local blender = Class:extend("blender")

function blender:new(x,y,w,h)
    self.x,self.y = x,y
    self.width,self.height = w,h
    self.blending = true
    self.image = love.graphics.newImage("Assets/Images/blending/the fucking blender.png")
    self.sound = love.audio.newSource("Assets/Sounds/blender.mp3", "stream")

    self.sound:setLooping(true)
    self.sound:play()
    self.volume = 0
    self.printableVolume = self.volume
    self.frame = 1
    self.shakeOffsetX, self.shakeOffsetY = 0,0
    self.shakeIntensity = 0
    self.shakeAmount = 0
    self.blending = true
    
end

function blender:update()

    if self.tween then Timer.cancel(self.tween) end
    self.tween = Timer.tween(0.5, self, {printableVolume = self.volume})
    self.sound:setVolume(self.printableVolume)
    self.shakeIntensity = self.printableVolume*10


    if self.blending then self:shake() end
end


function blender:shake()
    local x = love.math.random(-self.shakeIntensity, self.shakeIntensity)
    local y = love.math.random(-self.shakeIntensity, self.shakeIntensity)

    self.shakeOffsetX = x
    self.shakeOffsetY = y
end


function blender:checkForHit(checkedObject)
    

    return math.abs(checkedObject.x - self.x) < (self.image:getWidth()*self.width)*0.4

end

function blender:blend(time)
    self.blending = true

    Timer.after(time, function()

        self.blending = false
    end)
end

function blender:draw()
    local x,y = self.x + self.shakeOffsetX, self.y + self.shakeOffsetY
    love.graphics.draw(self.image,x,y,0,self.width,self.height, self.image:getWidth()/2,0)
end

return blender
