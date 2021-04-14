local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Tile = require(script.Parent.Tile)
local GridStore = require(Knit.Shared.State.GridStore)
local GridActions = require(Knit.Shared.State.GridStore.Actions)

local Grid = {}
Grid.__index = Grid


function Grid.new(size: Vector2)
    local self = setmetatable({
        ["State"] = {},
    }, Grid)
    local sizeX = size.X
    local sizeY = size.Y    

    for x = 1,sizeX  do
        self.State[x] = {}
        for y = 1,sizeY  do
            local currentPos = Vector2.new(x,y)
            self.State[x][y] = Tile.new(currentPos)
        end
    end
    warn(self.State)
    self.State = GridStore.new(self.State)

    self:Highlight(Vector2.new(5,5))
    warn(self.State:getState()[5][5])
    return self
end

function  Grid:Highlight(target)
    self.State:dispatch(GridActions.Highlight(target))
end

function Grid:Destroy()
    
end

function  Grid:Init() --// For the sake of organization
    
end

Grid:Init()


return Grid