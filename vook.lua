getgenv().SilentKeyy = 'c'
getgenv().PredictionAmmount = 0

--// Main Libarys \\--
local libary = loadstring(game:HttpGet("https://raw.githubusercontent.com/imagoodpersond/puppyware/main/lib"))()
local NotifyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/imagoodpersond/puppyware/main/notify"))()
local Notify = NotifyLibrary.Notify
--// Service Handler \\--
local GetService = setmetatable({}, {
    __index = function(self, key)
        return game:GetService(key)
    end
})
--// Services \\--
local RunService = GetService.RunService
local Players = GetService.Players
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = workspace.CurrentCamera
local UserInputService = GetService.UserInputService
local Unpack = table.unpack
local GuiInset = GetService.GuiService:GetGuiInset()
local Insert = table.insert
local Network = GetService.NetworkClient
local StarterGui = GetService.StarterGui
local tweenService = GetService.TweenService
local ReplicatedStorage = GetService.ReplicatedStorage
local http = GetService.HttpService
local lighting = GetService.Lighting
makefolder("VookV3")

--// Start \\--
local Settings = {
    SilentAim = {
        Enabled = false,
        UseFOV = false,
        ShowFOV = false,
        FOVColor = Color3.new(0.603921, 0.011764, 1),
		DOTColor = Color3.fromRGB(0, 71, 212),
        WallCheck = false,
        KnockedCheck = false,
		PingPred1 = false,
		PingPred2 = false,
        GrabbedCheck = false,
        ShowHitbox = false,
        NotificationMode = false,
        AirShotMode = false,
        UseNearestDistance = false,
		RandomHitbox = false,
        Hitboxes = "HumanoidRootPart",
		Selected = nil
    },
    SilentAimSettings = {
        MovementPrediction = false,
        MovementPredictionAmount = getgenv().PredictionAmmount,
        HitChance = false,
        HitChanceAmount = {
            HitPercent = 100,
            NotHitPercent = 0
        }
    },
	Aimbot = {
		Enabled = false,
		Prediction = false,
		Hitboxes = "HumanoidRootPart"
	},
    AimbotSettings = {
		Mode = "Camera",
		Smoothness = false,
		SmoothnessAmmount = 0.0334,
		PredictionVelocity = 10
    },
	AntiAim = {
		Enabled = false,
		Desync = false,
		Legit = false,
		FPSUnlocked = false,
		LegitAAKey = Enum.KeyCode.Z,
		DesyncValues = {
			Velocity = -100,
			CFrame = -100
		}
	},
	BackTracking = {
		Enabled = false
	},
	AutoPeak = {
		Enabled = false,
		APKey = Enum.KeyCode.N,

	},
	Misc = {
	CFrameSpeed = {
		Enabled = false,
		Bhop = false,
		Keybind = Enum.KeyCode.V,
		Speed = 1,
	},
	Strafe = false,
	Antislow = false,
	},

	Esp = {
		Enabled = false,
		Bones = false,

    },
    TargetGui = {
        Enabled = false
    },
    Whitelist = {
        Players = {},
        Friends = {},
        Holder = "",
        Enabled = false,
        CrewEnabled = false,
        FriendsWhitelist = false
    },
}
local Storage = {
    GetStrafeAngle = 0,
    BHoping = false,
    Side = "Right",
    StoredRange = 10,
    HeldSpace = false,
    GetPrediction = 0.165,
    Instance = {},
    Equipable = false,
    FPSBeat = 0,
    GetTime = 0,
    Macro = false
}
local Module = {
    Instance = {}
}

local Window = libary:new({name = "Vook Ware", accent = Color3.fromRGB(96, 28, 223), textsize = 13})
local AimingTab = Window:page({name = "Menu"})
local RageTab = Window:page({name = "Rage"})
local VisualTab = Window:page({name = "Visauls"})
local MiscTab = Window:page({name = "Misc"})

local SAimSection = AimingTab:section({name = "I dont knowt",size = 320})

local AAMainSection = RageTab:section({name = "Main", side = "left", size = 200})
local AASettings = RageTab:section({name = "Settings", side = "right", size = 200})

local VisualMainSection = VisualTab:section({name = "Main",side = "left", size = 200})

local MiscMoveSettings = MiscTab:section({name = "Movement Cheats",side = "left", size = 200})
local MiscToolSettings = MiscTab:section({name = "Tool Cheats",side = "left", size = 50})
local MiscCharSettings = MiscTab:section({name = "Character Cheats",side = "left", size = 50})
local MiscNorSettings = MiscTab:section({name = "Normal Cheats",side = "left", size = 100})

local ConfigSection = MiscTab:section({name = "Config",side = "right", size = 250})
local ConfigLoader = ConfigSection:configloader({folder = "vook"})

-- Aimbot Section --
local AimbotSection = AimingTab:section({name = "AimBot", side = "right",size = 113})
AimbotSection:toggle({name = "Aimbot", def = false, callback = function(Boolean)
    Settings.Aimbot.Enabled = Boolean
end})

AimbotSection:dropdown({name = "Aim Hitbox", def = "HumanoidRootPart", max = 4, options = {"Head","UpperTorso","HumanoidRootPart"}, callback = function(part)
    Settings.Aimbot.Hitboxes = part
end})

-- Aimbot Settings Section --

local AimbotSettings = AimingTab:section({name = "Aimbot Settings", side = "right",size = 150})

AimbotSettings:dropdown({name = "Aim Assist Type", def = "Camera", max = 4, options = {"Camera","Mouse",}, callback = function(part)
    Settings.AimbotSettings.Mode = part
end})

AimbotSettings:toggle({name = "Smoothness", def = false, callback = function(Boolean)
    Settings.AimbotSettings.Smoothness = Boolean
end})

AimbotSettings:slider({name = "Smoothness Ammount", def = 2, max = 10, min = 1, rounding = true, callback = function(Value)
    Settings.AimbotSettings.SmoothnessAmmount = Value
end})

AimbotSettings:slider({name = "Prediction Velocity", def = 10, max = 60, min = 10, rounding = true, callback = function(Value)
    Settings.AimbotSettings.PredictionVelocity = Value
end})

-- Anti Aim Section --

AAMainSection:toggle({name = "Anti Aim Enabled", def = false, callback = function(Boolean)
    Settings.AntiAim.Enabled = Boolean
end})

AAMainSection:toggle({name = "Desync AA Enabled", def = false, callback = function(Boolean)
    Settings.AntiAim.Desync = Boolean
end})

AAMainSection:toggle({name = "Legit AA Enabled", def = false, callback = function(Boolean)
    Settings.AntiAim.Legit = Boolean
end})

AAMainSection:toggle({name = "BackTracking", def = false, callback = function(Boolean)
    Settings.BackTracking.Enabled = Boolean
end})


AASettings:slider({name = "Desync Velocity", def = 500, max = 1000, min = 0, rounding = true, callback = function(Value)
	Settings.AntiAim.DesyncValues.Velocity = tonumber(Value)
end})

AASettings:slider({name = "Desync CFrame", def = 500, max = 1000, min = 0, rounding = true, callback = function(Value)
	Settings.AntiAim.DesyncValues.CFrame = tonumber(Value)
end})

AASettings:keybind({name = "Legit AA Keybind", def = Enum.KeyCode.Z, callback = function(Key)
	Settings.AntiAim.LegitAAKey = Key
end})

--// Visual Sections
VisualMainSection:toggle({name = "ESP", def = false, callback = function(Boolean)
	Settings.Esp.Enabled = Boolean
end})

--// Misc Sections
local TimeTick
TimeTick = hookfunction(wait, function(JumpCooldown)
	if JumpCooldown == 1.5 and (Settings.Misc.CFrameSpeed.Bhop and Settings.Misc.CFrameSpeed.Enabled) or Settings.Misc.Strafe then 
		return TimeTick()
    end
    return TimeTick(JumpCooldown)
end)

MiscMoveSettings:toggle({name = "CFrame Speed", def = false, callback = function(Boolean)
	Settings.Misc.CFrameSpeed.Enabled = Boolean
end})

MiscMoveSettings:toggle({name = "Bhop", def = false, callback = function(Boolean)
	ySettings.Misc.CFrameSpeed.Bhop = Boolean
end})

MiscMoveSettings:keybind({name = "CFrame Keybind", def = Enum.KeyCode.V, callback = function(Key)
	Settings.Misc.CFrameSpeed.Keybind = Key
end})

MiscMoveSettings:slider({name = "CFrame Value", def = 100, max = 1000, min = 0, rounding = true, callback = function(Value)
	Settings.Misc.CFrameSpeed.Speed = tonumber(Value)/100
end})

MiscMoveSettings:toggle({name = "Strafe Jump", def = false, callback = function(Boolean)
	Settings.Misc.Strafe = Boolean
end})

MiscMoveSettings:button({name = "Fly", callback = function()
	local mouse = game.Players.LocalPlayer:GetMouse()
	localplayer = game.Players.LocalPlayer
	if workspace:FindFirstChild("Core") then
		workspace.Core:Destroy()
	end
	local Core = Instance.new("Part")
	Core.Name = "Core"
	Core.Size = Vector3.new(0.05, 0.05, 0.05)
	spawn(function()
		Core.Parent = workspace
		local Weld = Instance.new("Weld", Core)
		Weld.Part0 = Core
		Weld.Part1 = localplayer.Character.LowerTorso
		Weld.C0 = CFrame.new(0, 0, 0)
	end)
	workspace:WaitForChild("Core")
	local torso = workspace.Core
	flying = true
	local speed=10
	local keys={a=false,d=false,w=false,s=false}
	local e1
	local e2
	local function start()
	local pos = Instance.new("BodyPosition",torso)
	local gyro = Instance.new("BodyGyro",torso)
	pos.Name="EPIXPOS"
	pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	pos.position = torso.Position
	gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
	gyro.cframe = torso.CFrame
	repeat wait() localplayer.Character.Humanoid.PlatformStand = true
		local new=gyro.cframe - gyro.cframe.p + pos.position
		if not keys.w and not keys.s and not keys.a and not keys.d then
			speed=5
		end
		if keys.w then
			new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
			speed=speed+0
		end
		if keys.s then
			new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
			speed=speed+0
		end
		if keys.d then
			new = new * CFrame.new(speed,0,0)
			speed=speed+0
		end
		if keys.a then
			new = new * CFrame.new(-speed,0,0)
			speed=speed+0
		end
		if speed>10 then
			speed=5
		end
		pos.position=new.p
		if keys.w then
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
		elseif keys.s then
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
		else
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame
		end
	until flying == false
	if gyro then gyro:Destroy() end
	if pos then pos:Destroy() end
	flying=false
	localplayer.Character.Humanoid.PlatformStand=false
	speed=10
	end
	e1=mouse.KeyDown:connect(function(key)
		if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
		if key=="w" then
			keys.w=true
		elseif key=="s" then
			keys.s=true
		elseif key=="a" then
			keys.a=true
		elseif key=="d" then
			keys.d=true
		elseif key=="x" then
			if flying==true then
				flying=false
			else
				flying=true
				start()
			end
		end
	end)
	e2=mouse.KeyUp:connect(function(key)
		if key=="w" then
			keys.w=false
		elseif key=="s" then
			keys.s=false
		elseif key=="a" then
			keys.a=false
		elseif key=="d" then
			keys.d=false
		end
	end)
	start()
end})

MiscMoveSettings:toggle({name = "Antislow", def = false, callback = function(Boolean)
	Settings.Misc.Antislow = Boolean 
end})

-- MiscToolSettings
MiscToolSettings:button({name = "ForceField Gun (hold gun)", callback = function()
	Game.GetService(game, "Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Default.Material = Enum.Material.ForceField
end})

-- Misc Char
MiscCharSettings:button({name = "Nil Char", callback = function()
	NilBody()
end})

AimingTab:openpage()

-- Init --

--// Lock Normal
getgenv().AimlockKey = "c"
getgenv().AimRadius = 30 
getgenv().ThirdPerson = true 
getgenv().FirstPerson = true
getgenv().PredictionVelocity = 11

local Players, Uis, RService, SGui = game:GetService"Players", game:GetService"UserInputService", game:GetService"RunService", game:GetService"StarterGui";
local Client, Mouse, Camera, CF, RNew, Vec3, Vec2 = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Ray.new, Vector3.new, Vector2.new;
local MousePressed, CanNotify = false, false;
local AimlockTarget;
local OldPre;

getgenv().GetNearestTarget = function()
    local players = {}
    local PLAYER_HOLD  = {}
    local DISTANCES = {}
    for i, v in pairs(Players:GetPlayers()) do
        if v ~= Client then
            table.insert(players, v)
        end
    end
    for i, v in pairs(players) do
        if v.Character ~= nil then
            local AIM = v.Character:FindFirstChild("Head")
                local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                local DIFF = math.floor((POS - AIM.Position).magnitude)
                PLAYER_HOLD[v.Name .. i] = {}
                PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                PLAYER_HOLD[v.Name .. i].plr = v
                PLAYER_HOLD[v.Name .. i].diff = DIFF
                table.insert(DISTANCES, DIFF)
        end
    end
    
    if unpack(DISTANCES) == nil then
        return nil
    end
    
    local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
    if L_DISTANCE > getgenv().AimRadius then
        return nil
    end
    
    for i, v in pairs(PLAYER_HOLD) do
        if v.diff == L_DISTANCE then
            return v.plr
        end
    end
    return nil
end

Mouse.KeyDown:Connect(function(a)
    if not (Uis:GetFocusedTextBox()) then 
        if a == AimlockKey and AimlockTarget == nil then
            pcall(function()
                if MousePressed ~= true then MousePressed = true end 
                local Target;Target = GetNearestTarget()
                if Target ~= nil then 
                    AimlockTarget = Target
                end
            end)
        elseif a == AimlockKey and AimlockTarget ~= nil then
            if AimlockTarget ~= nil then AimlockTarget = nil end
            if MousePressed ~= false then 
                MousePressed = false 
            end
        end
    end
end)

RService.RenderStepped:Connect(function()
	if Settings.Aimbot.Enabled then
    if getgenv().ThirdPerson == true and getgenv().FirstPerson == true then 
        if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 or (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
            CanNotify = true 
        else 
            CanNotify = false 
        end
    elseif getgenv().ThirdPerson == true and getgenv().FirstPerson == false then 
        if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then 
            CanNotify = true 
        else 
            CanNotify = false 
        end
    elseif getgenv().ThirdPerson == false and getgenv().FirstPerson == true then 
        if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
            CanNotify = true 
        else 
            CanNotify = false 
        end
    end
    if Settings.Aimbot.Enabled == true and MousePressed == true then 
        if AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(Settings.Aimbot.Hitboxes) then 
            if getgenv().FirstPerson == true then
                if CanNotify == true then
                    if Settings.Aimbot.Prediction == true then
                        if Settings.AimbotSettings.Smoothness == true then
                            --// The part we're going to lerp/smoothen \\--
                            local Main = CF(Camera.CFrame.p, AimlockTarget.Character[Settings.Aimbot.Hitboxes].Position + AimlockTarget.Character[Settings.Aimbot.Hitboxes].Velocity/Settings.AimbotSettings.PredictionVelocity)
                            
                            --// Making it work \\--
                            Camera.CFrame = Camera.CFrame:Lerp(Main, Settings.AimbotSettings.SmoothnessAmmount, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
                        else
                            Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[Settings.Aimbot.Hitboxes].Position + AimlockTarget.Character[Settings.Aimbot.Hitboxes].Velocity/Settings.AimbotSettings.PredictionVelocity)
                        end
                    elseif Settings.Aimbot.Prediction == false then 
                        if Settings.AimbotSettings.Smoothness == true then
                            local Main = CF(Camera.CFrame.p, AimlockTarget.Character[Settings.Aimbot.Hitboxes].Position)
                            Camera.CFrame = Camera.CFrame:Lerp(Main,  Settings.AimbotSettings.SmoothnessAmmount, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
                        else
                            Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[Settings.Aimbot.Hitboxes].Position)
                        end
                    end
                end
            end
        end
    end
end	
end)

function NoSpace(Data)
    return Data:gsub("%s+", "") or Data
end

--// Auto Peak
local APEF = Instance.new("Folder")
APEF.Parent = game.Workspace
APEF.Name = "APEF"
getgenv().oldc = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
getgenv().APE = false
game:service('UserInputService').InputBegan:connect(function(Key, IsChat)
	if IsChat then return end
	if Key.KeyCode == Settings.AutoPeak.APKey and Settings.AutoPeak.Enabled == true then
		if getgenv().APE == false then
			getgenv().APE = true
			local APEPart = Instance.new("Part")
			APEPart.Parent = APEF
			APEPart.Name = "backTP"
			APEPart.Anchored = true
			APEPart.CanCollide = false
			APEPart.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
			APEPart.Orientation = game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation
			APEPart.Size = Vector3.new(1, 1, 1)
			APEPart.Transparency = 0.7
			APEPart.BrickColor = BrickColor.new("Institutional white")
			APEPart.Material = "SmoothPlastic"
			getgenv().oldc = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		elseif getgenv().APE == true then
			getgenv().APE = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getgenv().oldc
			game.Workspace.APEF.backTP:Destroy()
		end
	end
end)

--// Esp Bones

--// BackTrack
local BTF = Instance.new("Folder")
BTF.Parent = game.Workspace
BTF.Name = "BTF"

--//SFOV
local SilentAimFOV = Drawing.new("Circle")
SilentAimFOV.Thickness = 2

--// Legit AA
getgenv().LegitAA = false
getgenv().CFSpeed = false

game:service('UserInputService').InputBegan:connect(function(Key, IsChat)
	if IsChat then return end
	if Key.KeyCode == Settings.AntiAim.LegitAAKey and Settings.AntiAim.Legit == true and Settings.AntiAim.Enabled == true then
		getgenv().LegitAA = not getgenv().LegitAA
	end
end)

game:service('UserInputService').InputBegan:connect(function(Key, IsChat)
	if IsChat then return end
	if Key.KeyCode == Settings.Misc.CFrameSpeed.Keybind and Settings.Misc.CFrameSpeed.Enabled == true then
		getgenv().CFSpeed = not getgenv().CFSpeed
	end
end)
    
function Find(Data)
   getgenv().Target = nil
    for i, v in next, Players:GetPlayers() do
        if v.Name ~= LocalPlayer.Name and v.Name:lower():match('^'.. NoSpace(Data):lower()) then
            getgenv().Target = v.Name
        end
    end
    
    return getgenv().Target
end

function IsNetwork(GetPlayer)
	return GetPlayer and GetPlayer.Character and GetPlayer.Character:FindFirstChild("HumanoidRootPart") ~= nil and GetPlayer.Character:FindFirstChild("Humanoid") ~= nil and GetPlayer.Character:FindFirstChild("Head") ~= nil and true or false
end

function Knocked(GetPlayer)
    if IsNetwork(GetPlayer) then
        return GetPlayer.Character.BodyEffects["K.O"].Value and true or false
    end
    return false
end

function Grabbing(GetPlayer)
    if IsNetwork(GetPlayer) then
        return GetPlayer.Character:FindFirstChild("GRABBING_CONSTRAINT") and true or false
    end
    return false
end

function Alive(Player)
    if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil and Player.Character:FindFirstChild("Humanoid") ~= nil and Player.Character:FindFirstChild("Head") ~= nil then
        return true
    end
    return false
end

function CameraCheck(GetPosition, IgnoredList)
    if IsNetwork(LocalPlayer) then
        return #CurrentCamera:GetPartsObscuringTarget({LocalPlayer.Character.Head.Position, GetPosition}, IgnoredList) == 0 and true or false
    end
end

function WallCheck(OriginPart, Part)
    if IsNetwork(LocalPlayer) then
        local IgnoreList = {CurrentCamera, LocalPlayer.Character, OriginPart.Parent}
        local Parts = CurrentCamera:GetPartsObscuringTarget(
            {
                OriginPart.Position, 
                Part.Position
            },
            IgnoreList
        )
    
        for i, v in pairs(Parts) do
            if v.Transparency >= 0.3 then
                Storage.Instance[#Storage.Instance + 1] = v
            end
    
            if v.Material == Enum.Material.Glass then
                Storage.Instance[#Storage.Instance + 1] = v
            end
        end
    
        return #Parts == 0
    end
    return true
end

function NilBody()
    if Alive(LocalPlayer) then
        for i, v in pairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") or v:IsA("Part") or v:IsA("MeshPart") then
                if v.Name ~= "HumanoidRootPart" then
                    v:Destroy()
                end
            end
        end
    end
end

function NearestDistance()
    local Target = nil
    local Distance = math.huge
    for i, v in next, Players:GetPlayers() do
        if v ~= LocalPlayer and Alive(LocalPlayer) and Alive(v) then
            local DistanceFromPlayer = (v.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if Distance > DistanceFromPlayer then
                if (not Settings.Whitelist.FriendsWhitelist or not table.find(Settings.Whitelist.Friends, v.Name)) and (not Settings.Whitelist.CrewEnabled or v:FindFirstChild("DataFolder") and v.DataFolder.Information:FindFirstChild("Crew") and not tonumber(v.DataFolder.Information.Crew.Value) == tonumber(LocalPlayer.DataFolder.Information.Crew.Value)) and (not Settings.Whitelist.Enabled or not table.find(Settings.Whitelist.Players, v.Name)) and (not Settings.SilentAim.WallCheck or WallCheck(v.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                    Target = v
                    Distance = DistanceFromPlayer
                end
            end
        end
    end

    return Target, Distance
end

function NearestMouse()
    local Target = nil
    local Distance = math.huge
    for i, v in next, Players:GetPlayers() do
        if v ~= LocalPlayer and Alive(LocalPlayer) and Alive(v) then
            local RootPosition, RootVisible = CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            local DistanceFromMouse = (Vector2.new(RootPosition.X, RootPosition.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if RootVisible and Distance > DistanceFromMouse then
                if (not Settings.Whitelist.FriendsWhitelist or not table.find(Settings.Whitelist.Friends, v.Name)) and (not Settings.Whitelist.CrewEnabled or v:FindFirstChild("DataFolder") and v.DataFolder.Information:FindFirstChild("Crew") and not tonumber(v.DataFolder.Information.Crew.Value) == tonumber(LocalPlayer.DataFolder.Information.Crew.Value)) and (not Settings.Whitelist.Enabled or not table.find(Settings.Whitelist.Players, v.Name)) and (not Settings.SilentAim.WallCheck or WallCheck(v.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                    Target = v
                    Distance = DistanceFromMouse
                end
            end
        end
    end

    return Target, Distance
end

function NearestType(Type)
    if Type == "Distance" then
        return NearestDistance()
    elseif Type == "Mouse" then
        return NearestMouse()
    end
end

function ChanceTable(Table)
    local Chance = 0
    for i, v in pairs(Table) do
        Chance = Chance + v
    end
    Chance = math.random(0, Chance)
    for i, v in pairs(Table) do
        Chance = Chance - v
        if Chance <= 0 then
            return i
        end
    end	
end

function RandomTable(Table)
    local Values = 0
    for i, v in pairs(Table) do
        Values = i
    end
    
    return Table[math.random(1, Values)]
end

local Plr
local Pos
local enabled = false
local placemarker = Instance.new("Part", game.Workspace)

function makemarker(Parent, Adornee, Color, Size, Size2)
    local e = Instance.new("BillboardGui", Parent)
    e.Name = "PP"
    e.Adornee = Adornee
    e.Size = UDim2.new(Size, Size2, Size, Size2)
    e.AlwaysOnTop = true
    local a = Instance.new("Frame", e)
    a.Size = UDim2.new(1, 0, 1, 0)
    a.Transparency = 0
    a.BackgroundTransparency = 0
    a.BackgroundColor3 = Color
    local g = Instance.new("UICorner", a)
    g.CornerRadius = UDim.new(50, 50)
    return(e)
end

spawn(function()
    placemarker.Anchored = true
    placemarker.CanCollide = false
    placemarker.Size = Vector3.new(8, 8, 8)
    placemarker.Transparency = 0.79
    makemarker(placemarker, placemarker, Settings.SilentAim.DOTColor, 0.40, 0)
end)    

getgenv().islocked = false
Mouse.KeyDown:connect(function(key)
    if key:lower() == getgenv().SilentKeyy then 
        if getgenv().islocked == false and Settings.SilentAim.Enabled and Settings.SilentAim.UseFOV == false then
            if enabled == true then
            else
                enabled = true
            end
            getgenv().islocked = true
            if Settings.SilentAim.UseNearestDistance then
				local NearestTarget, NearestPos = NearestDistance()
				if NearestTarget and (not Settings.SilentAim.UseFOV or Settings.FOV.SilentAimSize > NearestPos) and (not Settings.SilentAim.KnockedCheck or not Knocked(NearestTarget)) and (not Settings.SilentAim.grabbedCheck or not Grabbed(NearestTarget)) and (not Settings.SilentAim.WallCheck or WallCheck(NearestTarget.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                Plr = NearestDistance()
                Pos = NearestPos
				end
            else
				local NearestTarget, NearestPos = NearestMouse()
				if NearestTarget and (not Settings.SilentAim.UseFOV or Settings.FOV.SilentAimSize > NearestPos) and (not Settings.SilentAim.KnockedCheck or not Knocked(NearestTarget)) and (not Settings.SilentAim.grabbedCheck or not Grabbed(NearestTarget)) and (not Settings.SilentAim.WallCheck or WallCheck(NearestTarget.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                Plr = NearestMouse()
                Pos = NearestPos
				end
            end
            if Settings.SilentAim.NotificationMode and Plr ~= game.Players.LocalPlayer then
                Notify({
                    Title = "VookV2",
                    Description = "Locked Onto: "..Plr.DisplayName,
                    Duration = 3
                })
            end
        elseif getgenv().islocked == true and Settings.SilentAim.Enabled then
            getgenv().islocked = false
            enabled = false
			Plr = game.Players.LocalPlayer
            if Settings.SilentAim.NotificationMode then
                Notify({
                    Title = "VookV2",
                    Description = "Unlocked",
                    Duration = 3
                })
            end
        end
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
	if Settings.AntiAim.Enabled == true and Settings.AntiAim.Desync == true then
		game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * Settings.AntiAim.DesyncValues.Velocity
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(Settings.AntiAim.DesyncValues.CFrame), 0)
	end -- Anti Aim Desync
	if Settings.Misc.Antislow then
	    getgenv().DeletePart = game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild('NoJumping') or player.Character.BodyEffects.Movement:FindFirstChild('ReduceWalk') or player.Character.BodyEffects.Movement:FindFirstChild('NoWalkSpeed')
		if getgenv().DeletePart then getgenv().DeletePart:Destroy() end
		if game.Players.LocalPlayer.Character.BodyEffects.Reload.Value == true then game.Players.LocalPlayer.Character.BodyEffects.Reload.Value = false end
	end -- Anti Slow
	if Settings.Misc.CFrameSpeed.Bhop and LocalPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
		LocalPlayer.Character.Humanoid:ChangeState("Jumping")
	end -- Bhop
	if Settings.Misc.Strafe then
		if LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 and LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
			LocalPlayer.Character:TranslateBy(LocalPlayer.Character.Humanoid.MoveDirection / 3.1)
		end
	end -- Strafe
	if Settings.SilentAimSettings.PingPred1 and Settings.SilentAim.Enabled then
		getgenv().ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
		getgenv().Value = tostring(getgenv().ping)
		getgenv().pingValue = getgenv().Value:split(" ")
		local PingNumber = getgenv().pingValue[1]
		getgenv().PredictionAmmount = PingNumber / 1000 + getgenv().Prediction
		print(getgenv().PredictionAmmount)
	end -- Ping Prediction 1
	if Settings.SilentAimSettings.PingPred2 and not Settings.SilentAimSettings.PingPred1 and Settings.SilentAim.Enabled then
		pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
		split = string.split(pingvalue,'(')
		ping = tonumber(split[1])
	   if ping < 130 then
		   PredictionValue = 0.151
	   elseif ping < 125 then
		   PredictionValue = 0.149
	   elseif ping < 110 then
		   PredictionValue = 0.146
	   elseif ping < 105 then
		   PredictionValue = 0.138
	   elseif ping < 90 then
		   PredictionValue = 0.136
	   elseif ping < 80 then
		   PredictionValue = 0.134
	   elseif ping < 70 then
		   PredictionValue = 0.131
	   elseif ping < 60 then
		   PredictionValue = 0.1229
	   elseif ping < 50 then
		   PredictionValue = 0.1225
	   elseif ping < 40 then
		   PredictionValue = 0.1256
	   end
	end -- Ping Prediction 2
	if Settings.SilentAim.ShowFOV then
		SilentAimFOV.Visible = true
        SilentAimFOV.Radius = Settings.FOV.SilentAimSize
        SilentAimFOV.Filled = Settings.FOV.FOVFilled
        SilentAimFOV.Transparency = Settings.FOV.Transparency
        SilentAimFOV.NumSides = 100
        SilentAimFOV.Thickness = Settings.FOV.Thickness
        SilentAimFOV.Color = Settings.SilentAim.FOVColor
        SilentAimFOV.Position = Vector2.new(Mouse.X, Mouse.Y + GuiInset.Y)
    else
        SilentAimFOV.Visible = false
    end

    if Settings.SilentAim.UseFOV == true and Settings.SilentAim.Enabled then
        wait()
        enabled = true
        if Settings.SilentAim.UseNearestDistance then
            local NearestTarget, NearestPos = NearestDistance()
            if NearestTarget and (not Settings.SilentAim.UseFOV or Settings.FOV.SilentAimSize > NearestPos) and (not Settings.SilentAim.KnockedCheck or not Knocked(NearestTarget)) and (not Settings.SilentAim.grabbedCheck or not Grabbed(NearestTarget)) and (not Settings.SilentAim.WallCheck or WallCheck(NearestTarget.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                Plr = NearestDistance()
                Pos = NearestPos
            end
        else
            local NearestTarget, NearestPos = NearestMouse()
            if NearestTarget and (not Settings.SilentAim.UseFOV or Settings.FOV.SilentAimSize > NearestPos) and (not Settings.SilentAim.KnockedCheck or not Knocked(NearestTarget)) and (not Settings.SilentAim.grabbedCheck or not Grabbed(NearestTarget)) and (not Settings.SilentAim.WallCheck or WallCheck(NearestTarget.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                Plr = NearestMouse()
                Pos = NearestPos
            end
        end
    end -- use fov 
    if Settings.SilentAim.Enabled and enabled and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") and Plr ~= game.Players.LocalPlayer and Settings.SilentAim.ShowHitbox then
        if Settings.SilentAim.RandomHitbox then
            placemarker.CFrame = CFrame.new(Plr.Character[RandomTable(Hitboxes)].Position + (Plr.Character[RandomTable(Hitboxes)].Velocity * Settings.SilentAimSettings.MovementPredictionAmount))
		else
            placemarker.CFrame = CFrame.new(Plr.Character[Settings.SilentAim.Hitboxes].Position + (Plr.Character[Settings.SilentAim.Hitboxes].Velocity * Settings.SilentAimSettings.MovementPredictionAmount))
		end
    else
        placemarker.CFrame = CFrame.new(0, 9999, 0)
    end -- hitbox / dot
    if getgenv().LegitAA then
        if Settings.AntiAim.FPSUnlocked == true then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * -0.3
        else
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * -0.5
        end
    end -- legit aa
    if getgenv().CFSpeed then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * Settings.Misc.CFrameSpeed.Speed
    end -- cfspeed
    if getgenv().Clicking then
        mouse1click() 
        wait(0.001)
    end -- auto clciker
end)

if game.PlaceId == 5602055394 then -- da hood modded
	local mt = getrawmetatable(game)
	local old = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(...) --// LPH JIT
		local args = {...}
		if Settings.SilentAim.Enabled and ChanceTable(Settings.SilentAimSettings.HitChanceAmount) == "HitPercent" and enabled and Plr ~= game.Players.LocalPlayer and (not Settings.SilentAim.UseFOV or Settings.FOV.SilentAimSize > Pos) and getnamecallmethod() == "FireServer" and args[2] == "MousePos" then
			if Settings.SilentAim.RandomHitbox then
				args[3] = Plr.Character[RandomTable(Hitboxes)].Position + (Plr.Character[RandomTable(Hitboxes)].Velocity * Settings.SilentAimSettings.MovementPredictionAmount)
			else
				args[3] = Plr.Character[Settings.SilentAim.Hitboxes].Position + (Plr.Character[Settings.SilentAim.Hitboxes].Velocity * Settings.SilentAimSettings.MovementPredictionAmount)
			end
			return old(unpack(args))
		end
		return old(...)
	end)
else -- da hood
	local mt = getrawmetatable(game)
	local old = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(...) --// LPH JIT
		local args = {...}
		if Settings.SilentAim.Enabled and ChanceTable(Settings.SilentAimSettings.HitChanceAmount) == "HitPercent" and enabled and Plr ~= game.Players.LocalPlayer and (not Settings.SilentAim.UseFOV or Settings.FOV.SilentAimSize > Pos) and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
			if Settings.SilentAim.RandomHitbox then
				args[3] = Plr.Character[RandomTable(Hitboxes)].Position + (Plr.Character[RandomTable(Hitboxes)].Velocity * Settings.SilentAimSettings.MovementPredictionAmount)
			else
				args[3] = Plr.Character[Settings.SilentAim.Hitboxes].Position + (Plr.Character[Settings.SilentAim.Hitboxes].Velocity * Settings.SilentAimSettings.MovementPredictionAmount)
			end
			return old(unpack(args))
		end
		return old(...)
	end)
end

--// Anti
game.Players.LocalPlayer.Character:WaitForChild("FULLY_LOADED_CHAR")
local gm = getrawmetatable(game)
setreadonly(gm, false)
local namecall = gm.__namecall
gm.__namecall = newcclosure( function(self, ...)
	local args = {...}
	if not checkcaller() and getnamecallmethod() == "FireServer" and tostring(self) == "MainEvent" then
		if tostring(getcallingscript()) ~= "Framework" then
			return
        end
    end
    if not checkcaller() and getnamecallmethod() == "Kick" then
		return
    end
	return namecall(self, unpack(args))
end)
