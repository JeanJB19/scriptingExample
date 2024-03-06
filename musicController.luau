local sliderBG = script.Parent.Slider
local sliderBtn = script.Parent:WaitForChild("Button")

local music = game.Workspace.Sound

local mouse = game.Players.LocalPlayer:GetMouse()

local snapAmount = 100
local pixelsFromEdge = 10

local movingSlider = false

sliderBtn.MouseButton1Down:Connect(function()
	movingSlider = true
end)

sliderBtn.MouseButton1Up:Connect(function()
	movingSlider = false
end)

mouse.Button1Up:Connect(function()
	movingSlider = false
end)

mouse.Move:Connect(function()
	if movingSlider then
		local xOffset = math.floor((mouse.X - sliderBG.AbsolutePosition.X) / snapAmount + 0.5) * snapAmount
		local xOffsetClamped = math.clamp(xOffset, pixelsFromEdge, sliderBG.AbsoluteSize.X - pixelsFromEdge)
		
		local sliderPosNew = UDim2.new(0, xOffsetClamped, sliderBtn.Position.Y)
		
		sliderBtn.Position = sliderPosNew
		
		local roundedAbsSize = math.floor(sliderBG.AbsoluteSize.X / snapAmount + 0.5 ) * snapAmount
		local roundedOffsetClamped = math.floor(xOffsetClamped / snapAmount + 0.5) * snapAmount
		
		local sliderValue = roundedOffsetClamped / roundedAbsSize
		
		music.Volume = sliderValue
	end
end)