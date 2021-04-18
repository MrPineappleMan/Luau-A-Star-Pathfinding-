local Knit = require(game:GetService("ReplicatedStorage").Knit)

local UIController = Knit.CreateController { Name = "UIController" }

local Roact
local e 
local Grid 

function UIController:KnitStart()
    Roact = require(Knit.Shared.Utils.Roact)
    e = Roact.createElement
    Grid = require(script.Components.Grid)

    local test = require(Knit.Shared.Classes.Grid).new(Vector2.new(100,100))
    Roact.mount(Roact.createElement("ScreenGui",{},{
            ["Grid"] = e(Grid,{Grid = test})
        })
    ,game.Players.LocalPlayer.PlayerGui)
end


function UIController:KnitInit()
    
end


return UIController