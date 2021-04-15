local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)
local e = Roact.createElement

local Tile = Roact.Component:extend("Tile")
local Frame = require(script.Parent.Frame)

function Tile:render()
    return e(Frame,{
        Size = UDim2.new(1,0,1,0),
        AnchorPoint = Vector2.new(0,0),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        ThemeColor = self.props.ThemeColor,
        LayoutOrder = self.props.LayoutOrder,
    })
end

return Tile