function getcurrenttool() 
	for i,v in pairs(game.Players.LocalPlayer.character:GetChildren()) do
		if v.ClassName == 'Tool' then
			return v
		end
	end
end

function checkifgun(tool)
	if tool:FindFirstChild('MainGunScript') then
		return true
	else
		return false
	end
end

function reload(gunname)
    game:GetService("ReplicatedStorage"):WaitForChild("_CS.Events"):WaitForChild("WeaponServer"):FireServer('Reload',game.Players.LocalPlayer.Character:FindFirstChild(gunname).Handle,gunname,0,nil,0,game.ReplicatedStorage.ServerRunTime.Value)
end

function shoot(gun)
	gun.MainGunScript.FireEvent:Fire(game.Players.LocalPlayer:GetMouse())
end
