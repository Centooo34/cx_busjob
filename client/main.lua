local stopsDone = 0
local isWorking = false
local currentBlip = nil
local selectedStop = nil
local prewStops = {}
local stops = Config.Stops
local vehicleOut = false

local function spawnWorkCar()
    if vehicleOut then
        return
    end
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    vehicleModel = GetHashKey("bus")
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Citizen.Wait(500)
    end

    local spawnCoords = Config.CarSpawn
    local vehicleHandle = GetClosestVehicle(spawnCoords.x, spawnCoords.y, spawnCoords.z, 5.0, 0, 70)

    if vehicleHandle == 0 then 
        vehicle = CreateVehicle(vehicleModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w, true, false)
        SetVehicleNumberPlateText(vehicle, "BUS"..math.random(1000, 9999))
        vehicleOut = true
        lib.notify({ title = Config.Locales.Brigade, description = Config.Locales.BusReady})
    else
        lib.notify({ title = Config.Locales.Brigade, description = Config.Locales.SpawnFull})
    end
end

local function selectStop()
    if #prewStops >= #stops then prewStops = {} end
    local newStop
    local isDuplicate
    repeat
        newStop = stops[math.random(1, #stops)]
        isDuplicate = false
        for i = 1, #prewStops do
            local stop = prewStops[i]
            if stop.x == newStop.x and stop.y == newStop.y and stop.z == newStop.z then
                isDuplicate = true
                break
            end
        end
    until not isDuplicate
    selectedStop = newStop
    table.insert(prewStops, selectedStop)
    if currentBlip then RemoveBlip(currentBlip) end
    currentBlip = AddBlipForCoord(selectedStop.x, selectedStop.y, selectedStop.z)
    SetBlipSprite(currentBlip, 280)
    SetBlipColour(currentBlip, 3)
    SetBlipScale(currentBlip, 1.0)
    SetBlipRoute(currentBlip, true)
    SetBlipRouteColour(currentBlip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Autobusová zastávka")
    EndTextCommandSetBlipName(currentBlip)
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if selectedStop then
            DrawMarker(1, selectedStop.x, selectedStop.y, selectedStop.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, false, 2, false, nil, nil, false)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if isWorking and stopsDone <= #stops then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            if vehicle ~= 0 and GetEntityModel(vehicle) == GetHashKey("bus") then
                local vehicleCoords = GetEntityCoords(vehicle)
                if GetDistanceBetweenCoords(selectedStop, vehicleCoords, true) < 4.5 then
                    FreezeEntityPosition(vehicle, true)
                    if lib.progressBar({
                        duration = 10000,
                        label = Config.Locales.Wait,
                        useWhileDead = false,
                        canCancel = false,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                        },
                    }) then
                        FreezeEntityPosition(vehicle, false)
                        stopsDone = stopsDone + 1
                        if stopsDone == #stops then
                            lib.notify({ title = Config.Locales.Brigade, description = Config.Locales.Complete})
                            selectedStop = nil
                            SetWaypointOff()
                            if currentBlip then
                                RemoveBlip(currentBlip)
                                currentBlip = nil
                            end
                            SetNewWaypoint(436.470336, -640.338440)
                        else
                            selectStop()
                            lib.notify({ title = Config.Locales.Brigade, description = Config.Locales.NextStop})
                        end
                    end
                end
            end
        end
    end
end)



lib.registerContext({
    id = "busjob",
    title = Config.Locales.Brigade,
    options = {
        {
            title = Config.Locales.StartWork,
            icon = "fa-solid fa-user-check",
            onSelect = function()
                if isWorking then
                    lib.notify({ title = Config.Locales.Brigade, description = Config.Locales.AlredyWorking })
                    return
                end
                isWorking = true
                spawnWorkCar()
                selectStop()
                lib.notify({ title = Config.Locales.Brigade, description = Config.Locales.StartedWorking })
            end
        },
        {
            title = Config.Locales.StopWorking,
            icon = "fa-solid fa-user-minus",
            onSelect = function()
                if not isWorking then
                    lib.notify({ title = Config.Locales.Brigade, description = Config.Locales.NotWorking })
                    return
                end
                isWorking = false
                vehicleOut = false
                selectedStop = nil
                lib.notify({ title = Config.Locales.Brigade, description = Config.Locales.WorkEnded })
                DeleteVehicle(vehicle)
            end
        },
        {
            title = Config.Locales.CollectIncome,
            icon = "fa-solid fa-money-bills",
            onSelect = function()
                if stopsDone == 0 then
                    lib.notify({ title = Config.Locales.Brigade, description = Config.Locales.NoIncome })
                    return
                end
                local moneyPerStop = Config.MoneyPerStop
                local money = moneyPerStop * stopsDone
                TriggerServerEvent("cx:addMoney", money)
                lib.notify({ title = Config.Locales.Brigade, description = Config.Locales.Income })
                stopsDone = 0
            end
        },
        {
            title = Config.Locales.GuideBook,
            icon = "fa-solid fa-clipboard",
            onSelect = function()
                lib.alertDialog({
                    header = Config.Locales.GuideBook,
                    content = Config.Locales.GuideBookContent
                })
            end
        },
    }
})

local pedModel = "s_m_m_gentransport"
local coords = vector3(436.470336, -640.338440, 27.723754)
local heading = 90.0

CreateThread(function()
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do Wait(0) end
    local ped = CreatePed(0, pedModel, coords.x, coords.y, coords.z, heading, true, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    local netId = NetworkGetNetworkIdFromEntity(ped)
    exports.ox_target:addEntity(netId, {{
        label = "Začať prácu",
        icon = "fa-solid fa-bus",
        onSelect = function()
            lib.showContext("busjob")
        end
    }})
end)


if Config.UseBlip then
    local coords = vector3(436.470336, -640.338440, 28.723754)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 513)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip)
    EndTextCommandSetBlipName(blip)
end
