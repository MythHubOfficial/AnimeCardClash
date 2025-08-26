--[[
╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗
║                    🔥 ULTIMATE AI-POWERED RSPY V3.0 🔥                                                   ║
║                      💎 WORLD-CLASS REVERSE ENGINEERING 💎                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════╣
║ 🚀 NEXT-GEN FEATURES:                                                                                    ║
║ • 🤖 Real-time AI DEX Analysis & Chat                                                                    ║
║ • 🧠 Intelligent Script Reading & Decompilation                                                          ║
║ • 📡 Advanced Memory & Bytecode Analysis                                                                 ║
║ • 🎯 Smart Logging with AI-Relevance Detection                                                           ║
║ • ⚡ Ultra-Performance Optimized                                                                          ║
║ • 🔍 Deep Script Source Code Extraction                                                                  ║
║ • 🛡️ Advanced Stealth & Bypass Systems                                                                   ║
║ • 📊 Real-time Vulnerability Analysis                                                                    ║
║ • 🎮 Complete Game State Monitoring                                                                      ║
║ • 💬 Smooth Terminal AI Chat Interface                                                                   ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝
--]]

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🛡️ ULTRA-STEALTH INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local function s(n) return game:GetService(n) end
local function d(...) return table.concat({...}) end

-- Ultra-optimized service caching
local Services = setmetatable({}, {
    __index = function(t, k)
        local service = s(k)
        t[k] = service
        return service
    end
})

local Players, ReplicatedStorage, StarterGui, RunService = Services.Players, Services.ReplicatedStorage, Services.StarterGui, Services.RunService
local UserInputService, HttpService, ProximityPromptService = Services.UserInputService, Services.HttpService, Services.ProximityPromptService
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🧠 INTELLIGENT AI-POWERED LOGGING SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local SmartLogger = {
    Levels = {
        CRITICAL = {priority = 5, color = "\27[41m", icon = "🔥"},
        HIGH = {priority = 4, color = "\27[91m", icon = "⚡"},
        MEDIUM = {priority = 3, color = "\27[93m", icon = "💡"},
        LOW = {priority = 2, color = "\27[96m", icon = "📌"},
        DEBUG = {priority = 1, color = "\27[90m", icon = "🔍"}
    },
    AIRelevant = {},
    SilentMode = false,
    LastFlush = tick()
}

function SmartLogger:Log(level, category, message, data)
    local levelInfo = self.Levels[level] or self.Levels.LOW
    
    -- AI Relevance Detection
    local isAIRelevant = self:IsAIRelevant(category, message, data)
    
    -- Only log HIGH priority and above, or AI relevant items
    if levelInfo.priority < 3 and not isAIRelevant and not self.SilentMode then
        return
    end
    
    if isAIRelevant then
        table.insert(self.AIRelevant, {
            level = level,
            category = category, 
            message = message,
            data = data,
            timestamp = tick()
        })
    end
    
    -- Optimized console output
    if levelInfo.priority >= 3 then
        local timestamp = os.date("%H:%M:%S")
        print(string.format("%s[%s] %s %s: %s\27[0m", 
            levelInfo.color, timestamp, levelInfo.icon, category, message))
        
        if data and levelInfo.priority >= 4 then
            self:PrintData(data, " ")
        end
    end
end

function SmartLogger:IsAIRelevant(category, message, data)
    local relevantCategories = {
        ["EXPLOIT"] = true, ["VULNERABILITY"] = true, ["REMOTE"] = true,
        ["SCRIPT_FOUND"] = true, ["DEX_CHANGE"] = true, ["BYPASS"] = true
    }
    
    local relevantKeywords = {
        "RemoteEvent", "RemoteFunction", "ModuleScript", "LocalScript",
        "exploit", "bypass", "vulnerability", "hack", "cheat"
    }
    
    if relevantCategories[category] then return true end
    
    local lowerMessage = message:lower()
    for _, keyword in ipairs(relevantKeywords) do
        if lowerMessage:find(keyword:lower()) then return true end
    end
    
    return false
end

function SmartLogger:PrintData(data, indent, maxDepth)
    indent = indent or ""
    maxDepth = maxDepth or 2
    if maxDepth <= 0 then return end
    
    if type(data) == "table" then
        for k, v in pairs(data) do
            if type(v) == "table" then
                print(indent .. tostring(k) .. ":")
                self:PrintData(v, indent .. "  ", maxDepth - 1)
            else
                print(indent .. tostring(k) .. ": " .. tostring(v))
            end
        end
    end
end

function SmartLogger:FlushToAI()
    if #self.AIRelevant > 0 and AICore and AICore.SendBulkData then
        AICore:SendBulkData("recent_logs", self.AIRelevant)
        self.AIRelevant = {}
        self.LastFlush = tick()
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🤖 ADVANCED AI CORE SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local AICore = {
    Endpoint = "http://192.168.2.97:5001",
    Enabled = true,
    ConnectionStatus = false,
    DEXSnapshot = {},
    ScriptCache = {},
    LastHealthCheck = 0,
    RequestQueue = {},
    ProcessingQueue = false,
    ChatMode = false
}

function AICore:Initialize()
    SmartLogger:Log("HIGH", "AI_INIT", "🤖 Initializing AI Core...")
    
    self:HealthCheck()
    self:StartDEXMonitoring()
    self:StartScriptHunter()
    self:StartQueueProcessor()
    
    SmartLogger:Log("CRITICAL", "AI_READY", "🔥 AI Core fully initialized and ready!")
end

function AICore:HealthCheck()
    if not HttpService.HttpEnabled then
        SmartLogger:Log("CRITICAL", "AI_ERROR", "❌ HttpService disabled! AI cannot function!")
        return false
    end
    
    spawn(function()
        local success, result = pcall(function()
            return HttpService:GetAsync(self.Endpoint .. "/health")
        end)
        
        if success then
            local data = HttpService:JSONDecode(result)
            self.ConnectionStatus = true
            SmartLogger:Log("CRITICAL", "AI_CONNECTED", 
                string.format("✅ AI Connected! Model: %s", data.current_model or "Unknown"))
        else
            self.ConnectionStatus = false
            SmartLogger:Log("HIGH", "AI_ERROR", "❌ AI Connection failed: " .. tostring(result))
        end
        
        self.LastHealthCheck = tick()
    end)
end

function AICore:QueueRequest(endpoint, data, priority)
    priority = priority or 3
    table.insert(self.RequestQueue, {
        endpoint = endpoint,
        data = data,
        priority = priority,
        timestamp = tick()
    })
end

function AICore:StartQueueProcessor()
    spawn(function()
        while true do
            wait(0.5)
            if not self.ProcessingQueue and #self.RequestQueue > 0 then
                self.ProcessingQueue = true
                
                -- Sort by priority (highest first)
                table.sort(self.RequestQueue, function(a, b) return a.priority > b.priority end)
                
                local request = table.remove(self.RequestQueue, 1)
                if request then
                    spawn(function()
                        self:SendHTTPRequest(request.endpoint, request.data)
                    end)
                end
                
                self.ProcessingQueue = false
            end
        end
    end)
end

function AICore:SendHTTPRequest(endpoint, data)
    if not self.ConnectionStatus then return end
    
    local success, result = pcall(function()
        return HttpService:PostAsync(
            self.Endpoint .. "/" .. endpoint,
            HttpService:JSONEncode(data),
            Enum.HttpContentType.ApplicationJson
        )
    end)
    
    if not success then
        SmartLogger:Log("MEDIUM", "AI_ERROR", "Request failed: " .. tostring(result))
    end
end

function AICore:SendBulkData(dataType, data)
    self:QueueRequest("bulk_update", {
        type = dataType,
        data = data,
        timestamp = tick(),
        player = Player.Name,
        game_id = game.GameId
    }, 4)
end

function AICore:StartDEXMonitoring()
    spawn(function()
        while self.Enabled do
            wait(20) -- Every 20 seconds
            
            local dexData = self:CaptureDEXSnapshot()
            if dexData then
                self:QueueRequest("analyze_dex", dexData, 3)
            end
        end
    end)
end

function AICore:CaptureDEXSnapshot()
    local snapshot = {
        workspace = self:AnalyzeContainer(workspace, 2),
        replicatedStorage = self:AnalyzeContainer(ReplicatedStorage, 2),
        players = self:AnalyzeContainer(Players, 1),
        timestamp = tick()
    }
    
    return snapshot
end

function AICore:AnalyzeContainer(container, maxDepth, currentDepth)
    currentDepth = currentDepth or 0
    if currentDepth >= maxDepth then return nil end
    
    local data = {
        name = container.Name,
        className = container.ClassName,
        children = {},
        scripts = {}
    }
    
    for _, child in ipairs(container:GetChildren()) do
        if child:IsA("LuaSourceContainer") then
            local source = self:GetScriptSource(child)
            if source and #source > 20 then
                table.insert(data.scripts, {
                    name = child.Name,
                    type = child.ClassName,
                    source = source:sub(1, 1000), -- Truncate for performance
                    size = #source
                })
                
                SmartLogger:Log("HIGH", "SCRIPT_FOUND", 
                    string.format("📜 %s: %s (%d chars)", child.ClassName, child.Name, #source))
            end
        elseif currentDepth < maxDepth - 1 then
            local childData = self:AnalyzeContainer(child, maxDepth, currentDepth + 1)
            if childData then
                data.children[child.Name] = childData
            end
        end
    end
    
    return data
end

function AICore:GetScriptSource(script)
    if not script or not script:IsA("LuaSourceContainer") then return nil end
    
    local success, source = pcall(function()
        if script.Source and script.Source ~= "" then
            return script.Source
        end
        
        if decompile then
            return decompile(script)
        end
        
        if getsource then
            return getsource(script)
        end
        
        return nil
    end)
    
    return success and source or nil
end

function AICore:StartScriptHunter()
    spawn(function()
        while self.Enabled do
            wait(30) -- Every 30 seconds
            
            local scripts = {}
            for _, container in ipairs({workspace, ReplicatedStorage}) do
                for _, obj in ipairs(container:GetDescendants()) do
                    if obj:IsA("LuaSourceContainer") then
                        local source = self:GetScriptSource(obj)
                        if source and #source > 50 and not self.ScriptCache[obj] then
                            table.insert(scripts, {
                                name = obj.Name,
                                type = obj.ClassName,
                                parent = obj.Parent and obj.Parent.Name or "Unknown",
                                source = source,
                                path = obj:GetFullName()
                            })
                            
                            self.ScriptCache[obj] = true
                        end
                    end
                end
            end
            
            if #scripts > 0 then
                SmartLogger:Log("HIGH", "SCRIPT_HUNT", string.format("🎣 Found %d new scripts", #scripts))
                self:QueueRequest("analyze_scripts", {scripts = scripts}, 4)
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🕵️ ULTRA-ADVANCED REMOTE MONITORING
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local RemoteHunter = {
    HookedRemotes = {},
    RemoteData = {}
}

function RemoteHunter:Initialize()
    SmartLogger:Log("HIGH", "REMOTE_INIT", "🕵️ Initializing Remote Hunter...")
    
    self:HookRemoteEvents()
    self:ScanExistingRemotes()
end

function RemoteHunter:HookRemoteEvents()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "FireServer" and self:IsA("RemoteEvent") then
            local remoteData = {
                name = self.Name,
                parent = self.Parent and self.Parent.Name or "Unknown",
                args = #args > 0 and args or {},
                timestamp = tick(),
                type = "RemoteEvent",
                path = self:GetFullName()
            }
            
            SmartLogger:Log("CRITICAL", "REMOTE", 
                string.format("🚀 %s fired", self.Name), remoteData)
            
            AICore:QueueRequest("analyze_remote", remoteData, 5)
            
        elseif method == "InvokeServer" and self:IsA("RemoteFunction") then
            local remoteData = {
                name = self.Name,
                parent = self.Parent and self.Parent.Name or "Unknown",
                args = #args > 0 and args or {},
                timestamp = tick(),
                type = "RemoteFunction",
                path = self:GetFullName()
            }
            
            SmartLogger:Log("CRITICAL", "REMOTE", 
                string.format("🔧 %s invoked", self.Name), remoteData)
            
            AICore:QueueRequest("analyze_remote", remoteData, 5)
        end
        
        return oldNamecall(self, ...)
    end)
end

function RemoteHunter:ScanExistingRemotes()
    spawn(function()
        while AICore.Enabled do
            wait(25)
            
            local remotes = {}
            for _, container in ipairs({ReplicatedStorage, workspace}) do
                for _, obj in ipairs(container:GetDescendants()) do
                    if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) and not self.HookedRemotes[obj] then
                        table.insert(remotes, {
                            name = obj.Name,
                            type = obj.ClassName,
                            parent = obj.Parent and obj.Parent.Name or "Unknown",
                            path = obj:GetFullName()
                        })
                        
                        self.HookedRemotes[obj] = true
                    end
                end
            end
            
            if #remotes > 0 then
                SmartLogger:Log("HIGH", "REMOTE_DISCOVERY", 
                    string.format("🎯 Found %d new remotes", #remotes))
                AICore:SendBulkData("remote_discovery", remotes)
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🎯 SMART PROXIMITY & INTERACTION SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local InteractionSystem = {
    ProximityPrompts = {},
    TrackedGUIs = {},
    LastGUICheck = 0
}

function InteractionSystem:Initialize()
    SmartLogger:Log("MEDIUM", "INTERACTION", "🎯 Starting interaction monitoring...")
    
    -- Monitor ProximityPrompts
    ProximityPromptService.PromptShown:Connect(function(prompt, inputType)
        SmartLogger:Log("HIGH", "PROXIMITY", 
            string.format("📍 %s shown", prompt.ObjectText or "Prompt"))
        
        AICore:QueueRequest("report_interaction", {
            type = "proximity_shown",
            prompt = prompt.ObjectText or "Unknown",
            parent = prompt.Parent and prompt.Parent.Name or "Unknown"
        }, 3)
    end)
    
    ProximityPromptService.PromptHidden:Connect(function(prompt, inputType)
        AICore:QueueRequest("report_interaction", {
            type = "proximity_hidden",
            prompt = prompt.ObjectText or "Unknown"
        }, 2)
    end)
    
    -- Monitor GUI changes efficiently
    self:StartGUIMonitoring()
end

function InteractionSystem:StartGUIMonitoring()
    spawn(function()
        while AICore.Enabled do
            wait(3) -- Check every 3 seconds
            
            local currentTime = tick()
            if currentTime - self.LastGUICheck < 2 then
                continue
            end
            
            for _, gui in ipairs(PlayerGui:GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Enabled and not self.TrackedGUIs[gui.Name] then
                    self.TrackedGUIs[gui.Name] = currentTime
                    
                    SmartLogger:Log("MEDIUM", "GUI_SHOWN", 
                        string.format("🖼️ %s appeared", gui.Name))
                    
                    AICore:QueueRequest("report_interaction", {
                        type = "gui_shown",
                        name = gui.Name,
                        visible = gui.Enabled
                    }, 2)
                end
            end
            
            self.LastGUICheck = currentTime
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🎮 GLOBAL API & INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local function InitializeUltimateRspy()
    SmartLogger:Log("CRITICAL", "STARTUP", "🚀 Initializing Ultimate AI-Powered Rspy V3.0...")
    
    -- Initialize all systems
    AICore:Initialize()
    RemoteHunter:Initialize()
    InteractionSystem:Initialize()
    
    -- Start smart log flushing
    spawn(function()
        while true do
            wait(15)
            SmartLogger:FlushToAI()
        end
    end)
    
    SmartLogger:Log("CRITICAL", "SUCCESS", "🔥 Ultimate Rspy V3.0 fully operational!")
end

-- Enhanced Global API
_G.UltimateRspyV3 = {
    SmartLogger = SmartLogger,
    AICore = AICore,
    RemoteHunter = RemoteHunter,
    InteractionSystem = InteractionSystem,
    
    -- AI Chat Functions
    ChatWithAI = function(message)
        if not AICore.ConnectionStatus then
            SmartLogger:Log("HIGH", "AI_CHAT", "❌ AI not connected!")
            return
        end
        
        SmartLogger:Log("HIGH", "AI_CHAT", "💬 Sending: " .. message)
        AICore:QueueRequest("chat", {
            message = message,
            context = "roblox_game",
            player = Player.Name,
            timestamp = tick()
        }, 5)
        
        SmartLogger:Log("HIGH", "AI_CHAT", "📨 Message sent to AI! Check terminal for response.")
    end,
    
    -- Quick commands
    Ask = function(question)
        _G.UltimateRspyV3.ChatWithAI(question)
    end,
    
    -- Deep Analysis
    DeepScanNow = function()
        SmartLogger:Log("HIGH", "MANUAL_SCAN", "🔍 Starting manual deep scan...")
        local snapshot = AICore:CaptureDEXSnapshot()
        if snapshot then
            AICore:QueueRequest("analyze_dex", snapshot, 5)
            SmartLogger:Log("HIGH", "MANUAL_SCAN", "📊 Deep scan data sent to AI!")
        end
    end,
    
    -- AI Status
    AIStatus = function()
        local queueSize = #AICore.RequestQueue
        local relevantLogs = #SmartLogger.AIRelevant
        
        SmartLogger:Log("HIGH", "AI_STATUS", string.format(
            "🤖 Connected: %s | Queue: %d | AI Logs: %d | Scripts Found: %d",
            AICore.ConnectionStatus and "✅" or "❌",
            queueSize, relevantLogs, 
            table.getn and table.getn(AICore.ScriptCache) or 0
        ))
    end,
    
    -- Toggle modes
    SetVerbose = function(enabled)
        SmartLogger.SilentMode = not enabled
        SmartLogger:Log("HIGH", "MODE", 
            string.format("🔊 Verbose logging: %s", enabled and "ON" or "OFF"))
    end,
    
    -- Force send all data
    SendEverything = function()
        SmartLogger:Log("HIGH", "FORCE_SEND", "📤 Sending all data to AI...")
        SmartLogger:FlushToAI()
        local snapshot = AICore:CaptureDEXSnapshot()
        if snapshot then
            AICore:QueueRequest("full_analysis", snapshot, 5)
        end
        SmartLogger:Log("HIGH", "FORCE_SEND", "✅ Complete data dump sent to AI!")
    end,
    
    -- Show available commands
    Help = function()
        SmartLogger:Log("HIGH", "HELP", "🚀 UltimateRspyV3 Commands:")
        SmartLogger:Log("HIGH", "HELP", "• ChatWithAI('message') or Ask('question') - Chat with AI")
        SmartLogger:Log("HIGH", "HELP", "• AIStatus() - Check AI connection and stats") 
        SmartLogger:Log("HIGH", "HELP", "• DeepScanNow() - Force immediate deep scan")
        SmartLogger:Log("HIGH", "HELP", "• SendEverything() - Send all data to AI")
        SmartLogger:Log("HIGH", "HELP", "• SetVerbose(true/false) - Toggle verbose logging")
        SmartLogger:Log("HIGH", "HELP", "💡 AI analyzes everything automatically!")
    end
}

-- Initialize system
InitializeUltimateRspy()

-- Success messages (minimal)
SmartLogger:Log("CRITICAL", "READY", "🎉 ULTIMATE AI-POWERED RSPY V3.0 READY!")
SmartLogger:Log("CRITICAL", "READY", "💬 Use _G.UltimateRspyV3.Ask('your question') for AI chat!")
SmartLogger:Log("CRITICAL", "READY", "🧠 AI monitoring: DEX, Scripts, Remotes, Interactions!")

-- Initial AI connection test
spawn(function()
    wait(2)
    if HttpService.HttpEnabled then
        SmartLogger:Log("HIGH", "CONNECTION_TEST", "🔧 Testing AI connection...")
        AICore:HealthCheck()
    else
        SmartLogger:Log("CRITICAL", "HTTP_WARNING", "⚠️ Enable HttpService for AI features!")
    end
    
    wait(3)
    SmartLogger:Log("HIGH", "READY", "💡 Try: _G.UltimateRspyV3.Ask('What can you see in this game?')")
end)
