--shhhh

local GameRhythm = State()
local beatLength
local bpm
local musicTime
local bpmIsInit = false
local beat = 0

function GameRhythm:enter()
    homie = love.graphics.newImage("Assets/Images/homie.png")
    homer = love.graphics.newImage("Assets/Images/homer.png")
    background = love.graphics.newImage("Assets/Images/bg.png")

    click1 = love.audio.newSource("Assets/Sounds/sound-hit.wav", "static")
    click2 = love.audio.newSource("Assets/Sounds/sound-hitclap.wav", "static")
    song = love.audio.newSource("Assets/Sounds/freedom-dive.mp3", "stream")
    GameRhythm:initialize()
    GameRhythm:calculateBeatLength()

    curHomerPos = 4

end

function GameRhythm:initialize()
    homiePositionsTable = {
        {180,163, 0},
        {392,165, 0},
        {650,150, 0},
        {954,118, 0}
    }
    beatLength = 0
    bpm = 222.22*2
    musicTime = 0
end

function GameRhythm:calculateBeatLength()
    beatLength = (60/bpm)
    bpmIsInit = true
    Timer.after(0.3,function()song:play()end)
    print(beatLength)
end

function doBeat()
end

function GameRhythm:doBpmShit()

    if musicTime >= beatLength then

        print(beat)
        musicTime = 0
        beat = beat + 1

        if beat == 4 then
          -- click1:clone():play()
        elseif beat ~= 0 then
           -- click2:clone():play()
        end
        if beat > #homiePositionsTable then
            beat = 1
            if curHomerPos == 4 then
                curHomerPos = 1
            else
                curHomerPos = 4
            end
        end
        print("beat" .. beat)
        if curHomerPos == 4 then
            GameRhythm:makeHomieJumpIdk(beat)
        else
            local homieToJump             
            if beat == 1 then            --disgusting hard coding :sob:
                homieToJump = 4
            elseif beat == 2 then
                homieToJump = 3
            elseif beat == 3 then
                homieToJump = 2
            elseif beat == 4 then
                homieToJump = 1
            end
            GameRhythm:makeHomieJumpIdk(homieToJump)
        end

    end
end

function GameRhythm:makeHomieJumpIdk(whatHomie)
    if homiePositionsTable[whatHomie] then
        if curHomerPos == 4 and beat == 4 then
            homieJumpTween  = Timer.tween(beatLength/2, homiePositionsTable[whatHomie], {[3] = 25}, "out-quad", function()
                Timer.tween(beatLength/2, homiePositionsTable[whatHomie], {[3] = 0}, "in-quad",function()
                    click1:play()
                end)
            end)
        elseif curHomerPos == 1 and beat == 4 then
            homieJumpTween  = Timer.tween(beatLength/2, homiePositionsTable[whatHomie], {[3] = 25}, "out-quad", function()
                Timer.tween(beatLength/2, homiePositionsTable[whatHomie], {[3] = 0}, "in-quad",function()
                    click1:play()
                end)
            end)
        else

            homieJumpTween  = Timer.tween(beatLength/2, homiePositionsTable[whatHomie], {[3] = 25}, "out-quad", function()
                Timer.tween(beatLength/2, homiePositionsTable[whatHomie], {[3] = 0}, "in-quad",function()
                    click2:play()
                end)
            end)
        end
    end
end

function GameRhythm:checkInput()  -- if it returns 0 then no homie was hit, if it returns 1-4 then thats the homie that was hit and if it returns anything else then idk lmfao
    local hitHomie = 0
    for i = 1,#homiePositionsTable do
        if mouseX > homiePositionsTable[i][1] and mouseX < homiePositionsTable[i][1] + homie:getWidth() then
            -- X position is inside a homie
            if mouseY > homiePositionsTable[i][2] and mouseY < homiePositionsTable[i][2] + homie:getHeight() then
                -- Y position is inside a homie 
                hitHomie = i
            end
        end
    end
    return hitHomie
end

function GameRhythm:doNote()
end

function GameRhythm:update()
    musicTime = musicTime + (love.timer.getTime()) - (previousFrameTime or (love.timer.getTime()))
    previousFrameTime = love.timer.getTime()
    if bpmIsInit then
        GameRhythm:doBpmShit()
    end

    if Input:pressed("GameClick") then
        if GameRhythm:checkInput() == curHomerPos then
            print("idk")
        else
            print("idk 2")
        
        end
    end
end

function GameRhythm:draw()
    love.graphics.draw(background)
    --love.graphics.setColor(1,1,1,0.1)
    for i = 1,#homiePositionsTable do
        love.graphics.draw(homie, homiePositionsTable[i][1], homiePositionsTable[i][2]- homiePositionsTable[i][3])
        if i == curHomerPos then
            love.graphics.draw(homer, homiePositionsTable[i][1] , homiePositionsTable[i][2] - homiePositionsTable[i][3])
        end
    end
end

return GameRhythm