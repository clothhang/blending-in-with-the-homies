local GameTemp = State()

function GameTemp:enter()


    homiesTable = {
        {"1", 1, {1,0,0}, 180, 163},
        {"2", 2, {0,1,0}, 392, 165},
        {"3", 3, {0,0,1}, 650, 150},
        {"4", 4, {1,1,0}, 954, 118},
    }
end

function GameTemp:update(dt)

    if Input:pressed("GameClick") then
        GameTemp:checkInput()
        GameTemp:randomizeHomiesTable()
    end


   -- print(homiesTable[1][4])

end

function GameTemp:checkInput()
    for i = 1,#homiesTable do
        if mouseX > homiesTable[i][4] and mouseX < homiesTable[i][4] + 200 then
            if mouseY > homiesTable[i][5] and mouseY < homiesTable[i][5] + 500 then
                print(i)
                return i
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
            print("")
        end
        print(homiesTableCopy[testTable[i]][4])
        table.insert(homiesTable, homiesTableCopy[testTable[i]])
    end
end

function GameTemp:draw()
    for i = 1,#homiesTable do
        love.graphics.setColor(homiesTable[i][3])
        if i == 1 then
            print(homiesTable[i][3][1])
        end

        love.graphics.rectangle("fill", homiesTable[i][4], homiesTable[i][5], 200, 500)

    end

end

return GameTemp