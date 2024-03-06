local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventsFolder = ReplicatedStorage:WaitForChild("Events")

local ProfileService = require(ServerScriptService.Libs.ProfileService)
local Manager = require(ServerScriptService.PlayerData.Manager)

local lobby = workspace.LobbyFolder

EventsFolder.Settings.MusicOn.OnServerEvent:Connect(function(player, value)
	local profile = Manager.Profiles[player]
	if not profile then return end
	
	local Settings = player:WaitForChild("Settings")
	
	local music = Settings:WaitForChild("Music")	
	music.Value = true 
	lobby.Assets.LobbyMusic:Play()
end)

EventsFolder.Settings.MusicOff.OnServerEvent:Connect(function(player, value)
	local profile = Manager.Profiles[player]
	if not profile then return end

	local Settings = player:WaitForChild("Settings")

	local music = Settings:WaitForChild("Music")	
	music.Value = false 
	lobby.Assets.LobbyMusic:Stop()
end)