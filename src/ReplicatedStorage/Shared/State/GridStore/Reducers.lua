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


function ReducerFuncs.SetHighlight(state, action)
    local newState = shallowCopyState(state)
    local target = action.target
    local targetTile = newState[target.X][target.Y]
    targetTile.Highlighted = action.newState
    targetTile.HighlightColor = action.highlightColor or targetTile.HighlightColor
    return newState
end

function ReducerFuncs.SetAreaHighlight(state, action)
    local newState = shallowCopyState(state)
    local target = action.target

    local radius = action.rad
    for x = -radius, radius,1 do
        local column = newState[target.X + x]
        if column then
            for y = -radius, radius,1 do
                local tile = column[target.Y + y]
                local currentPos = Vector2.new(target.X + x,target.Y + y)
                if tile and ((currentPos - target).Magnitude < radius) then
                    tile.Highlighted = action.newState
                    tile.HighlightColor = action.highlightColor or tile.HighlightColor
                end
            end
        end
    end

    return newState
end


return ReducerFuncs