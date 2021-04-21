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
local Node = require(script.Node)
local HeapSort = require(script.HeapSort)

local GridPathfinding = Knit.CreateController { Name = "GridPathfinding" }

local function dist(orig: Vector2,target: Vector2)
    return (orig - target).Magnitude
end

local function checkIfTileIsBlocked(tile)
    if tile.Highlighted then
        return true
    end
    return false
end  

local function createVec2ID(target: Vector2)
    return string.format("%d,%d",target.X,target.Y)
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

function GridPathfinding:FindPath(orig: Vector2, target: Vector2,grid: Grid)
    local gridState = grid.Store:getState()

    local Heap = HeapSort.new()

    local open = {}
    local closed = {}

    local current = Node.new(orig,orig,target,gridState)
    local keysInOpen = 0
    local currentStep = 0

    local function addNodeTo(tbl: table, node: Node)
        tbl[createVec2ID(node.Position)] = node
        if (tbl == open) then
            grid:SetHighlight(node.Position,true,"OpenColor")
            Heap:Push(node.fCost,node)
            keysInOpen += 1
        else
            grid:SetHighlight(node.Position,true,"ClosedColor")
        end
    end

    local function removeNodeFrom(tbl: table, node: Node)
        tbl[createVec2ID(node.Position)] = nil
        if (tbl == open) then
           keysInOpen -= 1
        end
    end

    addNodeTo(open,current)

    while (keysInOpen > 0) do
        current = Heap.Values[1] --// This is the closest node!
        Heap:PopTop()

        local currentPos = current.Position

        removeNodeFrom(open,current)
        addNodeTo(closed,current)

        if currentPos == target then
            self:DrawPath(target,closed,grid)
            return closed
        end

        for _,neighbourPos in pairs(current:GetNeighbours()) do
            local neighbourID = createVec2ID(neighbourPos)
            local neighbourTile = gridState[neighbourPos.X][neighbourPos.Y]

            if checkIfTileIsBlocked(neighbourTile) or closed[neighbourID] then
                continue
            end

            local newCostToNeighbour = current.gCost + dist(current.Position,neighbourPos)
            local neighbourGCost = dist(neighbourPos,orig)
            if( newCostToNeighbour < neighbourGCost) or (not closed[neighbourID]) then
                local neighbourNode = Node.new(neighbourPos,orig,target,gridState)
                neighbourNode.Parent = current
                
                if not open[neighbourID] then
                    addNodeTo(open,neighbourNode)
                    grid:SetHighlight(neighbourNode.Position,true,"OpenColor")
                end
            end
        end
        
        if currentStep == 500 then
            RunService.Heartbeat:Wait()
            currentStep = 0
        end
        currentStep += 1
    end
    warn("NO RESULT! No path to Target!")
end

function GridPathfinding:DrawPath(target,closed,grid)
    local path = {}
    local current = closed[createVec2ID(target)]
    repeat 
        current = current.Parent
        table.insert(path,current)
        grid:SetHighlight(current.Position,true,"PathColor")
    until (current.Parent == nil) 
    return path
end

function GridPathfinding:KnitStart()
    
end


function GridPathfinding:KnitInit()
    
end


return GridPathfinding