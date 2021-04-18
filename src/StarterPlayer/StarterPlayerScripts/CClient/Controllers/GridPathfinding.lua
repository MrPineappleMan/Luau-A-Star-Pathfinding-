--This uses A* pathfinding to find the shortest path from one point to another

--[[
    A* Pseudo Code
    OPEN //the set of nodes to be evaluated
    CLOSED //the set of nodes already evaluated
    add the start node to OPEN
    
    loop
            current = node in OPEN with the lowest f_cost
            remove current from OPEN
            add current to CLOSED
    
            if current is the target node //path has been found
                    return
    
            foreach neighbour of the current node
                    if neighbour is not traversable or neighbour is in CLOSED
                            skip to the next neighbour
    
                    if new path to neighbour is shorter OR neighbour is not in OPEN
                            set f_cost of neighbour
                            set parent of neighbour to current
                            if neighbour is not in OPEN
                                    add neighbour to OPEN
]]
local RunService = game:GetService("RunService")

local Knit = require(game:GetService("ReplicatedStorage").Knit)

local GridPathfinding = Knit.CreateController { Name = "GridPathfinding" }

local function dist(orig: Vector2,target: Vector2)
    return (orig - target).Magnitude
end

local function getNeighboorPositions(grid: Grid,position: Vector2)
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

local function checkIfTileIsBlocked(tile)
    if tile.Highlighted then
        return true
    end
    return false
end  

local function createNode(current: Vector2,orig: Vector2, target: Vector2)
    return {
        gCost = dist(current,orig),
        fCost = dist(current,orig) + dist(current,target), -- G cost + H Cost 
        Position = current,
    }
end

local function getNodeWithLowestCost(open)
    local currentLowest = math.huge

    for _,node in pairs(open) do
        local currentFCost = node.fCost
        if currentFCost < currentLowest then
            currentLowest = currentFCost
        end
    end

    return currentLowest
end

local function createVec2ID(target: Vector2)
    return string.format("%d,%d",target.X,target.Y)
end

function GridPathfinding:FindPath(orig: Vector2, target: Vector2,grid: Grid)
    local open = {}
    local closed = {}
    local current = createNode(orig,orig,target)
    open[createVec2ID(current)] = current --// ID is used because using the vector2 as a key doesn't work...

    local currentStep = 0
    while true do
        current = getNodeWithLowestCost(open)

        local currentPos = current.Position
        local currentID = createVec2ID(currentPos)
        open[currentID] = nil
        closed[currentID] = current

        if currentPos == target then
            warn("Found!")
            return open
        end

        for _,neighbourPos in pairs(getNeighboorPositions(grid,currentPos)) do
            local neighbourID = createVec2ID(neighbourPos)
            local neighbourTile = grid[neighbourPos.X][neighbourPos.Y]

            if checkIfTileIsBlocked(neighbourTile) or closed[neighbourID] then
                continue
            end

            local newCostToNeighbour = current.gCost + dist(current.Position,neighbourPos)
            local neighbourGCost = dist(neighbourPos,orig)
            if newCostToNeighbour < neighbourGCost or not closed[neighbourID] then
                local neighbourNode = createNode(neighbourPos,orig,target)
                neighbourNode.Parent = current
                if not open[neighbourID] then
                    open[neighbourID] = neighbourNode
                end
            end
        end
        if current == target then
            return --//Path has been found
        end
        
        if currentStep == 10 then
            RunService.Heartbeat:Wait()
        end
        current += 1
    end
end

function GridPathfinding:KnitStart()
    
end


function GridPathfinding:KnitInit()
    
end


return GridPathfinding