local Weather, noSync = {}, false

AddEventHandler('playerSpawned', function()
    local h, m, s = NetworkGetGlobalMultiplayerClock()
    NetworkOverrideClockTime(h, m, s)
    TriggerServerEvent('XC-weathersync:server:requestSync')
end)

RegisterNetEvent('XC-weathersync:client:updateWeer')
AddEventHandler('XC-weathersync:client:updateWeer', function(weather)
    Weather.UpdateWeer(weather)
end)

exports('toggleSync', function(bool)
    if not bool then
        noSync = not noSync
    else
        noSync = bool
    end
    if noSync then
        SetWeatherTypeOverTime('EXTRASUNNY', 15.0)
        SetWeatherTypePersist('EXTRASUNNY')
    else
        TriggerServerEvent('XC-weathersync:server:requestSync')
    end
end)

Weather.UpdateWeer = function(weather)
    if not noSync then
        SetWeatherTypeOverTime(weather, 15.0)
        SetWeatherTypePersist(weather)
    end
end