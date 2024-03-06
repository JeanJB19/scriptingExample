local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MPS = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")

local Template = require(script.Parent.Template)
local ProfileService = require(ServerScriptService.Libs.ProfileService)
local ProfileStore = ProfileService.GetProfileStore("Rework7", Template)

local function PlayerAdded(player: Player)
	local profile = ProfileStore:LoadProfileAsync("Player_"..player.UserId)
	if profile == nil then
		player:Kick("There was an error when trying to load your data. Rejoin and try again")
		return
	end
	
	local AccessoriesFolder = Instance.new("Folder")
	AccessoriesFolder.Name = "AccessoriesFolder"
	AccessoriesFolder.Parent = player
	
	if type(profile.Data.Accessories.Equipped) == "table" then
		for _, accessory in ipairs(profile.Data.Accessories.Equipped) do
			if accessory then
				local existingInstances = AccessoriesFolder:GetChildren()

				local function check(accessory)
					local nn = {}
					for _, existingInstance in pairs(existingInstances) do
						if existingInstance:IsA("StringValue") and existingInstance.Name == accessory then
							table.insert(nn, existingInstance)
							print(nn)
						end
					end

					for i = 1, #nn - 1 do
						nn[i]:Destroy() -- Destroy all but the last instance
					end

					print('continue')
				end

				if not AccessoriesFolder:FindFirstChild(accessory) then
					local Value = Instance.new("StringValue", AccessoriesFolder)
					Value.Name = accessory
					check(accessory)
				else
					warn("An instance with the name", accessory, "already exists. Skipping creation.")
				end
			else
				warn("nil")
			end
		end
	else
		warn("profile.Data.Accessories.Equipped is nil or not a table")
	end



	
	local Inventory = player:WaitForChild("Inventory")
	
	if type(profile.Data.Inventory) == "table" then
		for _,inv in ipairs(profile.Data.Inventory) do
			if inv then
				local Value = Instance.new("StringValue", Inventory)
				Value.Name = inv
			else
				warn("nil")
			end
		end
	end
end