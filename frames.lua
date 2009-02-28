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

function HarmonyArena:InitFrames()
	if self.frame then return; end

	local width = 132;
	local height = 32;

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
		
		-- for testing...
		f.unit = "arena"..i;
		self.frames[f.unit] = f;
		
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
		
		f.health = CreateFrame( "Frame", nil, f );
		f.health:SetPoint( "TOPRIGHT", f, "TOPRIGHT", 0, -5 );
		f.health:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 5 );
		f.health:SetWidth(1);
		f.health.bg = f.health:CreateTexture( nil, "ARTWORK" );
		f.health.bg:SetAllPoints( f.health );
		f.health.bg:SetTexture( 0.5, 0.5, 0.5 );
		
		f.spec = CreateFrame( "Frame", nil, f );
		f.spec:SetPoint( "TOPLEFT", f, "TOPRIGHT", 5, 0 );
		f.spec:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", 5+1.5*height, 0 );
		f.spec.bg = f.spec:CreateTexture( nil, "BACKGROUND" );
		f.spec.bg:SetAllPoints( f.spec );
		f.spec.bg:SetTexture( 0, 0, 0 );
		f.spec.text1 = f.spec:CreateFontString( nil, "OVERLAY", "GameFontNormalSmall" );
		f.spec.text1:SetPoint( "CENTER", f.spec, "CENTER", 0, 8 )
		f.spec.text2 = f.spec:CreateFontString( nil, "OVERLAY", "GameFontNormalSmall" );
		f.spec.text2:SetPoint( "CENTER", f.spec, "CENTER", 0, -8 )
		
		f:SetScript( "OnShow",
			function( self ) HarmonyArena:InitUnitFrame( self ); end );
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
		local _, class = UnitClass( unit );
		local color = RAID_CLASS_COLORS[ class ];
		frame.text:SetTextColor( color.r, color.g, color.b );
		frame.health.bg:SetTexture( color.r, color.g, color.b );
		frame.icon:SetTexture( classIcons[ class ] );
		self:UpdateHealth( unit );
	end
end

function HarmonyArena:UpdateHealth( unit )
	local frame = self.frames[unit];
	if frame then
		local name = UnitName( unit );
		local health = floor( 100 * UnitHealth( unit ) / UnitHealthMax( unit ) + 0.5 );
		frame.text:SetText( health.."%" );
		frame.health:SetWidth( max( 1, 100 - health ) );
		local s = (health == 0) and "D E A D" or (name.." ("..health.."%)");
		frame.text:SetText( s );
	end
end

function HarmonyArena:SetSpec( unit, desc, s1, s2, s3 )
	local frame = self.frames[unit];
	if frame then
		frame.spec.text1:SetText( desc );
		frame.spec.text2:SetText( string.format( "%d/%d/%d", s1, s2, s3 ) );
	end
end
