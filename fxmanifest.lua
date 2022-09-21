fx_version("cerulean")
lua54 "yes"
game("gta5")

client_scripts {
    --RageUI
        "ui/RMenu.lua",
        "ui/menu/RageUI.lua",
        "ui/menu/Menu.lua",
        "ui/menu/MenuController.lua",
        "ui/components/*.lua",
        "ui/menu/elements/*.lua",
        "ui/menu/items/*.lua",
        "ui/menu/panels/*.lua",
        "ui/menu/windows/*.lua",
    -------
    --Client(fichiers)
        "client/*.lua",
    -------
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/*.lua",
}

shared_scripts {
    "shared/*.lua",
}