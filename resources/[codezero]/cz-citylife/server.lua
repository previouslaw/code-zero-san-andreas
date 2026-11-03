local QBCore = exports['qb-core']:GetCoreObject()
local activeRoutes = {}
local completedAt = {}

local function notify(source, message, kind)
    TriggerClientEvent('QBCore:Notify', source, message, kind or 'primary')
end

local function isNear(source, location, radius)
    local ped = GetPlayerPed(source)
    if not ped or ped == 0 then return false end

    local target = vector3(location.x, location.y, location.z)
    local playerCoords = GetEntityCoords(ped)
    return #(playerCoords - target) <= radius
end

RegisterNetEvent('cz-citylife:server:startRoute', function()
    local source = source
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return end

    if activeRoutes[source] then
        notify(source, 'You already have a courier route in progress.', 'error')
        return
    end

    if not isNear(source, Config.Dispatcher.coords, Config.StartRadius) then
        notify(source, 'Start the route with the City Hall courier clerk.', 'error')
        return
    end

    local now = os.time()
    local lastCompleted = completedAt[source] or 0
    local remaining = Config.RouteCooldownSeconds - (now - lastCompleted)
    if remaining > 0 then
        notify(source, ('The courier board will be ready again in %d seconds.'):format(remaining), 'error')
        return
    end

    activeRoutes[source] = {
        index = 1,
        startedAt = now,
        lastStopAt = now,
    }

    notify(source, 'Courier route accepted. Follow the GPS and hand over each parcel.', 'success')
    TriggerClientEvent('cz-citylife:client:routeUpdate', source, 1, #Config.DeliveryStops)
end)

RegisterNetEvent('cz-citylife:server:completeStop', function()
    local source = source
    local route = activeRoutes[source]
    local player = QBCore.Functions.GetPlayer(source)
    if not route or not player then
        notify(source, 'You do not have a courier route in progress.', 'error')
        return
    end

    local now = os.time()
    if now - route.startedAt > Config.MaxRouteSeconds then
        activeRoutes[source] = nil
        notify(source, 'Your courier route expired. Start a new route at City Hall.', 'error')
        TriggerClientEvent('cz-citylife:client:routeCancelled', source)
        return
    end

    local elapsed = now - route.lastStopAt
    if elapsed < Config.MinSecondsBetweenStops then
        notify(source, ('Wait %d more seconds before handing over the parcel.'):format(Config.MinSecondsBetweenStops - elapsed), 'error')
        return
    end

    local stop = Config.DeliveryStops[route.index]
    if not stop then
        activeRoutes[source] = nil
        notify(source, 'The route data was reset. Please start again at City Hall.', 'error')
        TriggerClientEvent('cz-citylife:client:routeCancelled', source)
        return
    end

    if not isNear(source, stop.coords, Config.StopRadius) then
        notify(source, 'You need to be at the marked delivery point.', 'error')
        return
    end

    route.lastStopAt = now
    player.Functions.AddMoney('cash', Config.PayoutPerStop, 'cz-citylife-courier-stop')
    route.index = route.index + 1

    if route.index > #Config.DeliveryStops then
        activeRoutes[source] = nil
        completedAt[source] = now
        player.Functions.AddMoney('cash', Config.CompletionBonus, 'cz-citylife-courier-complete')
        notify(source, ('All parcels delivered. You earned $%d in stop pay and a $%d completion bonus.'):format(
            Config.PayoutPerStop * #Config.DeliveryStops,
            Config.CompletionBonus
        ), 'success')
        TriggerClientEvent('cz-citylife:client:routeFinished', source)
        return
    end

    notify(source, ('Parcel delivered. $%d paid. Continue to the next stop.'):format(Config.PayoutPerStop), 'success')
    TriggerClientEvent('cz-citylife:client:routeUpdate', source, route.index, #Config.DeliveryStops)
end)

RegisterNetEvent('cz-citylife:server:cancelRoute', function()
    local source = source
    if not activeRoutes[source] then
        notify(source, 'You do not have a courier route to cancel.', 'error')
        return
    end

    activeRoutes[source] = nil
    notify(source, 'Courier route cancelled. No more route payments will be made.', 'primary')
    TriggerClientEvent('cz-citylife:client:routeCancelled', source)
end)

AddEventHandler('playerDropped', function()
    activeRoutes[source] = nil
    completedAt[source] = nil
end)
