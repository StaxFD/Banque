function RageUI.Info(Title, RightText, LeftText)
    local LineCount = 7--#RightText >= #LeftText and #RightText or #LeftText
    if Title ~= nil then
        RenderText("~h~" .. Title .. "~h~", 600, 110, 0, 0.34, 255, 255, 255, 255, 0)
    end
    if RightText ~= nil then
        RenderText(RightText.."\n", 432 + 15 + 10, Title ~= nil and 140 or 7, 0, 0.28, 255, 255, 255, 255, 0)
    end
    if LeftText ~= nil then
        RenderText(LeftText.."\n", 432 + 432 + 10, Title ~= nil and 140 or 7, 0, 0.28, 255, 255, 255, 255, 2)
    end
    RenderRectangle(450, 100, 432, Title ~= nil and ((LineCount + 1) * 20), 0, 0, 0, 160)
end

