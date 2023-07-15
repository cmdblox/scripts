lib = loadstring(game:HttpGet("https://github.com/Peanutnoodlez/scripts/raw/main/cmdhub/cmdgui.lua"))()

local kickphrase = getgenv().kickphrase

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

gui = lib:new('cmd hub')

lib:addbutton(gui,'antikick',antikick())
lib:addbutton(gui,'kick self',function()
	game.Players.LocalPlayer:Kick(kickphrase)
end)
lib:addbutton(gui,'print name',function()
	print(LPlayer.Name)
end)
