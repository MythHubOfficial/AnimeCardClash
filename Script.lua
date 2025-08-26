--[[
  ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗
  ║                    🚀 ULTIMATE ROBLOX REVERSE ENGINEERING SCRIPT V2.0 🚀                                ║
  ║                    💀 PROXIMITY GUI DETECTION & LIVE DASHBOARD EDITION 💀                               ║
  ╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════╣
  ║  🔥 NEW ULTIMATE FEATURES:                                                                                ║
  ║  • 📍 ProximityPrompt & Distance-Based GUI Detection                                                     ║
  ║  • 📊 Live Dashboard with Real-Time Updates                                                              ║
  ║  • 🎯 Interactive Elements Scanner & Monitor                                                              ║
  ║  • 📏 Distance-Based Interaction Tracking                                                                ║
  ║  • 🖼️  Enhanced GUI State Management                                                                     ║
  ║  • 📡 Advanced Network Traffic Visualization                                                             ║
  ║  • 🔄 Real-Time Property Change Monitoring                                                               ║
  ║  • 🎮 Comprehensive Player Action Analytics                                                               ║
  ║  • 👻 Advanced Stealth & Anti-Detection Systems                                                          ║
  ║  • 🛡️  Multi-Layer Bypass Protection                                                                     ║
  ║  • 🔍 Memory & Value Change Detection                                                                    ║
  ║  • ⚡ Lightning-Fast Live Updates                                                                        ║
  ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝
--]]

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🛡️ STEALTH & ANTI-DETECTION INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

-- Obfuscated service getters to avoid detection
local function getService(name)
    return game:GetService(name)
end

-- Dynamic string generation to avoid static analysis  
local function dynStr(...)
    local parts = {...}
    return table.concat(parts)
end

-- Services with randomized variable names for maximum stealth
local Players = getService(dynStr("Play", "ers"))
local ReplicatedStorage = getService(dynStr("Replica", "ted", "Storage"))
local StarterGui = getService(dynStr("Star", "ter", "Gui"))
local RunService = getService(dynStr("Run", "Service"))
local UserInputService = getService(dynStr("User", "Input", "Service"))
local TweenService = getService(dynStr("Tween", "Service"))
local SoundService = getService(dynStr("Sound", "Service"))
local Lighting = getService(dynStr("Lighting"))
local GuiService = getService(dynStr("Gui", "Service"))
local HttpService = getService(dynStr("Http", "Service"))
local TeleportService = getService(dynStr("Tele", "port", "Service"))
local Stats = getService(dynStr("Stats"))
local ProximityPromptService = getService(dynStr("Proximity", "Prompt", "Service"))

-- Player references
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild(dynStr("Player", "Gui"))
local Mouse = Player:GetMouse()

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🚀 ENHANCED LOGGING SYSTEM WITH LIVE DASHBOARD
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local UltimateLogger = {}
UltimateLogger.Colors = {
    UI = "\27[96m",           -- Cyan
    REMOTE = "\27[93m",       -- Yellow  
    PROPERTY = "\27[95m",     -- Magenta
    PLAYER = "\27[92m",       -- Green
    NETWORK = "\27[94m",      -- Blue
    ERROR = "\27[91m",        -- Red
    SUCCESS = "\27[92m",      -- Green
    INFO = "\27[97m",         -- White
    WARNING = "\27[33m",      -- Orange
    PROXIMITY = "\27[35m",    -- Purple
    DISTANCE = "\27[36m",     -- Cyan
    DASHBOARD = "\27[42m",    -- Green Background
    INTERACTION = "\27[45m",  -- Magenta Background
    RESET = "\27[0m"          -- Reset
}

UltimateLogger.LogHistory = {}
UltimateLogger.LogCounts = {}
UltimateLogger.StartTime = tick()
UltimateLogger.LiveDashboard = {
    ActiveGUIs = {},
    ProximityPrompts = {},
    InteractiveElements = {},
    NetworkActivity = {},
    PlayerStats = {},
    LastUpdate = tick()
}

function UltimateLogger.Print(category, message, data, priority)
    priority = priority or 1
    
    -- Increment log count
    UltimateLogger.LogCounts[category] = (UltimateLogger.LogCounts[category] or 0) + 1
    
    -- Create timestamp with microsecond precision
    local timestamp = string.format("[%s.%03d]", os.date("%H:%M:%S"), (tick() * 1000) % 1000)
    
    -- Format message with enhanced details
    local color = UltimateLogger.Colors[category] or UltimateLogger.Colors.INFO
    local priorityIcon = priority >= 3 and "🔥 " or priority >= 2 and "⚡ " or ""
    
    local formatted = string.format("%s%s [%s] %s%s%s", 
        color, timestamp, category, priorityIcon, message, UltimateLogger.Colors.RESET)
    
    print(formatted)
    
    -- Enhanced data logging
    if data then
        UltimateLogger.PrintEnhancedData(data, "  ")
    end
    
    -- Update live dashboard
    UltimateLogger:UpdateLiveDashboard(category, message, data)
end

function UltimateLogger.PrintEnhancedData(data, indent, maxDepth)
    indent = indent or ""
    maxDepth = maxDepth or 3
    
    if maxDepth <= 0 then
        print(indent .. "... (max depth)")
        return
    end
    
    if type(data) == "table" then
        for k, v in pairs(data) do
            if type(v) == "table" then
                print(indent .. tostring(k) .. ":")
                UltimateLogger.PrintEnhancedData(v, indent .. "  ", maxDepth - 1)
            else
                print(indent .. tostring(k) .. ": " .. tostring(v))
            end
        end
    else
        print(indent .. "📋 " .. tostring(data))
    end
end

function UltimateLogger:UpdateLiveDashboard(category, message, data)
    local dashboard = self.LiveDashboard
    local currentTime = tick()
    
    -- Update category-specific dashboard data
    if category == "UI" then
        dashboard.ActiveGUIs[#dashboard.ActiveGUIs + 1] = {
            message = message,
            timestamp = currentTime,
            data = data
        }
        -- Keep only last 10 entries
        if #dashboard.ActiveGUIs > 10 then
            table.remove(dashboard.ActiveGUIs, 1)
        end
    elseif category == "PROXIMITY" then
        dashboard.ProximityPrompts[#dashboard.ProximityPrompts + 1] = {
            message = message,
            timestamp = currentTime,
            data = data
        }
        if #dashboard.ProximityPrompts > 5 then
            table.remove(dashboard.ProximityPrompts, 1)
        end
    elseif category == "REMOTE" or category == "NETWORK" then
        dashboard.NetworkActivity[#dashboard.NetworkActivity + 1] = {
            message = message,
            timestamp = currentTime,
            data = data
        }
        if #dashboard.NetworkActivity > 8 then
            table.remove(dashboard.NetworkActivity, 1)
        end
    end
    
    dashboard.LastUpdate = currentTime
end

function UltimateLogger:PrintLiveDashboard()
    local dashboard = self.LiveDashboard
    local currentTime = tick()
    
    print(self.Colors.DASHBOARD .. "╔═════════════════════════════════════════════════════════════════╗" .. self.Colors.RESET)
    print(self.Colors.DASHBOARD .. "║                    📊 LIVE RSPY DASHBOARD 📊                    ║" .. self.Colors.RESET)
    print(self.Colors.DASHBOARD .. "╠═════════════════════════════════════════════════════════════════╣" .. self.Colors.RESET)
    
    -- Active GUI Section
    print(self.Colors.UI .. "🖼️  ACTIVE GUIs (" .. #dashboard.ActiveGUIs .. "):" .. self.Colors.RESET)
    for i, gui in ipairs(dashboard.ActiveGUIs) do
        local age = string.format("%.1fs ago", currentTime - gui.timestamp)
        print(self.Colors.UI .. string.format("  %d. %s [%s]", i, gui.message, age) .. self.Colors.RESET)
    end
    
    print("")
    
    -- Proximity Section  
    print(self.Colors.PROXIMITY .. "📍 PROXIMITY EVENTS (" .. #dashboard.ProximityPrompts .. "):" .. self.Colors.RESET)
    for i, prox in ipairs(dashboard.ProximityPrompts) do
        local age = string.format("%.1fs ago", currentTime - prox.timestamp)
        print(self.Colors.PROXIMITY .. string.format("  %d. %s [%s]", i, prox.message, age) .. self.Colors.RESET)
    end
    
    print("")
    
    -- Network Activity Section
    print(self.Colors.NETWORK .. "📡 NETWORK ACTIVITY (" .. #dashboard.NetworkActivity .. "):" .. self.Colors.RESET)
    for i, net in ipairs(dashboard.NetworkActivity) do
        local age = string.format("%.1fs ago", currentTime - net.timestamp)
        print(self.Colors.NETWORK .. string.format("  %d. %s [%s]", i, net.message, age) .. self.Colors.RESET)
    end
    
    print("")
    
    -- Statistics
    print(self.Colors.INFO .. "📈 STATISTICS:" .. self.Colors.RESET)
    local totalLogs = 0
    for category, count in pairs(self.LogCounts) do
        totalLogs = totalLogs + count
        print(self.Colors.INFO .. string.format("  %s: %d logs", category, count) .. self.Colors.RESET)
    end
    print(self.Colors.INFO .. string.format("  📚 Total Logs: %d", totalLogs) .. self.Colors.RESET)
    print(self.Colors.INFO .. string.format("  ⏱️  Uptime: %.1fs", currentTime - self.StartTime) .. self.Colors.RESET)
    
    print(self.Colors.DASHBOARD .. "╚═════════════════════════════════════════════════════════════════╝" .. self.Colors.RESET)
    print("")
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📍 PROXIMITY & DISTANCE-BASED GUI DETECTION SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local ProximitySystem = {}
ProximitySystem.ProximityPrompts = {}
ProximitySystem.DistanceBasedGUIs = {}
ProximitySystem.InteractiveElements = {}
ProximitySystem.PlayerPosition = Vector3.new(0, 0, 0)
ProximitySystem.ScanRadius = 100
ProximitySystem.UpdateInterval = 0.1

function ProximitySystem:Initialize()
    -- Monitor ProximityPrompts
    self:ScanForProximityPrompts()
    self:MonitorProximityPromptService()
    
    -- Monitor distance-based interactions
    self:StartDistanceMonitoring()
    
    -- Scan for interactive elements
    self:ScanForInteractiveElements()
    
    UltimateLogger.Print("PROXIMITY", "📍 Proximity Detection System initialized", nil, 2)
end

function ProximitySystem:ScanForProximityPrompts()
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then
            self:RegisterProximityPrompt(descendant)
        end
    end
    
    workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("ProximityPrompt") then
            wait(0.1) -- Small delay to ensure parent is set
            self:RegisterProximityPrompt(descendant)
        end
    end)
end

function ProximitySystem:RegisterProximityPrompt(prompt)
    if self.ProximityPrompts[prompt] then return end
    
    self.ProximityPrompts[prompt] = {
        name = prompt.ObjectText or prompt.ActionText or "Unknown Prompt",
        parent = prompt.Parent,
        maxDistance = prompt.MaxActivationDistance,
        holdDuration = prompt.HoldDuration,
        registered = tick()
    }
    
    UltimateLogger.Print("PROXIMITY", string.format("🎯 ProximityPrompt Found: %s", self.ProximityPrompts[prompt].name), {
        parent = prompt.Parent.Name,
        maxDistance = prompt.MaxActivationDistance,
        holdDuration = prompt.HoldDuration,
        keyboardKeyCode = prompt.KeyboardKeyCode.Name
    }, 2)
    
    -- Monitor prompt events
    prompt.Triggered:Connect(function(player)
        local distance = self:CalculateDistance(player.Character and player.Character.HumanoidRootPart, prompt.Parent)
        
        UltimateLogger.Print("PROXIMITY", string.format("⚡ ProximityPrompt Triggered: %s", self.ProximityPrompts[prompt].name), {
            player = player.Name,
            distance = distance
        }, 3)
        
        -- Notify AI of proximity interactions
        if AIAnalyzer.Enabled then
            AIAnalyzer:ReportChange("PROXIMITY_PROMPT_TRIGGERED", {
                promptName = self.ProximityPrompts[prompt].name,
                playerName = player.Name,
                distance = distance,
                maxDistance = prompt.MaxActivationDistance,
                parentObject = prompt.Parent.Name
            })
        end
    end)
    
    prompt.PromptShown:Connect(function(inputType)
        UltimateLogger.Print("PROXIMITY", string.format("👀 ProximityPrompt Shown: %s", self.ProximityPrompts[prompt].name), {
            inputType = inputType.Name
        }, 2)
    end)
    
    prompt.PromptHidden:Connect(function(inputType)
        UltimateLogger.Print("PROXIMITY", string.format("👁️  ProximityPrompt Hidden: %s", self.ProximityPrompts[prompt].name), {
            inputType = inputType.Name
        })
    end)
end

function ProximitySystem:MonitorProximityPromptService()
    ProximityPromptService.PromptShown:Connect(function(prompt, inputType)
        local promptData = self.ProximityPrompts[prompt]
        if promptData then
            UltimateLogger.Print("PROXIMITY", string.format("🔔 Proximity Service: %s shown", promptData.name), {
                inputType = inputType.Name,
                maxDistance = prompt.MaxActivationDistance
            }, 2)
        end
    end)
    
    ProximityPromptService.PromptHidden:Connect(function(prompt, inputType)
        local promptData = self.ProximityPrompts[prompt]
        if promptData then
            UltimateLogger.Print("PROXIMITY", string.format("🔕 Proximity Service: %s hidden", promptData.name), {
                inputType = inputType.Name
            })
        end
    end)
end

function ProximitySystem:StartDistanceMonitoring()
    spawn(function()
        while true do
            wait(self.UpdateInterval)
            pcall(function() self:UpdateDistanceBasedDetection() end)
        end
    end)
end

function ProximitySystem:UpdateDistanceBasedDetection()
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local humanoidRootPart = character.HumanoidRootPart
    local currentPosition = humanoidRootPart.Position
    
    -- Update player position
    local positionChanged = (currentPosition - self.PlayerPosition).Magnitude > 1
    if positionChanged then
        self.PlayerPosition = currentPosition
        
        -- Check all ProximityPrompts for distance
        for prompt, data in pairs(self.ProximityPrompts) do
            if prompt.Parent then
                local distance = self:CalculateDistance(humanoidRootPart, prompt.Parent)
                
                -- Check if player is getting close to activation distance
                if distance <= data.maxDistance + 5 and distance > data.maxDistance then
                    UltimateLogger.Print("DISTANCE", string.format("🚶 Approaching Proximity: %s (%.1f studs)", data.name, distance), {
                        activationDistance = data.maxDistance,
                        currentDistance = distance
                    })
                elseif distance <= data.maxDistance then
                    UltimateLogger.Print("DISTANCE", string.format("📍 In Proximity Range: %s (%.1f studs)", data.name, distance), {
                        activationDistance = data.maxDistance,
                        currentDistance = distance
                    })
                end
            end
        end
        
        -- Check for potential distance-based GUI systems
        self:DetectDistanceBasedGUIs(currentPosition)
    end
end

function ProximitySystem:DetectDistanceBasedGUIs(playerPosition)
    -- Look for potential trigger parts (commonly used for distance-based GUIs)
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("BasePart") then
            local distance = (playerPosition - obj.Position).Magnitude
            
            -- Check for parts that might be GUI triggers
            if obj.Name:lower():find("trigger") or 
               obj.Name:lower():find("gui") or 
               obj.Name:lower():find("shop") or
               obj.Name:lower():find("npc") or
               obj.Transparency == 1 then -- Invisible parts often used as triggers
                
                if distance <= 20 then -- Within potential trigger range
                    local key = tostring(obj)
                    if not self.DistanceBasedGUIs[key] then
                        self.DistanceBasedGUIs[key] = {
                            part = obj,
                            name = obj.Name,
                            firstDetected = tick(),
                            lastDistance = distance
                        }
                        
                        UltimateLogger.Print("DISTANCE", string.format("🎯 Potential GUI Trigger Found: %s", obj.Name), {
                            distance = distance,
                            transparency = obj.Transparency,
                            size = tostring(obj.Size),
                            position = tostring(obj.Position)
                        }, 2)
                    elseif math.abs(distance - self.DistanceBasedGUIs[key].lastDistance) > 2 then
                        self.DistanceBasedGUIs[key].lastDistance = distance
                        
                        if distance <= 10 then
                            UltimateLogger.Print("DISTANCE", string.format("🔥 Very Close to GUI Trigger: %s (%.1f studs)", obj.Name, distance), {
                                distance = distance
                            }, 3)
                        end
                    end
                end
            end
        end
    end
end

function ProximitySystem:CalculateDistance(obj1, obj2)
    if not obj1 or not obj2 then return math.huge end
    
    local pos1 = obj1.Position
    local pos2 = obj2.Position or obj2
    
    return (pos1 - pos2).Magnitude
end

function ProximitySystem:ScanForInteractiveElements()
    -- Scan for ClickDetectors
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("ClickDetector") then
            self:RegisterClickDetector(descendant)
        end
    end
    
    workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("ClickDetector") then
            wait(0.1)
            self:RegisterClickDetector(descendant)
        end
    end)
end

function ProximitySystem:RegisterClickDetector(clickDetector)
    local key = tostring(clickDetector)
    if self.InteractiveElements[key] then return end
    
    self.InteractiveElements[key] = {
        type = "ClickDetector",
        parent = clickDetector.Parent,
        maxDistance = clickDetector.MaxActivationDistance,
        registered = tick()
    }
    
    UltimateLogger.Print("INTERACTION", string.format("🖱️  ClickDetector Found: %s", clickDetector.Parent.Name), {
        maxDistance = clickDetector.MaxActivationDistance,
        parent = clickDetector.Parent.Name
    })
    
    clickDetector.MouseClick:Connect(function(player)
        UltimateLogger.Print("INTERACTION", string.format("🖱️  ClickDetector Activated: %s", clickDetector.Parent.Name), {
            player = player.Name,
            distance = self:CalculateDistance(player.Character and player.Character.HumanoidRootPart, clickDetector.Parent)
        }, 3)
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📡 ENHANCED REMOTE MONITORING SYSTEM (FIXED)
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local UltimateRemoteMonitor = {}
UltimateRemoteMonitor.HookedRemotes = {}
UltimateRemoteMonitor.RemoteStats = {}
UltimateRemoteMonitor.NetworkHistory = {}

function UltimateRemoteMonitor:HookRemoteEvent(remoteEvent)
    if not remoteEvent or self.HookedRemotes[remoteEvent] then return end
    
    self.HookedRemotes[remoteEvent] = true
    self.RemoteStats[remoteEvent] = {
        name = remoteEvent.Name,
        type = "RemoteEvent",
        fireCount = 0,
        firstCall = nil,
        lastCall = nil
    }
    
    local originalFireServer = remoteEvent.FireServer
    
    remoteEvent.FireServer = function(self, ...)
        local args = {...}
        local stats = UltimateRemoteMonitor.RemoteStats[remoteEvent]
        
        stats.fireCount = stats.fireCount + 1
        local currentTime = tick()
        
        if not stats.firstCall then
            stats.firstCall = currentTime
        end
        stats.lastCall = currentTime
        
        UltimateRemoteMonitor:LogRemoteCall("RemoteEvent", remoteEvent, args, stats)
        
        -- Notify AI of important network activity
        if AIAnalyzer.Enabled then
            AIAnalyzer:ReportChange("REMOTE_EVENT_FIRED", {
                remoteName = remoteEvent.Name,
                fireCount = stats.fireCount,
                arguments = #args,
                args = args
            })
        end
        
        return originalFireServer(self, ...)
    end
    
    UltimateLogger.Print("REMOTE", string.format("🔗 Hooked RemoteEvent: %s", remoteEvent.Name))
end

function UltimateRemoteMonitor:HookRemoteFunction(remoteFunction)
    if not remoteFunction or self.HookedRemotes[remoteFunction] then return end
    
    self.HookedRemotes[remoteFunction] = true
    self.RemoteStats[remoteFunction] = {
        name = remoteFunction.Name,
        type = "RemoteFunction", 
        invokeCount = 0,
        firstCall = nil,
        lastCall = nil
    }
    
    -- FIXED: Correct syntax - InvokeServer with capital I
    local originalInvokeServer = remoteFunction.InvokeServer
    
    remoteFunction.InvokeServer = function(self, ...)
        local args = {...}
        local stats = UltimateRemoteMonitor.RemoteStats[remoteFunction]
        local startTime = tick()
        
        stats.invokeCount = stats.invokeCount + 1
        
        if not stats.firstCall then
            stats.firstCall = startTime
        end
        stats.lastCall = startTime
        
        UltimateRemoteMonitor:LogRemoteCall("RemoteFunction", remoteFunction, args, stats)
        
        local result = originalInvokeServer(self, ...)
        local responseTime = tick() - startTime
        
        UltimateLogger.Print("REMOTE", string.format("📤 RemoteFunction Response: %s (%.1fms)", remoteFunction.Name, responseTime * 1000), {
            result = result,
            responseTime = responseTime
        })
        
        return result
    end
    
    UltimateLogger.Print("REMOTE", string.format("🔗 Hooked RemoteFunction: %s", remoteFunction.Name))
end

function UltimateRemoteMonitor:LogRemoteCall(remoteType, remote, args, stats)
    local priority = #args > 0 and 2 or 1
    
    UltimateLogger.Print("REMOTE", string.format("📡 %s: %s (#%d)", remoteType, remote.Name, stats.fireCount or stats.invokeCount), {
        arguments = #args,
        args = args
    }, priority)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🖼️ ENHANCED UI MONITORING WITH LIVE STATE TRACKING
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local UltimateUIMonitor = {}
UltimateUIMonitor.TrackedElements = {}
UltimateUIMonitor.ElementStates = {}
UltimateUIMonitor.UIEventHistory = {}
UltimateUIMonitor.GUIStateTracker = {}

function UltimateUIMonitor:TrackElement(element, customName)
    if not element or self.TrackedElements[element] then return end
    
    local elementName = customName or string.format("%s.%s", element.Parent and element.Parent.Name or "Unknown", element.Name)
    self.TrackedElements[element] = elementName
    
    self.ElementStates[element] = {
        visible = element.Visible,
        enabled = element.Parent and element.Parent.Enabled or true,
        position = element.AbsolutePosition,
        size = element.AbsoluteSize,
        transparency = element.BackgroundTransparency or 0
    }
    
    -- Enhanced visibility monitoring
    element:GetPropertyChangedSignal("Visible"):Connect(function()
        local newState = element.Visible
        local oldState = self.ElementStates[element].visible
        
        if newState ~= oldState then
            local action = newState and "OPENED" or "CLOSED"
            local priority = newState and 2 or 1
            
            UltimateLogger.Print("UI", string.format("🖼️  %s: %s", action, elementName), {
                position = tostring(element.AbsolutePosition),
                size = tostring(element.AbsoluteSize),
                zIndex = element.ZIndex,
                text = element:IsA("TextLabel") and element.Text or nil
            }, priority)
            
            self.ElementStates[element].visible = newState
            self:UpdateGUIStateTracker(elementName, action, element)
            
            -- Notify AI of important GUI changes
            if AIAnalyzer.Enabled then
                AIAnalyzer:ReportChange("GUI_VISIBILITY_CHANGE", {
                    element = elementName,
                    action = action,
                    position = tostring(element.AbsolutePosition),
                    size = tostring(element.AbsoluteSize),
                    zIndex = element.ZIndex
                })
            end
        end
    end)
    
    -- Monitor text changes with live updates
    if element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox") then
        element:GetPropertyChangedSignal("Text"):Connect(function()
            if element.Visible then
                UltimateLogger.Print("UI", string.format("📝 Text Update: %s", elementName), {
                    newText = element.Text,
                    textSize = element.TextSize,
                    font = element.Font.Name
                })
            end
        end)
    end
    
    -- Enhanced button monitoring
    if element:IsA("GuiButton") then
        element.MouseButton1Click:Connect(function()
            UltimateLogger.Print("UI", string.format("🖱️  Button Clicked: %s", elementName), {
                position = tostring(Mouse.Hit.Position),
                buttonSize = tostring(element.AbsoluteSize)
            }, 2)
        end)
        
        element.MouseEnter:Connect(function()
            UltimateLogger.Print("UI", string.format("🎯 Mouse Hover: %s", elementName))
        end)
    end
    
    UltimateLogger.Print("UI", string.format("👁️  Tracking UI: %s (%s)", elementName, element.ClassName))
end

function UltimateUIMonitor:UpdateGUIStateTracker(elementName, action, element)
    local currentTime = tick()
    
    if not self.GUIStateTracker[elementName] then
        self.GUIStateTracker[elementName] = {
            openCount = 0,
            closeCount = 0,
            totalTime = 0,
            lastOpened = nil,
            averageOpenTime = 0
        }
    end
    
    local tracker = self.GUIStateTracker[elementName]
    
    if action == "OPENED" then
        tracker.openCount = tracker.openCount + 1
        tracker.lastOpened = currentTime
        
        if tracker.openCount > 1 then
            UltimateLogger.Print("UI", string.format("📊 GUI Stats: %s opened %d times", elementName, tracker.openCount))
        end
    elseif action == "CLOSED" and tracker.lastOpened then
        tracker.closeCount = tracker.closeCount + 1
        local openDuration = currentTime - tracker.lastOpened
        tracker.totalTime = tracker.totalTime + openDuration
        tracker.averageOpenTime = tracker.totalTime / tracker.closeCount
        
        UltimateLogger.Print("UI", string.format("📊 GUI Session: %s (%.1fs open, avg: %.1fs)", 
            elementName, openDuration, tracker.averageOpenTime))
    end
end

function UltimateUIMonitor:ScanAndTrack(parent, depth, maxDepth)
    depth = depth or 0
    maxDepth = maxDepth or 8
    
    if depth > maxDepth then return end
    
    for _, child in pairs(parent:GetChildren()) do
        if child:IsA("GuiObject") then
            local elementName = string.format("%s.%s", parent.Name, child.Name)
            self:TrackElement(child, elementName)
            self:ScanAndTrack(child, depth + 1, maxDepth)
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🔄 ADVANCED PROPERTY MONITORING
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local AdvancedPropertyMonitor = {}
AdvancedPropertyMonitor.TrackedObjects = {}
AdvancedPropertyMonitor.PropertyHistory = {}

function AdvancedPropertyMonitor:TrackObject(object, properties)
    if not object or self.TrackedObjects[object] then return end
    
    self.TrackedObjects[object] = {
        name = object.Name or "Unknown",
        className = object.ClassName or "Unknown",
        properties = {},
        connections = {}
    }
    
    local objectData = self.TrackedObjects[object]
    
    for _, property in ipairs(properties) do
        local success, currentValue = pcall(function() return object[property] end)
        if success then
            objectData.properties[property] = {
                currentValue = currentValue,
                changeCount = 0
            }
            
            local connection = object:GetPropertyChangedSignal(property):Connect(function()
                self:HandlePropertyChange(object, property)
            end)
            objectData.connections[property] = connection
        end
    end
    
    UltimateLogger.Print("PROPERTY", string.format("👁️  Tracking: %s.%s", objectData.name, table.concat(properties, ", ")))
end

function AdvancedPropertyMonitor:HandlePropertyChange(object, property)
    local objectData = self.TrackedObjects[object]
    if not objectData then return end
    
    local propertyData = objectData.properties[property]
    if not propertyData then return end
    
    local newValue = object[property]
    local oldValue = propertyData.currentValue
    
    propertyData.currentValue = newValue
    propertyData.changeCount = propertyData.changeCount + 1
    
    local priority = property == "Health" and 2 or 1
    
    UltimateLogger.Print("PROPERTY", string.format("🔄 %s.%s: %s → %s (#%d)", 
        objectData.name, property, tostring(oldValue), tostring(newValue), propertyData.changeCount), nil, priority)
    
    -- Special health monitoring
    if property == "Health" and type(newValue) == "number" and type(oldValue) == "number" then
        local damage = oldValue - newValue
        if damage > 0 then
            UltimateLogger.Print("PROPERTY", string.format("💔 Damage Taken: %.1f HP", damage), nil, 3)
        elseif damage < 0 then
            UltimateLogger.Print("PROPERTY", string.format("💚 Health Gained: %.1f HP", -damage), nil, 2)
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🎮 ENHANCED PLAYER MONITORING
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local PlayerActionMonitor = {}
PlayerActionMonitor.InputHistory = {}

function PlayerActionMonitor:Initialize()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed then
            local priority = input.UserInputType == Enum.UserInputType.MouseButton1 and 2 or 1
            
            UltimateLogger.Print("PLAYER", string.format("⌨️  Input: %s", input.KeyCode.Name), {
                inputType = input.UserInputType.Name,
                position = tostring(input.Position)
            }, priority)
            
            if input.UserInputType == Enum.UserInputType.MouseButton1 and Mouse.Target then
                UltimateLogger.Print("PLAYER", string.format("🎯 Click Target: %s", Mouse.Target.Name), {
                    targetPosition = tostring(Mouse.Hit.Position),
                    distance = ProximitySystem:CalculateDistance(Player.Character and Player.Character.HumanoidRootPart, Mouse.Hit.Position)
                }, 2)
            end
        end
    end)
    
    Player.CharacterAdded:Connect(function(character)
        self:MonitorCharacter(character)
    end)
    
    if Player.Character then
        self:MonitorCharacter(Player.Character)
    end
    
    Player.Chatted:Connect(function(message)
        UltimateLogger.Print("PLAYER", string.format("💬 Chat: %s", message), nil, 2)
    end)
    
    UltimateLogger.Print("PLAYER", "🎮 Enhanced player monitor initialized")
end

function PlayerActionMonitor:MonitorCharacter(character)
    UltimateLogger.Print("PLAYER", "👤 Character spawned", nil, 2)
    
    local humanoid = character:WaitForChild("Humanoid")
    
    AdvancedPropertyMonitor:TrackObject(humanoid, {
        "Health", "MaxHealth", "WalkSpeed", "JumpPower", "DisplayName"
    })
    
    humanoid.Died:Connect(function()
        UltimateLogger.Print("PLAYER", "💀 Character died", nil, 3)
    end)
    
    character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            UltimateLogger.Print("PLAYER", string.format("⚔️  Tool Equipped: %s", child.Name), nil, 2)
            
            child.Activated:Connect(function()
                UltimateLogger.Print("PLAYER", string.format("🔥 Tool Used: %s", child.Name), nil, 3)
            end)
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🌐 NETWORK MONITORING
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local NetworkAnalyzer = {}

function NetworkAnalyzer:Initialize()
    ReplicatedStorage.ChildAdded:Connect(function(child)
        UltimateLogger.Print("NETWORK", string.format("➕ ReplicatedStorage: %s (%s)", child.Name, child.ClassName))
        
        if child:IsA("RemoteEvent") then
            UltimateRemoteMonitor:HookRemoteEvent(child)
        elseif child:IsA("RemoteFunction") then
            UltimateRemoteMonitor:HookRemoteFunction(child)
        end
    end)
    
    for _, child in pairs(ReplicatedStorage:GetDescendants()) do
        if child:IsA("RemoteEvent") then
            UltimateRemoteMonitor:HookRemoteEvent(child)
        elseif child:IsA("RemoteFunction") then
            UltimateRemoteMonitor:HookRemoteFunction(child)
        end
    end
    
    UltimateLogger.Print("NETWORK", "🌐 Network analyzer initialized")
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📈 PERFORMANCE MONITORING WITH LIVE UPDATES
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local PerformanceAnalyzer = {}
PerformanceAnalyzer.FrameCount = 0
PerformanceAnalyzer.LastFPSReport = tick()

function PerformanceAnalyzer:Initialize()
    RunService.Heartbeat:Connect(function()
        self.FrameCount = self.FrameCount + 1
        
        local now = tick()
        if now - self.LastFPSReport >= 20 then -- Report every 20 seconds
            local fps = self.FrameCount / (now - self.LastFPSReport)
            local memory = Stats:GetTotalMemoryUsageMb()
            local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            
            UltimateLogger.Print("INFO", string.format("📊 Performance: %.1f FPS | %.1f MB | %.0fms ping", fps, memory, ping), nil, 2)
            
            self.FrameCount = 0
            self.LastFPSReport = now
        end
    end)
    
    UltimateLogger.Print("INFO", "📈 Performance analyzer initialized")
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🔥 MAIN INITIALIZATION SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local function InitializeUltimateRspyV2()
    UltimateLogger.Print("SUCCESS", "╔═══════════════════════════════════════════════════════════════╗", nil, 3)
    UltimateLogger.Print("SUCCESS", "║       🚀 ULTIMATE RSPY V2.0 INITIALIZING 🚀                  ║", nil, 3)
    UltimateLogger.Print("SUCCESS", "║       📍 PROXIMITY GUI DETECTION EDITION 📍                   ║", nil, 3)
    UltimateLogger.Print("SUCCESS", "╚═══════════════════════════════════════════════════════════════╝", nil, 3)
    UltimateLogger.Print("SUCCESS", "")
    UltimateLogger.Print("SUCCESS", string.format("🎮 Game: %s (Place: %d)", game.Name or "Unknown", game.PlaceId))
    UltimateLogger.Print("SUCCESS", string.format("👤 Player: %s (ID: %d)", Player.Name, Player.UserId))
    UltimateLogger.Print("SUCCESS", "")
    
    -- Initialize systems with enhanced error handling
    local systems = {
        {ProximitySystem, "📍 Proximity Detection System"},
        {PlayerActionMonitor, "🎮 Enhanced Player Monitor"},
        {NetworkAnalyzer, "🌐 Network Analyzer"},
        {PerformanceAnalyzer, "📈 Performance Analyzer"},
        {AIAnalyzer, "🤖 AI-Powered DEX Analyzer"}
    }
    
    for _, system in ipairs(systems) do
        local success, err = pcall(function() system[1]:Initialize() end)
        if success then
            UltimateLogger.Print("SUCCESS", string.format("✅ %s initialized", system[2]))
        else
            UltimateLogger.Print("ERROR", string.format("❌ Failed: %s - %s", system[2], err))
        end
        wait(0.3)
    end
    
    -- Initialize UI monitoring
    UltimateLogger.Print("SUCCESS", "🖼️  Initializing enhanced UI monitoring...")
    
    PlayerGui.ChildAdded:Connect(function(gui)
        UltimateLogger.Print("UI", string.format("➕ New GUI: %s (%s)", gui.Name, gui.ClassName), nil, 2)
        
        if gui:IsA("ScreenGui") then
            UltimateUIMonitor:ScanAndTrack(gui)
        end
    end)
    
    -- Scan existing GUIs
    for _, gui in pairs(PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            UltimateUIMonitor:ScanAndTrack(gui)
        end
    end
    
    wait(1)
    
    UltimateLogger.Print("SUCCESS", "")
    UltimateLogger.Print("SUCCESS", "╔═══════════════════════════════════════════════════════════════╗", nil, 3)
    UltimateLogger.Print("SUCCESS", "║           ✅ ULTIMATE RSPY V2.0 ONLINE ✅                     ║", nil, 3)
    UltimateLogger.Print("SUCCESS", "╚═══════════════════════════════════════════════════════════════╝", nil, 3)
    UltimateLogger.Print("SUCCESS", "")
    UltimateLogger.Print("SUCCESS", "🔥 NEW V2.0 FEATURES ACTIVE:")
    UltimateLogger.Print("SUCCESS", "   • 📍 ProximityPrompt Detection & Monitoring")
    UltimateLogger.Print("SUCCESS", "   • 📏 Distance-Based GUI Detection")
    UltimateLogger.Print("SUCCESS", "   • 🎯 Interactive Elements Scanner")
    UltimateLogger.Print("SUCCESS", "   • 📊 Live Dashboard with Real-Time Updates")
    UltimateLogger.Print("SUCCESS", "   • 🖼️  Enhanced GUI State Tracking")
    UltimateLogger.Print("SUCCESS", "   • 🔍 Advanced Proximity Analysis")
    UltimateLogger.Print("SUCCESS", "   • 🤖 AI-Powered DEX Analysis (Ollama)")
    UltimateLogger.Print("SUCCESS", "   • 🧠 Real-Time Script Analysis")
    UltimateLogger.Print("SUCCESS", "   • ⚡ Lightning-Fast Live Monitoring")
    UltimateLogger.Print("SUCCESS", "")
    UltimateLogger.Print("INFO", "💡 Use _G.UltimateRspyV2 for enhanced control")
    UltimateLogger.Print("INFO", "📊 Dashboard updates every 30 seconds")
    UltimateLogger.Print("INFO", "🤖 AI Analysis: Run Python script with llama3.1:8b!")
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🤖 AI-POWERED DEX ANALYZER INTEGRATION
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local AIAnalyzer = {}
-- 📱 EMULATOR-COMPATIBLE ENDPOINTS (uncomment the right one):
-- AIAnalyzer.Endpoint = "http://127.0.0.1:5000"        -- For PC/Mac direct
-- AIAnalyzer.Endpoint = "http://10.0.2.2:5000"        -- Standard Android (doesn't work with MuMu)
AIAnalyzer.Endpoint = "http://192.168.2.97:5001"       -- MuMu Player IP for your Mac (Port 5001)
AIAnalyzer.Enabled = true
AIAnalyzer.LastDEXScan = 0
AIAnalyzer.ScanCooldown = 10 -- seconds
AIAnalyzer.DEXData = {}
AIAnalyzer.ScannedScripts = {}

function AIAnalyzer:SendHTTPRequest(endpoint, data)
    if not self.Enabled then return nil end
    
    pcall(function()
        local jsonData = HttpService:JSONEncode(data)
        
        local success, result = pcall(function()
            return HttpService:RequestAsync({
                Url = self.Endpoint .. endpoint,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = jsonData
            })
        end)
        
        if success and result.Success then
            UltimateLogger.Print("AI", string.format("🤖 AI Analysis: %s", endpoint), {
                status = result.StatusCode,
                responseLength = #(result.Body or "")
            }, 2)
            
            local responseData = HttpService:JSONDecode(result.Body)
            if responseData.analysis then
                UltimateLogger.Print("AI", "🧠 AI Response:", {
                    analysis = responseData.analysis:sub(1, 200) .. "..."
                }, 3)
            end
        else
            UltimateLogger.Print("AI", "❌ AI Request failed", {
                error = result and result.StatusMessage or "Unknown error"
            })
        end
    end)
end

function AIAnalyzer:ScanDEXStructure()
    local currentTime = tick()
    if currentTime - self.LastDEXScan < self.ScanCooldown then return end
    
    self.LastDEXScan = currentTime
    
    UltimateLogger.Print("AI", "🔍 Scanning DEX structure for AI analysis...", nil, 2)
    
    local dexData = {
        timestamp = currentTime,
        place_id = game.PlaceId,
        game_name = game.Name,
        job_id = game.JobId,
        object_count = 0,
        script_count = 0,
        services = {},
        structure = {},
        scripts = {}
    }
    
    -- Scan all services
    local services = {
        "Workspace", "Players", "ReplicatedStorage", "StarterGui", "StarterPack",
        "ServerStorage", "ServerScriptService", "StarterPlayer", "SoundService",
        "Lighting", "TweenService", "RunService", "UserInputService"
    }
    
    for _, serviceName in ipairs(services) do
        local success, service = pcall(function() return getService(serviceName) end)
        if success and service then
            dexData.services[serviceName] = self:AnalyzeContainer(service, 3)
        end
    end
    
    -- Count objects and scripts
    for _, obj in pairs(workspace:GetDescendants()) do
        dexData.object_count = dexData.object_count + 1
        if obj:IsA("LocalScript") or obj:IsA("Script") or obj:IsA("ModuleScript") then
            dexData.script_count = dexData.script_count + 1
        end
    end
    
    -- Add ReplicatedStorage descendants
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        dexData.object_count = dexData.object_count + 1
        if obj:IsA("LocalScript") or obj:IsA("Script") or obj:IsA("ModuleScript") then
            dexData.script_count = dexData.script_count + 1
        end
    end
    
    self.DEXData = dexData
    self:SendHTTPRequest("/analyze_dex", dexData)
end

function AIAnalyzer:AnalyzeContainer(container, maxDepth)
    if maxDepth <= 0 then return {} end
    
    local data = {
        name = container.Name,
        className = container.ClassName,
        children = {},
        properties = {}
    }
    
    -- Get important properties
    pcall(function()
        if container:IsA("Part") then
            data.properties = {
                size = tostring(container.Size),
                position = tostring(container.Position),
                material = container.Material.Name,
                color = tostring(container.Color)
            }
        elseif container:IsA("Humanoid") then
            data.properties = {
                health = container.Health,
                maxHealth = container.MaxHealth,
                walkSpeed = container.WalkSpeed,
                jumpPower = container.JumpPower
            }
        elseif container:IsA("RemoteEvent") or container:IsA("RemoteFunction") then
            data.properties = {
                type = "NetworkObject",
                parent = container.Parent.Name
            }
        end
    end)
    
    -- Analyze children (limited depth)
    for i, child in ipairs(container:GetChildren()) do
        if i <= 10 then -- Limit to prevent massive data
            data.children[child.Name] = self:AnalyzeContainer(child, maxDepth - 1)
        else
            break
        end
    end
    
    return data
end

function AIAnalyzer:AnalyzeScript(scriptObject)
    if not scriptObject or self.ScannedScripts[scriptObject] then return end
    
    self.ScannedScripts[scriptObject] = true
    
    local scriptData = {
        name = scriptObject.Name,
        type = scriptObject.ClassName,
        parent = scriptObject.Parent and scriptObject.Parent.Name or "Unknown",
        timestamp = tick(),
        content = "",
        size = 0
    }
    
    -- Try to get script source (if possible)
    local success, source = pcall(function()
        if scriptObject:IsA("ModuleScript") then
            return scriptObject.Source
        elseif scriptObject:IsA("LocalScript") or scriptObject:IsA("Script") then
            -- Note: Source is usually protected, but we try anyway
            return scriptObject.Source or "-- Source protected"
        end
        return "-- Cannot access source"
    end)
    
    if success and source then
        scriptData.content = source
        scriptData.size = #source
    end
    
    -- Get script descendants (for ModuleScripts that might have sub-components)
    local descendants = {}
    for _, child in ipairs(scriptObject:GetChildren()) do
        table.insert(descendants, {
            name = child.Name,
            className = child.ClassName
        })
    end
    scriptData.descendants = descendants
    
    UltimateLogger.Print("AI", string.format("📜 Analyzing script with AI: %s", scriptData.name), {
        type = scriptData.type,
        size = scriptData.size,
        hasSource = scriptData.size > 0
    }, 2)
    
    self:SendHTTPRequest("/analyze_script", scriptData)
end

function AIAnalyzer:ReportChange(changeType, details)
    if not self.Enabled then return end
    
    local changeData = {
        type = changeType,
        timestamp = tick(),
        details = details,
        game_state = {
            place_id = game.PlaceId,
            player_count = #Players:GetPlayers(),
            fps = workspace:GetRealPhysicsFPS()
        }
    }
    
    UltimateLogger.Print("AI", string.format("🔄 Reporting change to AI: %s", changeType), details, 2)
    self:SendHTTPRequest("/report_change", changeData)
end

function AIAnalyzer:AutoScanForScripts()
    spawn(function()
        while self.Enabled do
            wait(15) -- Scan every 15 seconds
            
            pcall(function()
                -- Scan workspace for new scripts
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("LocalScript") or obj:IsA("Script") or obj:IsA("ModuleScript") then
                        if not self.ScannedScripts[obj] then
                            self:AnalyzeScript(obj)
                        end
                    end
                end
                
                -- Scan ReplicatedStorage for new scripts
                for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                    if obj:IsA("LocalScript") or obj:IsA("Script") or obj:IsA("ModuleScript") then
                        if not self.ScannedScripts[obj] then
                            self:AnalyzeScript(obj)
                        end
                    end
                end
            end)
        end
    end)
end

function AIAnalyzer:Initialize()
    UltimateLogger.Print("AI", "🤖 AI Analyzer initializing...", nil, 3)
    
    -- Test connection
    pcall(function()
        local success, result = pcall(function()
            return HttpService:RequestAsync({
                Url = self.Endpoint .. "/health",
                Method = "GET",
                Headers = {}
            })
        end)
        
        if success and result.Success then
            UltimateLogger.Print("AI", "✅ AI connection established!", nil, 3)
            
            -- Start initial DEX scan
            spawn(function()
                wait(2) -- Give time for other systems to initialize
                self:ScanDEXStructure()
            end)
            
            -- Start auto script scanning
            self:AutoScanForScripts()
            
            -- Schedule periodic DEX scans
            spawn(function()
                while self.Enabled do
                    wait(30) -- Full DEX scan every 30 seconds
                    self:ScanDEXStructure()
                end
            end)
            
        else
            UltimateLogger.Print("AI", "❌ Cannot connect to AI server", {
                error = "Make sure Python AI script is running on port 5000"
            })
            self.Enabled = false
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🌟 ENHANCED GLOBAL API V2.0 WITH AI INTEGRATION
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

_G.UltimateRspyV2 = {
    -- Core Systems
    Logger = UltimateLogger,
    ProximitySystem = ProximitySystem,
    UIMonitor = UltimateUIMonitor,
    RemoteMonitor = UltimateRemoteMonitor,
    PropertyMonitor = AdvancedPropertyMonitor,
    PlayerMonitor = PlayerActionMonitor,
    NetworkAnalyzer = NetworkAnalyzer,
    PerformanceAnalyzer = PerformanceAnalyzer,
    AIAnalyzer = AIAnalyzer,
    
    -- Enhanced API Functions
    ShowDashboard = function()
        UltimateLogger:PrintLiveDashboard()
    end,
    
    FindProximityPrompts = function()
        UltimateLogger.Print("INFO", "📍 Found Proximity Prompts:")
        for prompt, data in pairs(ProximitySystem.ProximityPrompts) do
            UltimateLogger.Print("INFO", string.format("  • %s (%.1f studs)", data.name, data.maxDistance))
        end
    end,
    
    FindInteractiveElements = function()
        UltimateLogger.Print("INFO", "🎯 Found Interactive Elements:")
        for key, data in pairs(ProximitySystem.InteractiveElements) do
            UltimateLogger.Print("INFO", string.format("  • %s: %s", data.type, data.parent.Name))
        end
    end,
    
    ShowGUIStats = function()
        UltimateLogger.Print("INFO", "📊 GUI Statistics:")
        for name, tracker in pairs(UltimateUIMonitor.GUIStateTracker) do
            UltimateLogger.Print("INFO", string.format("  • %s: %d opens, avg %.1fs", name, tracker.openCount, tracker.averageOpenTime))
        end
    end,
    
    ScanForGUITriggers = function()
        ProximitySystem:DetectDistanceBasedGUIs(Player.Character and Player.Character.HumanoidRootPart.Position or Vector3.new(0,0,0))
        UltimateLogger.Print("SUCCESS", "🔄 Scanned for GUI triggers")
    end,
    
    SetScanRadius = function(radius)
        ProximitySystem.ScanRadius = radius
        UltimateLogger.Print("INFO", string.format("📏 Scan radius set to %d studs", radius))
    end,
    
    -- AI-Specific Functions
    StartAIAnalysis = function()
        AIAnalyzer:Initialize()
        UltimateLogger.Print("AI", "🤖 AI Analysis started manually")
    end,
    
    ScanDEXNow = function()
        AIAnalyzer:ScanDEXStructure()
        UltimateLogger.Print("AI", "🔍 Manual DEX scan initiated")
    end,
    
    AnalyzeScript = function(scriptObject)
        if scriptObject then
            AIAnalyzer:AnalyzeScript(scriptObject)
        else
            UltimateLogger.Print("AI", "❌ Please provide a script object to analyze")
        end
    end,
    
    ToggleAI = function(enabled)
        AIAnalyzer.Enabled = enabled
        UltimateLogger.Print("AI", string.format("🤖 AI Analysis %s", enabled and "enabled" or "disabled"))
    end,
    
    AIStatus = function()
        UltimateLogger.Print("AI", "🤖 AI Analyzer Status:")
        UltimateLogger.Print("AI", string.format("  📡 Enabled: %s", AIAnalyzer.Enabled and "Yes" or "No"))
        UltimateLogger.Print("AI", string.format("  🔗 Endpoint: %s", AIAnalyzer.Endpoint))
        UltimateLogger.Print("AI", string.format("  📊 DEX Scans: %d", AIAnalyzer.LastDEXScan > 0 and 1 or 0))
        UltimateLogger.Print("AI", string.format("  📜 Scripts Analyzed: %d", table.getn and table.getn(AIAnalyzer.ScannedScripts) or 0))
    end,
    
    -- Legacy compatibility
    TrackUI = function(element, name) return UltimateUIMonitor:TrackElement(element, name) end,
    TrackProperties = function(object, properties) return AdvancedPropertyMonitor:TrackObject(object, properties) end,
    GetStats = function() UltimateLogger:PrintLiveDashboard() end
}

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🚀 AUTO-SCANNING & LIVE DASHBOARD UPDATES
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

-- Live Dashboard Updates every 30 seconds
spawn(function()
    while true do
        wait(30)
        pcall(function()
            UltimateLogger:PrintLiveDashboard()
        end)
    end
end)

-- Auto-scan for new interactive elements every 10 seconds
spawn(function()
    while true do
        wait(10)
        pcall(function()
            -- Scan for new ProximityPrompts
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") and not ProximitySystem.ProximityPrompts[descendant] then
                    ProximitySystem:RegisterProximityPrompt(descendant)
                end
            end
            
            -- Scan for new GUIs
            for _, gui in pairs(PlayerGui:GetChildren()) do
                if gui:IsA("ScreenGui") and not UltimateUIMonitor.TrackedElements[gui] then
                    UltimateUIMonitor:ScanAndTrack(gui)
                end
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🎉 SYSTEM STARTUP
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

InitializeUltimateRspyV2()

UltimateLogger.Print("SUCCESS", "")
UltimateLogger.Print("SUCCESS", "🎉 ULTIMATE RSPY V2.0 + AI LOADED SUCCESSFULLY!")
UltimateLogger.Print("SUCCESS", "📍 PROXIMITY GUI DETECTION ACTIVE!")
UltimateLogger.Print("SUCCESS", "📊 LIVE DASHBOARD MONITORING!")
UltimateLogger.Print("SUCCESS", "🤖 AI-POWERED DEX ANALYSIS READY!")
UltimateLogger.Print("SUCCESS", "🧠 INTELLIGENT SCRIPT ANALYSIS!")
UltimateLogger.Print("SUCCESS", "🚀 NEXT-LEVEL REVERSE ENGINEERING!")
UltimateLogger.Print("SUCCESS", "")
UltimateLogger.Print("INFO", "🐍 Run: python3 Enhanced-AI-DEX-Analyzer.py")
UltimateLogger.Print("INFO", "🔗 Make sure Ollama is running locally")
UltimateLogger.Print("INFO", "💡 Use /analyze command in terminal for manual queries")

-- 🔧 AI CONNECTION DEBUG TEST
local HttpService = game:GetService("HttpService")
UltimateLogger.Print("DEBUG", "🔧 HttpService enabled: " .. tostring(HttpService.HttpEnabled))
if not HttpService.HttpEnabled then
    UltimateLogger.Print("WARNING", "⚠️ HTTP Service is disabled! This will block AI connection!")
    UltimateLogger.Print("INFO", "💡 Enable HttpService in Roblox Settings!")
end

UltimateLogger.Print("DEBUG", "🔧 AI Endpoint: " .. (AIAnalyzer.Endpoint or "NOT SET"))

-- Test AI connection immediately
spawn(function()
    wait(2) -- Give initialization time
    local testSuccess, testResult = pcall(function()
        return HttpService:GetAsync("http://192.168.2.97:5001/health")
    end)
    if testSuccess then
        UltimateLogger.Print("SUCCESS", "🔧 ✅ AI CONNECTION TEST: SUCCESS!")
        local data = game:GetService("HttpService"):JSONDecode(testResult)
        UltimateLogger.Print("INFO", "🤖 AI Model: " .. tostring(data.current_model))
    else
        UltimateLogger.Print("ERROR", "🔧 ❌ AI CONNECTION TEST FAILED!")
        UltimateLogger.Print("ERROR", "❌ Error: " .. tostring(testResult))
        UltimateLogger.Print("INFO", "💡 Check: 1) Python server running? 2) HttpService enabled? 3) Network/Firewall?")
    end
end)

UltimateLogger.Print("SUCCESS", "")

-- Initial dashboard display after 5 seconds
spawn(function()
    wait(5)
    UltimateLogger:PrintLiveDashboard()
end)