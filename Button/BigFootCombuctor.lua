-- BFCombuctor.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 8:43:02 PM

if not Combuctor then
    return
end

if not PUI_Toggle then
    return
end

local ns = select(2, ...)
--local orig_CombuctorFrameNew = Combuctor.InventoryFrame.New
local orig_PUI_Toggle = PUI_Toggle

local function createSortButton(parent, width, height, point1, point2, point3, isBank)
    local button = CreateFrame('Button', parent:GetName().."TdSort", parent, 'UIPanelButtonTemplate')
    ns.SetupButton(button, isBank)

    button:SetWidth(width)
    button:SetHeight(height)
    button:SetPoint(point1, point2, point3)
    button:SetText(__PUI_BUTTON_TEXT_BAG)

    --button.Icon:SetTexture(ns.ICON)
    --button:SetPoint('RIGHT', f.bagToggle, 'LEFT', 0, 0)

    return button
end

local function createSortButtons()
    if not CombuctorFrame1Search then return end
    CombuctorFrame1Search:SetPoint('TOPRIGHT', -166, -44)

    createSortButton(CombuctorFrame1, 45, 25, 'TOPRIGHT', -50, -41, false)
    createSortButton(CombuctorFrame2, 45, 25, 'TOPRIGHT', -50, -41, true)
end

function PUI_Toggle(__switch)
    print ("Combuctor.PUI_Toggle();")
    if orig_PUI_Toggle then
        orig_PUI_Toggle(self, __switch)

        if not CombuctorFrame1TdSort then
            createSortButtons()
        end

        CombuctorFrame1Sort:Hide()
        CombuctorFrame2Sort:Hide()

        if __switch then
            CombuctorFrame1TdSort:Show()
            CombuctorFrame2TdSort:Show()
        else
            CombuctorFrame1TdSort:Hide()
            CombuctorFrame2TdSort:Hide()
        end
    end
end

--[[
function Combuctor.InventoryFrame:New(titleText, settings, isBank, key)
    local f = orig_CombuctorFrameNew(self, ...)

    local button = CreateFrame('Button', nil, f, 'BFCombuctorBagToggleTemplate')
    ns.SetupButton(button, ... == 'bank')

    if f.sortButton then
        f.sortButton:Hide()
    end

    button.Icon:SetTexture(ns.ICON)
    button:SetPoint('RIGHT', f.bagToggle, 'LEFT', 0, 0)
    f.searchBox:SetPoint('TOPRIGHT', -77, -32)

    return f
end
]]--
