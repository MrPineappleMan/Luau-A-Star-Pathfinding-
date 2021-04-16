local UserInputService = game:GetService("UserInputService")

local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)
local e = Roact.createElement

local Tile = Roact.Component:extend("Tile")
local Frame = require(script.Parent.Frame)
function Tile:init()
    local props = self.props
    local grid = props.Grid.Store:getState()
    local pos = props.Position

    self:setState({
        {
            ["ThemeColor"] = props.ThemeColor,
            ["Highlighted"] = grid[pos.X][pos.Y].Highlighted,
        }
    })
end

function Tile:render()
    return e(Frame,{
        Size = UDim2.new(1,0,1,0),
        AnchorPoint = Vector2.new(0,0),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        ThemeColor = self.state.Highlighted and  "TileHighlightedColor" or self.props.ThemeColor,
        LayoutOrder = self.props.LayoutOrder,
        [Roact.Event.InputBegan] =  function(rbx,input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                self.props.Grid:ToggleHighlight(self.props.Position)
            end
        end,
        [Roact.Event.MouseEnter] =  function(rbx)
            local buttonsPressed = UserInputService:GetMouseButtonsPressed()
            local rightButtonPressed = false
            for _,input in pairs(buttonsPressed) do
                if input.UserInputType.Name == "MouseButton2" then
                    rightButtonPressed = true
                end
            end
            if rightButtonPressed then
                self.props.Grid:ToggleHighlight(self.props.Position)
            end
        end,
    })
end

function Tile:didMount()
    local props = self.props
    props.Grid.Store.changed:connect(function(oldState,newState)
        local pos = props.Position
        local newIsHighlighted = newState[pos.X][pos.Y].Highlighted
        if newIsHighlighted ~= self.state.Highlighted then
            self:setState({
                ["Highlighted"] = newIsHighlighted
            })
        end
    end)
end

return Tile