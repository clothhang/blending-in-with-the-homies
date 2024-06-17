Inits = require("inits")

function Try(f, catchFunc)
    local returnedValue, error = pcall(f)
    if not returnedValue then
        catchFunc(error)
    end

    return returnedValue
end

function toGameScreen(x, y, string)
    -- converts a position to the game screen
    local ratio = 1
    ratio = math.min(Inits.WindowWidth/Inits.GameWidth, Inits.WindowHeight/Inits.GameHeight)
    local x, y = x - Inits.WindowWidth/2, y - Inits.WindowHeight/2
    x, y = x / ratio, y / ratio
    x, y = x + Inits.GameWidth/2, y + Inits.GameHeight/2
    if string then
        return x .. ", " .. y -- this will never be used lmao
    else
        return x, y
    end
end

function love.load()
    -- Setup Libraries
    Input = (require("Libraries.Baton")).new({
        controls = {
            GameClick = {"mouse:1"},
            FunkinLeft = {"key:d", "key:left"},
            FunkinDown = {"key:f", "key:down"},
            FunkinUp = {"key:j", "key:up"},
            FunkinRight = {"key:k", "key:right"},
        }
    })
    Class = require("Libraries.Class")
    State = require("Libraries.State")
    Timer = require("Libraries.Timer")
    tinyyaml = require("Libraries.tinyyaml")
    
    defaultFont = love.graphics.newFont(12)

    GameScreen = love.graphics.newCanvas(Inits.GameWidth, Inits.GameHeight)

    -- Initialize Game
    States = require("Modules.States")
    Shaders = require("Modules.Shaders")
    Objects = require("Modules.Objects")
    UI = require("Modules.UI")
    require("Modules.fuckHarmoni")
    require("Modules.Debug")

    State.switch(States.GameFunkin)
end

function love.update(dt)
    Timer.update(dt)
    mouseX, mouseY = toGameScreen(love.mouse.getPosition())
    Input:update()
    State.update(dt)
end

function love.draw()
    love.graphics.push()
        love.graphics.setCanvas(GameScreen)
            love.graphics.clear(0,0,0,1)
            State.draw()
            UIDraw()
        love.graphics.setCanvas()
    love.graphics.pop()

    -- ratio
    local ratio = 1
    ratio = math.min(Inits.WindowWidth/Inits.GameWidth, Inits.WindowHeight/Inits.GameHeight)
    love.graphics.setColor(1,1,1,1)
    -- draw game screen with the calculated ratio and center it on the screen
    love.graphics.setShader(Shaders.CurrentShader)
    love.graphics.draw(GameScreen, Inits.WindowWidth/2, Inits.WindowHeight/2, 0, ratio, ratio, Inits.GameWidth/2, Inits.GameHeight/2)
    love.graphics.setShader()

    debug.printInfo()
end

function love.resize(w, h)
    Inits.WindowWidth = w
    Inits.WindowHeight = h
end

function love.quit()

end