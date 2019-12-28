vk = {}

--
-- Config zone
--

vk.Version = '5.103'

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

function vk:Session(token, options)
    local obj = {}
        obj.token = token
        obj.options = options or {}
    
    local api = setmetatable({}, {__index = function(t, kg)
        local group, method, result
        local argList = _newStack()
        
        group = kg
        kg = setmetatable({}, {__index = function(_, km)
            method = km
          
            return setmetatable({}, {__call = function(s, f)
              return {cb = function(this, callb)
                callb = callb or function(...) end
                if not f.v then f.v = vk.Version end

                for k, v in pairs(f) do
                  _addString(argList, k .. '=' .. v .. '&')
                end
                
                local req = string.gsub('https://api.vk.com/method/' .. group .. '.' .. method .. '?' .. _toString(argList) .. 'access_token=' .. obj.token, "%s+", "%%20")
                http.Fetch(req, 
                    function(body)
                        result = obj.options.raw and body or util.JSONToTable(body)
                        
                        callb(result)
                    end,
                    function(error)
                        callb(error)
                end)

                return true
              end}
            end})
        end})
        
        return kg
    end})

    setmetatable(obj, self)
    self.__index = self
    
    return api
end