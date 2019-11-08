vk = {}

--
-- Config zone
--

vk.Version = '5.103'

--
--

--
-- Help functions
--

local function _newStack ()
    return {''}   -- starts with an empty string
end
    
local function _addString (stack, s)
    table.insert(stack, s)    -- push 's' into the the stack
    for i=table.getn(stack)-1, 1, -1 do
        if string.len(stack[i]) > string.len(stack[i+1]) then
            break
        end
        stack[i] = stack[i] .. table.remove(stack)
    end
end

local function _toString(t)
    return table.concat(t)
end

--
--

function vk:Login(token)
    local obj = {}
        obj.token = token
        obj.options = {}
    local result
    
    function obj:SetOption(k, v)
        if not type(k) == "string" and not type(v) == "string" or not type(v) == "boolean" then return false end
        
        self.options[k] = v
        return true
    end
    
    function obj:SetOptions(t)
        if type(t) ~= "table" then return false end
        
        self.options = t
        return true
    end
    
    function obj:Request(name, args, cb, cbe)
        local argList = _newStack()
        
        local version = args.v and args.v or vk.Version
        
        for k, v in pairs(args) do
            _addString(argList, k .. '=' .. v .. '&')
        end
        
        http.Fetch('https://api.vk.com/method/' .. name .. '?' .. _toString(argList) .. 'v=' .. version .. '&access_token=' .. self.token, 
            function(body)
                result = self.options.raw and body or util.JSONToTable(body)
                
                cb(result)
            end,
            function(error) 
                local cbe = cbe and cbe(error) or print("HTTP Error | " .. error)
        end)
    end
    
    setmetatable(obj, self)
    self.__index = self
    
    return obj
end