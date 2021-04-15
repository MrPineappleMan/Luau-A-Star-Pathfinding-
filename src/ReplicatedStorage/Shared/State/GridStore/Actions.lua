local Knit = require(game:GetService("ReplicatedStorage").Knit)

local BoardActions = {}

function BoardActions.ToggleHighlight(target)
    return {
        ["type"] = "ToggleHighlight",
        ["target"] = target,
    }
end


return BoardActions