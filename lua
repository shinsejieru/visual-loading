-- ╔══════════════════════════════════════════════╗
-- ║         Unique SCRIPTS LOADER v3           ║
-- ║      Made with ❤️   |  Educational Use Only  ║
-- ╚══════════════════════════════════════════════╝

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  CONFIG
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local SCRIPT_NAME   = "Unique Scripts"
local CREATOR_TAG   = "@AnimeAdventures"
local ASSET_ID      = "rbxassetid://111416518795310"
local LOAD_DURATION = 150   -- exactly 2 minutes 30 seconds
local POPUP_HOLD    = math.random(15, 20)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  HELPERS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local function tw(obj, t, props, style, dir)
    TweenService:Create(obj, TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props):Play()
end
local function mkCorner(p, r) local c=Instance.new("UICorner") c.CornerRadius=r or UDim.new(0,12) c.Parent=p return c end
local function mkStroke(p, col, th) local s=Instance.new("UIStroke") s.Color=col s.Thickness=th or 1.5 s.Parent=p return s end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  SCREEN GUI
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local Gui = Instance.new("ScreenGui")
Gui.Name           = "UniqueLoader"
Gui.ResetOnSpawn   = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.IgnoreGuiInset = true
Gui.Parent         = PlayerGui

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  POPUP  (redesigned — slides from top)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local PW, PH = 342, 76
local Popup = Instance.new("Frame")
Popup.Size             = UDim2.new(0, PW, 0, PH)
Popup.Position         = UDim2.new(0.5, -PW/2, 0, -PH-10)
Popup.BackgroundColor3 = Color3.fromRGB(11, 9, 22)
Popup.BorderSizePixel  = 0
Popup.ZIndex           = 20
Popup.Parent           = Gui
mkCorner(Popup, UDim.new(0, 16))

local PopGrad = Instance.new("UIGradient")
PopGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(28, 16, 58)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(10, 8,  22)),
})
PopGrad.Rotation = 130
PopGrad.Parent = Popup

-- Gold left accent bar
local PAcc = Instance.new("Frame")
PAcc.Size             = UDim2.new(0, 4, 1, -18)
PAcc.Position         = UDim2.new(0, 9, 0, 9)
PAcc.BackgroundColor3 = Color3.fromRGB(255, 192, 0)
PAcc.BorderSizePixel  = 0
PAcc.ZIndex           = 21
PAcc.Parent           = Popup
mkCorner(PAcc, UDim.new(1, 0))

local PAccGrad = Instance.new("UIGradient")
PAccGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 220, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 140, 0)),
})
PAccGrad.Rotation = 90
PAccGrad.Parent = PAcc

local pStroke = mkStroke(Popup, Color3.fromRGB(255, 192, 0), 1.5)

-- Warning icon
local PIco = Instance.new("TextLabel")
PIco.Size              = UDim2.new(0, 26, 0, 26)
PIco.Position          = UDim2.new(0, 20, 0.5, -13)
PIco.BackgroundTransparency = 1
PIco.Text              = "⚠"
PIco.TextScaled        = true
PIco.Font              = Enum.Font.GothamBold
PIco.TextColor3        = Color3.fromRGB(255, 210, 0)
PIco.ZIndex            = 22
PIco.Parent            = Popup

-- Title
local PTit = Instance.new("TextLabel")
PTit.Size              = UDim2.new(1, -74, 0, 22)
PTit.Position          = UDim2.new(0, 54, 0, 11)
PTit.BackgroundTransparency = 1
PTit.Text              = "Unique Scripts — Loading"
PTit.TextScaled        = true
PTit.Font              = Enum.Font.GothamBold
PTit.TextColor3        = Color3.fromRGB(255, 255, 255)
PTit.TextXAlignment    = Enum.TextXAlignment.Left
PTit.ZIndex            = 22
PTit.Parent            = Popup

-- Sub
local PSub = Instance.new("TextLabel")
PSub.Size              = UDim2.new(1, -74, 0, 16)
PSub.Position          = UDim2.new(0, 54, 0, 36)
PSub.BackgroundTransparency = 1
PSub.Text              = "⏳  Please wait 2 min 30 sec for the script to load."
PSub.TextScaled        = true
PSub.Font              = Enum.Font.GothamSemibold
PSub.TextColor3        = Color3.fromRGB(224, 198, 130)
PSub.TextXAlignment    = Enum.TextXAlignment.Left
PSub.ZIndex            = 22
PSub.Parent            = Popup



-- Slide in
tw(Popup, 0.65, {Position = UDim2.new(0.5, -PW/2, 0, 16)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- Auto-dismiss after POPUP_HOLD seconds
task.delay(POPUP_HOLD, function()
    if Popup and Popup.Parent then
        tw(Popup, 0.4, {Position = UDim2.new(0.5, -PW/2, 0, -PH-10)}, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.5)
        Popup:Destroy()
    end
end)

-- Gold stroke pulse
task.spawn(function()
    while Popup and Popup.Parent do
        tw(pStroke, 0.75, {Thickness = 2.6})
        task.wait(0.75)
        tw(pStroke, 0.75, {Thickness = 1.0})
        task.wait(0.75)
    end
end)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  CARD SHADOW
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local CW, CH = 312, 274
local Shadow = Instance.new("Frame")
Shadow.Size             = UDim2.new(0, CW+22, 0, CH+22)
Shadow.Position         = UDim2.new(0.5, -(CW+22)/2, 0.5, -(CH+22)/2)
Shadow.BackgroundColor3 = Color3.fromRGB(90, 35, 210)
Shadow.BackgroundTransparency = 0.87
Shadow.BorderSizePixel  = 0
Shadow.ZIndex           = 4
Shadow.Parent           = Gui
mkCorner(Shadow, UDim.new(0, 24))

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  MAIN CARD
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local Card = Instance.new("Frame")
Card.Size              = UDim2.new(0, CW, 0, CH)
Card.Position          = UDim2.new(0.5, -CW/2, 0.5, -CH/2)
Card.BackgroundColor3  = Color3.fromRGB(9, 8, 18)
Card.BackgroundTransparency = 1
Card.BorderSizePixel   = 0
Card.ZIndex            = 5
Card.Parent            = Gui
mkCorner(Card, UDim.new(0, 20))

local CardGrad = Instance.new("UIGradient")
CardGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(20, 12, 46)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 8,  20)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(6,  5,  16)),
})
CardGrad.Rotation = 145
CardGrad.Parent = Card

local CardStroke = mkStroke(Card, Color3.fromRGB(100, 50, 255), 2)

tw(Card,   0.6, {BackgroundTransparency = 0}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- Top accent bar
local TBar = Instance.new("Frame")
TBar.Size             = UDim2.new(0.55, 0, 0, 3)
TBar.Position         = UDim2.new(0.225, 0, 0, 0)
TBar.BackgroundColor3 = Color3.fromRGB(130, 55, 255)
TBar.BorderSizePixel  = 0
TBar.ZIndex           = 6
TBar.Parent           = Card
mkCorner(TBar, UDim.new(1, 0))

local TBarG = Instance.new("UIGradient")
TBarG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(70,25,190)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(190,85,255)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(70,25,190)),
})
TBarG.Parent = TBar

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  AVATAR RING + IMAGE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local AV = 72
local AvRing = Instance.new("Frame")
AvRing.Size             = UDim2.new(0, AV+12, 0, AV+12)
AvRing.Position         = UDim2.new(0.5, -(AV+12)/2, 0, 14)
AvRing.BackgroundColor3 = Color3.fromRGB(110, 50, 255)
AvRing.BackgroundTransparency = 0.65
AvRing.BorderSizePixel  = 0
AvRing.ZIndex           = 6
AvRing.Parent           = Card
mkCorner(AvRing, UDim.new(1, 0))

local AvF = Instance.new("Frame")
AvF.Size             = UDim2.new(0, AV, 0, AV)
AvF.Position         = UDim2.new(0.5, -AV/2, 0, 20)
AvF.BackgroundColor3 = Color3.fromRGB(20, 12, 44)
AvF.BorderSizePixel  = 0
AvF.ZIndex           = 7
AvF.Parent           = Card
mkCorner(AvF, UDim.new(1, 0))

local AvStroke = mkStroke(AvF, Color3.fromRGB(130, 60, 255), 2.5)

local AvImg = Instance.new("ImageLabel")
AvImg.Size               = UDim2.new(1, -6, 1, -6)
AvImg.Position           = UDim2.new(0, 3, 0, 3)
AvImg.BackgroundTransparency = 1
AvImg.Image              = ASSET_ID
AvImg.ScaleType          = Enum.ScaleType.Crop
AvImg.ZIndex             = 8
AvImg.Parent             = AvF
mkCorner(AvImg, UDim.new(1, 0))

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  NAME + TAG
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local NameLbl = Instance.new("TextLabel")
NameLbl.Size               = UDim2.new(1,-20,0,26)
NameLbl.Position           = UDim2.new(0,10,0,101)
NameLbl.BackgroundTransparency = 1
NameLbl.Text               = SCRIPT_NAME
NameLbl.TextScaled         = true
NameLbl.Font               = Enum.Font.GothamBold
NameLbl.TextColor3         = Color3.fromRGB(255,255,255)
NameLbl.ZIndex             = 6
NameLbl.Parent             = Card

local TagLbl = Instance.new("TextLabel")
TagLbl.Size                = UDim2.new(1,-20,0,15)
TagLbl.Position            = UDim2.new(0,10,0,128)
TagLbl.BackgroundTransparency = 1
TagLbl.Text                = CREATOR_TAG
TagLbl.TextScaled          = true
TagLbl.Font                = Enum.Font.Gotham
TagLbl.TextColor3          = Color3.fromRGB(148,118,210)
TagLbl.ZIndex              = 6
TagLbl.Parent              = Card

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  GRADIENT DIVIDER
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local Div = Instance.new("Frame")
Div.Size              = UDim2.new(0.82, 0, 0, 1)
Div.Position          = UDim2.new(0.09, 0, 0, 150)
Div.BackgroundColor3  = Color3.fromRGB(255,255,255)
Div.BorderSizePixel   = 0
Div.ZIndex            = 6
Div.Parent            = Card
local DivG = Instance.new("UIGradient")
DivG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(100,55,220)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(100,55,220)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,0,0)),
})
DivG.Parent = Div

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  STATUS + SUB
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local SRow = Instance.new("Frame")
SRow.Size              = UDim2.new(1,-30,0,18)
SRow.Position          = UDim2.new(0,15,0,159)
SRow.BackgroundTransparency = 1
SRow.ZIndex            = 6
SRow.Parent            = Card

local SIco = Instance.new("TextLabel")
SIco.Size              = UDim2.new(0,18,1,0)
SIco.BackgroundTransparency = 1
SIco.Text              = "⚡"
SIco.TextScaled        = true
SIco.Font              = Enum.Font.GothamBold
SIco.TextColor3        = Color3.fromRGB(170,100,255)
SIco.ZIndex            = 7
SIco.Parent            = SRow

local StatusLbl = Instance.new("TextLabel")
StatusLbl.Size             = UDim2.new(1,-24,1,0)
StatusLbl.Position         = UDim2.new(0,24,0,0)
StatusLbl.BackgroundTransparency = 1
StatusLbl.Text             = "SCRIPT LOADING"
StatusLbl.TextScaled       = true
StatusLbl.Font             = Enum.Font.GothamBold
StatusLbl.TextColor3       = Color3.fromRGB(200,155,255)
StatusLbl.TextXAlignment   = Enum.TextXAlignment.Left
StatusLbl.ZIndex           = 7
StatusLbl.Parent           = SRow

local SubLbl = Instance.new("TextLabel")
SubLbl.Size                = UDim2.new(1,-30,0,13)
SubLbl.Position            = UDim2.new(0,15,0,181)
SubLbl.BackgroundTransparency = 1
SubLbl.Text                = "Initializing modules..."
SubLbl.TextScaled          = true
SubLbl.Font                = Enum.Font.Gotham
SubLbl.TextColor3          = Color3.fromRGB(165,155,182)
SubLbl.TextXAlignment      = Enum.TextXAlignment.Left
SubLbl.ZIndex              = 6
SubLbl.Parent              = Card

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  PROGRESS BAR
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local BarBG = Instance.new("Frame")
BarBG.Size             = UDim2.new(0.82,0,0,9)
BarBG.Position         = UDim2.new(0.09,0,0,200)
BarBG.BackgroundColor3 = Color3.fromRGB(20,15,40)
BarBG.BorderSizePixel  = 0
BarBG.ZIndex           = 6
BarBG.Parent           = Card
mkCorner(BarBG, UDim.new(1,0))
mkStroke(BarBG, Color3.fromRGB(55,38,95), 1)

local BarFill = Instance.new("Frame")
BarFill.Size             = UDim2.new(0,0,1,0)
BarFill.BackgroundColor3 = Color3.fromRGB(115,55,255)
BarFill.BorderSizePixel  = 0
BarFill.ZIndex           = 7
BarFill.Parent           = BarBG
mkCorner(BarFill, UDim.new(1,0))

local BFG = Instance.new("UIGradient")
BFG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(75,28,200)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(155,75,255)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(220,138,255)),
})
BFG.Parent = BarFill

-- Shimmer sweep
local Shim = Instance.new("Frame")
Shim.Size             = UDim2.new(0.35,0,1,0)
Shim.Position         = UDim2.new(-0.35,0,0,0)
Shim.BackgroundColor3 = Color3.fromRGB(255,255,255)
Shim.BackgroundTransparency = 0.72
Shim.BorderSizePixel  = 0
Shim.ZIndex           = 8
Shim.Parent           = BarFill
mkCorner(Shim, UDim.new(1,0))

task.spawn(function()
    while Gui.Parent do
        tw(Shim, 1.5, {Position = UDim2.new(1.15,0,0,0)}, Enum.EasingStyle.Quad)
        task.wait(1.75)
        Shim.Position = UDim2.new(-0.35,0,0,0)
        task.wait(0.4)
    end
end)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  TIMER + PERCENT
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local TimeLbl = Instance.new("TextLabel")
TimeLbl.Size              = UDim2.new(0.4,0,0,13)
TimeLbl.Position          = UDim2.new(0.09,0,0,214)
TimeLbl.BackgroundTransparency = 1
TimeLbl.Text              = "00:00"
TimeLbl.TextScaled        = true
TimeLbl.Font              = Enum.Font.GothamSemibold
TimeLbl.TextColor3        = Color3.fromRGB(128,115,162)
TimeLbl.TextXAlignment    = Enum.TextXAlignment.Left
TimeLbl.ZIndex            = 6
TimeLbl.Parent            = Card

local PctLbl = Instance.new("TextLabel")
PctLbl.Size               = UDim2.new(0.4,0,0,13)
PctLbl.Position           = UDim2.new(0.51,0,0,214)
PctLbl.BackgroundTransparency = 1
PctLbl.Text               = "0%"
PctLbl.TextScaled         = true
PctLbl.Font               = Enum.Font.GothamSemibold
PctLbl.TextColor3         = Color3.fromRGB(128,115,162)
PctLbl.TextXAlignment     = Enum.TextXAlignment.Right
PctLbl.ZIndex             = 6
PctLbl.Parent             = Card

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  DOTS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local DHolder = Instance.new("Frame")
DHolder.Size             = UDim2.new(0,48,0,9)
DHolder.Position         = UDim2.new(0.5,-24,0,233)
DHolder.BackgroundTransparency = 1
DHolder.ZIndex           = 6
DHolder.Parent           = Card

local dots = {}
for i = 1,3 do
    local d = Instance.new("Frame")
    d.Size             = UDim2.new(0,8,0,8)
    d.Position         = UDim2.new(0,(i-1)*20,0,0)
    d.BackgroundColor3 = Color3.fromRGB(42,30,76)
    d.BorderSizePixel  = 0
    d.ZIndex           = 7
    d.Parent           = DHolder
    mkCorner(d, UDim.new(1,0))
    dots[i] = d
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  FOOTER
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local Footer = Instance.new("TextLabel")
Footer.Size               = UDim2.new(1,-20,0,12)
Footer.Position           = UDim2.new(0,10,1,-16)
Footer.BackgroundTransparency = 1
Footer.Text               = "Unique Script ·  for educational purposes only"
Footer.TextScaled         = true
Footer.Font               = Enum.Font.Gotham
Footer.TextColor3         = Color3.fromRGB(66,56,92)
Footer.ZIndex             = 6
Footer.Parent             = Card

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  GLOW PULSE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local bcols = {
    Color3.fromRGB(100,45,255),
    Color3.fromRGB(155,75,255),
    Color3.fromRGB(72,118,255),
}
local bci = 1

RunService.Heartbeat:Connect(function()
    local p = math.abs(math.sin(tick()*1.4))
    CardStroke.Thickness = 1.5 + p*2.2
    CardStroke.Color     = bcols[bci]
    AvStroke.Thickness   = 2 + p*1.8
    AvRing.BackgroundTransparency = 0.7 - p*0.14
end)

task.spawn(function()
    while true do task.wait(1.3) bci=(bci%#bcols)+1 end
end)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  DOTS LOOP
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
task.spawn(function()
    local a=1
    while Gui.Parent do
        for i,d in ipairs(dots) do
            tw(d, 0.18, {BackgroundColor3=(i==a) and Color3.fromRGB(162,82,255) or Color3.fromRGB(36,26,66)})
        end
        a=(a%3)+1
        task.wait(0.36)
    end
end)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  STATUS MESSAGES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local msgs = {
    "Initializing modules...",
    "Verifying script integrity...",
    "Connecting to Sharkify servers...",
    "Decrypting payload...",
    "Loading assets & dependencies...",
    "Injecting executor hooks...",
    "Bypassing detection layers...",
    "Applying runtime patches...",
    "Syncing with game environment...",
    "Finalizing configuration...",
    "Almost ready — hang tight...",
}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  MAIN PROGRESS  (exactly 2:30)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local t0, lastMsg = tick(), 0

task.spawn(function()
    while Gui.Parent do
        local el  = tick()-t0
        local prg = math.min(el/LOAD_DURATION, 1)
        local pct = math.floor(prg*100)

        tw(BarFill, 0.3, {Size=UDim2.new(prg,0,1,0)})
        PctLbl.Text  = tostring(pct).."%"
        local s = math.floor(el)
        TimeLbl.Text = string.format("%02d:%02d", math.floor(s/60), s%60)

        local mi = math.min(math.floor(prg*#msgs)+1, #msgs)
        if mi ~= lastMsg then
            lastMsg = mi
            tw(SubLbl, 0.18, {TextTransparency=1})
            task.wait(0.2)
            SubLbl.Text = msgs[mi]
            tw(SubLbl, 0.3, {TextTransparency=0})
        end

        if prg >= 1 then break end
        task.wait(0.05)
    end

    -- DONE
    StatusLbl.Text       = "SCRIPT READY  ✓"
    StatusLbl.TextColor3 = Color3.fromRGB(75,255,148)
    SIco.Text            = "✓"
    SIco.TextColor3      = Color3.fromRGB(75,255,148)
    SubLbl.Text          = "Welcome to Unique Scripts!"
    SubLbl.TextColor3    = Color3.fromRGB(195,255,208)

    task.wait(2)
    tw(Card,   0.55, {BackgroundTransparency=1, Position=UDim2.new(0.5,-CW/2,0.53,-CH/2)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    tw(Shadow, 0.55, {BackgroundTransparency=1})
    task.wait(0.65)
    Gui:Destroy()

    -- ▶ YOUR SCRIPT HERE:
    -- loadstring(game:HttpGet("YOUR_SCRIPT_URL"))()
end)
