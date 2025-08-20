local GameJoker = State()


function GameJoker:enter()
    homiePositionsTable = {
        {180,163},
        {392,165},
        {650,150},
        {954,118}
    }

    murrImage = love.graphics.newImage("Assets/Images/murr.png")
    salImage = love.graphics.newImage("Assets/Images/sal.png")
    qImage = love.graphics.newImage("Assets/Images/q.png")
    joeImage = love.graphics.newImage("Assets/Images/joe.png")

    theJokers = {  -- name, id, position, personal use
        {"murr", 1, 1, murrImage, "12.4 inches"},
        {"sal", 2, 2, salImage, "11.9 inches"},
        {"q", 3, 3, qImage, "13 inches"},
        {"joe", 4, 4, joeImage, "10.1 inches"}
    }





end

function GameJoker:randomizeJokerPositions()  -- I HATE YOU SO MUCH 
    print("kill me")
    local usedValues = {}
    for i = 1,#usedValues do
        print("THIS SHOULDNT PRINT (shooting myself if it does (with my peenor (the white stuff that comes out of it)))" .. i)
    end
    for i = 1,#theJokers do
        ::iWannaFuckMurrayInTheAss::  -- not the joker (the joker)
        local value = love.math.random(1,4)
        table.insert(usedValues, value)
        print("Rolled Value:" .. value)
        for j = 1,#usedValues do
            if value == usedValues[j] then
                print("Same Number Rolled! time to get freaky with murray")
                goto iWannaFuckMurrayInTheAss
            end
        end
        print("(should be) new value:" .. value)
        theJokers[i][2] = value
    end
end

function GameJoker:randomizeJokerPositions()
    newPositions = {0,0,0,0}
    newTestValue = love.math.random(1,4)
  --  for i = 1,
end

function GameJoker:update(dt)

    if Input:pressed("GameClick") then
        GameJoker:randomizeJokerPositions()
        for i = 1,#theJokers do
            if i == 1 then
                print("")
            end
            print(theJokers[i][2])
            if i == #theJokers then
                print("")
            end
        end
    end
end

function GameJoker:draw()

end

return GameJoker