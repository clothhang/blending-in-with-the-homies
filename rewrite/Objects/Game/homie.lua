local homie = Class:extend("homie")

function homie:new(x,y,w,h,parent)

    self.parent = parent
    self.x,self.y = x,y 
    self.width,self.height = w,h 
    self.image = love.graphics.newImage("Assets/Images/blending/homieScared.png")
    self.screams = love.filesystem.getDirectoryItems("Assets/Sounds/screams")

end

function homie:update()
    if self.landsInBlender and self.dropped and not self.beenBlended then 
        if self.y >= self.parent.blender.y then 
            if self.tween then Timer.cancel(self.tween) end 
            self:getBlended()
        end
    end
end

function homie:getBlended()
    self.parent:increaseClawSpeed(0.1)
    self.inBlender = true
    self.beenBlended = true
    local targetX, targetY = self.parent.blender.x, Inits.GameHeight 
    --Timer.after(0.1, function() 
    self:fuckingScreamBecauseYouAreGettingBlendedAndItHurtsALot()
        Timer.tween(0.3, self, {x = targetX})
        Timer.tween(1, self, {y = targetY}, "linear", function() self.inBlender = false end)
    
  --  end)
    --Timer.tween(1, self, {x = targetX, y = targetY})
end

function homie:fuckingScreamBecauseYouAreGettingBlendedAndItHurtsALot()
    local screamPitch = love.math.random(0.8,1.2)
    local scream = love.math.random(1,#self.screams)

    self.scream = love.audio.newSource("Assets/Sounds/screams/" .. self.screams[scream], "static")
        self.scream:setVolume(0.2)

    self.scream:setPitch(screamPitch)
    self.scream:play()
    
end

function homie:drop()
    self.dropped = true
    -- there will be no check to make sure this homie is actually clawed, so we just really hope that it is lmfao 

    -- first we check whether or not it actually will land in the blender 

    local landsInBlender = self.parent.blender:checkForHit(self)

    if landsInBlender then self.landsInBlender = true end


    if landsInBlender then targetY = self.parent.blender.y else targetY = Inits.GameHeight end

    targetY = Inits.GameHeight
    self.tween = Timer.tween(0.6, self, {y = targetY}, "in-quad")

end

function homie:draw()
    love.graphics.draw(self.image, self.x, self.y, nil, self.width, self.height, self.image:getWidth()/2, 0)
end

return homie