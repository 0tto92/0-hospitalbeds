ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function LoadAnimDict(d)
    while (not HasAnimDictLoaded(d)) do
        RequestAnimDict(d)
        Wait(100)
    end
end

local function Text(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function LayOnBed(k, v)
    if k and v then
        if not v.busy then
            Config.beds[k]["busy"] = true
            TriggerServerEvent('0-hospitalbeds:busy', k, true)
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(), true)
            DoScreenFadeOut(2000)
            Wait(2500)
            SetEntityCoords(PlayerPedId(), v.pos.x, v.pos.y, v.pos.z - 1.0)
            SetEntityHeading(PlayerPedId(), v.pos.w)
            LoadAnimDict("missfbi5ig_0")
            TaskPlayAnim(PlayerPedId(), "missfbi5ig_0", "lyinginpain_loop_steve" ,3.0, 3.0, -1, 1, 0, false, false, false)
            Wait(2500)
            DoScreenFadeIn(1500)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "healing_process",
                duration = Config.settings["healing_time"] * 100,
                label = Config.locale["progress_label"],
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "",
                    anim = "",
                },
                prop = {
                    model = "",
                }
            }, function(status)
                if not status then
                    ClearPedTasks(PlayerPedId())
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerEvent('mythic_notify:client:SendAlert', { type = 'success', length = 4000, text = 'Sinut parannettiin' })
                    Config.beds[k]["busy"] = false
                    TriggerServerEvent('0-hospitalbeds:busy', k, false)
                    if Config.SkeletalSystem then
                        TriggerEvent('MF_SkeletalSystem:HealBones', "all")
                        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + Config.settings["heal_amount"])
                    else
                        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + Config.settings["heal_amount"])
                    end
                end
            end)
        end
    end
end

CreateThread(function()
    Wait(1000)
    while true do
        local wait = 1500
        for k, v in pairs(Config.beds) do
            if #(GetEntityCoords(PlayerPedId()) - vector3(v.pos.x, v.pos.y, v.pos.z)) < 3.0 then
		wait = 0
                if not v.busy then
                    DrawMarker(2, v.pos.x, v.pos.y, v.pos.z - 0.50, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.1, 255, 255, 255, 150, true, true, 5, nil, nil, false)
                    if #(GetEntityCoords(PlayerPedId()) - vector3(v.pos.x, v.pos.y, v.pos.z)) < 1.65 then
                        Text(v.pos.x, v.pos.y, v.pos.z - 0.25, Config.locale["enter_bed"])
                        if IsControlJustPressed(0, 38) then
                            LayOnBed(k, v)
                        end
                    end
                end
            end
        end
        Wait(wait)
    end
end)

RegisterNetEvent('0-hospital:busystate', function(bed, boolean)
    if bed and boolean then
        Config.beds[bed]["busy"] = boolean
    end
end)



