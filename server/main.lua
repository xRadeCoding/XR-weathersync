ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local currentWeather = "EXTRASUNNY"

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3600000)
        --[[
            
        local chance = math.random(0, 100)
            
        if chance < 5 then
            currentWeather = "THUNDER"
        elseif chance > 5 and chance < 15 then
            currentWeather = "RAIN"
        elseif chance > 15  and chance < 50 then
            currentWeather = "OVERCAST"
        elseif chance > 50 then
            currentWeather = "EXTRASUNNY"
        end
        ]]

        TriggerClientEvent('XC-weathersync:client:updateWeer', -1, currentWeather)
    end
end)

RegisterServerEvent('XC-weathersync:server:requestSync')
AddEventHandler('XC-weathersync:server:requestSync', function()
    TriggerClientEvent('XC-weathersync:client:updateWeer', source, currentWeather)
end)

RegisterCommand('setweather', function(source, args, rawCommand)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.group ~= 'superadmin' then
        currentWeather = args[1]
        TriggerClientEvent('XC-weathersync:client:updateWeer', -1, currentWeather)
    end
end, false)