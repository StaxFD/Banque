_Banque.Menu = _Banque.Menu or {}
_Banque.Historique = _Banque.Historique or {}
_Banque.SuppHistorique = _Banque.SuppHistorique or {}
_Banque.Menu.Create = function()
    _Banque.Menu.main = RageUI.CreateMenu(_Banque.Translations.Menu.Title, _Banque.Translations.Menu.Title)
    _Banque.Menu.Historique = RageUI.CreateSubMenu(_Banque.Menu.main, _Banque.Translations.Menu.Title, _Banque.Translations.Menu.Title)
end