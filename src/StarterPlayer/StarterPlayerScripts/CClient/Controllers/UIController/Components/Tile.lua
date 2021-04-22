local UserInputService = game:GetService("UserInputService")

local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)
local UIController = require(Knit.Client.Controllers.UIController)

local e = Roact.createElement

local Tile = Roact.Component:extend("Tile")
local Frame = require(script.Parent.Frame)
function Tile:init()
    local props = self.props
    local grid = props.Grid.Store:getState()
    local pos = props.Position

    self:setState({
        {
            ["HighlightColor"] = props.HighlightColor,
            ["ThemeColor"] = props.ThemeColor,
            ["Highlighted"] = grid[pos.X][pos.Y].Highlighted,
        }
    })
end

local function checkValidInputs()
    local buttonsPressed = UserInputService:GetMouseButtonsPressed()
    local keysPressed = UserInputService:GetKeysPressed()
    local rightButtonPressed = false
    local ctrlPressed = false
    local qPressed = false
    local ePressed = false

    for _,input in pairs(buttonsPressed) do
        if input.UserInputType.Name == "MouseButton2" then
            rightButtonPressed = true
        end
    end
    for _,input in pairs(keysPressed) do
        if input.KeyCode == Enum.KeyCode.LeftControl then
            ctrlPressed = true
        elseif  input.KeyCode == Enum.KeyCode.Q then
            qPressed = true
        elseif  input.KeyCode == Enum.KeyCode.E then
            ePressed = true
        end
    end

    return rightButtonPressed, ctrlPressed,qPressed,ePressed
end

function Tile:setAreaTiles()
    local rightMouseButtonPressed, ctrlPressed,qPressed,ePressed = checkValidInputs()

    if qPressed then
        UIController:SetStart(self.props.Position)
    elseif  ePressed then
        UIController:SetEnd(self.props.Position)
    end

    if rightMouseButtonPressed then
        if (ctrlPressed) then
            self.props.Grid:SetAreaHighlight(self.props.Position,5,false,"DefTileHighlightedColor")
        elseif  (not ctrlPressed) then
            self.props.Grid:SetAreaHighlight(self.props.Position,5,true,"DefTileHighlightedColor")
        end
    end
end

function Tile:render()
    return e(Frame,{
        Size = UDim2.new(1,0,1,0),
        AnchorPoint = Vector2.new(0,0),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        ThemeColor = self.state.Highlighted and self.state.HighlightColor or self.props.ThemeColor,
        LayoutOrder = self.props.LayoutOrder,
        [Roact.Event.InputBegan] =  function(rbx,input)
            self:setAreaTiles()
        end,
        [Roact.Event.MouseEnter] =  function(rbx)
            self:setAreaTiles()
        end,
    })
end

function Tile:didMount()
    local props = self.props
    props.Grid.Store.changed:connect(function(oldState,newState)
        local pos = props.Position
        local new = newState[pos.X][pos.Y]
        if (new.Highlighted ~= self.state.Highlighted) or (new.HighlightColor ~= self.state.HighlightColor) then
            self:setState({
                ["Highlighted"] = new.Highlighted,
                ["HighlightColor"] = new.HighlightColor,
            })
        end
    end)
end

return Tile