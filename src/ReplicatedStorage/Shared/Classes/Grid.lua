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
    self.Store = GridStore.new(self.Store)
    return self
end

function  Grid:SetHighlight(target,newState)
    self.Store:dispatch(GridActions.SetHighlight(target))
end

function Grid:SetAreaHighlight(target,radius,newState)
    self.Store:dispatch(GridActions.SetAreaHighlight(target,radius,newState))
end

function Grid:Destroy()
    
end

function  Grid:Init() --// For the sake of organization
    
end

Grid:Init()


return Grid