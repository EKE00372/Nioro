local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local L = LibStub("AceLocale-3.0"):GetLocale('Nioro', false)
local Actions = addon:NewModule('Actions')
local Utils = addon:GetModule('Utils')
local infos = addon:GetModule('Constants'):GetInfos()

function Actions:OnInitialize()
    self:initSlash()
end

function Actions:log(text)
    local prefix = format("|CFF00FFFF%s: |r", L.ADDON_SHOW_NAME)
    SendSystemMessage(prefix..text)
end

function Actions:initSlash()
    SLASH_NIORO1 = "/nioro"
    SLASH_NIORO2 = "/NIORO"
    SLASH_NIORO3 = "/nio"
    SlashCmdList['NIORO'] = function(param)
        param = string.lower(param)
        if param == 'show' then 
            local Settings = addon:GetModule('Settings', true)
            return Settings and Settings:Open()
        end
        if param == 'version' then
            return self:log('v'..infos.VERSION)
        end
        self:log("Usage:")
        self:log('/nio show  '..L.SLASH_TIPS_SHOW)
        self:log('/nio version  '..L.SLASH_TIPS_VERSION)
    end
end

function Actions:updateFrameOptions(options)
    if Utils:tableLength(NIORO_VARS.COMPACT_FRAME) == 0 then
        return self:log(L.NOT_FOUND_RAID_FRAME)
    end
    if not options then options = DefaultCompactUnitFrameOptions end

    for k, v in pairs(NIORO_DB.SETTINGS.OPTIONS) do
        options = Utils:setState(options, k, v)
    end
    for k, frame in pairs(NIORO_VARS.COMPACT_FRAME) do
        CompactUnitFrame_SetOptionTable(frame, options)
        CompactUnitFrame_UpdateAll(frame)
    end
end

function Actions:toggleRoleIcon(toggle)
    NIORO_DB.SETTINGS.OPTIONS.displayRoleIcon = toggle
    self:updateFrameOptions()
end

function Actions:toggleMemberName(toggle)
    NIORO_DB.SETTINGS.OPTIONS.displayName = toggle
    self:updateFrameOptions()
end

function Actions:toggleFlatTexture(toggle)
    NIORO_DB.SETTINGS.USE_FLAT_TEXTURE = toggle
    self:updateFrameOptions()
end

function Actions:toggleFlatIcon(toggle)
    NIORO_DB.SETTINGS.USE_FLAT_ICON = toggle
    self:updateFrameOptions()
end

function Actions:setBuffScale(scale)
    NIORO_DB.SETTINGS.BUFF_SCALE = scale
    self:updateFrameOptions()
end

function Actions:setDebuffScale(scale)
    NIORO_DB.SETTINGS.DEBUFF_SCALE = scale
    self:updateFrameOptions()
end




