local GameFunkin = State()

function GameFunkin:enter()
    quaverParse("Assets/Charts/test.qua")

    MusicTime = 0
    speed = 0.8
    
end

function GameFunkin:update()
    MusicTime = MusicTime + (love.timer.getTime() * 1000) - (previousFrameTime or (love.timer.getTime()*1000))
    previousFrameTime = love.timer.getTime() * 1000

end

function GameFunkin:draw()
    for i, lane in ipairs(homerLanes) do
        for j, note in ipairs(lane) do
            if note.time-MusicTime < Inits.GameHeight then
                --[[ local noteImg = _G["Note" .. AllDirections[i]]
                --love.graphics.draw(noteImg, Inits.GameWidth/2-(LaneWidth*(3-i)), note[3],nil,125/noteImg:getWidth(),125/noteImg:getHeight()) ]]
                love.graphics.setColor(1,1,1)
                love.graphics.circle("fill", (Inits.GameWidth/4)*i, 0-MusicTime+note.time*speed, 10)
            end
        end
    end

end

return GameFunkin