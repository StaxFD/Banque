function _BanqueButton()
    ESX.PlayerData = ESX.GetPlayerData()
    RageUI.Separator("Nom du compte : ~o~"..GetPlayerName(PlayerId()))
    for key, value in pairs(ESX.PlayerData.accounts) do 
        if value.name == "bank" then 
            RageUI.Separator(("Argent en banque : ~b~%s$"):format(value.money))
        end
    end
    RageUI.Button("Déposer", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
        onSelected = function()
            local number = _Banque.KeyboardInput("MONTANT", "", 5)
            if tonumber(number) == 0 or tonumber(number) == nil then
                ESX.ShowNotification("Vous devez entrer un numéro valide")
            else
                TriggerServerEvent(("%s:Deposer_"):format(_Banque.Event.Prefix), tonumber(number))
                TriggerServerEvent(("%s:InsertHistorique_"):format(_Banque.Event.Prefix), "[~g~+~s~] - ~g~Dépot~s~", tonumber(number))
                Wait(100)
                ESX.PlayerData = ESX.GetPlayerData()
            end

        end,
    })
    RageUI.Button("Retirer", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
        onSelected = function()
            local number = _Banque.KeyboardInput("MONTANT", "", 5)
            if tonumber(number) == 0 or tonumber(number) == nil then
                ESX.ShowNotification("Vous devez entrer un numéro valide")
            else
                TriggerServerEvent(("%s:Retirer_"):format(_Banque.Event.Prefix), tonumber(number))
                TriggerServerEvent(("%s:InsertHistorique_"):format(_Banque.Event.Prefix), "[~r~-~s~] - ~r~Retrait~s~", tonumber(number))
                Wait(100)
                ESX.PlayerData = ESX.GetPlayerData()
            end
        end,
    })
    RageUI.Button("Transférer de l'argent", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
        onSelected = function()
            local ID = _Banque.KeyboardInput("ID DU JOUEUR", "", 5)
            local number = _Banque.KeyboardInput("MONTANT", "", 5)
            if tonumber(number) == 0 and tonumber(ID) or tonumber(number) == nil and tonumber(ID) == nil then
                ESX.ShowNotification("Vous devez entrer un numéro valide")
            else
                TriggerServerEvent(("%s:VerifTransferer_"):format(_Banque.Event.Prefix), tonumber(number), tonumber(ID))
            end
        end,
    })
    RageUI.Button("Historique des transactions", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
        onSelected = function()
            TriggerServerEvent(("%s:Historique_"):format(_Banque.Event.Prefix))
            RageUI.Visible(_Banque.Menu.Historique, true)
        end
    })
end


RegisterNetEvent(("%s:Transferer_"):format(_Banque.Event.Prefix))
AddEventHandler(("%s:Transferer_"):format(_Banque.Event.Prefix), function(number, ID)
    TriggerServerEvent(("%s:Transferer_"):format(_Banque.Event.Prefix), tonumber(number), tonumber(ID))
    TriggerServerEvent(("%s:InsertHistorique_"):format(_Banque.Event.Prefix), "[~r~-~s~] - ~r~Transfére~s~", tonumber(number))
end)



RegisterNetEvent(("%s:Historique_"):format(_Banque.Event.Prefix))
AddEventHandler(("%s:Historique_"):format(_Banque.Event.Prefix), function(Historique)
    _Banque.Historique = Historique
end)

function _HistoriqueButton()
    RageUI.Line()
    if #_Banque.Historique < 1 then 
        RageUI.Separator("~r~Aucune transaction~s~")
        RageUI.Line()
    else
        RageUI.Separator("↓ ~b~Vos transactions~s~ ↓")
        for key, value in pairs(_Banque.Historique) do
            RageUI.Button("N°"..key..(" %s ~o~%s$~s~"):format(value.type, value.amount), value.date, {RightLabel = "~r~Supprimer →"}, true, {
                onSelected = function()
                    local variable = _Banque.KeyboardInput("SUPPRIMER LA TRANSACTION ? (~b~OUI~s~/~r~NON~s~)", "", 10)
                    if variable == nil or variable == "" then
                        ESX.ShowNotification("Vous devez entrer ~b~OUI~s~ ou ~r~NON~s~")
                    elseif variable:lower() == "oui" or variable:upper() == "OUI" then
                        TriggerServerEvent(("%s:SupprimerHistorique_"):format(_Banque.Event.Prefix), value.id)
                        Wait(100)
                        TriggerServerEvent(("%s:Historique_"):format(_Banque.Event.Prefix))
                        ESX.ShowNotification("~r~Vous avez supprimé la transaction~s~ N° ~b~"..key)
                    elseif variable:lower() == "non" or variable:upper() == "NON" then
                        ESX.ShowNotification("~r~La transaction n'a pas été supprimée~s~")
                    end
                end,
            })
        end
    end
end
