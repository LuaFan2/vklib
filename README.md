# vk
Functional VK (vk.com) api wrapper for Garry's Mod

## Usage:
- Create VK api object
- Make a request using the created object
- ???
- Profit!

## Example

```lua

local api = vk:Login(token)

api:Request("groups.isMember", {["group_id"] = 1, ["user_id"] = 1}, function(res)
    print(res.response)
end)

```