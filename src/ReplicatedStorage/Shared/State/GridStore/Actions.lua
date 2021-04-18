local Knit = require(game:GetService("ReplicatedStorage").Knit)

local BoardActions = {}

function BoardActions.SetHighlight(target,newState)
    return {
        ["type"] = "SetHighlight",
        ["target"] = target,
        ["newState"] = newState,
    }
end

function BoardActions.SetAreaHighlight(target,radius,newState)
    return {
        ["type"] = "SetAreaHighlight",
        ["target"] = target,
        ["rad"] = radius,
        ["newState"] = newState,
    }
    
end


return BoardActions