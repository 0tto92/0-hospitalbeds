ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('0-hospitalbeds:busy', function(bed, boolean)
    if bed and boolean then
        TriggerClientEvent('0-hospital:busystate', -1, bed, boolean)
    end
end)
