local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🐟 Lasso | 🌊 Escape | 🔥 Hellfront Multi-Hub",
   LoadingTitle = "Skyming Error404",
   LoadingSubtitle = "2026 Edition - Hellfront Editado",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "MultiHubProHellfrontEdit",
   },
   KeySystem = true,
   KeySettings = {
      Title = "Skyming Auth",
      Subtitle = "Ingresa la contraseña",
      Note = "GIve password: https://cuty.io/5UFCAhPzWfaP or Discord",
      FileName = "SkymingKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = "Anubissxxxx404"  -- Contraseña real
   },
})

-- Notificación fija con botón para copiar Discord (aparece después de ingresar key)
Rayfield:Notify({
   Title = "¡Bienvenido al Hub!",
   Content = "Discord oficial para la contraseña y updates: https://discord.gg/SjNVwQ7Q\nPulsa el botón para copiar el link",
   Duration = 15,  -- Más tiempo para que lo veas
   Image = 4483362458,
   Actions = {
      Ignore = {
         Name = "Copiar Discord Link",
         Callback = function()
            if setclipboard then
               setclipboard("https://discord.gg/SjNVwQ7Q")
               Rayfield:Notify({
                  Title = "¡Copiado!",
                  Content = "Link copiado al portapapeles: https://discord.gg/SjNVwQ7Q",
                  Duration = 5
               })
            else
               Rayfield:Notify({
                  Title = "No se pudo copiar",
                  Content = "Tu executor no soporta copiar. Pega manualmente: https://discord.gg/SjNVwQ7Q",
                  Duration = 8
               })
            end
         end
      }
   }
})

-- TAB Lasso a Fish (sin cambios)
local LassoTab = Window:CreateTab("🐟 Lasso a Fish", 4483362458)
LassoTab:CreateSection("Autofarm & Movimiento")

LassoTab:CreateToggle({
   Name = "Salto Infinito",
   CurrentValue = false,
   Flag = "InfiniteJumpLasso",
   Callback = function(Value)
      if Value then
         getgenv().InfiniteJumpConnLasso = game:GetService("UserInputService").JumpRequest:Connect(function()
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
         end)
      else
         if getgenv().InfiniteJumpConnLasso then getgenv().InfiniteJumpConnLasso:Disconnect() end
      end
   end,
})

LassoTab:CreateToggle({
   Name = "Speed x3",
   CurrentValue = false,
   Flag = "SpeedLasso",
   Callback = function(Value)
      local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
      if hum then hum.WalkSpeed = Value and 48 or 16 end
   end,
})

-- Fly agregado al tab Lasso a Fish
LassoTab:CreateToggle({
   Name = "Fly (WASD + Space/Ctrl)",
   CurrentValue = false,
   Flag = "FlyLasso",
   Callback = function(Value)
      getgenv().FlyEnabledLasso = Value
      local player = game.Players.LocalPlayer
      local uis = game:GetService("UserInputService")
      if Value then
         local char = player.Character
         if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
               local bv = Instance.new("BodyVelocity")
               bv.MaxForce = Vector3.new(4000, 4000, 4000)
               bv.Parent = hrp
               getgenv().FlyBVLasso = bv
               game:GetService("RunService").Heartbeat:Connect(function()
                  if not getgenv().FlyEnabledLasso then return end
                  local cam = workspace.CurrentCamera
                  local speed = 50
                  local dir = Vector3.new()
                  if uis:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
                  if uis:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
                  if uis:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
                  if uis:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
                  if uis:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
                  if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
                  bv.Velocity = dir * speed
               end)
               Rayfield:Notify({
                  Title = "Fly Activado",
                  Content = "Usa WASD para mover, Space para subir, Ctrl para bajar",
                  Duration = 5
               })
            else
               Rayfield:Notify({Title = "Error", Content = "No se encontró HumanoidRootPart", Duration = 4})
            end
         else
            Rayfield:Notify({Title = "Error", Content = "Personaje no cargado", Duration = 4})
         end
      else
         if getgenv().FlyBVLasso then getgenv().FlyBVLasso:Destroy() end
         Rayfield:Notify({Title = "Fly Desactivado", Content = "Vuelo desactivado", Duration = 3})
      end
   end,
})

LassoTab:CreateButton({
   Name = "TP a Pez Más Cercano",
   Callback = function()
      local player = game.Players.LocalPlayer
      local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
      if hrp then
         local nearest, minDist = nil, math.huge
         for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ClickDetector") and string.lower(obj.Parent.Name):find("fish") then
               local part = obj.Parent.PrimaryPart or obj.Parent:FindFirstChildOfClass("BasePart")
               if part then
                  local dist = (part.Position - hrp.Position).Magnitude
                  if dist < minDist then minDist = dist; nearest = part end
               end
            end
         end
         if nearest then
            hrp.CFrame = nearest.CFrame * CFrame.new(0, 5, -5)
            Rayfield:Notify({Title = "TP Pez ✅", Content = "¡Al pez más cercano!", Duration = 3})
         else
            Rayfield:Notify({Title = "Error", Content = "No se encontró pez cercano", Duration = 4})
         end
      else
         Rayfield:Notify({Title = "Error", Content = "No se encontró HumanoidRootPart", Duration = 4})
      end
   end,
})

-- TAB Escape Waves (sin cambios)
local EscapeTab = Window:CreateTab("🌊 Escape Waves", 4483362458)
EscapeTab:CreateSection("Auto Farm & Extras")

EscapeTab:CreateToggle({
   Name = "Auto Collect Cash (Brainrot Stands)",
   CurrentValue = false,
   Flag = "AutoFarmCashFIX",
   Callback = function(Value)
      getgenv().AutoFarmCashEnabled = Value
      if Value then
         spawn(function()
            while getgenv().AutoFarmCashEnabled do
               pcall(function()
                  for _, p in ipairs(workspace:GetDescendants()) do
                     if p:IsA("ProximityPrompt") and (p.Parent.Name:lower():find("brainrot") or p.Parent.Name:lower():find("stand")) then
                        fireproximityprompt(p)
                     end
                  end
               end)
               wait(0.3)
            end
         end)
      end
   end,
})

EscapeTab:CreateToggle({
   Name = "God Mode (Inf Health)",
   CurrentValue = false,
   Flag = "GodFIX",
   Callback = function(Value)
      getgenv().GodEnabled = Value
      spawn(function()
         while getgenv().GodEnabled do
            local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then
               hum.Health = math.huge
               hum.MaxHealth = math.huge
            end
            wait(1)
         end
      end)
   end,
})

EscapeTab:CreateToggle({
   Name = "Fly (WASD + Space/Ctrl)",
   CurrentValue = false,
   Flag = "FlyFIX",
   Callback = function(Value)
      getgenv().FlyEnabled = Value
      local player = game.Players.LocalPlayer
      local uis = game:GetService("UserInputService")
      if Value then
         local char = player.Character
         local hrp = char:FindFirstChild("HumanoidRootPart")
         if hrp then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(4000, 4000, 4000)
            bv.Parent = hrp
            getgenv().FlyBV = bv
            game:GetService("RunService").Heartbeat:Connect(function()
               if not getgenv().FlyEnabled then return end
               local cam = workspace.CurrentCamera
               local speed = 50
               local dir = Vector3.new()
               if uis:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
               if uis:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
               if uis:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
               if uis:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
               if uis:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
               if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
               bv.Velocity = dir * speed
            end)
         end
      else
         if getgenv().FlyBV then getgenv().FlyBV:Destroy() end
      end
   end,
})

-- TAB Hellfront Beta (sin cambios en este ejemplo, pero puedes pegar tu versión anterior aquí si quieres)
local HellfrontTab = Window:CreateTab("🔥 Hellfront Beta", 4483362458)

HellfrontTab:CreateSection("🔫 Aimbot Lock (NPCs/Mobs)")
HellfrontTab:CreateToggle({
   Name = "Enable Aimbot Lock",
   CurrentValue = false,
   Flag = "AimbotLock",
   Callback = function(Value)
      getgenv().AimbotLockEnabled = Value
      if not Value then getgenv().AimbotActive = false end
   end,
})
HellfrontTab:CreateDropdown({
   Name = "Tecla para mantener (Hold Key)",
   Options = {"MouseButton2", "E", "Q", "F", "G", "LeftShift", "RightShift"},
   CurrentOption = "MouseButton2",
   Flag = "AimbotKeybind",
   Callback = function(Option)
      getgenv().AimbotKey = Option
   end,
})
HellfrontTab:CreateSlider({
   Name = "Distancia máxima Aimbot",
   Range = {200, 2000},
   Increment = 50,
   CurrentValue = 1000,
   Flag = "MaxAimbotDist",
   Callback = function(Value)
      getgenv().MaxAimbotDist = Value
   end,
})

HellfrontTab:CreateSection("💎 ESP Crystals (Solo Texto - Nombre + Distancia)")
HellfrontTab:CreateToggle({
   Name = "ESP Crystals (Solo Texto)",
   CurrentValue = false,
   Flag = "CrystalESP",
   Callback = function(Value)
      getgenv().CrystalESPEnabled = Value
   end,
})
HellfrontTab:CreateSlider({
   Name = "Distancia máxima ESP Crystals",
   Range = {100, 5000},
   Increment = 100,
   CurrentValue = 3000,
   Flag = "MaxCrystalDist",
   Callback = function(Value)
      getgenv().MaxCrystalDist = Value
   end,
})

HellfrontTab:CreateSection("✨ Teleport a Crystals")

local CrystalDropdown = HellfrontTab:CreateDropdown({
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
                  if crystal.Name == size then
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

HellfrontTab:CreateButton({
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

HellfrontTab:CreateButton({
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

HellfrontTab:CreateSection("🔄 Auto TP al Crystal más cercano")
HellfrontTab:CreateToggle({
   Name = "Auto TP al Crystal más cercano",
   CurrentValue = false,
   Flag = "AutoTPCrystal",
   Callback = function(Value)
      getgenv().AutoTPCrystalEnabled = Value
   end,
})
HellfrontTab:CreateSlider({
   Name = "Distancia máxima para Auto TP",
   Range = {50, 1500},
   Increment = 25,
   CurrentValue = 400,
   Flag = "AutoTPMaxDist",
   Callback = function(Value)
      getgenv().AutoTPMaxDist = Value
   end,
})
HellfrontTab:CreateSlider({
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
-- Variables globales necesarias
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
-- Lógica Aimbot + ESP + Auto TP
-- ====================================================

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local localPlayer = Players.LocalPlayer

local ESPDrawings = {}
local CrystalDrawings = {}

local function cleanupESP()
   for _, d in pairs(ESPDrawings) do if d then d:Remove() end end
   ESPDrawings = {}
end

local function cleanupCrystalESP()
   for _, d in pairs(CrystalDrawings) do if d and d.Remove then d:Remove() end end
   CrystalDrawings = {}
end

RunService.RenderStepped:Connect(function()
   cleanupESP()
   cleanupCrystalESP()
   
   -- Aimbot Lock
   if getgenv().AimbotLockEnabled and getgenv().AimbotActive then
      local nearest, minDist = nil, getgenv().MaxAimbotDist + 1
      local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
      if hrp then
         for _, model in ipairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model:FindFirstChild("Head") and model:FindFirstChild("Humanoid") 
               and model ~= localPlayer.Character and not Players:GetPlayerFromCharacter(model) then
               local dist = (model.Head.Position - hrp.Position).Magnitude
               if dist < minDist then
                  minDist = dist
                  nearest = model
               end
            end
         end
         if nearest and nearest.Head then
            local targetCFrame = CFrame.lookAt(Camera.CFrame.Position, nearest.Head.Position)
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 0.25)
         end
      end
   end
   
   -- ESP Crystals texto
   if getgenv().CrystalESPEnabled then
      local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
      if hrp then
         local crystalsFolder = workspace:FindFirstChild("Crystals")
         if crystalsFolder then
            for _, folder in ipairs({crystalsFolder:FindFirstChild("Purple"), crystalsFolder:FindFirstChild("Blue")}) do
               if folder then
                  for _, crystal in ipairs(folder:GetChildren()) do
                     if crystal:IsA("Model") and crystal.PrimaryPart then
                        local pos = crystal.PrimaryPart.Position
                        local dist = (pos - hrp.Position).Magnitude
                        if dist > getgenv().MaxCrystalDist then continue end
                        
                        local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
                        if onScreen then
                           local text = Drawing.new("Text")
                           text.Position = Vector2.new(screenPos.X, screenPos.Y)
                           text.Size = 17
                           text.Color = folder.Name == "Purple" and Color3.fromRGB(200, 0, 255) or Color3.fromRGB(0, 150, 255)
                           text.Outline = true
                           text.OutlineColor = Color3.new(0,0,0)
                           text.Center = true
                           text.Font = 2
                           text.Text = crystal.Name .. " (" .. math.floor(dist) .. "m)"
                           text.Visible = true
                           table.insert(CrystalDrawings, text)
                        end
                     end
                  end
               end
            end
         end
      end
   end
end)

-- Auto TP
spawn(function()
   while true do
      task.wait(getgenv().AutoTPInterval or 4)
      
      if not getgenv().AutoTPCrystalEnabled then continue end
      
      local char = localPlayer.Character
      local hrp = char and char:FindFirstChild("HumanoidRootPart")
      if not hrp then continue end
      
      local crystalsFolder = workspace:FindFirstChild("Crystals")
      if not crystalsFolder then continue end
      
      local nearest, minDist = nil, getgenv().AutoTPMaxDist + 1
      for _, folder in ipairs({crystalsFolder:FindFirstChild("Purple"), crystalsFolder:FindFirstChild("Blue")}) do
         if folder then
            for _, crystal in ipairs(folder:GetChildren()) do
               if crystal:IsA("Model") and crystal.PrimaryPart then
                  local dist = (crystal.PrimaryPart.Position - hrp.Position).Magnitude
                  if dist < minDist then
                     minDist = dist
                     nearest = crystal
                  end
               end
            end
         end
      end
      
      if nearest and nearest.PrimaryPart and minDist <= getgenv().AutoTPMaxDist then
         local targetPos = nearest.PrimaryPart.Position + Vector3.new(0, 6, 0)
         
         if hrp:FindFirstChild("AutoTPBodyPos") then hrp.AutoTPBodyPos:Destroy() end
         if hrp:FindFirstChild("AutoTPBodyGyro") then hrp.AutoTPBodyGyro:Destroy() end
         
         local bp = Instance.new("BodyPosition")
         bp.Name = "AutoTPBodyPos"
         bp.MaxForce = Vector3.new(1e5, 1e5, 1e5)
         bp.Position = targetPos
         bp.P = 15000
         bp.D = 1000
         bp.Parent = hrp
         
         local bg = Instance.new("BodyGyro")
         bg.Name = "AutoTPBodyGyro"
         bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
         bg.CFrame = CFrame.new(hrp.Position, targetPos)
         bg.P = 15000
         bg.D = 1000
         bg.Parent = hrp
         
         spawn(function()
            task.wait(2)
            if bp and bp.Parent then bp:Destroy() end
            if bg and bg.Parent then bg:Destroy() end
         end)
         
         Rayfield:Notify({
            Title = "Auto TP Activo",
            Content = "Moviendo a " .. nearest.Name .. " (" .. math.floor(minDist) .. "m)",
            Duration = 4
         })
      end
   end
end)

print("✅ HUB cargado con contraseña y Discord copiable")
