local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "TubaHub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Tuba",
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local PlayerTab = Window:CreateTab("Player", 4483362458) -- Title, Image

local Slider = PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {10, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 10,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
    local player = game.Players.LocalPlayer
       local character = player.Character or player.CharacterAdded:Wait()
       local humanoid = character:FindFirstChildOfClass("Humanoid")
       
       if humanoid then
           humanoid.WalkSpeed = Value
       end
   end,
})

local Slider = PlayerTab:CreateSlider({
   Name = "JumpPower",
   Range = {10, 150},
   Increment = 1,
   Suffix = "Jump",
   CurrentValue = 10,
   Flag = "Slider2", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
  local player = game.Players.LocalPlayer
       local character = player.Character or player.CharacterAdded:Wait()
       local humanoid = character:FindFirstChildOfClass("Humanoid")
       
       if humanoid then
           humanoid.JumpPower = Value
       end
   end,
})

local AutoFarmTab = Window:CreateTab("AutoFarm", 4483362458) -- Title, Image

local Toggle = AutoFarmTab:CreateToggle({
   Name = "AutoClick",
   CurrentValue = false,
   Flag = "AutoClick", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
clicking = Value
if clicking then
    task.spawn(function()
        while clicking do
            local args = { [1] = true }
            game:GetService("ReplicatedStorage"):WaitForChild("Remote", 9e9)
                :WaitForChild("Event", 9e9)
                :WaitForChild("Train", 9e9)
                :WaitForChild("[C-S]PlayerTryClick", 9e9)
                :FireServer(unpack(args))
            task.wait(0.1)
        end
    end)
end
   end,
})

local Toggle = AutoFarmTab:CreateToggle({
   Name = "AutoClaimRewards",
   CurrentValue = false,
   Flag = "Claim", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
gettingReward = Value
        if gettingReward then
            task.spawn(function()
                while gettingReward do
                    for i = 1, 12 do -- tenta coletar da recompensa "1" até "7"
                        local args = {
                            [1] = tostring(i)
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("Remote", 9e9)
                            :WaitForChild("Event", 9e9)
                            :WaitForChild("Reward", 9e9)
                            :WaitForChild("[C-S]TryGetReward", 9e9)
                            :FireServer(unpack(args))
                        task.wait(0.1)
                    end
                    task.wait(1) -- espera 1 segundo antes de repetir o ciclo
                end
            end)
        end

   end,
})
