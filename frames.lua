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
	
	-- title
	local tf = CreateFrame( "Button", nil, mf );
	tf:SetPoint( "TOPLEFT", mf, "TOPLEFT", 0, 20 );
	tf:SetPoint( "BOTTOMRIGHT", mf, "TOPRIGHT", 0, 0 );
	tf:EnableMouse( true );
	tf:RegisterForDrag( "LeftButton" );
	tf:SetScript( "OnMouseDown", function() mf:StartMoving(); end );
	tf:SetScript( "OnMouseUp", function() mf:StopMovingOrSizing(); self:SavePosition(); end );
	tf:RegisterForClicks( "LeftButtonDown", "LeftButtonUp" );
	
	local title = tf:CreateFontString( nil, "ARTWORK", "GameFontHighlight" );
	title:SetAllPoints( tf );
	title:SetText( "Harmony Arena" );
	
	if not self.db.profile.position then
		self.db.profile.position = {};
		mf:SetPoint( "CENTER", UIParent );
		self:SavePosition();
	else
		local pos = self.db.profile.position;
		mf:SetPoint( pos.point, UIParent, pos.relPoint, pos.x, pos.y );
	end
	
	-- unit frames
	self.frames = {};
	for i = 1,5 do
		local f = CreateFrame( "Button", "HAFrame"..i, self.frame, "SecureUnitButtonTemplate" );
		f.index = i;
		
		f.unit = "arena"..i;
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
		
		f.pet = CreateFrame( "Button", "HAPetFrame"..i, f, "SecureUnitButtonTemplate" );
		f.pet.unit = f.unit.."pet";
		self.frames[ f.pet.unit ] = f.pet;
		f.pet:SetAttribute( "unit", f.pet.unit );
		f.pet:SetAttribute( "type1", "target" );
		f.pet:SetAttribute( "type2", "focus" );
		f.pet:RegisterForClicks( "LeftButtonDown", "RightButtonDown" );
		RegisterUnitWatch( f.pet );
		f.pet:SetPoint( "TOPLEFT", f, "TOPRIGHT", 5, 0 );
		f.pet:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", 5+1.5*height, 0 );
		f.pet.text1 = f.pet:CreateFontString( nil, "BACKGROUND", "GameFontHighlightSmall" );
		f.pet.text1:SetPoint( "CENTER", f.pet, "CENTER", 0, 8 );
		f.pet.text1:SetText( "PET" );
		f.pet.text2 = f.pet:CreateFontString( nil, "BACKGROUND", "GameFontHighlightSmall" );
		f.pet.text2:SetPoint( "CENTER", f.pet, "CENTER", 0, -8 );
		f.pet.text2:SetText( "100%" );
		f.pet.bg = f.pet:CreateTexture( nil, "BACKGROUND" );
		f.pet.bg:SetAllPoints( f.pet );
		f.pet.bg:SetTexture( 0, 0, 0 );
		
		f.spec = f:CreateTexture( nil, "BACKGROUND" );
		f.spec:SetPoint( "TOPLEFT", f.pet, "TOPRIGHT", 5, 0 );
		f.spec:SetPoint( "BOTTOMRIGHT", f.pet, "BOTTOMRIGHT", 5+1.5*height, 0 );
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
		f.drbar:SetPoint( "TOPRIGHT", f, "TOPLEFT", -2, 0 );
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

function HarmonyArena:SavePosition()
	local point, _, relPoint, x, y = self.frame:GetPoint();
	self.db.profile.position.point = point;
	self.db.profile.position.relPoint = relPoint;
	self.db.profile.position.x = math.floor(x);
	self.db.profile.position.y = math.floor(y);
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
--	self:UpdateDR( frame );
	self:UpdatePvPTrinket( frame );
end

function HarmonyArena:UNIT_HEALTH( event, unit )
	local frame = self.frames[unit];
	if frame then
		local health = floor( 100 * UnitHealth( unit ) / UnitHealthMax( unit ) + 0.5 );
		if UnitIsPlayer( unit ) then
			local name = UnitName( unit );
			frame.health:SetWidth( max( 1, 100 - health ) );
			local s = (health == 0) and "D E A D" or (name.." ("..health.."%)");
			frame.text:SetText( s );
		else -- pet
			local s = (health == 0) and "DEAD" or (health.."%");
			frame.pet.text2:SetText( s );
		end
	end
end

function HarmonyArena:PvPTrinketUsed( guid )
	local frame = self.frames[ guid ];
	if frame then
		frame.pvp:Hide();
		frame.pvp.time = GetTime() + 120.0;
	end
end

function HarmonyArena:UpdatePvPTrinket( frame )
	local time = frame.pvp.time;
	if time and time > GetTime() then
		frame.pvp.time = nil;
		frame.pvp:Show();
	end
end
