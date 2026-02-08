local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🔥 HELLFRONT Beta | By Skyming Anubissxxxx",
   LoadingTitle = "Loading.......",
   LoadingSubtitle = "2026 - V1.2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "HellfrontAimbotCrystalsFull",
   },
   KeySystem = false,
})

Rayfield:Notify({
   Title = "Hellfront Hub Completo 🔥",
   Content = "Aimbot + ESP texto + TP manual + Auto TP al más cercano (BodyPosition)",
   Duration = 7,
   Image = 4483362458,
})

local MainTab = Window:CreateTab("🔥 HELLFRONT Beta", 4483362458)

-- AIMBOT (sin cambios)
MainTab:CreateSection("🔫 Aimbot Lock (NPCs/Mobs)")
MainTab:CreateToggle({
   Name = "Enable Aimbot Lock",
   CurrentValue = false,
   Flag = "AimbotLock",
   Callback = function(Value)
      getgenv().AimbotLockEnabled = Value
      if not Value then getgenv().AimbotActive = false end
   end,
})
MainTab:CreateDropdown({
   Name = "Tecla para mantener (Hold Key)",
   Options = {"MouseButton2", "E", "Q", "F", "G", "LeftShift", "RightShift"},
   CurrentOption = "MouseButton2",
   Flag = "AimbotKeybind",
   Callback = function(Option)
      getgenv().AimbotKey = Option
   end,
})
MainTab:CreateSlider({
   Name = "Distancia máxima Aimbot",
   Range = {200, 2000},
   Increment = 50,
   CurrentValue = 1000,
   Flag = "MaxAimbotDist",
   Callback = function(Value)
      getgenv().MaxAimbotDist = Value
   end,
})

-- ESP Crystals (solo texto, sin cambios)
MainTab:CreateSection("💎 ESP Crystals (Solo Texto - Nombre + Distancia)")
local CrystalESPToggle = MainTab:CreateToggle({
   Name = "ESP Crystals (Solo Texto)",
   CurrentValue = false,
   Flag = "CrystalESP",
   Callback = function(Value)
      getgenv().CrystalESPEnabled = Value
   end,
})
MainTab:CreateSlider({
   Name = "Distancia máxima ESP Crystals",
   Range = {100, 5000},
   Increment = 100,
   CurrentValue = 3000,
   Flag = "MaxCrystalDist",
   Callback = function(Value)
      getgenv().MaxCrystalDist = Value
   end,
})

-- TELEPORT MANUAL + AUTO (sección completa)
MainTab:CreateSection("✨ Teleport a Crystals")

-- Dropdown y Refresh (manual)
local CrystalDropdown = MainTab:CreateDropdown({
   Name = "Seleccionar Crystal para TP Manual",
   Options = {"Ninguno"},
   CurrentOption = "Ninguno",
   Flag = "CrystalTPSelect",
   Callback = function(Option)
      if Option == "Ninguno" then
         getgenv().SelectedCrystal = nil
         return
      end
      local size = Option:match("^(%w+)")
      local color = Option:match("%((%w+)%)")
      if size and color then
         local crystalsFolder = workspace:FindFirstChild("Crystals")
         if crystalsFolder then
            local folder = crystalsFolder:FindFirstChild(color)
            if folder then
               for _, crystal in ipairs(folder:GetChildren()) do
                  if crystal.Name == size and crystal:IsA("Model") then
                     getgenv().SelectedCrystal = crystal
                     Rayfield:Notify({Title = "Seleccionado", Content = size .. " (" .. color .. ")", Duration = 3})
                     return
                  end
               end
            end
         end
      end
      Rayfield:Notify({Title = "Error", Content = "No encontrado", Duration = 3})
   end,
})

MainTab:CreateButton({
   Name = "🔄 Refresh Lista Crystals",
   Callback = function()
      local options = {"Ninguno"}
      local crystalsFolder = workspace:FindFirstChild("Crystals")
      if not crystalsFolder then
         Rayfield:Notify({Title = "Error", Content = "No se encontró Crystals", Duration = 4})
         return
      end
      
      local function addCrystals(folder, color)
         if folder then
            for _, crystal in ipairs(folder:GetChildren()) do
               if crystal:IsA("Model") and crystal.PrimaryPart then
                  table.insert(options, crystal.Name .. " (" .. color .. ")")
               end
            end
         end
      end
      
      addCrystals(crystalsFolder:FindFirstChild("Purple"), "Purple")
      addCrystals(crystalsFolder:FindFirstChild("Blue"), "Blue")
      
      CrystalDropdown:Refresh(options, true)
      Rayfield:Notify({Title = "Lista Actualizada", Content = #options - 1 .. " cristales encontrados", Duration = 4})
   end,
})

MainTab:CreateButton({
   Name = "🚀 TP Manual al Seleccionado",
   Callback = function()
      if not getgenv().SelectedCrystal or not getgenv().SelectedCrystal.PrimaryPart then
         Rayfield:Notify({Title = "Error", Content = "Selecciona un crystal primero", Duration = 4})
         return
      end
      
      local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
      if not hrp then return end
      
      local targetPos = getgenv().SelectedCrystal.PrimaryPart.Position + Vector3.new(0, 6, 0)
      hrp.CFrame = CFrame.new(targetPos)
      Rayfield:Notify({Title = "TP Manual", Content = "¡Teletransportado!", Duration = 3})
   end,
})

-- AUTO TP (nuevo - usando BodyPosition + BodyGyro)
MainTab:CreateSection("🔄 Auto TP al Crystal más cercano")
MainTab:CreateToggle({
   Name = "Auto TP al Crystal más cercano",
   CurrentValue = false,
   Flag = "AutoTPCrystal",
   Callback = function(Value)
      getgenv().AutoTPCrystalEnabled = Value
   end,
})
MainTab:CreateSlider({
   Name = "Distancia máxima para Auto TP",
   Range = {50, 1500},
   Increment = 25,
   CurrentValue = 400,
   Flag = "AutoTPMaxDist",
   Callback = function(Value)
      getgenv().AutoTPMaxDist = Value
   end,
})
MainTab:CreateSlider({
   Name = "Intervalo entre TPs (segundos)",
   Range = {2, 12},
   Increment = 1,
   CurrentValue = 4,
   Flag = "AutoTPInterval",
   Callback = function(Value)
      getgenv().AutoTPInterval = Value
   end,
})

-- ====================================================
-- Variables globales
-- ====================================================
getgenv().AimbotLockEnabled = false
getgenv().AimbotActive = false
getgenv().AimbotKey = "MouseButton2"
getgenv().MaxAimbotDist = 1000
getgenv().CrystalESPEnabled = false
getgenv().MaxCrystalDist = 3000
getgenv().SelectedCrystal = nil
getgenv().AutoTPCrystalEnabled = false
getgenv().AutoTPMaxDist = 400
getgenv().AutoTPInterval = 4

-- ====================================================
-- Servicios
-- ====================================================
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local localPlayer = Players.LocalPlayer

-- ====================================================
-- Aimbot (sin cambios)
-- ====================================================
local NPCList = {}
local lastUpdate = 0
local updateInterval = 0.15

local function getValidNPCs()
   local npcs = {}
   for _, obj in ipairs(workspace:GetDescendants()) do
      if obj:IsA("Model") and obj ~= localPlayer.Character and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("Head") and obj:FindFirstChild("HumanoidRootPart") and not Players:GetPlayerFromCharacter(obj) then
         local hum = obj:FindFirstChildOfClass("Humanoid")
         if hum and hum.Health > 0 then
            table.insert(npcs, obj)
         end
      end
   end
   return npcs
end

RunService.Heartbeat:Connect(function()
   if tick() - lastUpdate >= updateInterval then
      NPCList = getValidNPCs()
      lastUpdate = tick()
   end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
   if gameProcessed then return end
   if input.UserInputType.Name == getgenv().AimbotKey or input.KeyCode.Name == getgenv().AimbotKey then
      getgenv().AimbotActive = true
   end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
   if gameProcessed then return end
   if input.UserInputType.Name == getgenv().AimbotKey or input.KeyCode.Name == getgenv().AimbotKey then
      getgenv().AimbotActive = false
   end
end)

RunService.RenderStepped:Connect(function()
   if not (getgenv().AimbotLockEnabled and getgenv().AimbotActive) then return end
   local nearest, minDist = nil, math.huge
   local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
   if not hrp then return end
   for _, model in ipairs(NPCList) do
      if model.Head and model.HumanoidRootPart then
         local dist = (model.Head.Position - hrp.Position).Magnitude
         if dist < getgenv().MaxAimbotDist and dist < minDist then
            minDist = dist
            nearest = model
         end
      end
   end
   if nearest and nearest.Head then
      local targetCFrame = CFrame.lookAt(Camera.CFrame.Position, nearest.Head.Position)
      Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 0.25)
   end
end)

-- ====================================================
-- ESP Crystals solo texto (sin cambios)
-- ====================================================
local CrystalDrawings = {}
local function cleanupCrystalESP()
   for _, d in pairs(CrystalDrawings) do if d and d.Remove then d:Remove() end end
   CrystalDrawings = {}
end

RunService.RenderStepped:Connect(function()
   cleanupCrystalESP()
   if not getgenv().CrystalESPEnabled then return end
   
   local crystalsFolder = workspace:FindFirstChild("Crystals")
   if not crystalsFolder then return end
   
   local folders = {crystalsFolder:FindFirstChild("Purple"), crystalsFolder:FindFirstChild("Blue")}
   local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
   if not hrp then return end
   
   for _, folder in ipairs(folders) do
      if folder then
         local color = folder.Name == "Purple" and Color3.fromRGB(200, 0, 255) or Color3.fromRGB(0, 150, 255)
         for _, crystal in ipairs(folder:GetChildren()) do
            if crystal:IsA("Model") and crystal.PrimaryPart then
               local pos = crystal.PrimaryPart.Position
               local dist = (pos - hrp.Position).Magnitude
               if dist > getgenv().MaxCrystalDist then continue end
               local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
               if not onScreen then continue end
               
               local text = Drawing.new("Text")
               text.Position = Vector2.new(screenPos.X, screenPos.Y)
               text.Size = 17
               text.Color = color
               text.Outline = true
               text.OutlineColor = Color3.new(0,0,0)
               text.Center = true
               text.Font = 2
               text.Text = crystal.Name .. " (" .. math.floor(dist) .. ")"
               text.Visible = true
               table.insert(CrystalDrawings, text)
            end
         end
      end
   end
end)

-- ====================================================
-- AUTO TP - Método alternativo con BodyPosition + BodyGyro
-- ====================================================
spawn(function()
   while true do
      wait(getgenv().AutoTPInterval or 4)
      
      if not getgenv().AutoTPCrystalEnabled then continue end
      
      local player = game.Players.LocalPlayer
      local char = player.Character
      local hrp = char and char:FindFirstChild("HumanoidRootPart")
      if not hrp or not char then continue end
      
      local crystalsFolder = workspace:FindFirstChild("Crystals")
      if not crystalsFolder then continue end
      
      local nearestCrystal = nil
      local minDist = getgenv().AutoTPMaxDist + 1
      
      for _, folderName in ipairs({"Purple", "Blue"}) do
         local folder = crystalsFolder:FindFirstChild(folderName)
         if folder then
            for _, crystal in ipairs(folder:GetChildren()) do
               if crystal:IsA("Model") and crystal.PrimaryPart then
                  local dist = (crystal.PrimaryPart.Position - hrp.Position).Magnitude
                  if dist < minDist then
                     minDist = dist
                     nearestCrystal = crystal
                  end
               end
            end
         end
      end
      
      if nearestCrystal and nearestCrystal.PrimaryPart and minDist <= getgenv().AutoTPMaxDist then
         local targetPos = nearestCrystal.PrimaryPart.Position + Vector3.new(0, 6, 0)
         
         -- Limpiar instancias previas si existen
         if hrp:FindFirstChild("AutoTPBodyPos") then
            hrp.AutoTPBodyPos:Destroy()
         end
         if hrp:FindFirstChild("AutoTPBodyGyro") then
            hrp.AutoTPBodyGyro:Destroy()
         end
         
         -- BodyPosition para mover
         local bp = Instance.new("BodyPosition")
         bp.Name = "AutoTPBodyPos"
         bp.MaxForce = Vector3.new(1e5, 1e5, 1e5)
         bp.Position = targetPos
         bp.P = 15000
         bp.D = 1000
         bp.Parent = hrp
         
         -- BodyGyro para orientación (opcional pero ayuda a no girar raro)
         local bg = Instance.new("BodyGyro")
         bg.Name = "AutoTPBodyGyro"
         bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
         bg.CFrame = CFrame.new(hrp.Position, targetPos)
         bg.P = 15000
         bg.D = 1000
         bg.Parent = hrp
         
         -- Esperar a llegar cerca y luego limpiar
         spawn(function()
            wait(1.5) -- tiempo suficiente para llegar
            if bp and bp.Parent then bp:Destroy() end
            if bg and bg.Parent then bg:Destroy() end
         end)
         
         Rayfield:Notify({
            Title = "Auto TP",
            Content = "Moviendo a " .. nearestCrystal.Name .. " (" .. math.floor(minDist) .. " studs)",
            Duration = 4
         })
      end
   end
end)

print("✅ Hellfront cargado: Aimbot + ESP texto + TP manual + AUTO TP (BodyPosition)")
Rayfield:Notify({
   Title = "Auto TP agregado",
   Content = "Usa BodyPosition + BodyGyro (método alternativo) | Activa el toggle y ajusta distancia/intervalo",
   Duration = 5,
})
