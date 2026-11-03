local QBCore = exports['qb-core']:GetCoreObject()
local lastReportAt = {}

local function sendNotification(playerId, message, kind, duration)
    TriggerClientEvent('czs_basics:client:notify', playerId, message, kind, duration)
end

RegisterCommand('czevent', function(sourceId, args)
    if sourceId > 0 and not IsPlayerAceAllowed(sourceId, 'czs.staff') then
        sendNotification(sourceId, 'Only server staff can announce events.', 'error', 5000)
        return
    end

    local message = table.concat(args, ' '):gsub('[%c]', ' '):gsub('%s+', ' '):gsub('^%s+', ''):gsub('%s+$', '')
    if message == '' then
        if sourceId > 0 then
            sendNotification(sourceId, 'Use /czevent followed by the event details.', 'error', 5000)
        else
            print('[CZS] Usage: czevent <message>')
        end
        return
    end

    if #message > 200 then
        message = message:sub(1, 200)
    end

    print(('[CZS EVENT] %s'):format(message))
    for _, player in ipairs(GetPlayers()) do
        TriggerClientEvent('czs_basics:client:eventAnnouncement', tonumber(player), message)
    end
end, false)

RegisterNetEvent('czs_basics:server:submitReport', function(rawMessage)
    local sourceId = source

    if type(rawMessage) ~= 'string' then
        return
    end

    local now = os.time()
    local previous = lastReportAt[sourceId] or 0
    if now - previous < Config.ReportCooldownSeconds then
        local remaining = Config.ReportCooldownSeconds - (now - previous)
        sendNotification(sourceId, ('Please wait %s seconds before sending another report.'):format(remaining), 'error', 5000)
        return
    end

    local message = rawMessage:gsub('[%c]', ' '):gsub('%s+', ' '):gsub('^%s+', ''):gsub('%s+$', '')
    if message == '' then
        sendNotification(sourceId, 'Your report was empty. Add a short message and try again.', 'error', 5000)
        return
    end

    if #message > Config.ReportMaxLength then
        message = message:sub(1, Config.ReportMaxLength)
    end

    lastReportAt[sourceId] = now
    local playerName = GetPlayerName(sourceId) or 'Unknown player'
    print(('[CZS /report] %s (ID %s): %s'):format(playerName, sourceId, message))

    local staffOnline = false
    for _, player in ipairs(GetPlayers()) do
        local targetId = tonumber(player)
        if targetId and IsPlayerAceAllowed(targetId, 'czs.staff') then
            staffOnline = true
            TriggerClientEvent('czs_basics:client:reportReceived', targetId, playerName, sourceId, message)
        end
    end

    if staffOnline then
        sendNotification(sourceId, 'Your report was sent to online staff.', 'success', 5000)
    else
        sendNotification(sourceId, 'Your report was saved in the server console for staff to review.', 'success', 7000)
    end
end)

AddEventHandler('playerDropped', function()
    lastReportAt[source] = nil
end)

