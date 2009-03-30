--
-- auras.lua
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

local auras = {
	-- [name] = { priority, DR category }

	-- buffs
	["Adrenaline Rush"]        = { 1, 0 },
	["Berserk"]                = { 1, 0 },
	["Berserker Rage"]         = { 1, 0 },
	["Blessing of Freedom"]    = { 1, 0 },
	["Bloodlust"]              = { 10, 0 },
	["Divine Plea"]            = { 10, 0 },
	["Fel Domination"]         = { 100, 0 },
	["Heroism"]                = { 10, 0 },
	["Innervate"]              = { 10, 0 },
	["Pain Suppression"]       = { 10, 0 },
	["Refreshment"]            = { 100, 0 }, -- mage food
	["Drink"]                  = { 100, 0 }, -- arena water
	
	-- roots
	["Entangling Roots"]       = { 1, 1 },
	["Frost Nova"]             = { 1, 1 },
	
	-- silences
	["Improved Counterspell"]  = { 20, 2 },
	["Improved Kick"]          = { 20, 2 },
	["Silence"]                = { 20, 2 },
	["Silencing Shot"]         = { 20, 2 },
	["Spell Lock"]             = { 20, 2 },
	["Strangulate"]            = { 20, 2 },
	
	-- disarms
	["Chimera Shot - Scorpid"] = { 1, 3 },
	["Disarm"]                 = { 1, 3 },
	["Dismantle"]              = { 1, 3 },
	
	-- stun
	["Bash"]                   = { 20, 4 },
	["Charge"]                 = { 20, 4 },
	["Concussion Blow"]        = { 20, 4 },
	["Deep Freeze"]            = { 20, 4 },
	["Gnaw"]                   = { 20, 4 },
	["Hammer of Justice"]      = { 20, 4 },
	["Intercept"]              = { 20, 4 },
	["Kidney Shot"]            = { 20, 4 },
	["Maim"]                   = { 20, 4 },
	["Shadowfury"]             = { 20, 4 },
	["Shockwave"]              = { 20, 4 },
	
	-- cheap shot
	["Cheap Shot"]             = { 20, 5 },
	["Pounce"]                 = { 20, 5 },
	
	-- gouge/polymorph/sap
	["Hungering Cold"]         = { 20, 6 },
	["Polymorph"]              = { 20, 6 },
	["Gouge"]                  = { 20, 6 },
	["Hex"]                    = { 20, 6 },
	["Repentance"]             = { 20, 6 },
	["Sap"]                    = { 20, 6 },
	
	-- blind/cylone
	["Blind"]                  = { 20, 7 },
	["Cyclone"]                = { 20, 7 },
	
	-- sleep
	["Hibernate"]              = { 20, 8 },
	["Wyvern Sting"]           = { 20, 8 },

	-- fear
	["Fear"]                   = { 20, 9 },
	["Howl of Terror"]         = { 20, 9 },
	["Intimidating Shout"]     = { 20, 9 },
	["Psychic Scream"]         = { 20, 9 },
	["Scare Beast"]            = { 20, 9 },
	["Seduction"]              = { 20, 9 },

	-- horror
	["Death Coil"]             = { 20, 10 },
	["Psychic Horror"]         = { 20, 10 },

	-- banish
	["Banish"]                 = { 20, 11 },
	
	-- mind control
	["Mind Control"]           = { 20, 12 },
	
	-- misc not on DR
	["Scatter Shot"]           = { 20, 0 },
	["Freezing Trap Effect"]   = { 20, 0 },
	["Freezing Arrow Effect"]  = { 20, 0 },
	
	-- feign death
	["Feign Death"]            = { 30, 0 },
	
	-- pseudoimmunities
	["Cheating Death"]         = { 50, 0 },
	["Cloak of Shadows"]       = { 50, 0 },
	["Evasion"]                = { 50, 0 },
	["The Beast Within"]       = { 50, 0 },
	["Divine Protection"]      = { 50, 0 },
	["Hand of Protection"]     = { 100, 0 },
	
	-- immunities
	["Divine Shield"]          = { 200, 0 },
	["Ice Block"]              = { 200, 0 },
};

function HarmonyArena:UNIT_AURA( event, unit )
	local frame = self.frames[ unit ];
	if frame and UnitIsPlayer( unit ) then
		local prio, icon, expTime = -1, nil, nil;
		for i = 1,40 do
			local name, _, icon_, _, _, _, expTime_ = UnitBuff( unit, i );
			if not name then break; end
			local aura = auras[name];
			if aura and aura[1] >= prio then
				icon, expTime, prio = icon_, expTime_, aura[1];
			end
		end
		for i = 1,40 do
			local name, _, icon_, _, _, _, expTime_ = UnitDebuff( unit, i );
			if not name then break; end
			local aura = auras[name];
			if aura and aura[1] >= prio then
				icon, expTime, prio = icon_, expTime_, aura[1];
			end
		end
		local flash = prio >= 100;
		self:SetAura( unit, icon, expTime, flash );
	end
end

function HarmonyArena:SetAura( unit, icon, expTime, flash )
	local frame = self.frames[unit];
	if frame then
		frame.auradur.expTime = expTime;
		frame.auradur.flash = flash;
		frame.aura:SetTexture( icon );
		if icon then
			frame.aura:Show();
			frame.auradur:Show();
		else
			frame.aura:Hide();
			frame.auradur:Hide();
		end
		if not flash then
			frame.status:SetTexture( 0, 0, 0 );
			frame.spec:SetTexture( 0, 0, 0 );
		end
	end
end

function HarmonyArena:UpdateAuraDuration( frame )
	if frame.auradur.expTime then
		local dur = frame.auradur.expTime - GetTime();
		if dur < 5 then
			frame.auradur:SetText( string.format( "%2.1f", dur ) );
		else
			frame.auradur:SetText( string.format( "%2.0f", dur ) );
		end
		
		-- flash red if important
		if frame.auradur.flash then
			local t = GetTime();
			t = sin( (t-floor(t))*360 );
			frame.status:SetTexture( 0.8 + t*0.2, 0, 0 );
			frame.spec:SetTexture( 0.8 + t*0.2, 0, 0 );
		end
	end
end


-- Diminishing returns

function HarmonyArena:AuraApplied( ability, source, target )
	local unit = self.unit[ target ];
	local frame = unit and self.frames[ unit ];

	local aura = auras[ ability ];
	if frame and aura then
		local _, dr = unpack( aura );
		if dr > 0 then
			local info = frame.drbar.info;
			info[ dr ] = info[ dr ] or { n = 0 };
			info[ dr ].n = info[ dr ].n + 1;
			info[ dr ].time = 0;
			if source == UnitGUID( "player" ) then
				frame.drbar.active = dr;
			end
		end
	end
end

function HarmonyArena:AuraRemoved( ability, target )
	local unit = self.unit[ target ];
	local frame = unit and self.frames[ unit ];

	local aura = auras[ ability ];
	if frame and aura then
		local _, dr = unpack( aura );
		if dr > 0 then
			frame.drbar.info[ dr ].time = GetTime() + 15.0;
		end
	end
end

local dr_colors = {
	{ 0, 0.6, 0 },
	{ 0.7, 0.7, 0 },
	{ 0.7, 0, 0 }
};
function HarmonyArena:UpdateDR( frame )
	local dr = frame.drbar.active;
	if dr then
		local info = frame.drbar.info[ dr ];
		n = ( info.n > 3 and 3 or info.n );
		if n > 0 then
			local c = dr_colors[n];
			frame.drbar:SetTexture( c[1], c[2], c[3] );
			local dur = info.time - GetTime();
			if info.time == 0 then
				-- aura is still active
				frame.drbar:SetHeight( frame:GetHeight() );
				frame.drbar:Show();
			elseif dur > 0 then
				-- aura has ended, start timer
				local height = ceil( frame:GetHeight()*dur/15.0 );
				frame.drbar:SetHeight( height );
				frame.drbar:Show();
			else
				-- timer has ran out
				frame.drbar.info = {};
				frame.drbar.active = nil;
				frame.drbar:Hide();
			end
		end
	end
end
