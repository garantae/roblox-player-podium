--// General Variables
local player = game.Players.LocalPlayer
local Players = game:GetService("Players")

--// Data Variables
local FirstPlace = game.ReplicatedStorage.CORE_GameValues.FirstPlace
local SecondPlace = game.ReplicatedStorage.CORE_GameValues.SecondPlace
local ThirdPlace = game.ReplicatedStorage.CORE_GameValues.ThirdPlace
local StatusHeader = game.ReplicatedStorage.CORE_GameValues.StatusHeader
local ChosenMode = game.ReplicatedStorage.CORE_GameValues.ChosenMode

--// UI Variables
local PodiumMainFrame = script.Parent.MainFrame
local PersonalEarnedAmount = PodiumMainFrame.PersonalReward.CoinsImage.EarnedAmount
local FirstPlaceFrame = PodiumMainFrame.FirstPlace
local SecondPlaceFrame = PodiumMainFrame.SecondPlace
local ThirdPlaceFrame = PodiumMainFrame.ThirdPlace
local CloseButton = PodiumMainFrame.CloseButton

--// Reward Variables
local VIPBonus = script.Parent.MainFrame.PersonalReward.CoinsImage.VIPBonus
local X2Bonus = script.Parent.MainFrame.PersonalReward.CoinsImage.X2Bonus
local AmountEarned = script.Parent.AmountEarned

--// Sound FX Variables
local BonusRewardsSFX = script.Parent.BonusRewardsSFX
local FwooshSFX = script.Parent.FwooshSFX
local EndSound = script.Parent.EndSound

--// Podium Behavior Variables
local FirstUserId
local SecondUserId
local ThirdUserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size60x60
local PodiumMainFrame = script.Parent.MainFrame

--// Configurables
local ViewTime = 15


--// Main Function
game.ReplicatedStorage.CORE_RemoteEvents.ShowPodium.OnClientEvent:Connect(function(DidPlayerParticipate,IsServerPrivate)
	
	wait(2)
	
	local success, errorStatement = pcall(function() game.Players:GetUserIdFromNameAsync(FirstPlace.Value) end)

	if success then	
		FirstUserId = game.Players:GetUserIdFromNameAsync(FirstPlace.Value)
		PodiumMainFrame.FirstPlace.PlayerImage.PlayerName.Text = FirstPlace.Value
		
		local content, isReady = Players:GetUserThumbnailAsync(FirstUserId, thumbType, thumbSize)
		local imageLabel = PodiumMainFrame.FirstPlace.PlayerImage
		imageLabel.Image = content
	end
	
	
	local success, errorStatement = pcall(function() game.Players:GetUserIdFromNameAsync(SecondPlace.Value) end)

	if success then
		SecondUserId = game.Players:GetUserIdFromNameAsync(SecondPlace.Value)
		PodiumMainFrame.SecondPlace.PlayerImage.PlayerName.Text = SecondPlace.Value
		
		local content, isReady = Players:GetUserThumbnailAsync(SecondUserId, thumbType, thumbSize)
		local imageLabel = PodiumMainFrame.SecondPlace.PlayerImage
		imageLabel.Image = content
	end
	
	
	local success, errorStatement = pcall(function() game.Players:GetUserIdFromNameAsync(ThirdPlace.Value) end)

	if success then	
		ThirdUserId = game.Players:GetUserIdFromNameAsync(ThirdPlace.Value)
		PodiumMainFrame.ThirdPlace.PlayerImage.PlayerName.Text = ThirdPlace.Value
		
		local content, isReady = Players:GetUserThumbnailAsync(ThirdUserId, thumbType, thumbSize)
		local imageLabel = PodiumMainFrame.ThirdPlace.PlayerImage
		imageLabel.Image = content
	end

	
	if PodiumMainFrame.Visible == false then
		
		if IsServerPrivate.Value == true then
			FirstPlaceFrame.CoinsImage.Amount.Text = "0"
			SecondPlaceFrame.CoinsImage.Amount.Text = "0"
			ThirdPlaceFrame.CoinsImage.Amount.Text = "0"
		end
	
		FirstPlaceFrame.Size = UDim2.new(0.237,0,0.01,0)
		SecondPlaceFrame.Size = UDim2.new(0.236,0,0.01,0)
		ThirdPlaceFrame.Size = UDim2.new(0.236,0,0.01,0)
		
		FirstPlaceFrame.Position = UDim2.new(0.381, 0,0.818, 0)
		SecondPlaceFrame.Position = UDim2.new(0.125, 0,0.818, 0)
		ThirdPlaceFrame.Position = UDim2.new(0.637, 0,0.818, 0)
		
		PodiumMainFrame.PersonalReward.TextTransparency = 1
		PodiumMainFrame.PersonalReward.CoinsImage.ImageTransparency = 1
		PodiumMainFrame.PersonalReward.CoinsImage.EarnedAmount.TextTransparency = 1
		
		CloseButton.Visible = false
		CloseButton.Selectable = false
		
		wait(1)
		
		PodiumMainFrame.Visible = true
		EndSound:Play()
		
		--PodiumMainFrame:TweenSizeAndPosition(UDim2.new(0.336, 0,0.655, 0),UDim2.new(0.332, 0,0.17, 0), 0.1)
		

		PodiumMainFrame.Size = UDim2.new(0.336, 0,0.655, 0)
		PodiumMainFrame.Position = UDim2.new(0.332, 0,0.17, 0)

		
		FwooshSFX:Play()
		ThirdPlaceFrame:TweenSizeAndPosition(UDim2.new(0.236, 0,0.208, 0),UDim2.new(0.637, 0,0.61, 0), 0.05)
		
		repeat wait() until ThirdPlaceFrame.Size == UDim2.new(0.236, 0,0.208, 0) and FwooshSFX.IsPlaying == false
		
		FwooshSFX:Play()
		SecondPlaceFrame:TweenSizeAndPosition(UDim2.new(0.236, 0,0.311, 0),UDim2.new(0.125, 0,0.507, 0), 0.05)
		
		repeat wait() until SecondPlaceFrame.Size == UDim2.new(0.236, 0,0.311, 0) and FwooshSFX.IsPlaying == false
		
		FwooshSFX:Play()
		FirstPlaceFrame:TweenSizeAndPosition(UDim2.new(0.237, 0,0.498, 0),UDim2.new(0.381, 0,0.321, 0), 0.05)

		repeat wait() until FirstPlaceFrame.Size == UDim2.new(0.237, 0, 0.498) and FwooshSFX.IsPlaying == false

		PodiumMainFrame.PersonalReward.TextTransparency = 0
		PodiumMainFrame.PersonalReward.CoinsImage.ImageTransparency = 0
		PodiumMainFrame.PersonalReward.CoinsImage.EarnedAmount.TextTransparency = 0
		
		if ChosenMode.Value == "CLASSIC" and IsServerPrivate.Value == false then
			
			if player.Name == FirstPlace.Value then
				AmountEarned.Value = 150	
				PersonalEarnedAmount.Text = AmountEarned.Value
				
				wait(0.5)	
				
				if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.userId, 8767116) then --// X2 Gold
					AmountEarned.Value = AmountEarned.Value * 2
					PersonalEarnedAmount.Text = AmountEarned.Value
					X2Bonus.Visible = true
					BonusRewardsSFX:Play()
					wait(0.5)
					X2Bonus.Visible = false
				end
				
				if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.userId, 8786827) then --// VIP
					AmountEarned.Value = AmountEarned.Value + 25
					PersonalEarnedAmount.Text = AmountEarned.Value
					VIPBonus.Visible = true
					BonusRewardsSFX:Play()
					wait(0.5)
					VIPBonus.Visible = false
				end
			end	

			if player.Name == SecondPlace.Value then
				AmountEarned.Value = 100	
				PersonalEarnedAmount.Text = AmountEarned.Value
				
				wait(0.5)	
				
				if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.userId, 8767116) then --// X2 Gold
					AmountEarned.Value = AmountEarned.Value * 2
					PersonalEarnedAmount.Text = AmountEarned.Value
					X2Bonus.Visible = true
					BonusRewardsSFX:Play()
					wait(0.5)
					X2Bonus.Visible = false
				end
				
				if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.userId, 8786827) then --// VIP
					AmountEarned.Value = AmountEarned.Value + 25
					PersonalEarnedAmount.Text = AmountEarned.Value
					VIPBonus.Visible = true
					BonusRewardsSFX:Play()
					wait(0.5)
					VIPBonus.Visible = false
				end
			end
		
			if player.Name == ThirdPlace.Value then
				AmountEarned.Value = 70	
				PersonalEarnedAmount.Text = AmountEarned.Value
				
				wait(1)	
				
				if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.userId, 8767116) then --// X2 Gold
					AmountEarned.Value = AmountEarned.Value * 2
					PersonalEarnedAmount.Text = AmountEarned.Value
					X2Bonus.Visible = true
					BonusRewardsSFX:Play()
					wait(0.5)
					X2Bonus.Visible = false
				end
				
				if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.userId, 8786827) then --// VIP
					AmountEarned.Value = AmountEarned.Value + 25
					PersonalEarnedAmount.Text = AmountEarned.Value
					VIPBonus.Visible = true
					BonusRewardsSFX:Play()
					wait(0.5)
					VIPBonus.Visible = false
				end
			end
			
			if DidPlayerParticipate == true and player.Name ~= FirstPlace.Value and player.Name ~= SecondPlace.Value and player.Name ~= ThirdPlace.Value then
				AmountEarned.Value = 50	
				PersonalEarnedAmount.Text = AmountEarned.Value
				
				wait(1)
				
				if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.userId, 8767116) then --// X2 Gold
					AmountEarned.Value = AmountEarned.Value * 2
					PersonalEarnedAmount.Text = AmountEarned.Value
					X2Bonus.Visible = true
					BonusRewardsSFX:Play()
					wait(0.5)
					X2Bonus.Visible = false
				end
				
				if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.userId, 8786827) then --// VIP
					AmountEarned.Value = AmountEarned.Value + 25
					PersonalEarnedAmount.Text = AmountEarned.Value
					VIPBonus.Visible = true
					BonusRewardsSFX:Play()
					wait(0.5)
					VIPBonus.Visible = false
				end	
			end
			
			if DidPlayerParticipate == false then
				AmountEarned.Value = 0
				PersonalEarnedAmount.Text = AmountEarned.Value
				wait(1)
			end
			
		else
			AmountEarned.Value = 0
			PersonalEarnedAmount.Text = AmountEarned.Value
		end
		
		CloseButton.Visible = true
		CloseButton.Selectable = true
		
		wait(ViewTime)
		
		CloseButton.Visible = false
		CloseButton.Selectable = false
		
		PodiumMainFrame:TweenSizeAndPosition(UDim2.new(0,0,0,0),UDim2.new(0.5,0,0.5,0), 0.05)
		
		wait(1)
		
		PodiumMainFrame.Visible = false
		
	
	end
	
end)

game:GetService("ScriptContext").Error:Connect(function()
	
	warn("Error has occured with podium; closing now.")
	
	CloseButton.Visible = false
	CloseButton.Selectable = false
		
	PodiumMainFrame:TweenSizeAndPosition(UDim2.new(0,0,0,0),UDim2.new(0.5,0,0.5,0), 0.05)
		
	wait(1)
		
	PodiumMainFrame.Visible = false
	
end)
