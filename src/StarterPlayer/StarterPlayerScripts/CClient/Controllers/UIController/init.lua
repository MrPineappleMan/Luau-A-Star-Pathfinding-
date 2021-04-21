local Knit = require(game:GetService("ReplicatedStorage").Knit)

local UIController = Knit.CreateController { Name = "UIController" }

local Pathfinding 
local SpeedTest

local Roact
local e 
local Grid 

function UIController:KnitStart()
    local test = require(Knit.Shared.Classes.Grid).new(Vector2.new(100,100))
    Roact.mount(Roact.createElement("ScreenGui",{},{
            ["Grid"] = e(Grid,{Grid = test})
        })
    ,game.Players.LocalPlayer.PlayerGui)
    for i = 1,8 do
        warn(string.format("Waiting... %d",i))
        wait(1)
    end
    SpeedTest.TimeFunc(function()
        Pathfinding:FindPath(Vector2.new(1,1),Vector2.new(100,100),test)
    end)
end


function UIController:KnitInit()
    Roact = require(Knit.Shared.Utils.Roact)
    e = Roact.createElement
    Grid = require(script.Components.Grid)

    Pathfinding = require(Knit.Client.Controllers.GridPathfinding)
    SpeedTest = require(Knit.Shared.Utils.SpeedTest)
    warn(SpeedTest)
end


return UIController