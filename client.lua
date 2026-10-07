-- /a_back_pack_with_a_cat_in_it — put one down where you stand. "/a_back_pack_with_a_cat_in_it undo" removes the last one.
-- Added by THE ORB Studio's 3D Model → FiveM. Delete this file (and the
-- client_script line in fxmanifest.lua) if you place props another way.
local placed = {}

RegisterCommand("a_back_pack_with_a_cat_in_it", function(_, args)
    if args[1] == "undo" then
        local last = table.remove(placed)
        if last and DoesEntityExist(last) then DeleteEntity(last) end
        return
    end
    local model = `a_back_pack_with_a_cat_in_it`
    RequestModel(model)
    local tries = 0
    while not HasModelLoaded(model) and tries < 200 do Wait(10) tries = tries + 1 end
    if not HasModelLoaded(model) then return end
    local ped = PlayerPedId()
    local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.5, 0.0)
    local obj = CreateObject(model, pos.x, pos.y, pos.z, true, false, false)
    PlaceObjectOnGroundProperly(obj)
    SetEntityHeading(obj, GetEntityHeading(ped))
    FreezeEntityPosition(obj, true)
    SetModelAsNoLongerNeeded(model)
    placed[#placed + 1] = obj
end, false)
