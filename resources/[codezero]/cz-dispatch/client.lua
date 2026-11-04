local QBCore = exports['qb-core']:GetCoreObject()
local callBlips = {}

local function removeCallBlips(id)
    local blips = callBlips[id]
    if not blips then return end

    if blips.point and DoesBlipExist(blips.point) then
        RemoveBlip(blips.point)
    end
    if blips.radius and DoesBlipExist(blips.radius) then
        RemoveBlip(blips.radius)
    end

    callBlips[id] = nil
end

RegisterNetEvent('cz-dispatch:client:receiveCall', function(packet)
    if type(packet) ~= 'table' or type(packet.coords) ~= 'table' then return end

    local x, y, z = tonumber(packet.coords.x), tonumber(packet.coords.y), tonumber(packet.coords.z)
    if not x or not y or not z then return end

    local id = tostring(packet.id or GetGameTimer())
    removeCallBlips(id)

    local callConfig = Config.Calls[packet.code] or {}
    local colour = callConfig.color or 1
    local point = AddBlipForCoord(x, y, z)
    SetBlipSprite(point, callConfig.sprite or 280)
    SetBlipColour(point, colour)
    SetBlipScale(point, 0.85)
    SetBlipAsShortRange(point, false)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(('%s call - %s'):format(packet.code or 'Service', packet.caller or 'Resident'))
    EndTextCommandSetBlipName(point)

    local radius = AddBlipForRadius(x, y, z, Config.BlipRadius)
    SetBlipColour(radius, colour)
    SetBlipAlpha(radius, 90)
    callBlips[id] = { point = point, radius = radius }

    QBCore.Functions.Notify(
        ('%s call from %s: %s'):format(packet.code or 'Service', packet.caller or 'Resident', packet.message or ''),
        'primary',
        10000
    )

    CreateThread(function()
        Wait(Config.BlipDurationMs)
        removeCallBlips(id)
    end)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    for id in pairs(callBlips) do
        removeCallBlips(id)
    end
end)
