local mod = LibStub("AceAddon-3.0"):GetAddon("Sexy Reputations")
local L = LibStub("AceLocale-3.0"):GetLocale("SexyReputation", false)
local R = LibStub("AceConfigRegistry-3.0")
local C = LibStub("AceConfigDialog-3.0")
local DBOpt = LibStub("AceDBOptions-3.0")

function mod:SetProfileParam(var, value)
   local varName = var[#var]
   mod.db.global[varName] = value
end

function mod:GetProfileParam(var) 
   local varName = var[#var]
   return mod.db.global[varName]
end
mod.STYLE_BAR = 1
mod.STYLE_TEXT = 2
mod.STYLE_NONE = 3
mod.TEXT_STYLE_STANDING = 1
mod.TEXT_STYLE_REPUTATION = 2
mod.TEXT_STYLE_BOTH = 3


mod.defaults = {
   char = {
      factionHistory = {}, -- the gains of faction, per day
      hf = {}
   },
   global = {
      factionLookup = {},
      colorFactions = true,
      showStanding = false,
      showRep = false,
      showPercentage = true,
      showTooltips = true,
      showOnlyChanged = false,
      showGains = true,
      repTextStyle = mod.TEXT_STYLE_BOTH,
      repStyle = mod.STYLE_BAR,
   }
}

mod.options = {
   type = "group",
   name = L["Sexy Reputations"],
   handler = mod,
   set = "SetProfileParam",
   get = "GetProfileParam",
   args = {
      repTextStyle = {
	 type = "select",
	 values = {
	    L["Standing Only"], L["Reputation Only"], L["Both Standing and Reputation"]
	 },
	 name = L["Text Reputation Style"],
	 desc = L["Whether to show the standing and/or reputation level text."],
	 order = 200,
	 disabled = function() return mod.gdb.repStyle ~= mod.STYLE_TEXT end,
      },
      colorFactions = {
	 type = "toggle",
	 name = L["Color Text"],
	 desc = L["Color standing and reputation fields based on your standing with the different factions."],
	 order = 300, 
	 disabled = function() return mod.gdb.repStyle ~= mod.STYLE_TEXT end,
      },
      repStyle = {
	 type = "select",
	 values = {
	    L["Bar"], L["Text"],  L["None"]
	 },
	 order = 100, 
	 name = L["Standing Style"],
	 desc = L["Whether to show the reputation level as a bar, text or not at all"], 
      },
      showPercentage = {
	 type = "toggle",
	 name = L["Show Percentage"],
	 desc = L["Show your rep as a percentage of the reputation standing (i.e Neutral 1500/3000 = 50%)"], 
      },
      showGains = {
	 type = "toggle",
	 name = L["Show Gains"],
	 desc = L["Show reputation gained or lost in the session and today."],
      },
      showOnlyChanged = {
	 type = "toggle",
	 name = L["Active Factions Only"],
	 desc = L["Only show factions with recent reputation changes."],
      },
   }
}
