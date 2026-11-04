local QBCore = exports['qb-core']:GetCoreObject()
local cooldowns = {}

local function notify(source, message, kind)
    TriggerClientEvent('QBCore:Notify', source, message, kind or 'primary')
end

local function getCharacterName(player)
    local info = player.PlayerData.charinfo or {}
    local first = info.firstname or 'San Andreas'
    local last = info.lastname or 'Resident'
    return (first .. ' ' .. last):sub(1, 60)
end

local function sendCall(source, code, args)
    if not source or source < 1 then return end

    local callConfig = Config.Calls[code]
    local player = QBCore.Functions.GetPlayer(source)
    if not callConfig or not player then return end

    local message = table.concat(args or {}, ' ')
    message = message:gsub('[%c<>]', ''):gsub('%s+', ' ')
    message = message:gsub('^%s+', ''):gsub('%s+$', '')

    if message == '' then
        notify(source, ('Usage: /%s your message'):format(code), 'error')
        return
    end

    if #message > Config.MaxMessageLength then
        message = message:sub(1, Config.MaxMessageLength)
    end

    local now = os.time()
    local nextAllowed = cooldowns[source] or 0
    if now < nextAllowed then
        notify(source, ('Please wait %d seconds before sending another call.'):format(nextAllowed - now), 'error')
        return
    end

    local ped = GetPlayerPed(source)
    if not ped or ped == 0 then
        notify(source, 'Your location could not be read. Try again in a moment.', 'error')
        return
    end

    local recipients, seen = {}, {}
    for _, jobName in ipairs(callConfig.jobs) do
        local onDuty = QBCore.Functions.GetPlayersOnDuty(jobName)
        for _, target in ipairs(onDuty or {}) do
            if target ~= source and not seen[target] then
                seen[target] = true
                recipients[#recipients + 1] = target
            end
        end
    end

    if #recipients == 0 then
        notify(source, 'No matching service units are on duty right now.', 'error')
        return
    end

    local coords = GetEntityCoords(ped)
    local packet = {
        id = ('CZ-%s-%s-%s'):format(code, source, now),
        code = code,
        label = callConfig.label,
        caller = getCharacterName(player),
        message = message,
        coords = { x = coords.x, y = coords.y, z = coords.z },
    }

    cooldowns[source] = now + Config.CooldownSeconds
    for _, target in ipairs(recipients) do
        TriggerClientEvent('cz-dispatch:client:receiveCall', target, packet)
    end

    notify(source, ('Your %s call was sent to %d on-duty unit(s).'):format(code, #recipients), 'success')
    print(('[cz-dispatch] %s call sent by %s to %d unit(s).'):format(code, packet.caller, #recipients))
end

RegisterCommand('911', function(source, args)
    sendCall(source, '911', args)
end, false)

RegisterCommand('311', function(source, args)
    sendCall(source, '311', args)
end, false)

AddEventHandler('playerDropped', function()
    cooldowns[source] = nil
end)
