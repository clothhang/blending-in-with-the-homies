local GameFunkin = State()

local inputList = {
    "FunkinLeft",
    "FunkinDown",
    "FunkinUp",
    "FunkinRight"
}

function GameFunkin:enter()
    quaverParse("Assets/Charts/test/test.qua")
    song = love.audio.newSource("Assets/Charts/test/audio.mp3", "stream")
    laneWidth = 65
    missTiming = 100
    musicTime = -0
    speed = 0.8
    homerNotesX = Inits.GameWidth-(laneWidth*4)-60 -- what tf causes this offset?? im just subtracting 60 lmao to "fix" it
    homieNotesX = 20


end

function GameFunkin:update()

    if musicTime >= 0 and not song:isPlaying() then
        song:play()
    end
    GameFunkin:checkInput()
    musicTime = musicTime + (love.timer.getTime() * 1000) - (previousFrameTime or (love.timer.getTime()*1000))
    previousFrameTime = love.timer.getTime() * 1000

end

function GameFunkin:checkInput()
        for i, lane in ipairs(homerLanes) do
            for j, note in ipairs(lane) do
                local time = math.abs(note.time - musicTime) 
               -- if Input:pressed(inputList[i]) then
                    if math.abs(time) < missTiming then
                        table.remove(homerLanes[i][1])
                        print("hit")
                        break
                    end
              --  end
            end
        end 
end

function GameFunkin:draw()
    --love.graphics.translate(0,100)
    love.graphics.scale(0.1,0.1)
    for i = 1,#homerLanes do
        love.graphics.circle("line", homerNotesX + (laneWidth*i), 0, 30)
    end
--[[
    for i, lane in ipairs(homerLanes) do  
        for j, note in ipairs(lane) do
            if musicTime+note.time*speed > Inits.GameHeight then
                love.graphics.setColor(1,1,1)
                love.graphics.circle("fill", homerNotesX + (laneWidth*i), 0-musicTime+note.time*speed, 30)
            end
        end
    end

    for i, lane in ipairs(homieLanes) do  
        for j, note in ipairs(lane) do
            if musicTime+note.time*speed > Inits.GameHeight then
                love.graphics.setColor(1,1,1)
                love.graphics.circle("fill", homieNotesX + (laneWidth*i), 0-musicTime+note.time*speed, 30)
            end
        end
    end
    --]]

    for i = 1,#testLane do
        love.graphics.circle("fill", 400, musicTime + testLane[i], 30)
    end

end

return GameFunkin