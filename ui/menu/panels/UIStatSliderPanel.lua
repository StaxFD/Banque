local Slider = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 49, Width = 431, Height = 76 },
    Text = {
        Left = { X = 18, Y = 59, Scale = 0.28 },
        Right = { X = 380, Y = 59, Scale = 0.28 },
        Upper = {X = 230, Y = 59, Scale = 0.28},
    },
    Bar = { X = 100, Y = 91, Width = 250, Height = 16 },
    Slider = { X = 40, Y = 69.5, Width = 35, Height = 9 },
    LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 12, Y = 87.5, Width = 25, Height = 25 },
    RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 389, Y = 87.5, Width = 25, Height = 25 },
}
function RageUI.SliderStatPanel(Value, MinValue, UpperText, MaxValue, Actions, Text, Percent, RGBA1, Percent2, RGBA2, RGBA3, Index)
	local Statistics = {
        Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 42 },
        Text = {
            Left = { X = -40, Y = 12, Scale = 0.27 },
        },
        Bar = { Right = 8, Y = 22, Width = 200, Height = 8, OffsetRatio = 0.5 },
        Divider = {
            [1] = { X = 200, Y = 22, Width = 2, Height = 8 },
            [2] = { X = 200, Y = 22, Width = 2, Height = 8 },
            [3] = { X = 200, Y = 22, Width = 2, Height = 8 },
            [4] = { X = 200, Y = 22, Width = 2, Height = 8 },
            [5] = { X = 200, Y = 22, Width = 2, Height = 8 },
        }
    }    
	local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
		if CurrentMenu() and (Index == nil or (CurrentMenu.Index == Index)) then

			Value = Value or 0
			Slider.Bar.Width = Slider.RightArrow.X- Slider.LeftArrow.X - Slider.LeftArrow.Width - 5 + CurrentMenu.WidthOffset
			Slider.Bar.X = Slider.LeftArrow.X + Slider.LeftArrow.Width
			Slider.Text.Upper.X = (Slider.Bar.Width) / 2 + Slider.Bar.X
			Slider.Text.Right.X = Slider.RightArrow.X + Slider.LeftArrow.Width
			local Hovered = false
			local LeftArrowHovered, RightArrowHovered = false, false
			local SliderW = Slider.Bar.Width / (64 + 1)
			local SliderX =  CurrentMenu.X + Slider.Bar.X + Value * Slider.Bar.Width / MaxValue

			Hovered = RageUI.IsMouseInBounds(CurrentMenu.X + Slider.Bar.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + Slider.Bar.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset - 4, Slider.Bar.Width, Slider.Bar.Height + 8)

			RenderSprite("commonmenu", "gradient_bgd", CurrentMenu.X, CurrentMenu.Y + Slider.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.Background.Width + CurrentMenu.WidthOffset, Slider.Background.Height, 0.0, 255, 255, 255, 255)
			RenderText(MinValue, CurrentMenu.X + Slider.Text.Left.X, CurrentMenu.Y + Slider.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Slider.Text.Left.Scale, 255, 255, 255, 255)
			RenderText(UpperText, CurrentMenu.X + Slider.Text.Upper.X, CurrentMenu.Y + Slider.Text.Upper.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Slider.Text.Upper.Scale, 255, 255, 255, 255, "Center")
			RenderText(MaxValue, CurrentMenu.X + Slider.Text.Right.X + CurrentMenu.WidthOffset, CurrentMenu.Y + Slider.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Slider.Text.Right.Scale, 255, 255, 255, 255, "Right")

			RenderSprite(Slider.LeftArrow.Dictionary, Slider.LeftArrow.Texture, CurrentMenu.X + Slider.LeftArrow.X, CurrentMenu.Y + Slider.LeftArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.LeftArrow.Width, Slider.LeftArrow.Height, 0.0,  255, 255, 255, 255)
			RenderSprite(Slider.RightArrow.Dictionary, Slider.RightArrow.Texture, CurrentMenu.X + Slider.RightArrow.X + CurrentMenu.WidthOffset , CurrentMenu.Y + Slider.RightArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.RightArrow.Width, Slider.RightArrow.Height, 0.0, 255, 255, 255, 255)
			RenderRectangle(CurrentMenu.X + Slider.Bar.X, CurrentMenu.Y + Slider.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.Bar.Width, Slider.Bar.Height, 87, 87, 87, 255)
			RenderRectangle(SliderX, CurrentMenu.Y + Slider.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SliderW, Slider.Bar.Height, 245, 245, 245, 255)

			LeftArrowHovered = RageUI.IsMouseInBounds(CurrentMenu.X + Slider.LeftArrow.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + Slider.LeftArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.LeftArrow.Width, Slider.LeftArrow.Height)
			RightArrowHovered = RageUI.IsMouseInBounds(CurrentMenu.X + Slider.RightArrow.X + CurrentMenu.SafeZoneSize.X + CurrentMenu.WidthOffset, CurrentMenu.Y + Slider.RightArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Slider.RightArrow.Width, Slider.RightArrow.Height)

			if Hovered then
				if IsDisabledControlPressed(0, 24) then
					local GetControl_X = GetDisabledControlNormal
					Value = (math.round(GetControl_X(2, 239) * 1920) - CurrentMenu.SafeZoneSize.X - Slider.Bar.X )/ Slider.Bar.Width * MaxValue
					if Value < 0 then
						Value = 0
					elseif Value >= MaxValue then
						Value = MaxValue
					end
					Value = math.round(Value, 0)
					if (Actions.onSliderChange ~= nil) then
						Actions.onSliderChange(Value)
					end
				end
			elseif CurrentMenu.Controls.Click.Active and (LeftArrowHovered or RightArrowHovered) then
				local max = type(Items) == "table" and #Items or MaxValue
				Value = Value + (LeftArrowHovered and -1 or RightArrowHovered and 1)
				if Value < MinValue then
					Value = max
				elseif Value > max  then
					Value = MinValue
				end
				if (Actions.onSliderChange ~= nil) then
					Actions.onSliderChange(Value);
				end

				local Audio = RageUI.Settings.Audio
				RageUI.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
			end

			----------------------------------------------------------------------------------------
            RGBA1 = RGBA1 or { 255, 255, 255, 255 }
            local BarWidth = Statistics.Bar.Width + CurrentMenu.WidthOffset * Statistics.Bar.OffsetRatio

            ---@type number
            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Statistics.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + (RageUI.StatisticPanelCount * 42), Statistics.Background.Width + CurrentMenu.WidthOffset, Statistics.Background.Height, 0, 0, 0, 170)
            RenderText(Text or "", CurrentMenu.X + 8.0, (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Statistics.Text.Left.Scale, 245, 245, 245, 255, 0)
            RenderRectangle(CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset, (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, BarWidth, Statistics.Bar.Height, 87, 87, 87, 255)
            RenderRectangle(CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset, (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Percent * BarWidth, Statistics.Bar.Height, RGBA1[1], RGBA1[2], RGBA1[3], RGBA1[4])
            RGBA2 = RGBA2 or { 0, 153, 204, 255 }
            RGBA3 = RGBA3 or { 185, 0, 0, 255 }

            if Percent2 and Percent2 > 0 then
                local X = CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset + Percent * BarWidth
                RenderRectangle(X, (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Percent2 * BarWidth, Statistics.Bar.Height, RGBA2[1], RGBA2[2], RGBA2[3], RGBA2[4])
            elseif Percent2 and Percent2 < 0 then
                local X = CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset + Percent * BarWidth
                RenderRectangle(X, (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Percent2 * BarWidth, Statistics.Bar.Height, RGBA3[1], RGBA3[2], RGBA3[3], RGBA3[4])
            end

            for i = 1, #Statistics.Divider, 1 do
                RenderRectangle((CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right) + i * ((BarWidth - (#Statistics.Divider / Statistics.Divider[i].Width)) / (#Statistics.Divider + 1)) + CurrentMenu.WidthOffset, (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Divider[i].Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Statistics.Divider[i].Width, Statistics.Divider[i].Height, 0, 0, 0, 255)
            end

            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
		end
	end
end