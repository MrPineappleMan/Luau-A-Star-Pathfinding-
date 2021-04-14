local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Rodux = require(Knit.Shared.Utils.Rodux)

local Reducers = require(script.Reducers)

local reducer = Rodux.createReducer(nil,Reducers)

local GridStore = {}

function GridStore.new(initState)
    return Rodux.Store.new(reducer,initState)
end

return GridStore