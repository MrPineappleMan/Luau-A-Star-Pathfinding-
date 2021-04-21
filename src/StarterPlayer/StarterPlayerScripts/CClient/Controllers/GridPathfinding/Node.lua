local Node = {}
Node.__index = Node

local function dist(orig: Vector2,target: Vector2)
    return (orig - target).Magnitude
end

function Node.new(current: Vector2, orig: Vector2, target: Vector2, grid: Grid)
    local self = setmetatable({
        ["gCost"] = dist(current,orig),
        ["fCost"] = dist(current,orig) + dist(current,target), -- G cost + H Cost 
        ["Position"] = current,
        ["Grid"] = grid,
    }, Node)


    return self
end

function  Node:GetNeighbours()
    local position = self.Position
    local grid = self.Grid

    local neighboors = {}

    local origX = position.X
    local origY = position.Y
    for offX = -1,1,1 do
        local row = grid[origX + offX]
        if row then
            for offY = -1,1,1 do
                local tile = row[origY + offY]
                local isSamePos = (origX == 0 and origY == 0)
                if tile and not isSamePos then
                    table.insert(neighboors,Vector2.new(origX + offX, origY + offY))
                end
            end
        end
    end
    return neighboors
end

return Node