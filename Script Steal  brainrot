local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create main window
local Window = Rayfield:CreateWindow({
   Name = "SharkHub",
   LoadingTitle = "SharkHub",
   LoadingSubtitle = "by Tuba",
   Theme = "Ocean",
   ConfigurationSaving = {
      Enabled = true,
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = true,
      Invite = "https://discord.gg/UetEjwpgsg",
      RememberJoins = true,
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "SharkHub Key",
      Subtitle = "Key System",
      Note = "Join In Discord for Key", -- Use this to tell the user how to get a key
      FileName = "SharkHubKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"SHARKHUB"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }

})




-- Create tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local EspTab = Window:CreateTab("ESP", 4483362458)

-- Shared variables
local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")

--[[
    BillboardGUI Feature
]]
local Toggle = EspTab:CreateToggle({
    Name = "Aumentar BillboardGui",
    CurrentValue = false,
    Flag = "BiggerBillboardToggle",
    Callback = function(Value)
        local function findBillboards()
            local billboards = {}
            local plotsFolder = workspace:FindFirstChild("Plots")
            
            if plotsFolder then
                for _, plot in ipairs(plotsFolder:GetChildren()) do
                    local purchase = plot:FindFirstChild("Purchases")
                    if purchase then
                        local plotBlock = purchase:FindFirstChild("PlotBlock")
                        if plotBlock then
                            local main = plotBlock:FindFirstChild("Main")
                            if main then
                                local billboard = main:FindFirstChild("BillboardGui")
                                if billboard and billboard:IsA("BillboardGui") then
                                    table.insert(billboards, billboard)
                                end
                            end
                        end
                    end
                end
            end
            
            return billboards
        end

        local billboards = findBillboards()
        for _, billboard in ipairs(billboards) do
            if Value then
                billboard.Size = UDim2.new(35, 0, 35, 0)
                billboard.AlwaysOnTop = true
                billboard.MaxDistance = 10000
            else
                billboard.Size = UDim2.new(7, 0, 10, 0)
                billboard.AlwaysOnTop = false
                billboard.MaxDistance = 60
            end
        end
    end
})

--[[
    Speed Control Feature (Simplified)
]]
local speedValue = 36
local speedConnection = nil

local SpeedSlider = MainTab:CreateSlider({
    Name = "SpeedControl",
    Range = {36, 100},
    Increment = 1,
    CurrentValue = 36,
    Flag = "SpeedControl",
    Callback = function(Value)
        speedValue = Value
    end
})

local function enforceSpeed()
    if speedConnection then
        speedConnection:Disconnect()
    end

    speedConnection = runService.Heartbeat:Connect(function()
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speedValue + math.random(-1, 1) * 0.3
        end
    end)
end

--[[
    Super Jump Feature WITH DEBUG
]]
local jumpValue = 7
local jumpConnection = nil
local jumpDebugLogs = {}
local lastJumpCheck = os.clock()

-- Função de log para SuperJump
local function logJump(message)
    local entry = "[JUMP DEBUG] "..os.date("%X").." | "..message
    table.insert(jumpDebugLogs, entry)
    print(entry)
end

local JumpSlider = MainTab:CreateSlider({
    Name = "JumpControl",
    Range = {7, 50},
    Increment = 1,
    CurrentValue = 7,
    Flag = "JumpControl",
    Callback = function(Value)
        jumpValue = Value
        logJump("Slider alterado para: "..Value.." de JumpPower")
    end
})

local function enforceJump()
    if jumpConnection then
        jumpConnection:Disconnect()
        logJump("Reiniciando conexão de pulo...")
    end

    jumpConnection = runService.Heartbeat:Connect(function()
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end

        -- Monitoramento de interferência
        if humanoid.JumpHeight ~= jumpValue then
            logJump(string.format(
                "Interferência detectada! Valor atual: %.1f | Corrigindo para: %.1f",
                humanoid.JumpHeight,
                jumpValue
            ))
        end

        -- Aplica com variação controlada
        local randomizedJump = jumpValue + math.random(-2, 2)
        humanoid.JumpHeight = randomizedJump

        -- Log de performance (a cada 5 segundos)
        if os.clock() - lastJumpCheck >= 5 then
            logJump(string.format(
                "Status | Alvo: %d | Aplicado: %d | FPS: %.1f",
                jumpValue,
                randomizedJump,
                1/runService.Heartbeat:Wait().DeltaTime
            ))
            lastJumpCheck = os.clock()
        end
    end)
    
    logJump("Sistema de pulo ativado")
end

-- Função para exportar logs (Shift+J)
local function exportJumpLogs()
    return table.concat(jumpDebugLogs, "\n")
end

game:GetService("UserInputService").InputBegan:Connect(function(input, _)
    if input.KeyCode == Enum.KeyCode.J then
        print("\n=== LOGS DE SUPERJUMP ===\n"..exportJumpLogs())
    end
end)

--[[
    Base Teleport Feature
]]
local PLAYER_BASE_POSITION = nil

local function findPlayerBase()
    local plotsFolder = workspace:FindFirstChild("Plots")
    if not plotsFolder then return nil end
    
    for _, plot in ipairs(plotsFolder:GetChildren()) do
        local plotSign = plot:FindFirstChild("PlotSign", true)
        if plotSign then
            local yourBase = plotSign:FindFirstChild("YourBase")
            if yourBase and yourBase.Enabled then
                return plotSign.Position
            end
        end
    end
    return nil
end



--[[
    Initialize all systems
]]
local function initialize()
    enforceSpeed()
    enforceJump()
    
    -- Find base periodically
    task.spawn(function()
        while true do
            if not PLAYER_BASE_POSITION then
                PLAYER_BASE_POSITION = findPlayerBase()
            end
            task.wait(5)
        end
    end)
    
    -- Handle respawns
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        enforceSpeed()
        enforceJump()
    end)
end

-- Start everything
initialize()
