local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)
local e = Roact.createElement

local Column = require(script.Parent.Column)

local Grid = Roact.Component:extend("Grid")

function Grid:init()

end

function Grid:render()
    return e()
end

return Grid