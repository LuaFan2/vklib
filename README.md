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

local api = vk:Session(token)

api.groups.isMember{group_id = 1, user_id = 1}:cb(function(res)
    print(res.response)
end)
```
```
Output:
0
```
## Example with options
```lua
local api = vk:Session(token, {raw = true, version = 5.42})

api.groups.isMember{group_id = 1, user_id = 1}:cb(function(res)
    print(res)
end)
```
```
Output:
{"response":0}
```

## TODO

- Creating a session using login and password
