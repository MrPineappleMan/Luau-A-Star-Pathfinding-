local Tile = {}
Tile.__index = Tile


function Tile.new(pos)
    local self = setmetatable({
        ["Position"] = pos,
        ["Highlighted"] = false,
        ["HighlightColor"] = "DefTileHighlightedColor",
    }, Tile)
    return self
end


function Tile:Destroy()
    
end


return Tile