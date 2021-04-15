local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Tile = require(script.Parent.Tile)
local GridStore = require(Knit.Shared.State.GridStore)
local GridActions = require(Knit.Shared.State.GridStore.Actions)

local Grid = {}
Grid.__index = Grid


function Grid.new(size: Vector2)
    local self = setmetatable({
        ["Store"] = {},
        ["Size"] = size,
    }, Grid)
    local sizeX = size.X
    local sizeY = size.Y    

    for x = 1,sizeX  do
        self.Store[x] = {}
        for y = 1,sizeY  do
            local currentPos = Vector2.new(x,y)
            self.Store[x][y] = Tile.new(currentPos)
        end
    end
    warn(self.Store)
    self.Store = GridStore.new(self.Store)

    self:ToggleHighlight(Vector2.new(5,5))
    warn(self.Store:getState()[5][5])
    return self
end

function  Grid:ToggleHighlight(target)
    self.Store:dispatch(GridActions.ToggleHighlight(target))
    warn(self.Store:getState()[target.X][target.Y])
end

function Grid:Destroy()
    
end

function  Grid:Init() --// For the sake of organization
    
end

Grid:Init()


return Grid