--
-- frames.lua
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

local width = 132;
local height = 32;

function HarmonyArena:InitFrames()
	if self.frame then return; end

	-- main
	local mf = CreateFrame( "Frame", "HarmonyArenaFrame", UIParent );
	self.frame = mf;
	mf:SetFrameLevel(1);
	mf:SetWidth( width );
	mf:SetHeight( height * 5 );
	mf:SetMovable( true );
	mf:Hide();
	if not mf:GetLeft() then mf:SetPoint( "CENTER" ); end
	
	-- title
	local tf = CreateFrame( "Button", nil, mf );
	tf:SetPoint( "TOPLEFT", mf, "TOPLEFT", 0, 20 );
	tf:SetPoint( "BOTTOMRIGHT", mf, "TOPRIGHT", 0, 0 );
	tf:EnableMouse( true );
	tf:SetScript( "OnMouseDown", function() mf:StartMoving(); end );
	tf:SetScript( "OnMouseUp", function() mf:StopMovingOrSizing(); end );
	
	local title = tf:CreateFontString( nil, "ARTWORK", "GameFontHighlight" );
	title:SetAllPoints( tf );
	title:SetText( "Harmony Arena" );
	
	-- unit frames
	self.frames = {};
	for i = 1,5 do
		local f = CreateFrame( "Button", "HAFrame"..i, self.frame, "SecureUnitButtonTemplate" );
		f.index = i;
		
		f.unit = ( i == 1 and "target" or "arena"..i );
--		f.unit = "arena"..i;
		self.frames[ f.unit ] = f;
		
		f:SetAttribute( "unit", f.unit );
		f:SetAttribute( "type1", "target" );
		f:SetAttribute( "type2", "focus" );
		f:RegisterForClicks( "LeftButtonDown", "RightButtonDown" );
		RegisterUnitWatch( f );
		
		f:SetPoint( "TOPLEFT", mf, "TOPLEFT", 0, -(i-1)*height );
		f:SetPoint( "BOTTOMRIGHT", mf, "TOPRIGHT", 0, -i*height );
		
		f.icon = f:CreateTexture( nil, "BACKGROUND" );
		f.icon:SetTexture( 0.5, 0.5, 0.5 );
		f.icon:SetPoint( "TOPLEFT", f, "TOPLEFT" );
		f.icon:SetPoint( "BOTTOMRIGHT", f, "BOTTOMLEFT", height, 0 );
		
		f.status = f:CreateTexture( nil, "BACKGROUND" );
		f.status:SetPoint( "TOPLEFT", f, "TOPLEFT", height, 0 );
		f.status:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0 );
		f.status:SetTexture( 0, 0, 0 );
		
		f.text = f:CreateFontString( nil, "OVERLAY", "GameFontNormal" );
		f.text:SetAllPoints( f.status );
		
		f.health = f:CreateTexture( nil, "ARTWORK" );
		f.health:SetPoint( "TOPRIGHT", f, "TOPRIGHT", 0, -5 );
		f.health:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 5 );
		f.health:SetWidth(1);
		f.health:SetTexture( 0.5, 0.5, 0.5 );
		
		f.spec = f:CreateTexture( nil, "BACKGROUND" );
		f.spec:SetPoint( "TOPLEFT", f, "TOPRIGHT", 5, 0 );
		f.spec:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", 5+1.5*height, 0 );
		f.spec:SetTexture( 0, 0, 0 );
		f.spec.text1 = f:CreateFontString( nil, "OVERLAY", "GameFontHighlightSmall" );
		f.spec.text1:SetPoint( "CENTER", f.spec, "CENTER", 0, 8 )
		f.spec.text2 = f:CreateFontString( nil, "OVERLAY", "GameFontHighlightSmall" );
		f.spec.text2:SetPoint( "CENTER", f.spec, "CENTER", 0, -8 )
		
		f.pvp = f:CreateTexture( nil, "BACKGROUND" );
		f.pvp:SetPoint( "TOPLEFT", f.spec, "TOPRIGHT", 5, 0 );
		f.pvp:SetPoint( "BOTTOMRIGHT", f.spec, "BOTTOMRIGHT", 5+height, 0 );
		f.pvp:SetTexture( "Interface\\Icons\\INV_Jewelry_Necklace_37" );
		
		f.aura = f:CreateTexture( nil, "BACKGROUND" );
		f.aura:SetTexture( 0.5, 0.5, 0.5 );
		f.aura:SetPoint( "TOPLEFT", f, "TOPLEFT", -height-10, 0 );
		f.aura:SetPoint( "BOTTOMRIGHT", f, "BOTTOMLEFT", -10, 0 );
		f.aura:Hide();
		
		f.auradur = f:CreateFontString( nil, "ARTWORK", "GameFontRedLarge" );
		f.auradur:SetPoint( "CENTER", f.aura, "CENTER", 0, -8 );
		f.auradur:Hide();
		
		f.drbar = f:CreateTexture( nil, "BACKGROUND" );
		f.drbar:SetPoint( "BOTTOMRIGHT", f, "BOTTOMLEFT", -2, 0 );
		f.drbar:SetPoint( "BOTTOMLEFT", f, "BOTTOMLEFT", -7, 0 );
		f.drbar:SetTexture( 0.5, 0.5, 0.5 );
		f.drbar:SetHeight( 0.5*height );
		f.drbar:Hide();
		
		f:SetScript( "OnShow",
			function( self ) HarmonyArena:InitUnitFrame( self ); end );
		f:SetScript( "OnUpdate",
			function( self ) HarmonyArena:UpdateUnitFrame( self ); end );
	end
end

local classIcons = {
	["DEATHKNIGHT"] = "Interface\\Icons\\Spell_Deathknight_ClassIcon",
	["DRUID"] = "Interface\\Icons\\INV_Misc_MonsterClaw_04",
	["HUNTER"] = "Interface\\Icons\\INV_Weapon_Bow_07",
	["MAGE"] = "Interface\\Icons\\INV_Staff_13",
	["PALADIN"] = "Interface\\Addons\\HarmonyArena\\Images\\paladin",
	["PRIEST"] = "Interface\\Icons\\INV_Staff_30",
	["ROGUE"] = "Interface\\Addons\\HarmonyArena\\Images\\rogue",
	["SHAMAN"] = "Interface\\Icons\\Spell_Nature_BloodLust", 
	["WARLOCK"] = "Interface\\Icons\\Spell_Nature_FaerieFire",
	["WARRIOR"] = "Interface\\Icons\\INV_Sword_27",
};

function HarmonyArena:InitUnitFrame( frame )
	local unit = frame.unit;
	if UnitExists( unit ) then
		local guid = UnitGUID( unit );
		self.unit[ guid ] = unit;
		local _, class = UnitClass( unit );
		local color = RAID_CLASS_COLORS[ class ];
		frame.text:SetTextColor( color.r, color.g, color.b );
		frame.health:SetTexture( color.r, color.g, color.b );
		frame.icon:SetTexture( classIcons[ class ] );
		self:UNIT_HEALTH( nil, unit );
		self.db.global.talents[ guid ] = self.db.global.talents[ guid ] or { 0, 0, 0 };
		self:UpdateSpec( unit, guid );
	end
end

function HarmonyArena:UpdateUnitFrame( frame )
	self:UpdateAuraDuration( frame );
	self:UpdateDR( frame );
	self:UpdatePvPTrinket( frame );
end

function HarmonyArena:UNIT_HEALTH( event, unit )
	local frame = self.frames[unit];
	if frame then
		local health = floor( 100 * UnitHealth( unit ) / UnitHealthMax( unit ) + 0.5 );
		local name = UnitName( unit );
		frame.health:SetWidth( max( 1, 100 - health ) );
		local s = (health == 0) and "D E A D" or (name.." ("..health.."%)");
		frame.text:SetText( s );
	end
end

function HarmonyArena:PvPTrinketUsed( guid )
	local unit = self.unit[ guid ];
	local frame = unit and self.frames[ unit ];
	if frame then
		frame.pvp.time = GetTime() + 120.0;
		frame.pvp:Hide();
	end
end

function HarmonyArena:UpdatePvPTrinket( frame )
	local time = frame.pvp.time;
	if time and time < GetTime() then
		frame.pvp.time = nil;
		frame.pvp:Show();
	end
end
