
local GameBlending = State("GameBlending")
function GameBlending:enter()
    self.clawSpeed = 3
    self:setupObjects()

    self:addHomieToClaw()
    self.inBlender = 0

    self.bg = love.graphics.newImage("Assets/Images/blending/bg.png")

    self.homerbutifhewasEVILandFUCKEDUP = love.graphics.newImage("Assets/Images/blending/homerFUCKEDUPANDEVIL!!!.png")
end

function GameBlending:setupObjects()
    self.claw = claw(self)
    self.blender = blender(Inits.GameWidth/2, 239, 0.4, 0.4)
    self.lever = lever(1140,300,-0.5,0.5,self)
    self.homies = {}
end

function GameBlending:addHomieToClaw()
    table.insert(self.homies, 1, homie(-1000,100,0.4,0.4,self))
end


function GameBlending:update(dt)
    self.claw:update(dt)
    self.blender:update(dt)
    self:updateHomies(dt)
    self.blender.volume = self.inBlender*0.4

    if Input:pressed("GameClick") and not self.claw.stopped  then self:dropClawedHomie() end
end

function GameBlending:increaseClawSpeed(speed)
    self.clawSpeed = self.clawSpeed + -((speed and speed) or 0.05)
end

function GameBlending:updateHomies(dt)
    self.inBlender = 0
    -- update all the homies :) 
    for i, Homie in ipairs(self.homies) do

        -- first lets check if this is the claw homie 
        if i == 1 and not Homie.dropped then 
            Homie.x = self.claw.x 
        end
        if Homie.inBlender then self.inBlender = self.inBlender + 1 end
        Homie:update(dt)
    end

end

function GameBlending:dropClawedHomie()
    self.claw:open()
    self.lever:switch()
    if self.doingDrop then return end

    self.doingDrop = true
    if not self.homies[1].dropped then self.homies[1]:drop() end
    Timer.after(1, function() GameBlending:addHomieToClaw(); self.doingDrop = false end)

end


function GameBlending:draw()
    love.graphics.draw(self.bg)
    love.graphics.draw(self.homerbutifhewasEVILandFUCKEDUP, 1250,220, nil, -0.8, 0.8)
        -- draw the homies :) 
    for i, Homie in ipairs(self.homies) do
        Homie:draw()
    end

    self.claw:draw()
    self.lever:draw()
    self.blender:draw()


end

return GameBlending