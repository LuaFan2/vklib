# vk
Functional VK (vk.com) api wrapper for Garry's Mod

## Usage:
- Create VK api object
- Make a request using the created object
- ???
- Profit!

## Examples
## Simple example
```lua

local api = vk:Login(token)

api:Request("groups.isMember", {["group_id"] = 1, ["user_id"] = 1}, function(res)
    print(res.response)
end)

```
```
Output:
0
```
## Example with options
```lua

local api = vk:Login(token)

api:SetOption("raw", true) -- or api:SetOptions({["raw"] = true})

api:Request("groups.isMember", {["group_id"] = 1, ["user_id"] = 1}, function(res)
    print(res)
end)
```
```
Output:
{"response":0}
```