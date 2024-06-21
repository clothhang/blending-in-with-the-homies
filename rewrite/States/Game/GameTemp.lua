local GameTemp = State()

function GameTemp:enter()

    murrImage = love.graphics.newImage("Assets/Images/murr.png")
    salImage = love.graphics.newImage("Assets/Images/sal.png")
    qImage = love.graphics.newImage("Assets/Images/q.png")
    joeImage = love.graphics.newImage("Assets/Images/joe.png")

    homiePositionsTable = {
        {180,163, 0},
        {392,165, 0},
        {650,150, 0},
        {954,118, 0}
    }

    homiesTable = {
        {murrImage, 1, {1,0,0}, 180, 163},
        {salImage, 2, {0,1,0}, 392, 165},
        {qImage, 3, {0,0,1}, 650, 150},
        {joeImage, 4, {1,1,0}, 954, 118},
    }

    curTarget = love.math.random(1,#homiesTable)
end

function GameTemp:update(dt)
        

    if Input:pressed("GameClick") then
        if GameTemp:checkInput() == curTarget then
            print("S")
        else
            print("F")
        end
        GameTemp:randomizeHomiesTable()

       --l print(homiesTable[1][1] .. ", " .. homiesTable[1][2] .. ", " .. homiesTable[1][3][1] .. ", " .. homiesTable[1][3][2] .. ", " .. homiesTable[1][3][3] .. ", " .. homiesTable[1][4] .. ", " .. homiesTable[1][5])
    end


   -- print(homiesTable[1][4])

end

function GameTemp:checkInput()
    for i = 1,#homiePositionsTable do
        if mouseX > homiePositionsTable[i][1] and mouseX < homiePositionsTable[i][1] + 200 then
            if mouseY > homiePositionsTable[i][2] and mouseY < homiePositionsTable[i][2] + 500 then
                print(homiesTable[i][1])
                return homiesTable[i][2]
            end
        end
    end
end

function GameTemp:randomizeHomiesTable()
    local loop = #homiesTable
    local testTable = {}
    local possibleNewValue
    ::restart::
    possibleNewValue = love.math.random(1, #homiesTable)
    while isInTable(possibleNewValue, testTable) do
        possibleNewValue = love.math.random(1, #homiesTable)
    end
    table.insert(testTable, possibleNewValue)
    loop = loop - 1
    if loop > 0 then
        goto restart
    end
    local homiesTableCopy = tableCopy(homiesTable)
    homiesTable = {}
    for i = 1,#homiesTableCopy do
        if i == 1 then
        --    print("")
        end
       -- print(homiesTableCopy[testTable[i]][4])
        table.insert(homiesTable, homiesTableCopy[testTable[i]])
    end
end

function GameTemp:draw()
    love.graphics.print(curTarget, 100, 100)
    for i = 1,#homiesTable do
      --  love.graphics.setColor(homiesTable[i][3])
        if i == 1 then
          --  print(homiesTable[i][3][1])
        end
        love.graphics.draw(homiesTable[i][1], homiePositionsTable[i][1], homiePositionsTable[i][2])
      --  love.graphics.rectangle("fill", homiePositionsTable[i][1], homiePositionsTable[i][2], 200, 500)

    end

end

return GameTemp