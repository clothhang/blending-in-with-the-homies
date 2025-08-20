local GameFunkin = State()

local inputList = {
    "FunkinLeft",
    "FunkinDown",
    "FunkinUp",
    "FunkinRight"
}

function GameFunkin:enter()

    --load assets

    quaverParse("Assets/Charts/test/test.qua")
    song = love.audio.newSource("Assets/Charts/test/audio.mp3", "stream")



    marvTiming = 43+10
    perfTiming = 68+15
    greatTiming = 93+15
    goodTiming = 117 +15
    okayTiming = 142+15
    missTiming = 166+15

    marvCount = 0
    perfCount = 0
    greatCount = 0
    goodCount = 0
    okayCount = 0
    missCount = 0
    judgeCounterXPos = {0,0,0,0,0,0}

    --set variables
    MusicTime = -300
    speed = 1.4
    laneWidth = 75
    score = 0
    accuracy = 0
    currentBestPossibleScore = 0
    combo = 0
    
end
function GameFunkin:update(dt)
    MusicTime = MusicTime + (love.timer.getTime() * 1000) - (previousFrameTime or (love.timer.getTime()*1000))
    previousFrameTime = love.timer.getTime() * 1000

    
    GameFunkin:checkInput()

    if MusicTime >= 0 and not song:isPlaying() and MusicTime < 1000 --[[ to make sure it doesnt restart --]] then
        song:play()
    end
end


function GameFunkin:judge(noteTime)
        if noteTime <= marvTiming then
            score = score + bestScorePerNote*(6/6)
            marvCount = marvCount + 1

        elseif noteTime <= perfTiming then
            score = score + bestScorePerNote*(5/6)
            perfCount = perfCount + 1

        elseif noteTime <= greatTiming then
            score = score + bestScorePerNote*(4/6)
            greatCount = greatCount + 1

        elseif noteTime <= goodTiming then
            score = score + bestScorePerNote*(3/6)
            goodCount = goodCount + 1

        elseif noteTime <= okayTiming then
            score = score + bestScorePerNote*(2/6)
            okayCount = okayCount + 1
        else
            missCount = missCount + 1
            
        end

end



function GameFunkin:checkInput()
    for i = 1,4 do 
        for j = 1,#homerLanes[i] do
            local noteTime = (math.abs(homerLanes[i][j] - MusicTime))
            if noteTime < missTiming  and Input:pressed(inputList[i]) then
                --print(noteTime)
                table.remove(homerLanes[i], j)
                break
            end
        end
    end

end
 
function GameFunkin:draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.translate(0,100)
    for i = 1,4 do
        love.graphics.circle("line", Inits.GameWidth/2+(laneWidth*i), 0, 30)
    end
    for i = 1,4 do
        for j = 1,#homerLanes[i] do
            if -(MusicTime - homerLanes[i][j])*speed < Inits.GameHeight then
                --print("test")
                love.graphics.circle("fill", Inits.GameWidth/2+(laneWidth*i), -(MusicTime - homerLanes[i][j])*speed, 30)
                --love.graphics.draw(NoteLeft, love.graphics.getWidth()/2-(LaneWidth*2), -(MusicTime - lane1[i])*speed)
            end
        end
    end


end

return GameFunkin