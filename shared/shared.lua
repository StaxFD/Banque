_Banque = _Banque or {}
_Banque.Menu = _Banque.Menu or {}
_Banque = {
    ESX = "esx:getSharedObject",
    Event = {
        Prefix = "_/Stax_/",
    },
    PositionsBanque = {
        {pos = vector3(150.266,  -1040.203,  29.374)},
        {pos = vector3(-1212.980,  -330.841,  37.787)},
        {pos = vector3(-2962.59,  482.5,  15.703)},
        {pos = vector3(-112.202,  6469.295,  31.626)},
        {pos = vector3(314.187,  -278.621,  54.170)},
        {pos = vector3(-351.534,  -49.529,  49.042)},
        {pos = vector3(241.727,  220.706,  106.286)},
        {pos = vector3(1175.064,  2706.643,  38.094)},	
    },
    PropsAtm = {
        "prop_atm_02",
        "prop_atm_03",
        "prop_fleeca_atm",
        "prop_atm_01"
    },
    Markers = {
        Type = 29,
        TailleX = 0.5,
        TailleY = 0.5,
        TailleZ = 0.5,
        CouleurR = 255,
        CouleurG = 255,
        CouleurB = 255, 
        Opacite = 155,
    },
    Blips = {
        Sprite = 108,
        Scale = 0.65,
        Color = 2,
        Display = 4,
        AsShortRange = true,
        Name = "Banque",  
    },
    ["Translations"] = {
        ["Menu"] = {
            ["Title"] = "Banque",
            ["SubTitle"] = "Banque",
            ["Button"] = "Banque",
            ["MyBank"] = "Ma Banque",
            ["colorprice"] = "~g~",
            ["add_money"] = "Vous avez deposé ~g~",
            ["remove_money"] = "Vous avez retiré ~r~",
            ["Dollars"] = "$",
            ["TypeAdvancedNotif"] = "esx:showAdvancedNotification",
            ["TypeNotif"] = "esx:showNotification",
            ["Char_Notif"] = "CHAR_BANK_FLEECA",
            ["HelpNotif"] = "Appuyez sur ~INPUT_CONTEXT~ pour accéder à la ~HC_18~Banque ~BLIP_financier_strand~ ~s~",
            ["No_Money"] = "~r~Vous n'avez pas assez d\'argent~s~ !~s~",
            ["no_players"] = "Le joueur n'est pas connecté",
            ["no_transfert"] = "Vous ne pouvez pas vous transférer de l'argent",
        },
    }
}


