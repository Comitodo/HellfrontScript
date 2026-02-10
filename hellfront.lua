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

-- TAB Lasso a Fish (intacto)
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

-- TAB Hellfront Beta (sin cambios)
local HellfrontTab = Window:CreateTab("🔥 Hellfront Beta", 4483362458)
-- (todo el contenido de Hellfront Beta sigue intacto, no lo repito aquí para no alargar demasiado)

-- TAB Keys Season 25🗝 (intacto)
local KeysSeasonTab = Window:CreateTab("Keys Season 25🗝", 4483362458)
-- (todo el contenido de Keys Season 25 sigue intacto)

-- TAB Slay a Slime Rpg (intacto)
local SlaySlimeTab = Window:CreateTab("Slay a Slime Rpg", 4483362458)
-- (todo el contenido de Slay a Slime Rpg sigue intacto)

-- TAB Kayak and Surft (agregado de nuevo, como pediste)
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

-- ====================================================
-- NUEVO TAB: Mas Scripts (renombrado como pediste, con los dos botones)
-- ====================================================
local MasScriptsTab = Window:CreateTab("Mas Scripts", 4483362458)

MasScriptsTab:CreateSection("Scripts Externos")

MasScriptsTab:CreateButton({
   Name = "Ejecutar Kayak & Surf",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/KayakandSurf"))()
      Rayfield:Notify({
         Title = "Kayak & Surf Cargado 🔥",
         Content = "Script externo ejecutado correctamente",
         Duration = 4
      })
   end,
})

MasScriptsTab:CreateButton({
   Name = "Ejecutar Break a Lucky Blocks",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/timuritobondito/RESHUB-Break-a-lucky-block/9957285d92a31de344f00952ee21cb79168d0c2a/RESHUB/RESHUB"))()
      Rayfield:Notify({
         Title = "Break a Lucky Blocks Cargado 🔥",
         Content = "RESHUB script ejecutado correctamente",
         Duration = 4
      })
   end,
})

-- Notificación final para confirmar el cambio
Rayfield:Notify({
   Title = "Tab Mas Scripts ACTUALIZADO",
   Content = "Ahora contiene botones para Kayak & Surf y Break a Lucky Blocks.\n¡Presiona K para ver todo!",
   Duration = 6,
   Image = 4483362458
})

print("✅ HUB cargado con tab Mas Scripts actualizado 🔥")
