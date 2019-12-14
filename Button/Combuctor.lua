-- Combuctor.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 8:43:02 PM

if not Combuctor then
    return
end

if (not Combuctor.Frame) or PUI_Toggle then
    return
end

local ns = select(2, ...)
local orig_FrameNew = Combuctor.Frame.New
local orig_PUI_Toggle = PUI_Toggle

function Combuctor.Frame:New(...)
    if orig_FrameNew then
        local f = orig_FrameNew(self, ...)

        if not orig_PUI_Toggle then
            local button = CreateFrame('Button', nil, f, 'BFCombuctorBagToggleTemplate')
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

        return f
    else
        return nil
    end
end
