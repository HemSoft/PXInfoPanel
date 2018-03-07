---------------------------------------------------------------------------------------------------------
-- S E T T I N G S
---------------------------------------------------------------------------------------------------------
function PXInfoPanelAddon:CreateSettingsWindow()
  local LAM2 = LibStub("LibAddonMenu-2.0")
  local panelData =
  {
    type                = "panel",
    name                = self.Name,
    displayName         = GetString(PXIP_SETTINGS_DISPLAY_NAME),
    author              = GetString(PXIP_SETTINGS_AUTHOR),
    version             = self.Version,
    registerForRefresh  = true,
    registerForDefaults = true
  }

  local cntrlOptionsPanel = LAM2:RegisterAddonPanel(self.Name, panelData)

  local optionsData =
  {
    {
      type = "description",
      text = GetString(PXIP_SETTINGS_HEADER_TEXT),
    },
    {
      type = "button",
      name = GetString(PXIP_SETTINGS_SHOW_WINDOW),
      func = function()
        PXInfoPanelAddonIndicator:SetHidden(false)
      end,
      width = "full",
    },

    --------------------- Window Settings ---------------------
    {
      type = "submenu",
      name = GetString(PXIP_SETTINGS_WINDOW_SETTINGS),
      controls =
      {
        {
          type = "colorpicker",
          name = GetString(PXIP_SETTINGS_FONT_COLOR),
          tooltip = GetString(PXIP_SETTINGS_FONT_COLOR_TOOLTIP),
          getFunc = function() return self.savedVariables.fontColor.r, self.savedVariables.fontColor.g, self.savedVariables.fontColor.g end,
          setFunc = function(r,g,b,a) self.savedVariables.fontColor = { ["r"] = r, ["g"] = g, ["b"] = b }; PXInfoPanelAddon:UpdateUI() end,
          default = { r = 1, g = 1, b = 1 },
        },
        {
          type = "slider",
          name = GetString(PXIP_SETTINGS_FONT_SCALE),
          min = 0, max = 3, step = 0.1,
          getFunc = function() return self.savedVariables.fontScale end,
          setFunc = function(value) self.savedVariables.fontScale = value; PXInfoPanelAddon:UpdateUI() end,
          disabled = function() return false end,
          width = "full",
          default = 1,
        },
        {
          type = "slider",
          name = GetString(PXIP_SETTINGS_BACKGROUND_TRANSPARENCY),
          min = 0, max = 1, step = 0.1,
          getFunc = function() return self.savedVariables.transparency end,
          setFunc = function(value) self.savedVariables.transparency = value; PXInfoPanelAddon:UpdateUI() end,
          width = "full",
          default = 0,
        },
      }
    },

    {
      type = "submenu",
      name = GetString(PXIP_SETTINGS_TOGGLE_NOTIFY_OPTIONS),
      controls =
      {
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_HIDE_INFO_PANEL_WHEN_USING_INVENTORY),
          tooltip = GetString(PXIP_SETTINGS_HIDE_INFO_PANEL_WHEN_USING_INVENTORY_TOOLTIP),
          getFunc = function() return self.savedVariables.hideInfoPanelWhenViewInventory end,
          setFunc = function(e) self.savedVariables.hideInfoPanelWhenViewInventory = e; PXInfoPanelAddon:UpdateWritStatus() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_DATE_TIME),
          getFunc = function() return self.savedVariables.showTime end,
          setFunc = function(e) self.savedVariables.showTime = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_GROUP_LOOT),
          getFunc = function() return self.savedVariables.showGroupLoot end,
          setFunc = function(e) self.savedVariables.showGroupLoot = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_LAST_LOOT),
          getFunc = function() return self.savedVariables.showLastLoot end,
          setFunc = function(e) self.savedVariables.showLastLoot = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_LAST_LOOT_TRAIT),
          getFunc = function() return self.savedVariables.showLastLootTrait end,
          setFunc = function(e) self.savedVariables.showLastLootTrait = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_LAST_LOOT_IN_CHAT),
          getFunc = function() return self.savedVariables.showLastLootInChat end,
          setFunc = function(e) self.savedVariables.showLastLootInChat = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_LAST_LOOT_AND_TOTAL_GOLD_IN_CHAT),
          getFunc = function() return self.savedVariables.showLastLootAndGoldInChat end,
          setFunc = function(e) self.savedVariables.showLastLootAndGoldInChat = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "slider",
          name    = GetString(PXIP_SETTINGS_LAST_LOOT_LINES),
          tooltip = GetString(PXIP_SETTINGS_LAST_LOOT_LINES_TOOLTIP),
          min     = -1, max = 5, step = 1,
          getFunc = function() return self.savedVariables.lastLootLines end,
          setFunc = function(value) self.savedVariables.lastLootLines = value; PXInfoPanelAddon:UpdateUI() end,
          width   = "full",
          default = self.DefaultSettings.lastLootLines,
          disabled= function(e) return not self.savedVariables.showLastLoot; end,
        },
        {
          type    = "slider",
          name    = GetString(PXIP_SETTINGS_NOTIFY_ABOUT_LOOT_OVER),
          tooltip = GetString(PXIP_SETTINGS_NOTIFY_ABOUT_LOOT_OVER_TOOLTIP),
          min     = -1, max = 50000, step = 1000,
          getFunc = function() return self.savedVariables.notifyOnLootAbove end,
          setFunc = function(value) self.savedVariables.notifyOnLootAbove = value; PXInfoPanelAddon:UpdateUI() end,
          width   = "full",
          default = self.DefaultSettings.notifyOnLootAbove,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_PLAY_SOUND_ON_NOTIFY_ABOUT_LOOT_ABOVE),
          tooltip = GetString(PXIP_SETTINGS_PLAY_SOUND_ON_NOTIFY_ABOUT_LOOT_ABOVE_TOOLTIP),
          getFunc = function() return self.savedVariables.playSoundOnNotifyOnLootAbove end,
          setFunc = function(e) self.savedVariables.playSoundOnNotifyOnLootAbove = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_BEST_LOOT),
          getFunc = function() return self.savedVariables.showBestLoot end,
          setFunc = function(e) self.savedVariables.showBestLoot = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_2ND_BEST_LOOT),
          getFunc = function() return self.savedVariables.showBestLoot2 end,
          setFunc = function(e) self.savedVariables.showBestLoot2 = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_3RD_BEST_LOOT),
          getFunc = function() return self.savedVariables.showBestLoot3 end,
          setFunc = function(e) self.savedVariables.showBestLoot3 = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_4TH_BEST_LOOT),
          getFunc = function() return self.savedVariables.showBestLoot4 end,
          setFunc = function(e) self.savedVariables.showBestLoot4 = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_5TH_BEST_LOOT),
          getFunc = function() return self.savedVariables.showBestLoot5 end,
          setFunc = function(e) self.savedVariables.showBestLoot5 = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_MATERIAL_INFO),
          getFunc = function() return self.savedVariables.showMaterialInventory end,
          setFunc = function(e) self.savedVariables.showMaterialInventory = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_CONDENSED_MATERIAL_INFO),
          tooltip = GetString(PXIP_SETTINGS_SHOW_CONDENSED_MATERIAL_INFO_TOOLTIP),
          getFunc = function() return self.savedVariables.showMaterialInventoryCondensed end,
          setFunc = function(e) self.savedVariables.showMaterialInventoryCondensed = e; PXInfoPanelAddon:UpdateUI() end,
          disabled = function() return not self.savedVariables.showMaterialInventory end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_ACHIEVEMENT_POINTS),
          getFunc = function() return self.savedVariables.showAchievements end,
          setFunc = function(e) self.savedVariables.showAchievements = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_ENLIGHTENED_POOL),
          getFunc = function() return self.savedVariables.showEnlightenedPool end,
          setFunc = function(e) self.savedVariables.showEnlightenedPool = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_TOTAL_MINUTES_PLAYED),
          getFunc = function() return self.savedVariables.showTotalMinutesPlayed end,
          setFunc = function(e) self.savedVariables.showTotalMinutesPlayed = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_LEVEL_PROGRESS),
          getFunc = function() return self.savedVariables.showLevelProgress end,
          setFunc = function(e) self.savedVariables.showLevelProgress = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_GRIND_STATUS),
          tooltip = GetString(PXIP_SETTINGS_SHOW_GRIND_STATUS_TOOLTIP),
          getFunc = function() return self.savedVariables.showGrindStatus end,
          setFunc = function(e) self.savedVariables.showGrindStatus = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_TOTAL_GOLD_MADE),
          getFunc = function() return self.savedVariables.showTotalGoldMade end,
          setFunc = function(e) self.savedVariables.showTotalGoldMade = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_TOTAL_XP_GAINED),
          getFunc = function() return self.savedVariables.showTotalXPMade end,
          setFunc = function(e) self.savedVariables.showTotalXPMade = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_LAST_LOREBOOK_LEARNED),
          getFunc = function() return self.savedVariables.showLastLoreBookLearned end,
          setFunc = function(e) self.savedVariables.showLastLoreBookLearned = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_LORE_BOOK_NOTIICATION),
          tooltip = GetString(PXIP_SETTINGS_SHOW_LORE_BOOK_NOTIICATION_TOOLTIP),
          getFunc = function() return self.savedVariables.notifyOnLoreBooks end,
          setFunc = function(e) self.savedVariables.notifyOnLoreBooks = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_TOTAL_WRIT_VOUCHERS),
          getFunc = function() return self.savedVariables.showTotalWritVouchers end,
          setFunc = function(e) self.savedVariables.showTotalWritVouchers = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_WRIT_VOUCHERS),
          getFunc = function() return self.savedVariables.showWritStatus end,
          setFunc = function(e) self.savedVariables.showWritStatus = e; PXInfoPanelAddon:UpdateWritStatus(); end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_CONDENSED_WRIT_VOUCHERS),
          tooltip = GetString(PXIP_SETTINGS_SHOW_CONDENSED_WRIT_VOUCHERS_TOOLTIP),
          getFunc = function() return self.savedVariables.showWritStatusCondensed end,
          setFunc = function(e) self.savedVariables.showWritStatusCondensed = e; PXInfoPanelAddon:UpdateWritStatus() end,
          disabled = function() return not self.savedVariables.showWritStatus end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_BIS_LOOT_NOTIFICATIONS),
          tooltip = GetString(PXIP_SETTINGS_SHOW_BIS_LOOT_NOTIFICATIONS_TOOLTIP),
          getFunc = function() return self.savedVariables.showBiSLootNotifications end,
          setFunc = function(e) self.savedVariables.showBiSLootNotifications = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_ACHIEVEMENT_PROGRESS_IN_CHAT),
          tooltip = GetString(PXIP_SETTINGS_SHOW_ACHIEVEMENT_PROGRESS_IN_CHAT),
          getFunc = function() return self.savedVariables.showAchievementProgressInChat end,
          setFunc = function(e) self.savedVariables.showAchievementProgressInChat = e; PXInfoPanelAddon:UpdateUI() end,
          default = true,
        },
      },
    },
    {
      type = "submenu",
      name = GetString(PXIP_SETTINGS_PVP),
      controls =
      {
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_PVP_INFORMATION),
          tooltip = GetString(PXIP_SETTINGS_SHOW_PVP_INFORMATION_TOOLTIP),
          getFunc = function() return self.savedVariables.showPVPInfo end,
          setFunc = function(e) self.savedVariables.showPVPInfo = e; PXInfoPanelAddon:UpdateUI() end,
          default = self.DefaultSettings.showPVPInfo,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_PVP_ONLY_WHEN_IN_PVP),
          getFunc = function() return self.savedVariables.showPVPInfoOnlyWhenInPVP end,
          setFunc = function(e) self.savedVariables.showPVPInfoOnlyWhenInPVP = e; PXInfoPanelAddon:UpdateUI() end,
          default = self.DefaultSettings.showPVPInfoOnlyWhenInPVP,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_PVP_RANK),
          getFunc = function() return self.savedVariables.showPVPRank end,
          setFunc = function(e) self.savedVariables.showPVPRank = e; PXInfoPanelAddon:UpdateUI() end,
          default = self.DefaultSettings.showPVPRank,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_SHOW_PVP_QUEUE_TIME_WHEN_QUEUED),
          getFunc = function() return self.savedVariables.showPVPQueueTimeWhenQueued end,
          setFunc = function(e) self.savedVariables.showPVPQueueTimeWhenQueued = e; self:UpdateUI() end,
          default = self.DefaultSettings.showPVPQueueTimeWhenQueued,
        },
      },
    },
    {
      type = "submenu",
      name = GetString(PXIP_SETTINGS_MONITOR_INVENTORY),
      controls =
      {
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 1:",
          getFunc = function() return self.savedVariables.customMonitor1.Show end,
          setFunc = function(e) self.savedVariables.customMonitor1.Show = e; self:UpdateUI() end,
          default = false,
        },
        {
          type    = "editbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 1:",
          getFunc = function() return self.savedVariables.customMonitor1.SearchText end,
          setFunc = function(e) self.savedVariables.customMonitor1.SearchText = self:AdjustItemLink(e); self:UpdateUI(); end,
          default = '',
          disabled= function(e) return not self.savedVariables.customMonitor1.Show; end,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 2:",
          getFunc = function() return self.savedVariables.customMonitor2.Show end,
          setFunc = function(e) self.savedVariables.customMonitor2.Show = e; self:UpdateUI() end,
          default = false,
        },
        {
          type    = "editbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 2:",
          getFunc = function() return self.savedVariables.customMonitor2.SearchText end,
          setFunc = function(e) self.savedVariables.customMonitor2.SearchText = self:AdjustItemLink(e); self:UpdateUI(); end,
          default = '',
          disabled= function(e) return not self.savedVariables.customMonitor2.Show; end,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 3:",
          getFunc = function() return self.savedVariables.customMonitor3.Show end,
          setFunc = function(e) self.savedVariables.customMonitor3.Show = e; self:UpdateUI() end,
          default = false,
        },
        {
          type    = "editbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 3:",
          getFunc = function() return self.savedVariables.customMonitor3.SearchText end,
          setFunc = function(e) self.savedVariables.customMonitor3.SearchText = self:AdjustItemLink(e); self:UpdateUI(); end,
          default = '',
          disabled= function(e) return not self.savedVariables.customMonitor3.Show; end,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 4:",
          getFunc = function() return self.savedVariables.customMonitor4.Show end,
          setFunc = function(e) self.savedVariables.customMonitor4.Show = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "editbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 4:",
          getFunc = function() return self.savedVariables.customMonitor4.SearchText end,
          setFunc = function(e) self.savedVariables.customMonitor4.SearchText = self:AdjustItemLink(e); self:UpdateUI(); end,
          default = '',
          disabled= function(e) return not self.savedVariables.customMonitor4.Show; end,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 5:",
          getFunc = function() return self.savedVariables.customMonitor5.Show end,
          setFunc = function(e) self.savedVariables.customMonitor5.Show = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "editbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 5:",
          getFunc = function() return self.savedVariables.customMonitor5.SearchText end,
          setFunc = function(e) self.savedVariables.customMonitor5.SearchText = self:AdjustItemLink(e); self:UpdateUI(); end,
          default = '',
          disabled= function(e) return not self.savedVariables.customMonitor5.Show; end,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 6:",
          getFunc = function() return self.savedVariables.customMonitor6.Show end,
          setFunc = function(e) self.savedVariables.customMonitor6.Show = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "editbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 6:",
          getFunc = function() return self.savedVariables.customMonitor6.SearchText end,
          setFunc = function(e) self.savedVariables.customMonitor6.SearchText = self:AdjustItemLink(e); self:UpdateUI(); end,
          default = '',
          disabled= function(e) return not self.savedVariables.customMonitor6.Show; end,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 7:",
          getFunc = function() return self.savedVariables.customMonitor7.Show end,
          setFunc = function(e) self.savedVariables.customMonitor7.Show = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "editbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 7:",
          getFunc = function() return self.savedVariables.customMonitor7.SearchText end,
          setFunc = function(e) self.savedVariables.customMonitor7.SearchText = self:AdjustItemLink(e); self:UpdateUI(); end,
          default = '',
          disabled= function(e) return not self.savedVariables.customMonitor7.Show; end,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 8:",
          getFunc = function() return self.savedVariables.customMonitor8.Show end,
          setFunc = function(e) self.savedVariables.customMonitor8.Show = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "editbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 8:",
          getFunc = function() return self.savedVariables.customMonitor8.SearchText end,
          setFunc = function(e) self.savedVariables.customMonitor8.SearchText = self:AdjustItemLink(e); self:UpdateUI(); end,
          default = '',
          disabled= function(e) return not self.savedVariables.customMonitor8.Show; end,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 9:",
          getFunc = function() return self.savedVariables.customMonitor9.Show end,
          setFunc = function(e) self.savedVariables.customMonitor9.Show = e; PXInfoPanelAddon:UpdateUI(); end,
          default = false,
        },
        {
          type    = "editbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 9:",
          getFunc = function() return self.savedVariables.customMonitor9.SearchText end,
          setFunc = function(e) self.savedVariables.customMonitor9.SearchText = self:AdjustItemLink(e); self:UpdateUI(); end,
          default = '',
          disabled= function(e) return not self.savedVariables.customMonitor9.Show; end,
        },
        {
          type    = "checkbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 10:",
          getFunc = function() return self.savedVariables.customMonitor10.Show end,
          setFunc = function(e) self.savedVariables.customMonitor10.Show = e; PXInfoPanelAddon:UpdateUI() end,
          default = false,
        },
        {
          type    = "editbox",
          name    = GetString(PXIP_SETTINGS_CUSTOM_INVENTORY_MONITOR) .. " 10:",
          getFunc = function() return self.savedVariables.customMonitor10.SearchText end,
          setFunc = function(e) self.savedVariables.customMonitor10.SearchText = self:AdjustItemLink(e); self:UpdateUI(); end,
          default = '',
          disabled= function(e) return not self.savedVariables.customMonitor10.Show; end,
        },
      },
    },
  }

  LAM2:RegisterOptionControls(self.Name, optionsData)
end

function PXInfoPanelAddon:CheckDefaultSettingsAreApplied()
  if (self.savedVariables.allWritsDoneNotified == nil) then
    self.savedVariables.allWritsDoneNotified = self.DefaultSettings.allWritsDoneNotified
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.top == nil) then
    self.savedVariables.top = self.DefaultSettings.top
  end
  if (self.savedVariables.fontColor == nil) then
    self.savedVariables.fontColor = self.DefaultSettings.fontColor
  end
  if (self.savedVariables.fontScale == nil) then
    self.savedVariables.fontScale = self.DefaultSettings.fontScale
  end
  if (self.savedVariables.transparency == nil) then
    self.savedVariables.transparency = self.DefaultSettings.transparency
  end
  if (self.savedVariables.showTime == nil) then
    self.savedVariables.showTime = self.DefaultSettings.showTime
  end
  if (self.savedVariables.showLastLoot == nil) then
    self.savedVariables.showLastLoot = self.DefaultSettings.showLastLoot
  end
  if (self.savedVariables.showLastLootInChat == nil) then
    self.savedVariables.showLastLootInChat = self.DefaultSettings.showLastLootInChat
  end
  if (self.savedVariables.showLastLootAndGoldInChat == nil) then
    self.savedVariables.showLastLootAndGoldInChat = self.DefaultSettings.showLastLootAndGoldInChat
  end
  if (self.savedVariables.showLastLootTrait == nil) then
    self.savedVariables.showLastLootTrait = self.DefaultSettings.showLastLootTrait
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.left == nil) then
    self.savedVariables.left = self.DefaultSettings.left
  end
  if (self.savedVariables.showBestLoot == nil) then
    self.savedVariables.showBestLoot = self.DefaultSettings.showBestLoot
  end
  if (self.savedVariables.showBestLoot2 == nil) then
    self.savedVariables.showBestLoot2 = self.DefaultSettings.showBestLoot2
  end
  if (self.savedVariables.showBestLoot3 == nil) then
    self.savedVariables.showBestLoot3 = self.DefaultSettings.showBestLoot3
  end
  if (self.savedVariables.showBestLoot4== nil) then
    self.savedVariables.showBestLoot4 = self.DefaultSettings.showBestLoot4
  end
  if (self.savedVariables.showBestLoot5 == nil) then
    self.savedVariables.showBestLoot5 = self.DefaultSettings.showBestLoot5
  end
  if (self.savedVariables.showBestLootNotification == nil) then
    self.savedVariables.showBestLootNotification = self.DefaultSettings.showBestLootNotification
  end
  if (self.savedVariables.showMaterialInventory == nil) then
    self.savedVariables.showMaterialInventory = self.DefaultSettings.showMaterialInventory
  end
  if (self.savedVariables.showMaterialInventoryCondensed == nil) then
    self.savedVariables.showMaterialInventoryCondensed = self.DefaultSettings.showMaterialInventoryCondensed
  end
  if (self.savedVariables.showAchievements == nil) then
    self.savedVariables.showAchievements = self.DefaultSettings.showAchievements
  end
  if (self.savedVariables.showEnlightenedPool == nil) then
    self.savedVariables.showEnlightenedPool = self.DefaultSettings.showEnlightenedPool
  end
  if (self.savedVariables.showTotalMinutesPlayed == nil) then
    self.savedVariables.showTotalMinutesPlayed = self.DefaultSettings.showTotalMinutesPlayed
  end
  if (self.savedVariables.showTotalGoldMade == nil) then
    self.savedVariables.showTotalGoldMade = self.DefaultSettings.showTotalGoldMade
  end
  if (self.savedVariables.showTotalXPMade == nil) then
    self.savedVariables.showTotalXPMade = self.DefaultSettings.showTotalXPMade
  end
  if (self.savedVariables.showLastLoreBookLearned == nil) then
    self.savedVariables.showLastLoreBookLearned = self.DefaultSettings.showLastLoreBookLearned
  end
  if (self.savedVariables.showPVPInfo == nil) then
    self.savedVariables.showPVPInfo = self.DefaultSettings.showPVPInfo
  end
  if (self.savedVariables.showPVPInfoOnlyWhenInPVP == nil) then
    self.savedVariables.showPVPInfoOnlyWhenInPVP = self.DefaultSettings.showPVPInfoOnlyWhenInPVP
  end
  if (self.savedVariables.showPVPRank == nil) then
    self.savedVariables.showPVPRank = self.DefaultSettings.showPVPRank
  end
  if (self.savedVariables.showPVPQueueTimeWhenQueued == nil) then
    self.savedVariables.showPVPQueueTimeWhenQueued = self.DefaultSettings.showPVPQueueTimeWhenQueued
  end
  if (self.savedVariables.notifyOnLootAbove == nil) then
    self.savedVariables.notifyOnLootAbove = self.DefaultSettings.notifyOnLootAbove
  end
  if (self.savedVariables.playSoundOnNotifyOnLootAbove == nil) then
    self.savedVariables.playSoundOnNotifyOnLootAbove = self.DefaultSettings.playSoundOnNotifyOnLootAbove
  end
  if (self.savedVariables.notifyOnLoreBooks == nil) then
    self.savedVariables.notifyOnLoreBooks = self.DefaultSettings.notifyOnLoreBooks
  end
  if (self.savedVariables.showWritStatus == nil) then
    self.savedVariables.showWritStatus = self.DefaultSettings.showWritStatus
  end
  if (self.savedVariables.showWritStatusCondensed == nil) then
    self.savedVariables.showWritStatusCondensed = self.DefaultSettings.showWritStatusCondensed
  end
  if (self.savedVariables.showLevelProgress == nil) then
    self.savedVariables.showLevelProgress = self.DefaultSettings.showLevelProgress
  end
  if (self.savedVariables.showGrindStatus == nil) then
    self.savedVariables.showGrindStatus = self.DefaultSettings.showGrindStatus
  end
  if (self.savedVariables.showBiSLootNotifications == nil) then
    self.savedVariables.showBiSLootNotifications = self.DefaultSettings.showBiSLootNotifications
  end
  if (self.savedVariables.hideInfoPanelWhenViewInventory == nil) then
    self.savedVariables.hideInfoPanelWhenViewInventory = self.DefaultSettings.hideInfoPanelWhenViewInventory
  end
  if (self.savedVariables.showGroupLoot == nil) then
    self.savedVariables.showGroupLoot = self.DefaultSettings.showGroupLoot
  end
  if (self.savedVariables.lastLootLines == nil) then
    self.savedVariables.lastLootLines = self.DefaultSettings.lastLootLines
  end
  if (self.savedVariables.showAchievementProgressInChat == nil) then
    self.savedVariables.showAchievementProgressInChat = self.DefaultSettings.showAchievementProgressInChat
  end
end