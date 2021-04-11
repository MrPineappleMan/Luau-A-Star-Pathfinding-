local Knit = require(game:GetService("ReplicatedStorage").Knit)

local Grid = {}
Grid.__index = Grid


function Grid.new(size: Vector2,)
    local self = setmetatable({
        ["State"] = {},
    }, Grid)
    

    return self
end


function Grid:Destroy()
    
end

function  Grid:Init() --// For the sake of organization
    
end

Grid:Init()


return Grid