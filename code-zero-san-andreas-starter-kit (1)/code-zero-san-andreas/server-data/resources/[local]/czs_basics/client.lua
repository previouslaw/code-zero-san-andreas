local QBCore = exports['qb-core']:GetCoreObject()

local function notify(message, kind, duration)
    QBCore.Functions.Notify(message, kind or 'primary', duration or 5000)
end

RegisterNetEvent('czs_basics:client:notify', function(message, kind, duration)
    notify(message, kind, duration)
end)

RegisterNetEvent('czs_basics:client:reportReceived', function(playerName, serverId, message)
    notify(('Report from %s (ID %s): %s'):format(playerName, serverId, message), 'primary', 10000)
end)

RegisterNetEvent('czs_basics:client:eventAnnouncement', function(message)
    notify(('Community event: %s'):format(message), 'success', 10000)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    SetTimeout(2500, function()
        notify(Config.WelcomeMessage, 'success', 8000)
    end)
end)

RegisterCommand('czshelp', function()
    notify('Commands: /rules, /discord, /serverinfo, /report <message>. Staff: /czevent <message>.', 'primary', 9000)
end, false)

RegisterCommand('rules', function()
    CreateThread(function()
        for _, rule in ipairs(Config.Rules) do
            notify(rule, 'primary', 5500)
            Wait(1200)
        end
    end)
end, false)

RegisterCommand('discord', function()
    if Config.DiscordInvite == nil or Config.DiscordInvite == '' then
        notify('The Discord invite has not been added yet.', 'error', 6000)
        return
    end

    notify(('Join the community: %s'):format(Config.DiscordInvite), 'primary', 8000)
end, false)

RegisterCommand('serverinfo', function()
    notify(Config.ServerName, 'primary', 5000)
    SetTimeout(1000, function()
        notify(Config.ServerDescription, 'primary', 7000)
    end)
end, false)

RegisterCommand('report', function(_, args)
    local message = table.concat(args, ' '):gsub('^%s+', ''):gsub('%s+$', '')

    if message == '' then
        notify('Use /report followed by a short message.', 'error', 6000)
        return
    end

    if #message > Config.ReportMaxLength then
        notify(('Keep the report under %s characters.'):format(Config.ReportMaxLength), 'error', 6000)
        return
    end

    TriggerServerEvent('czs_basics:server:submitReport', message)
end, false)

