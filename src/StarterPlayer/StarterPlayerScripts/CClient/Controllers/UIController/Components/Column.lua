local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)
local Column = Roact.Component:extend("Column")

local e = Roact.createElement

function Column:render()
    local props = self.props
    local s = props.Size
    local children = {}

    for yVal = 1,s.Y do
        
    end
    return e("Frame",{
        Size = UDim2.new(1/s.X,0,1, 0),
        BackgroundTransparency = 1,
        Name = tostring(props.ColumnNumber),
    },{

    })
end

return Column