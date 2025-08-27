-- CARDS CLASH AUTO FIGHT UI - Enhanced Version
-- Advanced auto-fighting system with intelligent combat detection

-- Load the UI library
local Library = loadstring(game:HttpGet('https://gist.githubusercontent.com/MjContiga1/5b9535166d60560ac884a871cb0dc418/raw/e7fdb16802d9486d8d04d3e41d3607d89e6b4a1b/Libsuck.lua'))()

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")

-- Create main window
local window = Library:Window('⚡ CARDS CLASH - AUTO FIGHT V2')

-- Create tabs
local storyTab = window:Tab({"🏯 Story Mode", "rbxassetid://7734022041"})
local raidTab = window:Tab({"⚔️ Raids", "rbxassetid://7743875962"})
local towerTab = window:Tab({"🗼 Towers", "rbxassetid://7733673987"})
local miscTab = window:Tab({"🗺️ Misc", "rbxassetid://7734042071"})
local settingsTab = window:Tab({"⚙️ Settings", "rbxassetid://7734052508"})

-- Enhanced auto-fighting states and connections
local autoFightStates = {}
local autoFightConnections = {}
local fightStatistics = {}
local globalSettings = {
    smartIntervals = true,
    maxRetries = 3,
    enableNotifications = true,
    autoCollectRewards = true,
    fightDelay = 5,
    quickFightDelay = 2
}

-- Enhanced Fight Detection System
local function isInBattle()
    -- Check for common battle UI elements
    local battleUI = PlayerGui:FindFirstChild("BattleGui") or PlayerGui:FindFirstChild("FightUI")
    if battleUI and battleUI.Visible then
        return true
    end
    
    -- Check for loading screens or battle indicators
    local loadingScreen = PlayerGui:FindFirstChild("LoadingScreen")
    if loadingScreen and loadingScreen.Visible then
        return true
    end
    
    -- Check workspace for battle indicators
    if workspace:FindFirstChild("BattleArea") or workspace.CurrentCamera:FindFirstChild("BattleEffect") then
        return true
    end
    
    return false
end

local function getOptimalWaitTime(fightType)
    if not globalSettings.smartIntervals then
        return globalSettings.fightDelay
    end
    
    -- Dynamic wait times based on fight type and status
    if isInBattle() then
        return 1 -- Check frequently during battle
    end
    
    local waitTimes = {
        story = globalSettings.fightDelay,
        raid = globalSettings.fightDelay + 1,
        tower = globalSettings.quickFightDelay,
        exploration = globalSettings.fightDelay + 2
    }
    
    return waitTimes[fightType] or globalSettings.fightDelay
end

local function logFightAttempt(fightType, success, error)
    if not fightStatistics[fightType] then
        fightStatistics[fightType] = {
            attempts = 0,
            successes = 0,
            errors = 0,
            lastAttempt = 0
        }
    end
    
    local stats = fightStatistics[fightType]
    stats.attempts = stats.attempts + 1
    stats.lastAttempt = tick()
    
    if success then
        stats.successes = stats.successes + 1
        if globalSettings.enableNotifications then
            print("✅ " .. fightType:upper() .. " fight successful! (" .. stats.successes .. "/" .. stats.attempts .. ")")
        end
    else
        stats.errors = stats.errors + 1
        if globalSettings.enableNotifications then
            print("❌ " .. fightType:upper() .. " fight failed: " .. (error or "Unknown error"))
        end
    end
end

-- Enhanced auto-fight function with retry logic and smart intervals
local function startAutoFight(key, fightFunction, fightType)
    if autoFightConnections[key] then
        task.cancel(autoFightConnections[key])
    end
    
    -- Initialize fight statistics
    if not fightStatistics[key] then
        fightStatistics[key] = {attempts = 0, successes = 0, errors = 0, lastAttempt = 0}
    end
    
    autoFightConnections[key] = task.spawn(function()
        local retryCount = 0
        
        while autoFightStates[key] do
            local waitTime = getOptimalWaitTime(fightType or key)
            
            -- Don't attempt fight if already in battle (unless it's been too long)
            if isInBattle() and (tick() - fightStatistics[key].lastAttempt) < 30 then
                task.wait(1)
                continue
            end
            
            local success, error = pcall(fightFunction)
            logFightAttempt(key, success, error)
            
            if not success then
                retryCount = retryCount + 1
                if retryCount >= globalSettings.maxRetries then
                    print("🛑 Max retries reached for " .. key .. ". Stopping auto-fight.")
                    autoFightStates[key] = false
                    break
                end
                waitTime = waitTime * 2 -- Exponential backoff on errors
            else
                retryCount = 0 -- Reset retry count on success
            end
            
            task.wait(waitTime)
        end
    end)
end

local function stopAutoFight(key)
    autoFightStates[key] = false
    if autoFightConnections[key] then
        task.cancel(autoFightConnections[key])
        autoFightConnections[key] = nil
    end
end

local function stopAllAutoFights()
    for key, _ in pairs(autoFightStates) do
        stopAutoFight(key)
    end
    print("🛑 All auto-fighting stopped!")
end

-- Auto-reward collection function
local function collectRewards()
    if not globalSettings.autoCollectRewards then return end
    
    pcall(function()
        -- Try to collect various rewards
        ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("claimDailyReward"):FireServer()
        ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("collectAllMail"):FireServer()
        ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("claimBattlePass"):FireServer()
    end)
end

-- ==================== STORY MODE TAB ====================
storyTab:Label("🏯 Story Mode Auto-Fighting")

-- Story Mode Variables
local storyEnemyId = 311
local storyDifficulty = "normal"

-- Enemy ID Input
storyTab:InputBox("Enemy ID", "Enter enemy ID (311, 309, etc.)", function(text)
    local id = tonumber(text)
    if id then
        storyEnemyId = id
        print("Story Enemy ID set to:", storyEnemyId)
    end
end)

-- Difficulty Dropdown
storyTab:Dropdown("Difficulty", {"normal", "medium", "hard", "extreme"}, function(selected)
    storyDifficulty = selected
    print("Story Difficulty set to:", storyDifficulty)
end)

-- Auto Fight Story Toggle
storyTab:Toggle('🚀 Auto Fight Story Enemy', false, function(state)
    autoFightStates["story"] = state
    print("Auto Story Fight:", state and "ON" or "OFF")
    
    if state then
        startAutoFight("story", function()
            local args = {storyEnemyId, storyDifficulty}
            ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("fightStoryBoss"):FireServer(unpack(args))
            
            -- Auto-collect rewards after fight
            collectRewards()
        end, "story")
    else
        stopAutoFight("story")
    end
end)

-- Story Mode Status Display
storyTab:Label("📊 Story Status: Idle")
local storyStatusLabel = storyTab:Label("Fights: 0/0 | Success Rate: 0%")

-- Popular Story Enemies
storyTab:Label("📋 Popular Story Enemies:")

storyTab:Button('🏯 Rock Lee (311)', function()
    storyEnemyId = 311
    print("Selected: Rock Lee (311)")
end)

storyTab:Button('🏯 Kakashi (309)', function()
    storyEnemyId = 309
    print("Selected: Kakashi (309)")
end)

storyTab:Button('👑 Bijuu Naruto (308) - BOSS', function()
    storyEnemyId = 308
    print("Selected: Bijuu Naruto (308) - BOSS")
end)

storyTab:Button('👑 King of Curses (331) - BOSS', function()
    storyEnemyId = 331
    print("Selected: King of Curses (331) - BOSS")
end)

-- ==================== RAID BOSSES TAB ====================
raidTab:Label("⚔️ Raid Bosses Auto-Fighting")

-- Raid Boss Variables
local raidBossId = 373

-- Raid Boss ID Input
raidTab:InputBox("Raid Boss ID", "Enter boss ID (373, 370, etc.)", function(text)
    local id = tonumber(text)
    if id then
        raidBossId = id
        print("Raid Boss ID set to:", raidBossId)
    end
end)

-- Auto Fight Raid Boss Toggle
raidTab:Toggle('🐉 Auto Fight Raid Boss', false, function(state)
    autoFightStates["raid"] = state
    print("Auto Raid Fight:", state and "ON" or "OFF")
    
    if state then
        startAutoFight("raid", function()
            local args = {raidBossId}
            ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("fightRaidBoss"):FireServer(unpack(args))
            
            -- Auto-collect rewards after fight
            collectRewards()
        end, "raid")
    else
        stopAutoFight("raid")
    end
end)

-- Auto Fight Raid Minions Toggle (Creator of Flames)
raidTab:Toggle('👹 Auto Fight Raid Minions', false, function(state)
    autoFightStates["minions"] = state
    print("Auto Minion Fight:", state and "ON" or "OFF")
    
    if state then
        startAutoFight("minions", function()
            if workspace:FindFirstChild("raid_creator_of_flames") then
                for _, model in pairs(workspace.raid_creator_of_flames:GetChildren()) do
                    if model.Name:find("infernal") and model:GetAttribute("serverEntityId") then
                        local minionId = model:GetAttribute("serverEntityId")
                        local args = {minionId}
                        ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("fightRaidMinion"):FireServer(unpack(args))
                        break -- Only fight one minion per cycle
                    end
                end
            end
            
            -- Auto-collect rewards after minion fights
            collectRewards()
        end, "raid")
    else
        stopAutoFight("minions")
    end
end)

-- Raid Status Display
raidTab:Label("📊 Raid Status: Idle")
local raidStatusLabel = raidTab:Label("Boss Fights: 0/0 | Minion Fights: 0/0")

-- Popular Raid Bosses
raidTab:Label("📋 Available Raid Bosses:")

raidTab:Button('🐉 Eternal Dragon (373)', function()
    raidBossId = 373
    print("Selected: Eternal Dragon (373)")
end)

raidTab:Button('🌑 Shadow Dragon (370)', function()
    raidBossId = 370
    print("Selected: Shadow Dragon (370)")
end)

raidTab:Button('⚔️ Sword Deity (325)', function()
    raidBossId = 325
    print("Selected: Sword Deity (325)")
end)

raidTab:Button('🔥 Creator of Flames (384)', function()
    raidBossId = 384
    print("Selected: Creator of Flames (384)")
end)

-- ==================== TOWERS TAB ====================
towerTab:Label("🗼 Towers Auto-Fighting")

-- Infinite Tower Variables
local towerMode = "base"
local battleTowerIndex = 30

-- Infinite Tower Mode Dropdown
towerTab:Dropdown("Infinite Tower Mode", {"base", "nightmare", "potion"}, function(selected)
    towerMode = selected
    print("Tower Mode set to:", towerMode)
end)

-- Auto Fight Infinite Tower Toggle
towerTab:Toggle('🗼 Auto Fight Infinite Tower', false, function(state)
    autoFightStates["infinite"] = state
    print("Auto Infinite Tower:", state and "ON" or "OFF")
    
    if state then
        startAutoFight("infinite", function()
            local args = {towerMode}
            ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("fightInfinite"):FireServer(unpack(args))
            collectRewards()
        end, "tower")
    else
        stopAutoFight("infinite")
    end
end)

-- Story Infinite Tower Mode Dropdown
local storyInfiniteMode = "ninja_village"
towerTab:Dropdown("Story Infinite Mode", {
    "ninja_village", "green_planet", "shibuya_station", "titans_city", 
    "dimensional_fortress", "candy_island", "solo_city", "eminence_lookout",
    "invaded_ninja_village", "necromancer_graveyard"
}, function(selected)
    storyInfiniteMode = selected
    print("Story Infinite Mode set to:", storyInfiniteMode)
end)

-- Auto Fight Story Infinite Toggle
towerTab:Toggle('📖 Auto Fight Story Infinite', false, function(state)
    autoFightStates["story_infinite"] = state
    print("Auto Story Infinite:", state and "ON" or "OFF")
    
    if state then
        startAutoFight("story_infinite", function()
            local args = {storyInfiniteMode}
            ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("fightInfinite"):FireServer(unpack(args))
            collectRewards()
        end, "tower")
    else
        stopAutoFight("story_infinite")
    end
end)

-- Battle Tower Index Slider
towerTab:Slider("Battle Tower Index", 1, 50, 30, function(value)
    battleTowerIndex = value
    local minStage = (value - 1) * 5 + 1
    local maxStage = value * 5
    print("Battle Tower Index set to:", value, "(Stages " .. minStage .. "-" .. maxStage .. ")")
end)

-- Auto Fight Battle Tower Toggle
towerTab:Toggle('⚔️ Auto Fight Battle Tower', false, function(state)
    autoFightStates["battle"] = state
    print("Auto Battle Tower:", state and "ON" or "OFF")
    
    if state then
        startAutoFight("battle", function()
            local args = {battleTowerIndex}
            ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("fightTowerWave"):FireServer(unpack(args))
            collectRewards()
        end, "tower")
    else
        stopAutoFight("battle")
    end
end)

-- Tower Status Display
towerTab:Label("📊 Tower Status: Idle")
local towerStatusLabel = towerTab:Label("Infinite: 0/0 | Story: 0/0 | Battle: 0/0")

-- ==================== MISC TAB ====================
miscTab:Label("🗺️ Exploration & Miscellaneous")

-- Exploration Variables
local explorationLevel = "easy"

-- Exploration Level Dropdown
miscTab:Dropdown("Exploration Level", {"easy", "medium", "hard", "extreme", "nightmare", "celestial"}, function(selected)
    explorationLevel = selected
    print("Exploration Level set to:", explorationLevel)
end)

-- Claim Exploration Button
miscTab:Button('🎁 Claim Exploration Rewards', function()
    local args = {explorationLevel}
    ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("claimExploration"):FireServer(unpack(args))
    print("Claimed exploration rewards for:", explorationLevel)
end)

-- Auto Claim Exploration Toggle
miscTab:Toggle('🎁 Auto Claim Exploration', false, function(state)
    autoFightStates["exploration"] = state
    print("Auto Claim Exploration:", state and "ON" or "OFF")
    
    if state then
        startAutoFight("exploration", function()
            local args = {explorationLevel}
            ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("claimExploration"):FireServer(unpack(args))
            collectRewards()
        end, "exploration")
    else
        stopAutoFight("exploration")
    end
end)

-- Teleport Section
miscTab:Label("🚀 Quick Teleports:")

local teleportLocations = {
    "ninja_village", "green_planet", "shibuya_station", "titans_city",
    "dimensional_fortress", "candy_island", "solo_city", "eminence_lookout",
    "invaded_ninja_village", "necromancer_graveyard"
}

local selectedTeleport = "ninja_village"
miscTab:Dropdown("Teleport Location", teleportLocations, function(selected)
    selectedTeleport = selected
    print("Selected teleport location:", selectedTeleport)
end)

miscTab:Button('🚀 Teleport Now', function()
    local args = {selectedTeleport}
    ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("teleport"):FireServer(unpack(args))
    print("Teleported to:", selectedTeleport)
end)

-- Raid Teleports
miscTab:Label("⚔️ Raid Teleports:")

miscTab:Button('🐉 → Eternal Dragon', function()
    local args = {"raid_eternal_dragon"}
    ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("teleport"):FireServer(unpack(args))
end)

miscTab:Button('🌑 → Shadow Dragon', function()
    local args = {"raid_shadow_dragon"}
    ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("teleport"):FireServer(unpack(args))
end)

miscTab:Button('⚔️ → Sword Deity', function()
    local args = {"raid_sword_deity"}
    ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("teleport"):FireServer(unpack(args))
end)

miscTab:Button('🔥 → Creator of Flames', function()
    local args = {"raid_creator_of_flames"}
    ReplicatedStorage:WaitForChild("shared/network@eventDefinitions"):WaitForChild("teleport"):FireServer(unpack(args))
end)

-- Settings Section
miscTab:Label("⚚ Settings & Info:")

miscTab:Toggle('🔊 Enable Notifications', true, function(state)
    print("Notifications:", state and "ON" or "OFF")
    -- Add notification toggle logic here
end)

miscTab:Button('🛑 Stop All Auto-Fighting', function()
    stopAllAutoFights()
end)

miscTab:Button('🎁 Collect All Rewards Now', function()
    collectRewards()
    print("🎁 Attempted to collect all available rewards!")
end)

-- UI Toggle Keybind
miscTab:Keybind("Toggle UI", Enum.KeyCode.Insert, function(key)
    print("UI toggle key set to:", key.Name)
end)

-- ==================== SETTINGS TAB ====================
settingsTab:Label("⚙️ Advanced Settings & Statistics")

-- Fight Delay Settings
settingsTab:Slider("Fight Delay (Normal)", 1, 15, globalSettings.fightDelay, function(value)
    globalSettings.fightDelay = value
    print("Fight delay set to:", value, "seconds")
end)

settingsTab:Slider("Quick Fight Delay", 1, 10, globalSettings.quickFightDelay, function(value)
    globalSettings.quickFightDelay = value
    print("Quick fight delay set to:", value, "seconds")
end)

settingsTab:Slider("Max Retries", 1, 10, globalSettings.maxRetries, function(value)
    globalSettings.maxRetries = value
    print("Max retries set to:", value)
end)

-- Smart Settings Toggles
settingsTab:Toggle('🧠 Smart Intervals', globalSettings.smartIntervals, function(state)
    globalSettings.smartIntervals = state
    print("Smart Intervals:", state and "ON" or "OFF")
end)

settingsTab:Toggle('🔊 Enable Notifications', globalSettings.enableNotifications, function(state)
    globalSettings.enableNotifications = state
    print("Notifications:", state and "ON" or "OFF")
end)

settingsTab:Toggle('🎁 Auto Collect Rewards', globalSettings.autoCollectRewards, function(state)
    globalSettings.autoCollectRewards = state
    print("Auto Collect Rewards:", state and "ON" or "OFF")
end)

-- Statistics Display
settingsTab:Label("📊 Fight Statistics:")

local function updateStatisticsDisplay()
    local totalFights = 0
    local totalSuccesses = 0
    
    for fightType, stats in pairs(fightStatistics) do
        if stats.attempts > 0 then
            totalFights = totalFights + stats.attempts
            totalSuccesses = totalSuccesses + stats.successes
            local successRate = math.floor((stats.successes / stats.attempts) * 100)
            
            settingsTab:Label(string.format("• %s: %d/%d (%d%% success)", 
                fightType:upper(), stats.successes, stats.attempts, successRate))
        end
    end
    
    if totalFights > 0 then
        local overallRate = math.floor((totalSuccesses / totalFights) * 100)
        settingsTab:Label(string.format("🎯 Overall: %d/%d (%d%% success)", 
            totalSuccesses, totalFights, overallRate))
    end
end

settingsTab:Button('📊 Refresh Statistics', function()
    updateStatisticsDisplay()
end)

settingsTab:Button('🗑️ Clear Statistics', function()
    fightStatistics = {}
    print("🗑️ Fight statistics cleared!")
end)

-- Auto-Detection Status
settingsTab:Label("🔍 Detection Status:")

local detectionStatusLabel = settingsTab:Label("Battle Status: Idle")

-- Update detection status periodically
task.spawn(function()
    while true do
        if detectionStatusLabel then
            local battleStatus = isInBattle() and "🔥 IN BATTLE" or "💤 Idle"
            detectionStatusLabel:Update("Battle Status: " .. battleStatus)
        end
        task.wait(2)
    end
end)

-- Advanced Features
settingsTab:Label("🚀 Advanced Features:")

settingsTab:Button('⚡ Emergency Stop All', function()
    stopAllAutoFights()
    print("🚨 EMERGENCY STOP - All activities halted!")
end)

settingsTab:Button('🔄 Restart All Active Fights', function()
    local activeFights = {}
    for key, state in pairs(autoFightStates) do
        if state then
            activeFights[key] = true
            stopAutoFight(key)
        end
    end
    
    task.wait(2)
    
    for key, _ in pairs(activeFights) do
        autoFightStates[key] = true
        print("🔄 Restarting", key, "auto-fight...")
        -- Note: This would need the original fight functions to be properly restarted
        -- For now, just set the state back
    end
end)

-- Performance Monitoring
local startTime = tick()
settingsTab:Button('⏱️ Show Uptime', function()
    local uptime = tick() - startTime
    local hours = math.floor(uptime / 3600)
    local minutes = math.floor((uptime % 3600) / 60)
    local seconds = math.floor(uptime % 60)
    
    print(string.format("⏱️ Uptime: %dh %dm %ds", hours, minutes, seconds))
end)

-- Status Update System
local function updateAllStatusDisplays()
    -- Update Story Status
    if fightStatistics["story"] then
        local stats = fightStatistics["story"]
        local rate = stats.attempts > 0 and math.floor((stats.successes / stats.attempts) * 100) or 0
        if storyStatusLabel then
            storyStatusLabel:Update(string.format("Fights: %d/%d | Success Rate: %d%%", 
                stats.successes, stats.attempts, rate))
        end
    end
    
    -- Update Raid Status
    local raidStats = fightStatistics["raid"] or {attempts = 0, successes = 0}
    local minionStats = fightStatistics["minions"] or {attempts = 0, successes = 0}
    if raidStatusLabel then
        raidStatusLabel:Update(string.format("Boss Fights: %d/%d | Minion Fights: %d/%d", 
            raidStats.successes, raidStats.attempts, minionStats.successes, minionStats.attempts))
    end
    
    -- Update Tower Status
    local infiniteStats = fightStatistics["infinite"] or {attempts = 0, successes = 0}
    local storyInfiniteStats = fightStatistics["story_infinite"] or {attempts = 0, successes = 0}
    local battleStats = fightStatistics["battle"] or {attempts = 0, successes = 0}
    if towerStatusLabel then
        towerStatusLabel:Update(string.format("Infinite: %d/%d | Story: %d/%d | Battle: %d/%d", 
            infiniteStats.successes, infiniteStats.attempts,
            storyInfiniteStats.successes, storyInfiniteStats.attempts,
            battleStats.successes, battleStats.attempts))
    end
end

-- Update status displays every 5 seconds
task.spawn(function()
    while true do
        updateAllStatusDisplays()
        task.wait(5)
    end
end)

-- Auto-reward collection timer
if globalSettings.autoCollectRewards then
    task.spawn(function()
        while true do
            task.wait(300) -- Collect rewards every 5 minutes
            pcall(collectRewards)
        end
    end)
end

-- Welcome message
print("🎉 Cards Clash Auto Fight UI V2 Loaded!")
print("📋 Features: Story Mode, Raid Bosses, Infinite Towers, Battle Tower, Exploration")
print("⚡ Enhanced with smart intervals, battle detection, and auto-rewards")
print("🧠 New: Statistics tracking, retry logic, and advanced settings")
print("🎮 Use the Settings tab for advanced configuration")
print("🔄 Status displays update every 5 seconds automatically")
