lib = loadstring(game:HttpGet("https://github.com/Peanutnoodlez/scripts/raw/main/cmdhub/cmdgui.lua"))()

local kickphrase = getgenv().kickphrase
local autoreload = false
local rapidshotgun = false

function jsonencode(text) 
	return game:GetService("HttpService"):JSONEncode(text)
end

function jsondecode(text) 
	return game:GetService("HttpService"):JSONDecode(text)
end

local LPlayer = game.Players.LocalPlayer

local function antikick()
        local s, err = pcall(function()
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            local namecall = mt.__namecall

            mt.__namecall = function(self,...)
                local args = {...}
                if getnamecallmethod() == "Kick" then
                	if ... ~= kickphrase then
          				return nil
                    end
                end
            return namecall(self,...)
        end
    end)         
end

function getcurrenttool() 
    for i,v in pairs(LPlayer.character:GetChildren()) do
        if v.ClassName == 'Tool' then
            return v
        end
    end
    return(false)
end

function checkifgun(tool)
    if tool:FindFirstChild('MainGunScript') then
        return true
    else
        return false
    end
end

function reload(gunname)
    game:GetService("ReplicatedStorage"):WaitForChild("_CS.Events"):WaitForChild("WeaponServer"):FireServer('Reload',LPlayer.Character:FindFirstChild(gunname).Handle,gunname,0,nil,0,game.ReplicatedStorage.ServerRunTime.Value)
end

local mouse = LPlayer:GetMouse()
local userinput = game:GetService('UserInputService')

gui = lib:new('cmd hub')

lib:addbutton(gui,'antikick',antikick())
lib:addbutton(gui,'kick self',function()
	game.Players.LocalPlayer:Kick(kickphrase)
end)
lib:addbutton(gui,'print name',function()
	print(LPlayer.Name)
end)

lib:addtoggle(gui,'auto reload',autoreload,function(x)
	autoreload = x
end)

lib:addtoggle(gui,'rapid shotty',rapidshotgun,function(x)
	rapidshotgun = x
end)

local clickedown = false
userinput.InputBegan:Connect(function(x)
    if x.UserInputType == Enum.UserInputType.MouseButton1 then
        clickedown = true 
    end
end)
userinput.InputEnded:Connect(function(x)
    if x.UserInputType == Enum.UserInputType.MouseButton1 then
        clickedown = false
    end
end)
spawn( function()
while wait(0.0001) do
	local gun = getcurrenttool()
	if gun then
		if checkifgun(gun) then
			local getlist = game:GetService("ReplicatedStorage"):WaitForChild("_CS.Events").GetList: Invoke()
            local specs = getlist[gun.Name]
            if clickedown == true and specs.Firemode == 'Shot' and rapidshotgun then
				reload(gun.Name)
				LPlayer.character:FindFirstChild(gun.Name).MainGunScript.FireEvent:Fire(mouse)  
				end
			end
		end
	end
end )

spawn( function()
while wait(0.1) do
    local gun = getcurrenttool()
    if gun ~= false and autoreload then
        if checkifgun(gun) then
            if gun.Handle.Mag.Value <= 0 then
                local getlist = game:GetService("ReplicatedStorage"):WaitForChild("_CS.Events").GetList: Invoke()
                local specs = getlist[gun.Name]
                if specs.Firemode == 'Shot' then
                    for i = specs.MaxAmmo,1,-1 do 
                        reload(gun.Name)
                    end
                else
                    reload(gun.Name)
                    wait(specs.ReloadTime)
                end
            end
        end
    end
end end)
