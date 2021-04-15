local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)

local Column = Roact.Component:extend("Column")
local Tile = require(script.Parent.Tile)
local Frame = require(script.Parent.Frame)

local e = Roact.createElement

local function determineTileColor(grid,y,offIsEven,columnNum)
    local tileProps = {}
    tileProps["ThemeColor"] = (y%2 == 0) and "TileColor2" or "TileColor1"
    if offIsEven then
        local currentTheme = tileProps["ThemeColor"]
        tileProps["ThemeColor"] = (currentTheme == "TileColor2") and "TileColor1" or "TileColor2"
    end

    local gridTile = grid[columnNum][y]
    if gridTile.Highlighted then
        tileProps["ThemeColor"] = "TileHighlightedColor"
    end
    return tileProps
end

function Column:render()
    local props = self.props
    local grid = props.Grid.State:getState()
    local size = props.Grid.Size

    local columnNum = props.ColumnNumber
    local children = {}

    children.Layout = e("UIListLayout",{  
        FillDirection = Enum.FillDirection.Vertical,
        Padding = UDim.new(0,0),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    local offIsEven = (columnNum%2 == 0)
    for y = 1,size.Y do
        local tileProps = determineTileColor(grid,y,offIsEven,columnNum)
        tileProps.LayoutOrder = y

        children[tostring(y)] = e(Tile,tileProps)
    end

    return e(Frame,{
        Size = UDim2.new(1/size.X,0,1, 0),
        BackgroundTransparency = 1,
        Name = tostring(columnNum),
        LayoutOrder = columnNum,
    },children)
end

return Column