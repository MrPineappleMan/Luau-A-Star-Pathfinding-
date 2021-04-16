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

local function createNode(current: Vector2,orig: Vector2, target: Vector2)
    return {
        fCost = dist(current,orig) + dist(current,target) -- G cost + H Cost 
    }
end

local function createVec2ID(target: Vector2)
    return string.format("%d,%d",target.X,target.Y)
end

function GridPathfinding:FindPath(orig: Vector2, target: Vector2,grid: Grid)
    local open = {}
    local closed = {}
    local current = orig
    open[createVec2ID(current)] = createNode(current, orig, target) 

    local currentStep = 0
    while true do

--[[
        current = node in OPEN with the lowest f_cost
        remove current from OPEN
        add current to CLOSED]]

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