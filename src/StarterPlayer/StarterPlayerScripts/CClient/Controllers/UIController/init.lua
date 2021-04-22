local Knit = require(game:GetService("ReplicatedStorage").Knit)

local UserInputService = game:GetService("UserInputService")

local UIController = Knit.CreateController { Name = "UIController" }
UIController.StartPosition = Vector2.new(1,1)
UIController.EndPosition = Vector2.new(2,2)

local Pathfinding 
local SpeedTest

local Roact
local e 
local Grid 

function UIController:SetStart(startPos)
    self.StartPosition = startPos
end

function UIController:SetEnd(endPos)
    self.EndPosition = endPos
end

function UIController:KnitStart()
    local test = require(Knit.Shared.Classes.Grid).new(Vector2.new(100,100))
    Roact.mount(Roact.createElement("ScreenGui",{},{
            ["Grid"] = e(Grid,{Grid = test})
        })
    ,game.Players.LocalPlayer.PlayerGui)
    UserInputService.InputBegan:Connect(function(input,gpe)
        if not gpe then
            if (input.KeyCode == Enum.KeyCode.Return) then
                SpeedTest.TimeFunc(function()
                    Pathfinding:FindPath(self.StartPosition,self.EndPosition,test)
                end)
            elseif input.KeyCode == Enum.KeyCode.One then
                test:ResetHighlight()
            end
        end
    end)
end


function UIController:KnitInit()
    Roact = require(Knit.Shared.Utils.Roact)
    e = Roact.createElement
    Grid = require(script.Components.Grid)

    Pathfinding = require(Knit.Client.Controllers.GridPathfinding)
    SpeedTest = require(Knit.Shared.Utils.SpeedTest)
end


return UIController