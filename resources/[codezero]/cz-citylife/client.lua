local QBCore = exports['qb-core']:GetCoreObject()
local clerk
local routeBlip
local activeRoute = false
local currentStop
local actionPending = false
local actionPendingUntil = 0

local function notify(message, kind)
    QBCore.Functions.Notify(message, kind or 'primary')
end

local function removeRouteBlip()
    if routeBlip and DoesBlipExist(routeBlip) then
        RemoveBlip(routeBlip)
    end
    routeBlip = nil
end

local function drawText3D(coords, text)
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 230)
    SetTextCentre(true)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

local function spawnClerk()
    local model = joaat(Config.Dispatcher.model)
    RequestModel(model)

    local timeoutAt = GetGameTimer() + 10000
    while not HasModelLoaded(model) and GetGameTimer() < timeoutAt do
        Wait(50)
    end

    if not HasModelLoaded(model) then
        print('[cz-citylife] Could not load the courier clerk ped model.')
        return
    end

    local coords = Config.Dispatcher.coords
    clerk = CreatePed(4, model, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
    SetEntityAsMissionEntity(clerk, true, false)
    SetBlockingOfNonTemporaryEvents(clerk, true)
    SetEntityInvincible(clerk, true)
    FreezeEntityPosition(clerk, true)
    SetModelAsNoLongerNeeded(model)
end

RegisterNetEvent('cz-citylife:client:routeUpdate', function(index, total)
    local stopIndex = tonumber(index)
    local stop = stopIndex and Config.DeliveryStops[stopIndex]
    if not stop then return end

    activeRoute = true
    currentStop = stopIndex
    actionPending = false
    removeRouteBlip()

    routeBlip = AddBlipForCoord(stop.coords.x, stop.coords.y, stop.coords.z)
    SetBlipSprite(routeBlip, 501)
    SetBlipColour(routeBlip, 3)
    SetBlipScale(routeBlip, 0.85)
    SetBlipRoute(routeBlip, true)
    SetBlipRouteColour(routeBlip, 3)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(('Code Zero courier - stop %d/%d'):format(stopIndex, tonumber(total) or #Config.DeliveryStops))
    EndTextCommandSetBlipName(routeBlip)

    notify(('GPS set to %s.'):format(stop.label), 'primary')
end)

RegisterNetEvent('cz-citylife:client:routeFinished', function()
    activeRoute = false
    currentStop = nil
    actionPending = false
    removeRouteBlip()
    notify('Route complete. Return to City Hall when you are ready for another run.', 'success')
end)

RegisterNetEvent('cz-citylife:client:routeCancelled', function()
    activeRoute = false
    currentStop = nil
    actionPending = false
    removeRouteBlip()
    notify('Courier route ended.', 'primary')
end)

RegisterCommand('cancelroute', function()
    if not activeRoute then
        notify('You do not have a courier route in progress.', 'error')
        return
    end

    actionPending = true
    actionPendingUntil = GetGameTimer() + 4000
    TriggerServerEvent('cz-citylife:server:cancelRoute')
end, false)

CreateThread(function()
    spawnClerk()

    while true do
        local waitMs = 1000
        if actionPending and GetGameTimer() >= actionPendingUntil then
            actionPending = false
        end

        local playerCoords = GetEntityCoords(PlayerPedId())
        if activeRoute and currentStop and Config.DeliveryStops[currentStop] then
            local stop = Config.DeliveryStops[currentStop]
            local distance = #(playerCoords - stop.coords)
            if distance < 12.0 then
                waitMs = 0
                drawText3D(stop.coords + vector3(0.0, 0.0, 1.05), ('%s - press [E] to deliver'):format(stop.label))
                if distance <= Config.InteractionDistance and IsControlJustReleased(0, 38) and not actionPending then
                    actionPending = true
                    actionPendingUntil = GetGameTimer() + 4000
                    TriggerServerEvent('cz-citylife:server:completeStop')
                end
            end
        elseif not activeRoute then
            local clerkCoords = vector3(Config.Dispatcher.coords.x, Config.Dispatcher.coords.y, Config.Dispatcher.coords.z)
            local distance = #(playerCoords - clerkCoords)
            if distance < 12.0 then
                waitMs = 0
                drawText3D(clerkCoords + vector3(0.0, 0.0, 1.2), 'Code Zero Courier Board - press [E] to start')
                if distance <= Config.InteractionDistance and IsControlJustReleased(0, 38) and not actionPending then
                    actionPending = true
                    actionPendingUntil = GetGameTimer() + 4000
                    TriggerServerEvent('cz-citylife:server:startRoute')
                end
            end
        end

        Wait(waitMs)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    removeRouteBlip()
    if clerk and DoesEntityExist(clerk) then
        DeleteEntity(clerk)
    end
end)
