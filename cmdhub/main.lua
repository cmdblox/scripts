lib = loadstring(game:HttpGet("https://github.com/Peanutnoodlez/scripts/raw/main/cmdhub/cmdgui.lua"))()

local kickphrase = getgenv().kickphrase
local autoreload = false
local rapidshotgun = false
local buyshells = false
getgenv().multishotval = 6 -- default is 6

function jsonencode(text) 
	return game:GetService("HttpService"):JSONEncode(text)
end

function jsondecode(text) 
	return game:GetService("HttpService"):JSONDecode(text)
end

local LPlayer = game.Players.LocalPlayer

        local s, err = pcall(function()
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            local namecall = mt.__namecall

            mt.__namecall = function(self,...)
                local args = {...}
                if getnamecallmethod() == "Kick" then
          				return nil
                end
            return namecall(self,...)
        end
    end)         


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

lib:addbutton(gui,'print name',function()
	print(LPlayer.Name)
end)

lib:addtoggle(gui,'auto reload',autoreload,function(x)
	autoreload = x
end)

lib:addtoggle(gui,'rapid shotty',rapidshotgun,function(x)
	rapidshotgun = x
end)

lib:addtoggle(gui, 'buy shells', buyshells,function(x)
	buyshells = x
end)

local clickedown = false
userinput.InputBegan:Connect(function(x)
    if x.UserInputType == Enum.UserInputType.MouseButton1 then
        clickedown = true 
    end
end)
