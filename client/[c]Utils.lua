ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent(_Banque.ESX, function(obj) ESX = obj end)
        Citizen.Wait(80)
    end
    TriggerEvent("Banque:blips")
end)

local tablepositionsandblips = _Banque.PositionsBanque
function _Banque.Menu:Main()
    _Banque.Menu.Create()
    RageUI.Visible(_Banque.Menu.main, not RageUI.Visible(_Banque.Menu.main))
	FreezeEntityPosition(PlayerPedId(),true)
    while _Banque.Menu.main do
        Citizen.Wait(0)
        RageUI.IsVisible(_Banque.Menu.main, function()
            _BanqueButton()
        end)
        RageUI.IsVisible(_Banque.Menu.Historique, function()
            _HistoriqueButton()
        end)
        if not RageUI.Visible(_Banque.Menu.main) 
        and not RageUI.Visible(_Banque.Menu.Historique) 
        then 
            _Banque.Menu.main = RMenu:DeleteType("_Banque.Menu.main", true, FreezeEntityPosition(PlayerPedId(),false))
        end
    end
end

local nearObject = false 

function ReloadProps()
    local pCoords = GetEntityCoords(PlayerPedId())
    for k,v in pairs(_Banque.PropsAtm) do
        local closestObject = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.2, GetHashKey(v), false, false)
        if closestObject ~= 0 and closestObject ~= nil then
            nearObject = closestObject
            break
        else
            nearObject = nil
        end
    end
    SetTimeout(1000, function()
        ReloadProps()
    end)
end


CreateThread(function()
    ReloadProps()
    while true do 
        local closetEntity, nearToObject = IsPedSittingInAnyVehicle(PlayerPedId()), false
        if closetEntity ~= 1 then 
            if nearObject ~= nil then
                nearToObject = true 
                ESX.ShowHelpNotification(_Banque.Translations.Menu.HelpNotif)
                if IsControlJustPressed(1, 38) then
                    _Banque.Menu:Main()
                end
            end
        end
        if nearToObject then 
            Wait(1)
        else
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 700
        local playerPos = GetEntityCoords(PlayerPedId())
        for k,v in pairs(tablepositionsandblips) do
            local PositionBanque = vec3(v.pos)
            local dst1 = #(playerPos - PositionBanque)
            if dst1 < 5.0 then
                wait = 0
                DrawMarker(_Banque.Markers.Type, PositionBanque.x, PositionBanque.y, PositionBanque.z, 0, 0, 0, 0, 0, 0, _Banque.Markers.TailleX, _Banque.Markers.TailleY, _Banque.Markers.TailleZ, _Banque.Markers.CouleurR, _Banque.Markers.CouleurG, _Banque.Markers.CouleurB, _Banque.Markers.Opacite, 0, 0, 0, 1, 0, 0, 0)
                if dst1 < 2.0 then
                    ESX.ShowHelpNotification(_Banque.Translations.Menu.HelpNotif)
                    if IsControlJustReleased(1, 38) then
                        _Banque.Menu:Main()
                    end
                end
            end
        end
        Wait(wait)
    end
end)

RegisterNetEvent("Banque:blips")
AddEventHandler("Banque:blips", function()
    for k,v in pairs(tablepositionsandblips) do
        blip = AddBlipForCoord(v.pos.x,v.pos.y,v.pos.z)
        SetBlipSprite(blip, _Banque.Blips.Sprite)
        SetBlipScale(blip, _Banque.Blips.Scale)
        SetBlipColour(blip, _Banque.Blips.Color)
        SetBlipDisplay(blip, _Banque.Blips.Display)
        SetBlipAsShortRange(blip, _Banque.Blips.ShortRange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_Banque.Blips.Name)
        EndTextCommandSetBlipName(blip)
    end
end)

function _Banque.KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end