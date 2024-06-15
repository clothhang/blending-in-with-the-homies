function CreateWindow(title,content,buttons,width,height,x,y)  

end

function CreateButton(label, x, y, width, height, id, buttonFillColor, buttonTextColor, outline, buttonOutlineColor)
    label = (label or "NO TEXT")
    x = (x or 0)
    y = (y or 0)
    width = (width or 0)
    height = (height or 0)
    id = (id or 0)
    buttonFillColor = (buttonFillColor or {0,0,0})
    buttonTextColor = (buttonTextColor or {0,0,0})
    outline = (outline or false)
    buttonOutlineColor = (buttonOutlineColor or {0,0,0})
    table.insert(buttons, {label, x, y, width, height, id, buttonFillColor, buttonTextColor, outline, buttonOutlineColor})
end

function Notification()
end

function UIDraw()
end







-- fuck making this lmao its not really needed 