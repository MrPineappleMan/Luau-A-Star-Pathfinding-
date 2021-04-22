local Knit = require(game:GetService("ReplicatedStorage").Knit)

local BoardActions = {}

function BoardActions.SetHighlight(target,newState,highlightColor)
    return {
        ["type"] = "SetHighlight",
        ["target"] = target,
        ["newState"] = newState,
        ["highlightColor"] = highlightColor,
    }
end

function BoardActions.SetAreaHighlight(target,radius,newState,highlightColor)
    return {
        ["type"] = "SetAreaHighlight",
        ["target"] = target,
        ["rad"] = radius,
        ["newState"] = newState,
        ["highlightColor"] = highlightColor,
    }
    
end


function  BoardActions.ResetHighlight()
    return {
        ["type"] = "ResetHighlight",
    }
end

return BoardActions