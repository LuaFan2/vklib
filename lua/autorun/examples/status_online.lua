if SERVER then
    local gid = your_group_id

    local api = vk:Session(token)
    local online, str_online
    
    if not c then
        c = timer.Create("StatusSet", 15, 0, function()
            online = player.GetCount()
            local str_online = "Online: " .. online .. " player(s)"
            
            api.status.set{text = str_online, group_id = gid}:cb()
        end)
    end
end