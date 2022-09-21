ESX = nil 
TriggerEvent(_Banque.ESX, function(obj) ESX = obj end)


RegisterNetEvent(("%s:Deposer_"):format(_Banque.Event.Prefix))
AddEventHandler(("%s:Deposer_"):format(_Banque.Event.Prefix), function(number)
    local src = source
    if (not (src) or src <= 0) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(src)  
    if (not (xPlayer)) then
        return
    end
    local xMoney = xPlayer.getMoney()
    if xMoney >= number then
        xPlayer.addAccountMoney('bank', number)
        xPlayer.removeMoney(number)
        TriggerClientEvent(_Banque.Translations.Menu.TypeAdvancedNotif, src, _Banque.Translations.Menu.Title, _Banque.Translations.Menu.MyBank, _Banque.Translations.Menu.add_money..number.." $~s~ à votre banque !", _Banque.Translations.Menu.Char_Notif, 10)
    else
        TriggerClientEvent(_Banque.Translations.Menu.TypeNotif, src, _Banque.Translations.Menu.No_Money)
    end    
end) 

RegisterNetEvent(("%s:Retirer_"):format(_Banque.Event.Prefix))
AddEventHandler(("%s:Retirer_"):format(_Banque.Event.Prefix), function(number)
    local src = source
    if (not (src) or src <= 0) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(src)  
    if (not (xPlayer)) then
        return
    end
    local xMoney = xPlayer.getMoney()
    if xMoney >= number then
        xPlayer.removeAccountMoney('bank', number)
        xPlayer.addMoney(number)
        TriggerClientEvent(_Banque.Translations.Menu.TypeAdvancedNotif, src, _Banque.Translations.Menu.Title, _Banque.Translations.Menu.MyBank, _Banque.Translations.Menu.remove_money..number.." $~s~ de votre banque !", _Banque.Translations.Menu.Char_Notif, 10)
    else
        TriggerClientEvent(_Banque.Translations.Menu.TypeNotif, src, _Banque.Translations.Menu.No_Money)
    end    
end) 

RegisterNetEvent(("%s:VerifTransferer_"):format(_Banque.Event.Prefix))
AddEventHandler(("%s:VerifTransferer_"):format(_Banque.Event.Prefix), function(number, ID)
    local src = source
    if (not (src) or src <= 0) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(src)  
    if (not (xPlayer)) then
        return
    end
    local target = ESX.GetPlayerFromId(ID)
    if (not (target)) then
        TriggerClientEvent(_Banque.Translations.Menu.TypeNotif, src, _Banque.Translations.Menu.no_players)
        return
    end
    if ID == src then
        TriggerClientEvent(_Banque.Translations.Menu.TypeNotif, src, _Banque.Translations.Menu.no_transfert)
        return
    else
        TriggerClientEvent(("%s:Transferer_"):format(_Banque.Event.Prefix), src, number, ID)
    end 
end) 
RegisterNetEvent(("%s:Transferer_"):format(_Banque.Event.Prefix))
AddEventHandler(("%s:Transferer_"):format(_Banque.Event.Prefix), function(number, ID)
    local src = source
    if (not (src) or src <= 0) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(src)  
    if (not (xPlayer)) then
        return
    end
    local target = ESX.GetPlayerFromId(ID)
    local xMoney = xPlayer.getMoney()
    if xMoney >= number then
        xPlayer.removeAccountMoney('bank', number)
        target.addAccountMoney('bank', number)
        TriggerClientEvent(_Banque.Translations.Menu.TypeAdvancedNotif, src, _Banque.Translations.Menu.Title, _Banque.Translations.Menu.MyBank, "Vous avez transféré ~g~"..number.." $~s~ à "..GetPlayerName(ID).." !", _Banque.Translations.Menu.Char_Notif, 10)
        TriggerClientEvent(_Banque.Translations.Menu.TypeAdvancedNotif, ID, _Banque.Translations.Menu.Title, _Banque.Translations.Menu.MyBank, "Vous avez reçu ~g~"..number.." $~s~ de "..GetPlayerName(src).." !", _Banque.Translations.Menu.Char_Notif, 10)
    else
        TriggerClientEvent(_Banque.Translations.Menu.TypeNotif, src, _Banque.Translations.Menu.No_Money)
    end   
end) 


local function getDate()
    return os.date("*t", os.time()).day.."/"..os.date("*t", os.time()).month.."/"..os.date("*t", os.time()).year.." à "..os.date("*t", os.time()).hour.."h"..os.date("*t", os.time()).min
end
RegisterNetEvent(("%s:InsertHistorique_"):format(_Banque.Event.Prefix))
AddEventHandler(("%s:InsertHistorique_"):format(_Banque.Event.Prefix), function(type, amount)
    local src = source 
    if (not (src)) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(src)  
    if (not (xPlayer)) then
        return
    end
    MySQL.Async.execute('INSERT INTO banque_historique (identifier, type, amount, date) VALUES (@identifier, @type, @amount, @date)', {
        ["@identifier"] = xPlayer.identifier,
        ['@type'] = type,
        ['@amount'] = amount,
		['@date'] = getDate(),
    })
end)
RegisterNetEvent(("%s:Historique_"):format(_Banque.Event.Prefix))
AddEventHandler(("%s:Historique_"):format(_Banque.Event.Prefix), function()
    local src = source 
    if (not (src)) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(src)  
    if (not (xPlayer)) then
        return
    end
    MySQL.Async.fetchAll("SELECT * FROM banque_historique WHERE identifier = @identifier ", {
        ["@identifier"] = xPlayer.identifier
    }, function(result)
        if (result) then
            TriggerClientEvent(("%s:Historique_"):format(_Banque.Event.Prefix), src, result)
        end
    end)
end)
RegisterNetEvent(("%s:SupprimerHistorique_"):format(_Banque.Event.Prefix))
AddEventHandler(("%s:SupprimerHistorique_"):format(_Banque.Event.Prefix), function(id)
    local src = source 
    if (not (src)) then
        return
    end
    MySQL.Async.execute("DELETE FROM banque_historique WHERE id ='"..id.."'")
end)