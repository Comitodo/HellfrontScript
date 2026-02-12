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
      Key = "DEADNOTE00003" -- Contraseña real
   },
})

-- Notificación fija con botón para copiar Discord
Rayfield:Notify({
   Title = "¡Bienvenido al Hub!",
   Content = "Discord oficial para la contraseña y updates: https://discord.gg/SjNVwQ7Q\nPulsa el botón para copiar el link",
   Duration = 15,
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

-- TAB Lasso a Fish
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

-- TAB Escape Waves
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

-- TAB Hellfront Beta (sin cambios)
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

-- TAB Kayak and Surft
local KayakTab = Window:CreateTab("Kayak and Surft", 4483362458)
KayakTab:CreateSection("Ejecutar Script Externo")
KayakTab:CreateButton({
   Name = "Ejecutar Kayak & Surf Script",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/KayakandSurf"))()
      Rayfield:Notify({
         Title = "Script Cargado",
         Content = "Kayak and Surf script ejecutado correctamente 🔥",
         Duration = 5
      })
   end,
})

-- TAB Climb for Bairon
local ClimbTab = Window:CreateTab("Climb for Bairon", 4483362458)
ClimbTab:CreateSection("Ejecutar Script Externo SNWHUB")
ClimbTab:CreateButton({
   Name = "Cargar Climb for Bairon (SNWHUB)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/therealkyosh/SNWHUB/b3a1aa2ad3b232f85aa44a32062a1ab450b5fb19/MainLoder"))()
      Rayfield:Notify({
         Title = "Script Cargado",
         Content = "Climb for Bairon / SNWHUB script ejecutado correctamente 🔥",
         Duration = 5
      })
   end,
})

-- =============================================
-- TAB TPKill Universal (REPARADO - funcional como antes)
-- =============================================
local TPKillTab = Window:CreateTab("TPKill Universal", 4483362458)

TPKillTab:CreateSection("Spam TP a Jugadores")

-- Variables locales para evitar conflictos
local tpkill_dist = 8
local tpkill_altura = 3
local tpkill_radio = 10

local tpkill_toggles = {}
local tpkill_active = {}

local function tpkill_tp_to_front(player)
   local lp = game.Players.LocalPlayer
   if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
   if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
   
   local hrp = lp.Character.HumanoidRootPart
   local targetCFrame = hrp.CFrame * CFrame.new(0, tpkill_altura, -tpkill_dist)
   
   player.Character.HumanoidRootPart.CFrame = targetCFrame
   player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
end

local function tpkill_refresh_players()
   for _, t in pairs(tpkill_toggles) do
      pcall(function() t:Destroy() end)
   end
   tpkill_toggles = {}
   
   local players = game.Players:GetPlayers()
   local found = 0
   
   for _, plr in pairs(players) do
      if plr ~= game.Players.LocalPlayer then
         found = found + 1
         local toggle = TPKillTab:CreateToggle({
            Name = "Spam TP → " .. plr.Name,
            CurrentValue = false,
            Callback = function(active)
               tpkill_active[plr.Name] = active
               if active then
                  spawn(function()
                     while tpkill_active[plr.Name] do
                        pcall(tpkill_tp_to_front, plr)
                        task.wait(0.03)
                     end
                  end)
               end
            end,
         })
         table.insert(tpkill_toggles, toggle)
      end
   end
   
   if found == 0 then
      TPKillTab:CreateLabel("No hay otros jugadores conectados")
   end
end

TPKillTab:CreateButton({
   Name = "🔄 Escanear / Actualizar Jugadores",
   Callback = function()
      pcall(tpkill_refresh_players)
   end,
})

-- Spam por radio
TPKillTab:CreateSection("Spam por Radio")
local tpkill_radio_on = false

TPKillTab:CreateToggle({
   Name = "Spam TP a jugadores cercanos (radio)",
   CurrentValue = false,
   Callback = function(val)
      tpkill_radio_on = val
      if val then
         spawn(function()
            while tpkill_radio_on do
               pcall(function()
                  local lp = game.Players.LocalPlayer
                  if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
                  
                  local myPos = lp.Character.HumanoidRootPart.Position
                  
                  for _, plr in pairs(game.Players:GetPlayers()) do
                     if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (plr.Character.HumanoidRootPart.Position - myPos).Magnitude
                        if dist <= tpkill_radio then
                           tpkill_tp_to_front(plr)
                        end
                     end
                  end
               end)
               task.wait(0.05)
            end
         end)
      end
   end,
})

-- Ajustes
TPKillTab:CreateSection("Ajustes")
TPKillTab:CreateSlider({
   Name = "Distancia enfrente",
   Range = {1, 30},
   Increment = 1,
   Suffix = "studs",
   CurrentValue = tpkill_dist,
   Callback = function(v) tpkill_dist = v end,
})

TPKillTab:CreateSlider({
   Name = "Altura arriba",
   Range = {0, 15},
   Increment = 1,
   Suffix = "studs",
   CurrentValue = tpkill_altura,
   Callback = function(v) tpkill_altura = v end,
})

TPKillTab:CreateSlider({
   Name = "Radio cercanos",
   Range = {5, 50},
   Increment = 1,
   Suffix = "studs",
   CurrentValue = tpkill_radio,
   Callback = function(v) tpkill_radio = v end,
})

-- Inicializar
spawn(function()
   task.wait(1.5)
   pcall(tpkill_refresh_players)
end)

game.Players.PlayerAdded:Connect(function() task.wait(1) pcall(tpkill_refresh_players) end)
game.Players.PlayerRemoving:Connect(function() pcall(tpkill_refresh_players) end)

-- =============================================
-- Final del script (notificación)
-- =============================================
Rayfield:Notify({
   Title = "Hub Cargado Correctamente",
   Content = "Todos los tabs están disponibles, incluido TPKill Universal reparado.\nPresiona K para abrir el menú.",
   Duration = 6,
   Image = 4483362458
})

print("✅ HUB completo cargado - TPKill Universal reparado y funcional")
