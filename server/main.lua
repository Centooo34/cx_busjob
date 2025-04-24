RegisterNetEvent('cx:addMoney', function(count)
    local src = source
    exports.ox_inventory:AddItem(src, 'money', count)
end)


Citizen.CreateThread( function()
    updatePath = "/Centooo34/cx_busjob" 
    resourceName = "CX_busjob ("..GetCurrentResourceName()..")" 
    
    function checkVersion(err,responseText, headers)
        curVersion = LoadResourceFile(GetCurrentResourceName(), "version")
    
        if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
            print("\n###############################")
            print("\n"..resourceName.." is outdated, should be:\n"..responseText.."is:\n"..curVersion.."\nplease update it from https://github.com"..updatePath.."")
            print("\n###############################")
        elseif tonumber(curVersion) > tonumber(responseText) then
            print("You somehow skipped a few versions of "..resourceName.." or the git went offline, if it's still online i advise you to update ( or downgrade? )")
        else
            print("\n"..resourceName.." is up to date, have fun!")
        end
    end
    
    PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/version", checkVersion, "GET")
    end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        Wait(1000)
        TriggerClientEvent("busjob:spawnPed", -1)
    end
end)
