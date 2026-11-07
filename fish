local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

-- 1. XÓA UI KEY CŨ NẾU CÒN TỒN TẠI
if CoreGui:FindFirstChild("TamdzHub_KeySystem") then
    CoreGui.TamdzHub_KeySystem:Destroy()
end

-- 2. DANH SÁCH KEY 1 LẦN & KEY VĨNH VIỄN
local TemporaryKeys = {
    ["Tamdz-Key901"] = true,
    ["Tamdz-Key352"] = true,
    ["Tamdz-Key883"] = true,
    ["Tamdz-Key784"] = true,
    ["Tamdz-Key775"] = true,
    ["Tamdz-Key156"] = true,
    ["Tamdz-Key779"] = true,
    ["Tamdz-Key178"] = true,
    ["Tamdz-Key789"] = true,
    ["Tamdz-Key100"] = true,
    ["Tamdz-Key141"] = true,
    ["Tamdz-Key682"] = true,
    ["Tamdz-Key163"] = true,
    ["Tamdz-Key194"] = true,
    ["Tamdz-Key815"] = true
}

local PermanentKey = "Tamdz-Hub123"
local FailCount = 0
local LinkGetKey = "https://laykeyfreeheavyweightfishing.netlify.app/"

-- 3. HÀM TẢI SCRIPT CỦ CỦA ÔNG TỪ GITHUB MỚI
local function LoadMainScript()
    local rawUrl = "https://raw.githubusercontent.com/Tamdz-2011/C-u-c-/refs/heads/main/Heavyweigh%20Fishing%20of%20Tam.lua"
    
    StarterGui:SetCore("SendNotification", {
        Title = "Tamdz Hub",
        Text = "Đang tải script...",
        Duration = 3
    })

    task.spawn(function()
        local success, err = pcall(function()
            loadstring(game:HttpGet(rawUrl))()
        end)
        
        if not success then
            StarterGui:SetCore("SendNotification", {
                Title = "LỖI TẢI SCRIPT!",
                Text = tostring(err),
                Duration = 5
            })
        end
    end)
end

-- 4. GIAO DIỆN KEY UI MÀU ĐEN (CHUẨN MOBILE)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TamdzHub_KeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 240)
MainFrame.Position = UDim2.new(0.5, -170, 0.4, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 60)
UIStroke.Thickness = 1.8
UIStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "🎣 Tamdz Hub - Key System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.88, 0, 0, 42)
KeyBox.Position = UDim2.new(0.06, 0, 0.23, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
KeyBox.Text = ""
KeyBox.PlaceholderText = "Nhập Key tại đây..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 130)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14
KeyBox.Font = Enum.Font.Gotham
KeyBox.Parent = MainFrame

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0, 8)
KeyBoxCorner.Parent = KeyBox

local KeyBoxStroke = Instance.new("UIStroke")
KeyBoxStroke.Color = Color3.fromRGB(70, 70, 70)
KeyBoxStroke.Thickness = 1
KeyBoxStroke.Parent = KeyBox

-- Nút Xác Nhận
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.42, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.06, 0, 0.48, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
SubmitBtn.Text = "XÁC NHẬN"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 14
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Parent = MainFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = SubmitBtn

-- Nút Get Key
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.42, 0, 0, 40)
GetKeyBtn.Position = UDim2.new(0.52, 0, 0.48, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 14
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Parent = MainFrame

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0.76, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "⚠️ Sai quá 3 lần sẽ bị kick!"
StatusLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

-- 5. XỬ LÝ SỰ KIỆN BẤM NÚT
SubmitBtn.Activated:Connect(function()
    local inputKey = KeyBox.Text:gsub("%s+", "")
    
    if inputKey == PermanentKey or TemporaryKeys[inputKey] then
        if TemporaryKeys[inputKey] then
            TemporaryKeys[inputKey] = nil
        end
        ScreenGui:Destroy()
        LoadMainScript()
    else
        FailCount = FailCount + 1
        if FailCount >= 3 then
            LocalPlayer:Kick("Ra ik get key đê")
        else
            StatusLabel.Text = "❌ Sai key! Còn " .. (3 - FailCount) .. " lần thử."
            StatusLabel.TextColor3 = Color3.fromRGB(255, 85, 85)
        end
    end
end)

GetKeyBtn.Activated:Connect(function()
    if setclipboard then
        setclipboard(LinkGetKey)
        StatusLabel.Text = "✅ Đã copy link Get Key!"
        StatusLabel.TextColor3 = Color3.fromRGB(85, 255, 127)
    else
        StatusLabel.Text = "❌ Executor không hỗ trợ copy!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 85, 85)
    end
end)
