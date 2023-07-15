lib = loadstring(game:HttpGet("https://github.com/Peanutnoodlez/scripts/raw/main/cmdhub/cmdgui.lua"))()


local LPlayer = game.Players.LocalPlayer

local function antikick()
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
end

gui = lib:new('cmd hub')

lib:addbutton(gui,'antikick',antikick())
lib:addbutton(gui,'print name',function()
	print(LPlayer.Name)
end)
