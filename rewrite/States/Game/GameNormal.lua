local GameNormal = State()
zoom = 1
botplay = false
local gameTimerDecrementAmount
function GameNormal:enter()
    --load assets

    --images
    homie = love.graphics.newImage("Assets/Images/homie.png")
    homer = love.graphics.newImage("Assets/Images/homer.png")
    peter = love.graphics.newImage("Assets/Images/peter.png")
    frank = love.graphics.newImage("Assets/Images/frank.png")
    chicken = love.graphics.newImage("Assets/Images/chicken.png")
    testGraphic = love.graphics.newImage("Assets/Images/blendingIn.png")
    background = love.graphics.newImage("Assets/Images/bg.png")
    healthIcon = love.graphics.newImage("Assets/Images/hp.png")
    comboShatter = love.graphics.newImage("Assets/Images/particles/comboShatter.png")
    peterBonus = love.graphics.newImage("Assets/Images/peterBonus.png")

    --audio

    --sound effects
    homerLaugh = love.audio.newSource("Assets/Sounds/homerLaugh.mp3", "static")
    lucky = love.audio.newSource("Assets/Sounds/lucky.mp3", "static")
    myNameIsFrankGrimes = love.audio.newSource("Assets/Sounds/frankGrimes.mp3", "static")
    GRRR = love.audio.newSource("Assets/Sounds/GRRR.mp3", "static")
    priceIsRight = love.audio.newSource("Assets/Sounds/priceIsRightLose.mp3","static")
    whatTheHell = love.audio.newSource("Assets/Sounds/whatTheHellAreYouDoin.mp3", "static")

    --music
    backgroundMusic = love.audio.newSource("Assets/Music/nocturnes.mp3", "stream")

    backgroundMusic:setLooping(true)
    if not backgroundMusic:isPlaying() then
        backgroundMusic:play()
    end
    backgroundMusic:setVolume(1)

    --fonts
    solidFont = love.graphics.newFont("Assets/Fonts/FATASSFI.TTF",100)  -- i did not type this its literally the real font name lmfao 💀💀
    lineFont = love.graphics.newFont("Assets/Fonts/FATASSOU.TTF",100)

    GameNormal:initialize()

    botplay = false

end

function GameNormal:initialize()
    --initialize game shit
    homiePositionsTable = {
        {180,163},
        {392,165},
        {650,150},
        {954,118}
    }
    curHomerPos = love.math.random(1,#homiePositionsTable)
    curEnemyPos = 1
    PETERFUCKINGGRIFFIN = false
    hasEnemy = false
    score = 0
    printableScore = {score}
    peterBonusPos = {-99999, -99999, -15}
    scoreMultiplier = 1
    TimerDecrementer = 0
    gameTimer = 10
    timerJump = {0}
    peterTimer = 0
    peterTimerDecrementer = 0
    totalHits = 0
    accuracy = 1
    printableAccuracy = {accuracy}
    scoreSizeAndPosShitIdk = {0,0}
    goodHits = 0
    badHits = 0
    peterHits = 0
    homerHits = 0
    homieHits = 0
    frankHits = 0
    chickenHits = 0
    totalHits = 0



end


function GameNormal:update(dt)
    gameTimerDecrementAmount = math.min((1000+(score*10)), 20000)
    TimerDecrementer = TimerDecrementer - gameTimerDecrementAmount*dt
    peterTimerDecrementer = peterTimerDecrementer - 1000*dt





    if TimerDecrementer <= 0 then
        TimerDecrementer = 1000
        GameNormal:decrementTimer()
    end

    if peterTimerDecrementer <= 0 then
        peterTimerDecrementer = 1000
        GameNormal:decrementPeterTimer()
    end


    if gameTimer < 0 then
        GameNormal:gameOver()
    end



    if scoreTween then
        Timer.cancel(scoreTween)
    end
    scoreTween = Timer.tween(0.5, printableScore, {score}, "out-quad")
    if tostring(printableAccuracy[1]) == "nan" then
        printableAccuracy[1] = 0
    end
    
    accuracy = (goodHits/totalHits)
    if accuracyTween then
        Timer.cancel(accuracyTween)
    end
    accuracyTween = Timer.tween(0.5, printableAccuracy, {accuracy}, "out-quad")



    if Input:pressed("GameClick") then
        if GameNormal:checkInput() == curHomerPos then
            if PETERFUCKINGGRIFFIN then
                GameNormal:hitPeter()
            end
            GameNormal:hitHomer()
        elseif GameNormal:checkInput() == curEnemyPos and hasEnemy then
            if PETERFUCKINGGRIFFIN then
                GameNormal:hitChicken()
            else
                GameNormal:hitFrank()
            end
        else
            GameNormal:hitHomie()
        end
    
    elseif botplay then
        if PETERFUCKINGGRIFFIN then
            GameNormal:hitPeter()
        else
            GameNormal:hitHomer()
        end
    end
end

function GameNormal:incrementScore(incrementAmount)
    scoreSizeAndPosShitIdk = {love.math.random(-25,25), 1.3}
    if scoreSizeAndPosShitIdkTween then
        Timer.cancel(scoreSizeAndPosShitIdkTween)
    end
    scoreSizeAndPosShitIdkTween = Timer.tween(0.3, scoreSizeAndPosShitIdk, {[1] = 0, [2] = 0}, "out-quad")
    score = score + incrementAmount * scoreMultiplier
end

function GameNormal:decrementTimer()
    gameTimer = gameTimer - 1
    timerJump = {-15}
    Timer.tween(0.2, timerJump, {0}, "out-back")

end

function GameNormal:decrementPeterTimer()
    peterTimer = peterTimer - 1
    peterTimerJump = {-15}
    Timer.tween(0.2, peterTimerJump, {0}, "out-back")

end

function GameNormal:hitHomer()
    goodHits = goodHits + 1
    homerHits = homerHits + 1
    totalHits = totalHits + 1
    
    GameNormal:incrementScore(10)
    local clone = homerLaugh:clone()
    clone:setVolume(0.4)
    local pitch = love.math.random(80, 120)/100
    clone:setPitch(pitch)
    clone:play()
    GameNormal:pickHomerPosition(curHomerPos)
end 

function GameNormal:hitPeter()
    goodHits = goodHits + 1
    peterHits = peterHits + 1
    totalHits = totalHits + 1

    if peterBonusTween then
        Timer.cancel(peterBonusTween)
    end
    peterTimer = 15

    scoreMultiplier = scoreMultiplier + 0.5
    Timer.after(15, function()
        scoreMultiplier = scoreMultiplier - 0.5
    end)

    lucky:play()

    local clone = lucky:clone()
    clone:play()
    GameNormal:pickHomerPosition(curHomerPos)

    peterBonusPos = {-peterBonus:getWidth(), 130, -35}
    peterBonusTween = Timer.after(0, function()
        Timer.tween(1, peterBonusPos, {[3] = 0}, "out-back")
        Timer.tween(0.8, peterBonusPos, {[1] = Inits.GameWidth/2-peterBonus:getWidth()/2}, "out-quad", function()
            Timer.tween(1.3, peterBonusPos, {[3] = 0}, "out-back")
            Timer.after(1.65, function()
                Timer.tween(0.2, peterBonusPos, {[2] = -300, [3] = 25}, "in-expo")
            end)
        end)
    end)

end

function GameNormal:hitChicken()
    chickenHits = chickenHits + 1
    badHits = badHits + 1
    totalHits = totalHits + 1

    local audio = lucky:clone()
    audio:setPitch(0.75)
    audio:play()
    whatTheHell:play()
    peterTimer = 15

    scoreMultiplier = scoreMultiplier - 0.5
    Timer.after(15, function()
        scoreMultiplier = scoreMultiplier + 0.5
    end)
    score = score - 100
    GameNormal:pickHomerPosition(curHomerPos)

end

function GameNormal:hitFrank()
    frankHits = frankHits + 1 -- this will never be anything other than 0 or 1
    badHits = badHits + 1
    totalHits = totalHits + 1

    myNameIsFrankGrimes:play()
    GameNormal:gameOver()
    GameNormal:pickHomerPosition(curHomerPos)

end

function GameNormal:hitHomie()
    badHits = badHits + 1
    homieHits = homieHits + 1
    totalHits = totalHits + 1

    local clone = GRRR:clone()
    clone:setVolume(0.2)
    local pitch = love.math.random(80, 120)/100
    clone:setPitch(pitch)

    clone:play()
    gameTimer = gameTimer - 3
   -- GameNormal:pickHomerPosition(curHomerPos)

end

function GameNormal:gameOver()
    backgroundMusic:stop()
    priceIsRight:play()
    State.switch(States.Results)
end


function GameNormal:checkInput()  -- if it returns 0 then no homie was hit, if it returns 1-4 then thats the homie that was hit and if it returns anything else then idk lmfao
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

function GameNormal:pickHomerPosition(currentPos)
    local pos
    local PETER = false
    local enemy = false
    PETERFUCKINGGRIFFIN = false
    hasEnemy = false
    gameTimer = 10
    if love.math.random(1,50) == 1 then
        PETER = true
        PETERFUCKINGGRIFFIN = true
    end
    if love.math.random(1,3) == 1 then
        enemy = true
        hasEnemy = true
    end

    if peterTimer > 0 then
        PETERFUCKINGGRIFFIN = false
    end

    if not currentPos then
        pos = (curHomerPos or 1)  -- no clue why im doing it like this but idk maybe there could be a situation where i want to give something other than the current homer position as an arg to this
    else
       pos = currentPos
    end
    local newPos = pos
    while(newPos == pos) do
        newPos = love.math.random(1,#homiePositionsTable) -- just in case i add more homies idk
    end


    if enemy then
        curEnemyPos = newPos
        while(curEnemyPos == newPos) do
            curEnemyPos = love.math.random(1,#homiePositionsTable)
        end

    end
        
  

    curHomerPos = newPos

end

function GameNormal:debugDraw()
    love.graphics.setColor(1,0,0)
    love.graphics.print(
    "Score: " .. score .. "\n" ..
    "Game Timer Decrement Amount: " .. gameTimerDecrementAmount .. "\n" ..
    "Accuracy: " .. accuracy .. "\n" ..
    "Printable Accuracy: " .. printableAccuracy[1] .. "\n" ..
    "Total Hits: " .. totalHits .. "\n" ..
    "Homer Hits: " .. homerHits .. "\n" ..
    "Homie Hits: " .. homieHits .. "\n" ..
    "Peter Hits: "  .. peterHits .. "\n" ..
    "Frank Hits: " .. frankHits .. "\n" ..
    "Chicken Hits: " .. chickenHits .. "\n"
    , 
    10, 100)
    love.graphics.setColor(1,1,1)
end

function GameNormal:draw()
    love.graphics.scale(zoom, zoom)
    love.graphics.draw(background)
    for i = 1,#homiePositionsTable do
        love.graphics.draw(homie,homiePositionsTable[i][1], homiePositionsTable[i][2])

        if i == curHomerPos then
            if PETERFUCKINGGRIFFIN then
                love.graphics.draw(peter, homiePositionsTable[i][1], homiePositionsTable[i][2])
            else
                love.graphics.draw(homer, homiePositionsTable[i][1], homiePositionsTable[i][2])
            end
        end
    
        if i == curEnemyPos and hasEnemy then
            if PETERFUCKINGGRIFFIN then
                love.graphics.draw(chicken, homiePositionsTable[i][1], homiePositionsTable[i][2])
            else
                love.graphics.draw(frank, homiePositionsTable[i][1], homiePositionsTable[i][2])
            end
        end

      --  love.graphics.draw(peter,homiePositionsTable[i][1], homiePositionsTable[i][2])

    end
    love.graphics.setFont(lineFont)
    love.graphics.setColor(0,0,0)
    shakeBooleanIdk = not shakeBooleanIdk
    otherShakeBooleanIdk = not otherShakeBooleanIdk
    if otherShakeBooleanIdk then
        if shakeBooleanIdk then 
            shakeX = love.math.random(0,score/1000)
            shakeY = love.math.random(0,score/1000)
        else
            shakeX = -shakeX
            shakeY = -shakeY
        end
    end
    love.graphics.printf(math.ceil(printableScore[1]), (100+(shakeX or 0)) + scoreSizeAndPosShitIdk[1], (100+(shakeY or 0)) + scoreSizeAndPosShitIdk[1], math.huge, left, math.rad(-5))

    love.graphics.printf(string.format("%.2f",tostring(printableAccuracy[1])) .. "%", 30, 600, math.huge, "left", nil, 0.5, 0.5)
    if gameTimer <= 3 then
        love.graphics.setColor(168/255,26/255,26/255)

    elseif gameTimer <= 5 then
        love.graphics.setColor(1,99/255,0)

    else
        love.graphics.setColor(0,0,0)
    end
   --love.graphics.setColor(1,1,1)

    love.graphics.printf(gameTimer, 0, 100+timerJump[1], Inits.GameWidth*2, "center", nil, 0.5, 0.5)

    if peterTimer > 0 then
        love.graphics.printf(peterTimer, 300, 100+peterTimerJump[1], Inits.GameWidth*2, "center", nil, 0.5, 0.5)
    end

    love.graphics.setColor(1,1,1)
    love.graphics.setFont(defaultFont)
    --GameNormal:debugDraw()
    love.graphics.draw(peterBonus, (peterBonusPos[1] or Inits.GameWidth/2), (peterBonusPos[2] or Inits.GameHeight/2), math.rad(peterBonusPos[3]), 0.7, 0.7, 15, peterBonus:getHeight()/2)
   -- love.graphics.draw(peterBonus, Inits.GameWidth/2, Inits.GameHeight/2)
end

return GameNormal
