--
-- HarmonyArena.lua
-- Copyright 2009 Johannes Rydh
--
-- HarmonyArena is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--

HarmonyArena = LibStub("AceAddon-3.0"):NewAddon("HarmonyArena",
	"AceConsole-3.0", "AceEvent-3.0");

function HarmonyArena:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New( "HarmonyArenaDB" );
	self:InitFrames();
end

function HarmonyArena:OnEnable()
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	self:RegisterEvent("PLAYER_ENTERED_WORLD", "ZONE_CHANGED_NEW_AREA");
end

function HarmonyArena:OnDisable()
	self:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
	self:UnregisterEvent("PLAYER_ENTERED_WORLD", "ZONE_CHANGED_NEW_AREA");
end

function HarmonyArena:ZONE_CHANGED_NEW_AREA()
	local _, type = IsInInstance();
	if( type == "arena" ) then
		self:Activate();
	elseif( type ~= "arena" and lastType == "arena" ) then
		self:Deactivate();
	end
	lastType = type;
end

function HarmonyArena:Activate()
	self:Print( "Activated" );
	self:RegisterEvent("UNIT_HEALTH", function(event,unit) self:UpdateHealth(unit); end );
	self.frame:Show();
end

function HarmonyArena:Deactivate()
	self:Print( "Deactivated" );
	self:UnregisterEvent("UNIT_HEALTH");
	self.frame:Hide();
end

-- Key bindings
_G["BINDING_HEADER_HARMONYARENA"] = "HarmonyArena";
_G["BINDING_NAME_CLICK HAFrame1:LeftButton"] = "Target Opponent 1";
_G["BINDING_NAME_CLICK HAFrame2:LeftButton"] = "Target Opponent 2";
_G["BINDING_NAME_CLICK HAFrame3:LeftButton"] = "Target Opponent 3";
_G["BINDING_NAME_CLICK HAFrame4:LeftButton"] = "Target Opponent 4";
_G["BINDING_NAME_CLICK HAFrame5:LeftButton"] = "Target Opponent 5";
_G["BINDING_NAME_CLICK HAFrame1:RightButton"] = "Focus Opponent 1";
_G["BINDING_NAME_CLICK HAFrame2:RightButton"] = "Focus Opponent 2";
_G["BINDING_NAME_CLICK HAFrame3:RightButton"] = "Focus Opponent 3";
_G["BINDING_NAME_CLICK HAFrame4:RightButton"] = "Focus Opponent 4";
_G["BINDING_NAME_CLICK HAFrame5:RightButton"] = "Focus Opponent 5";
