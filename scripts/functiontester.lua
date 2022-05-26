local LightingService = game:GetService("Lighting")
local TweenService    = game:GetService("TweenService")

local screen = Instance.new("ScreenGui")
local blur = Instance.new("BlurEffect")
local correction = Instance.new("ColorCorrectionEffect")
local bloom = Instance.new("BloomEffect")
local logo = Instance.new("ImageLabel")
local score = 0

local function thread(e) coroutine.resume(coroutine.create(e)) end
local instances = {}

local function TweenSize(object, dest, timing, direction)
    direction = direction or Enum.EasingDirection.Out
    timing = timing or 0.25
    local anim = TweenService:Create(
    	object,
    	TweenInfo.new(timing, Enum.EasingStyle.Exponential, direction), --Enum.EasingStyle.Linear, Enum.EasingDirection.In
    	{Size = dest}
    )
    anim:Play()
end

local function TweenPosition(object, dest, timing, direction)
    direction = direction or Enum.EasingDirection.Out
    timing = timing or 0.25
    local anim = game.TweenService:Create(
    	object,
    	TweenInfo.new(timing, Enum.EasingStyle.Exponential, direction), --Enum.EasingStyle.Linear, Enum.EasingDirection.In
    	{Position = dest}
    )
    anim:Play()
end

local function TweenContrast(object, dest, timing)
    timing = timing or 0.25
    game.TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{Contrast = dest}):Play()
end
local function TweenBrightness(object, dest, timing)
    timing = timing or 0.25
    game.TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{Brightness = dest}):Play()
end
local function TweenIntensity(object, dest, timing)
    timing = timing or 0.25
    game.TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{Intensity = dest}):Play()
end
local function TweenTransparency(object, dest, timing)
    timing = timing or 0.25
    game.TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{ImageTransparency = dest}):Play()
end
local function TweenTextTransparency(object, dest, timing)
    timing = timing or 0.25
    game.TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{TextTransparency = dest, TextStrokeTransparency = dest}):Play()
end

local function TextAnim(textlabel)
    textlabel.TextColor3 = Color3.fromRGB(120,255,255)
    game.TweenService:Create(textlabel,TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end

local function NewText(e, position)
    local mask = Instance.new("Frame")
    mask.Size = UDim2.new(0, 300, 0, 100)
    mask.Parent = screen
    mask.ClipsDescendants = true
    mask.Position = position
    mask.BackgroundTransparency = 1
    mask.BorderSizePixel = 0
    mask.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    
    local text = Instance.new("TextLabel")
    text.Parent = mask
    text.BackgroundTransparency = 1
    text.Position = UDim2.new(0, 0, 0, -75)
    text.Size = UDim2.new(1, 0, 1, 0)
    text.Font = Enum.Font.Nunito
    text.Text = e
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.TextSize = 35
    text.RichText = true
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    text.TextStrokeTransparency = 0
    text.ZIndex = 300
    
    table.insert(instances,text)
    TweenPosition(text, UDim2.new(0,0,0,0), 1)
    
    return text
end


local function FadeOut()
    TweenSize(blur, 0, 1)
    TweenContrast(correction, 0, 1)
    TweenBrightness(correction, 0, 1)
    TweenIntensity(bloom, 0, 1)
    TweenSize(bloom, 0, 1)
    TweenTransparency(logo, 1, timing)
    wait(1)
    
    blur:Destroy()
    correction:Destroy()
    bloom:Destroy()
    screen:Destroy()  
end

local function Run(pos, start, stop, amount)
    thread(function()
        for a=start,stop do
            tests[a] = tests[a] or ""
            NewText(a..") "..tests[a], UDim2.new(pos,0,(a-start)/35,40))
            wait()
        end
    end)
    
    thread(function()
        for b=start,stop do
            if genv[tests[b]] then
                NewText("<font color='#00ff00'>true</font>", UDim2.new(pos,300,(b-start)/35,40))
                score = score + amount
                scoretext.Text = "Score: "..tostring(score).." / "..scoremax
                TextAnim(scoretext)
            else
                NewText("<font color='#ff0000'>false</font>", UDim2.new(pos,300,(b-start)/35,40))
            end
            wait()
        end
    end) 
    
end

screen.Parent = game.CoreGui

blur.Parent = LightingService
blur.Size = 0

correction.Parent = LightingService

bloom.Parent = LightingService
bloom.Intensity = 0 
bloom.Size = 0 


TweenSize(blur, 25, 1)
TweenContrast(correction, 0.1, 1)
TweenBrightness(correction, -0.1, 1)
TweenIntensity(bloom, 5, 1)
TweenSize(bloom, 80, 1)



tests = {
    --from syn docs
    "getgenv",
    "getrenv",
    "getreg",
    "getgc",
    "getinstances",
    "getnilinstances",
    "getscripts",
    "getloadedmodules",
    "getconnections",
    "firesignal",
    "fireclickdetector",
    "fireproximityprompt",
    "firetouchinterest",
    "isnetworkowner",
    "gethiddenproperty",
    "sethiddenproperty",
    "setsimulationradius",
    "getsenv",
    "getcallingscript",
    "getscriptclosure",
    "getscripthash",
    "getrawmetatable",
    "setrawmetatable",
    "isreadonly",
    "iswindowactive",
    "keypress",
    "keyrelease",
    "mouse1click",
    "mouse1press",
    "mouse1release",
    "mouse2click",
    "mouse2press",
    "mouse2release",
    "mousescroll",
    "mousemoverel",
    "mousemoveabs",
    "hookfunction",
    "newcclosure",
    "loadstring",
    "checkcaller",
    "islclosure",
    "dumpstring",
    "decompile",
    "rconsoleprint",
    "rconsoleinfo",
    "rconsolewarn",
    "rconsoleerr",
    "rconsoleclear",
    "rconsolename",
    "rconsoleinput",
    "printconsole",
    "readfile",
    "writefile",
    "appendfile",
    "loadfile",
    "listfiles",
    "isfile",
    "isfolder",
    "makefolder",
    "delfolder",
    "delfile",
    "setclipboard",
    "setfflag",
    "getnamecallmethod",
    "setnamecallmethod",
    "getspecialinfo",
    "saveinstance",
    "messagebox",
    "bit","debug","Drawing","bit32",
    "make_readonly",
    "make_writeable",
    "get_nil_instances",
    "get_calling_script",
    
    --Obscure aliases for more popular funtions that most exploits support
    
    "AES","Hash","Input","WebSocket","Base64",
    
    
    "make_writeable","dofile","make_readonly","is_writeable","is_readonly","getobjects","dump_function",
    "get_script_function","disconnect_all"
    
}

genv = getgenv()


scoremax = #tests-14
score = 0
scoretext = NewText("Score: 0 / "..scoremax, UDim2.new(0.5, -100, 0, -30))
wait(0.1)
TextAnim(scoretext)
wait(1)

Run(0.05, 1, 30, 1)
wait(0.2)
Run(0.35, 31, 60, 1)
wait(0.2)
Run(0.55, 61, 76, 1)
wait(0.2)
Run(0.75, 77, 90, 0)

wait(0.1)
NewText("<font size='25'> ^^^^^^^^^^^^<br/>Libraries/functions that may be<br/>unique to a few exploits, but have<br/>more popular alternatives</font>", UDim2.new(0.9, -250, 0.5, 0))
NewText("<font size='25'> Because of them being unique,<br/>they will not be counted.</font>", UDim2.new(0.9, -250, 0.61, 0))


wait(3)
scoretext.Text = "        "..(tostring((score/scoremax)*100):sub(1,5)).."%!", UDim2.new(0.5, -100, 0, -30)
TextAnim(scoretext)
wait(1)
for i,v in pairs(instances) do
    TweenPosition(v, v.Position+UDim2.new(0, 0, 0, 200), 1, Enum.EasingDirection.In)
end
wait(2.3)
FadeOut()

for i,v in pairs(instances) do
    instances[i] = nil
end
