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


function ReducerFuncs.Highlight(state, action)
    local newState = shallowCopyState(state)
    local target = action.target

    newState[target.X][target.Y].Highlighted = true

    return newState
end

return ReducerFuncs