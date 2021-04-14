local Knit = require(game:GetService("ReplicatedStorage").Knit)

local UIController = Knit.CreateController { Name = "UIController" }


function UIController:KnitStart()
    local test = require(Knit.Shared.Classes.Grid).new(Vector2.new(10,10))
    print(test)
end


function UIController:KnitInit()
    
end


return UIController