--
-- options.lua
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

local function HarmonyArena_DRDropDownClick( button )
	UIDropDownMenu_SetSelectedValue( button.owner, button.value );
end

local categories = { "Disabled", "Root", "Silence", "Disarm", "Stun",
	"Cheap Shot/Pounce", "Gouge/Polymorph/Sap", "Cyclone", "Sleep", "Blind/Fear/Seduce",
	"Horror", "Banish", "Mind Control" };

local function HarmonyArena_InitializeDRDropDown( frame )
	local info = UIDropDownMenu_CreateInfo();
	for i,cat in ipairs( categories ) do
		info.text = cat;
		info.value = i-1;
		info.func = HarmonyArena_DRDropDownClick;
		info.owner = frame;
		info.checked = ( UIDropDownMenu_GetSelectedValue( frame ) == i-1 );
		UIDropDownMenu_AddButton( info, 1 );
	end
end

function HarmonyArena:SetupOptions( defaults )
	if self.optionsFrame then return; end
	
	local f = CreateFrame( "Frame", "HarmonyArenaOptionsFrame" );
	self.optionsFrame = f;
	
	local text = f:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" );
	text:SetPoint( "TOPLEFT", 16, -16 );
	text:SetText( "HarmonyArena" );

	local subtext = f:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
	subtext:SetHeight( 32 );
	subtext:SetPoint( "TOPLEFT", text, "BOTTOMLEFT", 0, -8 );
	subtext:SetPoint( "RIGHT", f, -32, 0 );
	subtext:SetNonSpaceWrap( true );
	subtext:SetJustifyH( "LEFT" );
	subtext:SetJustifyV( "TOP" );
	subtext:SetText( "Arena unitframes" );
	
	local function CreateDropdown( i, xd, yd )
		local s = f:CreateFontString( nil, "ARTWORK", "GameFontNormal" );
		s:SetText( "DR timer "..i.." category" );
		s:SetPoint( "TOPLEFT", f, "TOPLEFT", xd, yd );
		
		local d = CreateFrame( "Button", "HarmonyArenaDRDropdown"..i, f, "UIDropDownMenuTemplate" );
		d:SetWidth( 128 );
		d:SetHeight( 16 );
		UIDropDownMenu_Initialize( d, HarmonyArena_InitializeDRDropDown );
		d:SetScript( "OnClick", function( self )
			ToggleDropDownMenu( 1, nil, self, self, 0, 0 );
		end );
		d:SetPoint( "LEFT", s, "LEFT", 125, 0 );
		
		return d;
	end

	local drcat1 = CreateDropdown( 1, 16, -72 );
	local drcat2 = CreateDropdown( 2, 16, -102 );

	f.name = "HarmonyArena";
	f.okay = function()
		self.db.global.dr1 = UIDropDownMenu_GetSelectedValue( drcat1 );
		self.db.global.dr2 = UIDropDownMenu_GetSelectedValue( drcat2 );
	end;
	f.default = function()
		UIDropDownMenu_SetSelectedValue( drcat1, 0 );
		UIDropDownMenu_SetSelectedValue( drcat2, 0 );
	end
	f.cancel = function()
		UIDropDownMenu_SetSelectedValue( drcat1, self.db.global.dr1 );
		UIDropDownMenu_SetSelectedValue( drcat2, self.db.global.dr2 );
	end;
	f.cancel();
	InterfaceOptions_AddCategory( f );
	
	SLASH_HARMONYARENA1 = "/ha";
	SLASH_HARMONYARENA2 = "/harmonyarena";
	SlashCmdList["HARMONYARENA"] = function()
		InterfaceOptionsFrame_OpenToCategory( f );
	end;
end
