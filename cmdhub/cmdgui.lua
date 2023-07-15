local path = game.CoreGui

local keybinds = getgenv().keybinds
keybinds = {}

keybinds['main'] = Enum.KeyCode.L

cmdui = {}

function cmdui:setbind(name,value)
	keybinds[name] = value
end

function cmdui:getbind(name)
	return keybinds[name]
end

function cmdui:Create(instance, properties, children) -- skidded from venyx
	local object = Instance.new(instance)

	for i, v in pairs(properties or {}) do
		object[i] = v
	end

	for i, module in pairs(children or {}) do
		module.Parent = object
	end

	return object
end

function cmdui:new(name)
	if path:FindFirstChild(name) then path:FindFirstChild(name):Remove() end
	local gui = getgenv()[name]
	
	gui = Instance.new('ScreenGui')
	gui.Name = name
	gui.Parent = path
	local mainframe = Instance.new('Frame')
	mainframe.Parent = gui
	mainframe.Size = UDim2.new(0, 398,0, 512)
	mainframe.Position = UDim2.new(0.031, 0,0.129, 0)
	mainframe.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
	local corner = Instance.new('UICorner')
	corner.Parent = mainframe
	corner.CornerRadius = UDim.new(0, 20)
	local label = Instance.new('TextLabel')
	label.Parent = mainframe
	label.Position = UDim2.new(0.05, 0,0.039, 0)
	label.Size = UDim2.new(0, 358,0, 50)
	label.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
	label.BackgroundTransparency = 0.8
	label.Text = name
	label.TextColor3 = Color3.fromRGB(127, 35, 255)
	label.TextScaled = true
	label.FontFace = Font.fromName('Roboto')
	label.TextSize = 48
	local scrollingframe = Instance.new('ScrollingFrame')
	scrollingframe.Parent = mainframe
	scrollingframe.Position = UDim2.new(0.05, 0,0.176, 0)
	scrollingframe.Size = UDim2.new(0, 358,0, 402)
	scrollingframe.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
	scrollingframe.BackgroundTransparency = 0.8
	scrollingframe.BorderSizePixel = 0
	scrollingframe.ScrollBarImageColor3 = Color3.fromRGB(127, 35, 255)
	scrollingframe.ScrollBarThickness = 0
	scrollingframe.ScrollingDirection =  'Y'
	scrollingframe.VerticalScrollBarPosition = 'Left'
	scrollingframe.CanvasSize = UDim2.new(0, 0,1000, 0)
	mainframe:SetAttribute("ButtonCount", 0)
	corner:Clone().Parent = label
	
	spawn(function()
		local UserInputService = game:GetService("UserInputService")


		local gui = mainframe

		local dragging
		local dragInput
		local dragStart
		local startPos

		local function update(input)
			local delta = input.Position - dragStart
			gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end

		local function invert(value)
			if value then
				return false
			else
				return true
			end
		end

		gui.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = gui.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		gui.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)

		UserInputService.InputBegan:Connect(function(x,y)
			if y then return end
			if x.KeyCode ~= Enum.KeyCode.Unknown then
				if(x.KeyCode == cmdui:getbind('main')) then
					gui.Visible = invert(gui.Visible)
				end
			end
		end)
	end)
	return mainframe
end

function cmdui:addbutton(gui,name,func)
	local buttoncount = gui:GetAttribute("ButtonCount")
	local offset = buttoncount*60+20
	gui:SetAttribute("ButtonCount", buttoncount+1) 
	local button = Instance.new('TextButton')
	button.Name = name
	button.Parent = gui.ScrollingFrame
	button.Size = UDim2.new(0, 318,0, 50)
	button.Position = UDim2.new(0.056, 0,0, offset)
	button.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
	button.FontFace = Font.fromName('Roboto')
	button.Text = name
	button.TextColor3 = Color3.fromRGB(127, 35, 255)
	button.TextScaled = true
	button.TextSize = 48
	local corner = Instance.new('UICorner')
	corner.Parent = button
	corner.CornerRadius = UDim.new(0, 20) 
	
	local debounce
	
	button.MouseButton1Click:Connect(function()

		if func then
			func(function(...)
				self:updateButton(button, ...)
			end)
		end

		debounce = false
	end)

	return button
end

function cmdui:addtoggle(gui,name,default,func)
	local buttoncount = gui:GetAttribute("ButtonCount")
	local offset = buttoncount*60+20
	gui:SetAttribute("ButtonCount", buttoncount+1) 
	local button = Instance.new('TextButton')
	button.Name = name
	button.Parent = gui.ScrollingFrame
	button.Size = UDim2.new(0, 238,0, 50)
	button.Position = UDim2.new(0.056, 0,0, offset)
	button.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
	button.FontFace = Font.fromName('Roboto')
	button.Text = name
	button.TextColor3 = Color3.fromRGB(127, 35, 255)
	button.TextScaled = true
	button.TextSize = 48
	local corner = Instance.new('UICorner')
	corner.Parent = button
	corner.CornerRadius = UDim.new(0, 20) 
	local label = Instance.new('TextLabel')
	label.Parent = button
	label.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
	label.TextColor3 = Color3.fromRGB(127, 35, 255)
	label.FontFace = Font.fromName('Roboto')
	label.TextSize = 44
	label.TextScaled = true
	label.Size = UDim2.new(0, 70,0, 50)
	label.Position = UDim2.new(0, 248,0, 0)
	corner:Clone().Parent = label
	
	local active = default
	
	if active then
		label.Text = 'on'
	else
		label.Text = 'off'
	end
	
	button.MouseButton1Click:Connect(function()
		if active then
			active = false
			label.Text = 'off'
		else
			active = true
			label.Text = 'on'
		end

		if func then
			func(active, function(...)

			end)
		end
	end)

	return button
end

return cmdui
