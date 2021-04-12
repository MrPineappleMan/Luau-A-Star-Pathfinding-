local Knit = require(game:GetService("ReplicatedStorage").Knit)

local BoardActions = {}

function BoardActions.Highlight(target)
    return {
        ["type"] = "Highlight",
        ["target"] = target,
    }
end


return BoardActions