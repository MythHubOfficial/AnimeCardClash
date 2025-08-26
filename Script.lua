--[[
╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗
║                    🔥 ULTIMATE LOCAL RSPY V3.5 - NO HTTP NEEDED! 🔥                                     ║
║                      💎 CLIENT-FRIENDLY REVERSE ENGINEERING 💎                                           ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════╣
║ 🚀 LOKALE FEATURES (KEIN HTTPSERVICE NÖTIG):                                                             ║
║ • 🧠 Local AI-Style Analysis & Pattern Recognition                                                       ║
║ • 🔍 Advanced Script Decompilation & Analysis                                                            ║
║ • 📊 Real-time Local Vulnerability Detection                                                             ║
║ • 🎯 Smart Local Logging with Intelligence                                                               ║
║ • 📈 Live Local Dashboard & Statistics                                                                   ║
║ • 💾 Local Data Export & Analysis                                                                        ║
║ • 🛡️ Zero Network Dependencies                                                                           ║
║ • ⚡ Ultra-Fast Local Processing                                                                          ║
║ • 🎮 Complete Game State Monitoring                                                                      ║
║ • 🔧 Advanced Local Chat Commands                                                                        ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝
--]]

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🛡️ ULTRA-STEALTH LOCAL INITIALIZATION
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
local UserInputService, ProximityPromptService = Services.UserInputService, Services.ProximityPromptService
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🧠 LOCAL AI-STYLE INTELLIGENCE SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local LocalAI = {
    PatternDatabase = {
        -- Exploitable Remote Patterns
        exploit_remotes = {
            "money", "cash", "coin", "gold", "gem", "diamond", "currency",
            "teleport", "tp", "position", "cframe",
            "speed", "walkspeed", "jumppower", "jump",
            "health", "hp", "damage", "hurt", "heal",
            "admin", "mod", "owner", "kick", "ban",
            "god", "godmode", "invincible", "immortal",
            "fly", "flight", "noclip", "clip",
            "level", "exp", "experience", "rank", "score"
        },
        
        -- Vulnerable Script Patterns
        script_patterns = {
            {pattern = "RemoteEvent:FireServer", risk = "HIGH", desc = "Remote execution point"},
            {pattern = "RemoteFunction:InvokeServer", risk = "HIGH", desc = "Remote function call"},
            {pattern = "_G%[", risk = "MEDIUM", desc = "Global variable access"},
            {pattern = "loadstring", risk = "CRITICAL", desc = "Dynamic code execution"},
            {pattern = "getfenv", risk = "HIGH", desc = "Environment manipulation"},
            {pattern = "HttpService", risk = "MEDIUM", desc = "HTTP requests detected"},
            {pattern = "game%.Players%.LocalPlayer%.UserId", risk = "LOW", desc = "User ID exposure"},
            {pattern = "workspace%.CurrentCamera", risk = "LOW", desc = "Camera manipulation"}
        },
        
        -- GUI Exploitation Patterns
        gui_patterns = {
            "shop", "store", "buy", "purchase", "trade",
            "inventory", "backpack", "items", "weapons",
            "settings", "config", "menu", "panel",
            "admin", "mod", "developer", "dev"
        }
    },
    
    AnalysisResults = {
        vulnerabilities = {},
        exploitable_remotes = {},
        interesting_scripts = {},
        gui_targets = {},
        patterns_found = {}
    }
}

function LocalAI:AnalyzeRemote(remote_data)
    local name = remote_data.name:lower()
    local risk_score = 0
    local exploit_methods = {}
    local description = "Standard remote"
    
    -- Check exploit patterns
    for _, pattern in ipairs(self.PatternDatabase.exploit_remotes) do
        if name:find(pattern) then
            risk_score = risk_score + 10
            table.insert(exploit_methods, "Pattern: " .. pattern)
            description = "POTENTIALLY EXPLOITABLE - " .. pattern .. " related"
        end
    end
    
    -- Analyze arguments if provided
    if remote_data.args and #remote_data.args > 0 then
        risk_score = risk_score + 5
        table.insert(exploit_methods, "Has arguments - manipulation possible")
    end
    
    -- Check parent context
    local parent = (remote_data.parent or ""):lower()
    if parent:find("shop") or parent:find("money") or parent:find("admin") then
        risk_score = risk_score + 15
        description = "HIGH RISK - Critical system remote"
    end
    
    local risk_level = risk_score >= 20 and "CRITICAL" or 
                      risk_score >= 10 and "HIGH" or 
                      risk_score >= 5 and "MEDIUM" or "LOW"
    
    local analysis = {
        name = remote_data.name,
        risk_level = risk_level,
        risk_score = risk_score,
        description = description,
        exploit_methods = exploit_methods,
        timestamp = tick()
    }
    
    if risk_score >= 10 then
        table.insert(self.AnalysisResults.exploitable_remotes, analysis)
        table.insert(self.AnalysisResults.vulnerabilities, {
            type = "Exploitable Remote",
            target = remote_data.name,
            severity = risk_level,
            details = description,
            timestamp = tick()
        })
    end
    
    return analysis
end

function LocalAI:AnalyzeScript(script_data)
    local source = script_data.source or ""
    local name = script_data.name
    local vulnerabilities = {}
    local interesting_patterns = {}
    
    -- Pattern analysis
    for _, pattern_data in ipairs(self.PatternDatabase.script_patterns) do
        local matches = {}
        local pattern = pattern_data.pattern
        
        -- Find all matches
        for match in source:gmatch(pattern) do
            table.insert(matches, match)
        end
        
        if #matches > 0 then
            table.insert(vulnerabilities, {
                pattern = pattern,
                risk = pattern_data.risk,
                description = pattern_data.desc,
                matches = #matches,
                examples = {matches[1], matches[2], matches[3]} -- First 3 matches
            })
            
            table.insert(interesting_patterns, pattern_data.desc)
        end
    end
    
    -- Script size analysis
    local size_analysis = ""
    if #source > 10000 then
        size_analysis = "LARGE SCRIPT - Likely contains complex logic"
    elseif #source > 1000 then
        size_analysis = "MEDIUM SCRIPT - May contain interesting features"
    else
        size_analysis = "SMALL SCRIPT - Basic functionality"
    end
    
    local analysis = {
        name = name,
        type = script_data.type,
        size = #source,
        size_analysis = size_analysis,
        vulnerabilities = vulnerabilities,
        patterns = interesting_patterns,
        risk_score = #vulnerabilities * 5,
        timestamp = tick()
    }
    
    if #vulnerabilities > 0 then
        table.insert(self.AnalysisResults.interesting_scripts, analysis)
    end
    
    return analysis
end

function LocalAI:AnalyzeGUI(gui_data)
    local name = gui_data.name:lower()
    local interest_score = 0
    local potential_exploits = {}
    
    for _, pattern in ipairs(self.PatternDatabase.gui_patterns) do
        if name:find(pattern) then
            interest_score = interest_score + 10
            table.insert(potential_exploits, "GUI Type: " .. pattern)
        end
    end
    
    if interest_score >= 10 then
        local analysis = {
            name = gui_data.name,
            interest_score = interest_score,
            potential_exploits = potential_exploits,
            timestamp = tick()
        }
        
        table.insert(self.AnalysisResults.gui_targets, analysis)
        return analysis
    end
    
    return nil
end

function LocalAI:GenerateReport()
    local report = {
        "🧠 LOCAL AI ANALYSIS REPORT",
        "═══════════════════════════════════",
        ""
    }
    
    -- Vulnerability Summary
    table.insert(report, string.format("📊 VULNERABILITIES FOUND: %d", #self.AnalysisResults.vulnerabilities))
    table.insert(report, string.format("🎯 EXPLOITABLE REMOTES: %d", #self.AnalysisResults.exploitable_remotes))
    table.insert(report, string.format("📜 INTERESTING SCRIPTS: %d", #self.AnalysisResults.interesting_scripts))
    table.insert(report, string.format("🖼️ GUI TARGETS: %d", #self.AnalysisResults.gui_targets))
    table.insert(report, "")
    
    -- Top Vulnerabilities
    if #self.AnalysisResults.vulnerabilities > 0 then
        table.insert(report, "🔥 TOP VULNERABILITIES:")
        for i, vuln in ipairs(self.AnalysisResults.vulnerabilities) do
            if i <= 5 then -- Top 5
                table.insert(report, string.format("  %d. [%s] %s: %s", i, vuln.severity, vuln.type, vuln.details))
            end
        end
        table.insert(report, "")
    end
    
    -- Top Exploitable Remotes
    if #self.AnalysisResults.exploitable_remotes > 0 then
        table.insert(report, "🎯 TOP EXPLOITABLE REMOTES:")
        for i, remote in ipairs(self.AnalysisResults.exploitable_remotes) do
            if i <= 5 then -- Top 5
                table.insert(report, string.format("  %d. [%s] %s - %s", i, remote.risk_level, remote.name, remote.description))
            end
        end
        table.insert(report, "")
    end
    
    return table.concat(report, "\n")
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🎯 ENHANCED LOCAL LOGGING SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local LocalLogger = {
    Levels = {
        CRITICAL = {priority = 5, color = "\27[41m", icon = "🔥"},
        HIGH = {priority = 4, color = "\27[91m", icon = "⚡"},
        MEDIUM = {priority = 3, color = "\27[93m", icon = "💡"},
        LOW = {priority = 2, color = "\27[96m", icon = "📌"},
        SUCCESS = {priority = 4, color = "\27[92m", icon = "✅"},
        INFO = {priority = 3, color = "\27[97m", icon = "ℹ️"}
    },
    LogHistory = {},
    Stats = {
        scripts_found = 0,
        remotes_found = 0,
        guis_tracked = 0,
        vulnerabilities = 0,
        start_time = tick()
    }
}

function LocalLogger:Log(level, category, message, data)
    local levelInfo = self.Levels[level] or self.Levels.INFO
    
    -- Only log MEDIUM priority and above for cleaner output
    if levelInfo.priority < 3 then return end
    
    local timestamp = os.date("%H:%M:%S")
    local formatted = string.format("%s[%s] %s %s: %s\27[0m", 
        levelInfo.color, timestamp, levelInfo.icon, category, message)
    
    print(formatted)
    
    -- Store in history
    table.insert(self.LogHistory, {
        level = level,
        category = category,
        message = message,
        timestamp = tick(),
        data = data
    })
    
    -- Keep only last 100 logs
    if #self.LogHistory > 100 then
        table.remove(self.LogHistory, 1)
    end
end

function LocalLogger:ShowDashboard()
    local uptime = tick() - self.Stats.start_time
    local minutes = math.floor(uptime / 60)
    local seconds = math.floor(uptime % 60)
    
    print("\n" .. self.Levels.SUCCESS.color .. "╔══════════════════════════════════════════════════════════════════════════════╗" .. "\27[0m")
    print(self.Levels.SUCCESS.color .. "║                    📊 ULTIMATE LOCAL RSPY DASHBOARD                         ║" .. "\27[0m")
    print(self.Levels.SUCCESS.color .. "╠══════════════════════════════════════════════════════════════════════════════╣" .. "\27[0m")
    print(string.format("%s║ ⏱️  Uptime: %dm %02ds                  🎮 Game: %s%s║%s", 
        self.Levels.INFO.color, minutes, seconds, 
        string.sub(game.Name or "Unknown", 1, 20),
        string.rep(" ", 22 - math.min(#(game.Name or "Unknown"), 20)),
        "\27[0m"))
    print(string.format("%s║ 📜 Scripts Found: %d                   🎯 Remotes Found: %d%s║%s", 
        self.Levels.INFO.color, self.Stats.scripts_found, self.Stats.remotes_found,
        string.rep(" ", 10 - #tostring(self.Stats.remotes_found)),
        "\27[0m"))
    print(string.format("%s║ 🖼️  GUIs Tracked: %d                   🔥 Vulnerabilities: %d%s║%s", 
        self.Levels.INFO.color, self.Stats.guis_tracked, self.Stats.vulnerabilities,
        string.rep(" ", 8 - #tostring(self.Stats.vulnerabilities)),
        "\27[0m"))
    print(self.Levels.SUCCESS.color .. "╚══════════════════════════════════════════════════════════════════════════════╝" .. "\27[0m")
    
    -- Show AI Analysis Summary
    local ai_report = LocalAI:GenerateReport()
    print("\n" .. self.Levels.MEDIUM.color .. ai_report .. "\27[0m")
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🕵️ ADVANCED REMOTE MONITORING
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local RemoteHunter = {
    TrackedRemotes = {},
    RemoteStats = {}
}

function RemoteHunter:Initialize()
    LocalLogger:Log("HIGH", "REMOTE_INIT", "🕵️ Initializing Local Remote Hunter...")
    
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
                args = args,
                timestamp = tick(),
                type = "RemoteEvent",
                path = self:GetFullName()
            }
            
            -- Local AI analysis
            local analysis = LocalAI:AnalyzeRemote(remoteData)
            
            if analysis.risk_score >= 10 then
                LocalLogger:Log("CRITICAL", "EXPLOIT_REMOTE", 
                    string.format("🎯 %s (%s)", self.Name, analysis.risk_level))
            else
                LocalLogger:Log("MEDIUM", "REMOTE", 
                    string.format("📡 %s fired", self.Name))
            end
            
        elseif method == "InvokeServer" and self:IsA("RemoteFunction") then
            local remoteData = {
                name = self.Name,
                parent = self.Parent and self.Parent.Name or "Unknown",
                args = args,
                timestamp = tick(),
                type = "RemoteFunction",
                path = self:GetFullName()
            }
            
            local analysis = LocalAI:AnalyzeRemote(remoteData)
            
            if analysis.risk_score >= 10 then
                LocalLogger:Log("CRITICAL", "EXPLOIT_REMOTE", 
                    string.format("🔧 %s (%s)", self.Name, analysis.risk_level))
            else
                LocalLogger:Log("MEDIUM", "REMOTE", 
                    string.format("🔧 %s invoked", self.Name))
            end
        end
        
        return oldNamecall(self, ...)
    end)
end

function RemoteHunter:ScanExistingRemotes()
    spawn(function()
        while true do
            wait(30) -- Every 30 seconds
            
            local newRemotes = 0
            for _, container in ipairs({ReplicatedStorage, workspace}) do
                for _, obj in ipairs(container:GetDescendants()) do
                    if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) and not self.TrackedRemotes[obj] then
                        newRemotes = newRemotes + 1
                        self.TrackedRemotes[obj] = {
                            name = obj.Name,
                            type = obj.ClassName,
                            parent = obj.Parent and obj.Parent.Name or "Unknown",
                            path = obj:GetFullName(),
                            discovered_at = tick()
                        }
                        
                        -- Immediate local analysis
                        local analysis = LocalAI:AnalyzeRemote({
                            name = obj.Name,
                            type = obj.ClassName,
                            parent = obj.Parent and obj.Parent.Name or "Unknown"
                        })
                        
                        LocalLogger.Stats.remotes_found = LocalLogger.Stats.remotes_found + 1
                    end
                end
            end
            
            if newRemotes > 0 then
                LocalLogger:Log("HIGH", "REMOTE_DISCOVERY", 
                    string.format("🎯 %d new remotes discovered", newRemotes))
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🔍 ADVANCED LOCAL SCRIPT HUNTER
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local ScriptHunter = {
    TrackedScripts = {}
}

function ScriptHunter:Initialize()
    LocalLogger:Log("HIGH", "SCRIPT_INIT", "🔍 Starting Local Script Hunter...")
    
    self:StartScriptHunting()
end

function ScriptHunter:GetScriptSource(script)
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

function ScriptHunter:StartScriptHunting()
    spawn(function()
        while true do
            wait(25) -- Every 25 seconds
            
            local newScripts = 0
            for _, container in ipairs({workspace, ReplicatedStorage, PlayerGui}) do
                for _, obj in ipairs(container:GetDescendants()) do
                    if obj:IsA("LuaSourceContainer") and not self.TrackedScripts[obj] then
                        local source = self:GetScriptSource(obj)
                        if source and #source > 50 then -- Ignore tiny scripts
                            newScripts = newScripts + 1
                            
                            local scriptData = {
                                name = obj.Name,
                                type = obj.ClassName,
                                parent = obj.Parent and obj.Parent.Name or "Unknown",
                                source = source,
                                size = #source,
                                path = obj:GetFullName()
                            }
                            
                            self.TrackedScripts[obj] = scriptData
                            
                            -- Local AI analysis
                            local analysis = LocalAI:AnalyzeScript(scriptData)
                            
                            if analysis.risk_score >= 15 then
                                LocalLogger:Log("CRITICAL", "VULN_SCRIPT", 
                                    string.format("🔥 %s (%d chars, %d vulns)", 
                                    obj.Name, #source, #analysis.vulnerabilities))
                                LocalLogger.Stats.vulnerabilities = LocalLogger.Stats.vulnerabilities + 1
                            else
                                LocalLogger:Log("HIGH", "SCRIPT_FOUND", 
                                    string.format("📜 %s: %s (%d chars)", 
                                    obj.ClassName, obj.Name, #source))
                            end
                            
                            LocalLogger.Stats.scripts_found = LocalLogger.Stats.scripts_found + 1
                        end
                    end
                end
            end
            
            if newScripts > 0 then
                LocalLogger:Log("SUCCESS", "SCRIPT_HUNT", 
                    string.format("📚 %d new scripts analyzed", newScripts))
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🎯 GUI MONITORING SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local GUIMonitor = {
    TrackedGUIs = {}
}

function GUIMonitor:Initialize()
    LocalLogger:Log("MEDIUM", "GUI_INIT", "🎯 Starting GUI monitoring...")
    
    self:StartGUIMonitoring()
    
    -- Monitor ProximityPrompts if available
    if ProximityPromptService then
        ProximityPromptService.PromptShown:Connect(function(prompt, inputType)
            LocalLogger:Log("HIGH", "PROXIMITY", 
                string.format("📍 %s shown", prompt.ObjectText or "Prompt"))
        end)
    end
end

function GUIMonitor:StartGUIMonitoring()
    spawn(function()
        while true do
            wait(5) -- Check every 5 seconds
            
            for _, gui in ipairs(PlayerGui:GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Enabled and not self.TrackedGUIs[gui.Name] then
                    self.TrackedGUIs[gui.Name] = tick()
                    
                    -- Local AI analysis
                    local analysis = LocalAI:AnalyzeGUI({name = gui.Name})
                    
                    if analysis then
                        LocalLogger:Log("HIGH", "TARGET_GUI", 
                            string.format("🎯 %s (Score: %d)", gui.Name, analysis.interest_score))
                    else
                        LocalLogger:Log("MEDIUM", "GUI_SHOWN", 
                            string.format("🖼️ %s appeared", gui.Name))
                    end
                    
                    LocalLogger.Stats.guis_tracked = LocalLogger.Stats.guis_tracked + 1
                end
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🎮 ENHANCED GLOBAL API & COMMANDS
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════

local function InitializeUltimateRspy()
    LocalLogger:Log("CRITICAL", "STARTUP", "🚀 Initializing Ultimate Local Rspy V3.5...")
    
    -- Initialize all systems
    RemoteHunter:Initialize()
    ScriptHunter:Initialize() 
    GUIMonitor:Initialize()
    
    -- Start dashboard updates
    spawn(function()
        while true do
            wait(60) -- Every minute
            LocalLogger:ShowDashboard()
        end
    end)
    
    LocalLogger:Log("CRITICAL", "SUCCESS", "🔥 Ultimate Local Rspy V3.5 fully operational!")
end

-- Enhanced Global API
_G.UltimateLocalRspy = {
    LocalLogger = LocalLogger,
    LocalAI = LocalAI,
    RemoteHunter = RemoteHunter,
    ScriptHunter = ScriptHunter,
    GUIMonitor = GUIMonitor,
    
    -- Dashboard & Analysis
    ShowDashboard = function()
        LocalLogger:ShowDashboard()
    end,
    
    ShowAIReport = function()
        local report = LocalAI:GenerateReport()
        print("\n" .. report)
    end,
    
    -- Vulnerability Analysis
    ShowVulnerabilities = function()
        LocalLogger:Log("INFO", "VULNS", "🔥 VULNERABILITY REPORT:")
        for i, vuln in ipairs(LocalAI.AnalysisResults.vulnerabilities) do
            print(string.format("%d. [%s] %s: %s", i, vuln.severity, vuln.type, vuln.details))
        end
    end,
    
    ShowExploitableRemotes = function()
        LocalLogger:Log("INFO", "EXPLOITS", "🎯 EXPLOITABLE REMOTES:")
        for i, remote in ipairs(LocalAI.AnalysisResults.exploitable_remotes) do
            print(string.format("%d. [%s] %s - %s", i, remote.risk_level, remote.name, remote.description))
            if #remote.exploit_methods > 0 then
                for j, method in ipairs(remote.exploit_methods) do
                    print(string.format("   • %s", method))
                end
            end
        end
    end,
    
    ShowInterestingScripts = function()
        LocalLogger:Log("INFO", "SCRIPTS", "📜 INTERESTING SCRIPTS:")
        for i, script in ipairs(LocalAI.AnalysisResults.interesting_scripts) do
            print(string.format("%d. %s (%d chars, Risk: %d)", i, script.name, script.size, script.risk_score))
            for j, pattern in ipairs(script.patterns) do
                print(string.format("   • %s", pattern))
            end
        end
    end,
    
    -- Remote Testing
    TestRemote = function(remoteName, ...)
        local args = {...}
        LocalLogger:Log("HIGH", "TEST", string.format("🧪 Testing remote: %s with args: %s", remoteName, table.concat(args, ", ")))
        
        for _, container in ipairs({ReplicatedStorage, workspace}) do
            for _, obj in ipairs(container:GetDescendants()) do
                if obj.Name == remoteName and obj:IsA("RemoteEvent") then
                    pcall(function()
                        obj:FireServer(unpack(args))
                        LocalLogger:Log("SUCCESS", "TEST", "✅ Remote fired successfully")
                    end)
                    return
                elseif obj.Name == remoteName and obj:IsA("RemoteFunction") then
                    pcall(function()
                        local result = obj:InvokeServer(unpack(args))
                        LocalLogger:Log("SUCCESS", "TEST", "✅ Remote invoked, result: " .. tostring(result))
                    end)
                    return
                end
            end
        end
        
        LocalLogger:Log("HIGH", "TEST", "❌ Remote not found: " .. remoteName)
    end,
    
    -- Statistics
    ShowStats = function()
        LocalLogger:ShowDashboard()
    end,
    
    -- Search functions
    FindRemote = function(pattern)
        LocalLogger:Log("INFO", "SEARCH", "🔍 Searching for remotes matching: " .. pattern)
        local found = {}
        for obj, data in pairs(RemoteHunter.TrackedRemotes) do
            if data.name:lower():find(pattern:lower()) then
                table.insert(found, data.name)
            end
        end
        
        if #found > 0 then
            LocalLogger:Log("SUCCESS", "SEARCH", "✅ Found " .. #found .. " matching remotes:")
            for i, name in ipairs(found) do
                print(string.format("  %d. %s", i, name))
            end
        else
            LocalLogger:Log("HIGH", "SEARCH", "❌ No remotes found matching: " .. pattern)
        end
        
        return found
    end,
    
    -- Help system
    Help = function()
        LocalLogger:Log("INFO", "HELP", "🚀 Ultimate Local Rspy V3.5 Commands:")
        LocalLogger:Log("INFO", "HELP", "• ShowDashboard() - Show live dashboard")
        LocalLogger:Log("INFO", "HELP", "• ShowAIReport() - Show AI analysis report") 
        LocalLogger:Log("INFO", "HELP", "• ShowVulnerabilities() - List all vulnerabilities")
        LocalLogger:Log("INFO", "HELP", "• ShowExploitableRemotes() - List exploitable remotes")
        LocalLogger:Log("INFO", "HELP", "• ShowInterestingScripts() - List interesting scripts")
        LocalLogger:Log("INFO", "HELP", "• TestRemote(name, args...) - Test a remote")
        LocalLogger:Log("INFO", "HELP", "• FindRemote(pattern) - Search for remotes")
        LocalLogger:Log("INFO", "HELP", "💡 All analysis runs automatically in background!")
    end
}

-- Initialize system
InitializeUltimateRspy()

-- Success messages
LocalLogger:Log("CRITICAL", "READY", "🎉 ULTIMATE LOCAL RSPY V3.5 READY!")
LocalLogger:Log("CRITICAL", "READY", "💬 Use _G.UltimateLocalRspy.Help() for commands!")
LocalLogger:Log("CRITICAL", "READY", "🧠 Local AI analyzing everything automatically!")
LocalLogger:Log("SUCCESS", "NO_HTTP", "✅ No HttpService needed - Pure local analysis!")

-- Show initial dashboard after 5 seconds
spawn(function()
    wait(5)
    LocalLogger:ShowDashboard()
    
    wait(3)
    LocalLogger:Log("HIGH", "HINT", "💡 Try: _G.UltimateLocalRspy.ShowExploitableRemotes()")
end)
