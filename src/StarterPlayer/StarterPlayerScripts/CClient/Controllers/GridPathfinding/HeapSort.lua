--// This is a very basic implementation of heap sort

local HeapSort = {}
HeapSort.__index = HeapSort


--[[
    Parent = math.floor(n/2)
    Child1 = (2n)
    Child2 = (2n+1)
]]
  
function HeapSort:GetChildrenOf(index)
    local array = self.Array 

    local children = {}

    local leftIndex = 2*index
    local leftVal = array[leftIndex]

    local rightIndex = 2*index+1
    local rightVal = array[rightIndex]

    children[1] = {
        ["Index"] = leftIndex,
        ["Value"] = leftVal or math.huge   
    }
    children[2] = {
        ["Index"] = rightIndex,
        ["Value"] = rightVal or math.huge        
    }
    return children
end

function HeapSort:GetParentOf(index)
    local array = self.Array


    local parentIndex = math.floor(index/2)
    local parentVal = array[parentIndex]

    if parentVal then
        local parent = {}
        parent["Index"] = parentIndex
        parent["Value"] = parentVal
        return parent
    end

    return 
end

function HeapSort:Get(index)
    local array = self.Array

    local val = array[index]

    if val then
        return {
            ["Index"] = index,
            ["Value"] = val,
        }
    end
    return nil
end

function HeapSort:SortUp()
    local array = self.Array

    local current = self:Get(#array) 

    local parent = self:GetParentOf(current.Index)
    if not parent then
        return --// There are no parents, there is one or less indexies
    end
    
    if current.Index > 1 then
        if parent.Value > current.Value then
            repeat       
                self:Swap(current.Index,parent.Index)
         
                current = self:Get(parent.Index)
                parent = self:GetParentOf(parent.Index)

                if not parent then
                    break
                end
            until (parent.Value < current.Value) or (current.Index == 0)
        end 
    end
end

function HeapSort:SortDown()
    local array = self.Array
    if #array == 0 then
        return
    end
    local current = self:Get(1)
    local children = self:GetChildrenOf(current.Index)

    if (current.Value > children[1].Value) or  (current.Value > children[2].Value) then
        repeat
            local smallestIndex = (children[1].Value < children[2].Value) and children[1].Index or children[2].Index
            self:Swap(current.Index,smallestIndex)

            current = self:Get(smallestIndex)
            children = self:GetChildrenOf(smallestIndex)

        until (current.Index == #array) or ((current.Value < children[2].Value) and  ((current.Value < children[1].Value)))
    end
end

function HeapSort:Push(val,node)
    assert(typeof(val) == "number","Value To Be Sorted, Must be a number")
    table.insert(self.Array,val)
    table.insert(self.Values,node)
    self:SortUp()
end

function HeapSort:PopTop()
    local array = self.Array
    local values = self.Values

    array[1] = array[#array]
    array[#array] = nil

    values[1] = values[#values]
    values[#values] = nil
    self:SortDown()
end

function HeapSort:Swap(index1,index2)
    local array = self.Array
    local values = self.Values

    local val1 = array[index1]
    array[index1] = array[index2]
    array[index2] = val1

    local node = values[index1]
    values[index1] = values[index2]
    values[index2] = node
end

function HeapSort.new()
    local self = setmetatable({
        ["Array"] = {},
        ["Values"] = {},
    }, HeapSort)
    return self
end

return HeapSort