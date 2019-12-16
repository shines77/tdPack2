-- Combuctor.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 8:43:02 PM

if not Combuctor then
    return
end

local ns = select(2, ...)
local orig_FrameNew = Combuctor.Frame.New
local orig_PUI_Toggle = PUI_Toggle

local function CreateSortButton(parent, width, height, point1, point2, point3, isBank)
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

local function CreateSortButtons()
    if not CombuctorFrame1Search then return end
    CombuctorFrame1Search:SetPoint('TOPRIGHT', -166, -44)

    CreateSortButton(CombuctorFrame1, 45, 25, 'TOPRIGHT', -50, -41, false)
    CreateSortButton(CombuctorFrame2, 45, 25, 'TOPRIGHT', -50, -41, true)
end

--
-- For BigFoot's backpack addon Combuctor.
--
function PUI_Toggle(__switch)
    --print("Combuctor.PUI_Toggle();")
    if orig_PUI_Toggle then
        orig_PUI_Toggle(__switch)

        if not CombuctorFrame1TdSort then
            CreateSortButtons()
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

function Combuctor.Frame:New(...)
    --print("Combuctor.Frame:New();")
    local f = nil
    if orig_FrameNew then
        f = orig_FrameNew(self, ...)

        if not orig_PUI_Toggle then
            local button = CreateFrame('Button', nil, f, 'CombuctorBagToggleTemplate')
            ns.SetupButton(button, ... == 'bank')

            if f.sortButton then
                f.sortButton:Hide()
            end

            if button.Icon then
                button.Icon:SetTexture(ns.ICON)
                button:SetPoint('RIGHT', f.bagToggle, 'LEFT', 0, 0)
                f.searchBox:SetPoint('TOPRIGHT', -77, -32)
            end
        end
    end
    return f
end
