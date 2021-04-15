local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)
local e = Roact.createElement

local Column = require(script.Parent.Column)
local Grid = Roact.Component:extend("Grid")
local Frame = require(script.Parent.Frame)

function Grid:init()

end

function Grid:render()
    local props = self.props
    local children = {}
    children.Layout = e("UIListLayout",{
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0,0),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    for x = 1,props.Grid.Size.X do
        children[tostring(x)] = e(Column,{["Grid"] = props.Grid, ["ColumnNumber"] = x})
    end
    return e(Frame,{
        Position = UDim2.new(0.5,0,0.5,0),
        Size = UDim2.new(0.6,0,0.6,0),
        AnchorPoint = Vector2.new(0.5,0.5),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        ThemeColor = "GridColor",
    },children)
end

return Grid