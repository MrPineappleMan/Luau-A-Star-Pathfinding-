-- Note this module requires BoardActions first so BoardActions must not require BoardReducers when it starts

local Knit = require(game:GetService("ReplicatedStorage").Knit)
local GridActions = require(script.Parent.Actions)

local ReducerFuncs = {}

local function shallowCopyState(oldState)
    local newState = {}

    for index,val in pairs(oldState) do
        newState[index] = val
    end
    return newState
end


function ReducerFuncs.ToggleHighlight(state, action)
    local newState = shallowCopyState(state)
    local target = action.target
    local targetTile = newState[target.X][target.Y]
    targetTile.Highlighted = not targetTile.Highlighted

    return newState
end

return ReducerFuncs