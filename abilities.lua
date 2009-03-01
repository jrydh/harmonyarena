--
-- abililies.lua
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

local abilities = {
	-- Deathknight
	["Rune Tap"]                 = { 11, 0, 0 },
	["Mark of Blood"]            = { 21, 0, 0 },
	["Hysteria"]                 = { 31, 0, 0 },
	["Vampiric Blood"]           = { 36, 0, 0 },
	["Heart Strike"]             = { 41, 0, 0 },
	["Dancing Rune Weapon"]      = { 51, 0, 0 },
	["Lichborne"]                = { 0, 11, 0 },
	["Deathchill"]               = { 0, 21, 0 },
	["Howling Blast"]            = { 0, 31, 0 },
	["Unbreakable Armor"]        = { 0, 36, 0 },
	["Frost Strike"]             = { 0, 41, 0 },
	["Hungering Cold"]           = { 0, 51, 0 },
	["Corpse Explosion"]         = { 0, 0, 11 },
	["Summon Gargoyle"]          = { 0, 0, 21 },
	["Anti-Magic Zone"]          = { 0, 0, 31 },
	["Bone Shield"]              = { 0, 0, 36 },
	["Scourge Strike"]           = { 0, 0, 41 },
	["Unholy Blight"]            = { 0, 0, 51 },
	
	-- Druid
	["Insect Swarm"]             = { 21, 0, 0 },
	["Moonkin Form"]             = { 31, 0, 0 },
	["Force of Nature"]          = { 41, 0, 0 },
	["Typhoon"]                  = { 41, 0, 0 },
	["Starfall"]                 = { 51, 0, 0 },
	["Survival Instincts"]       = { 0, 11, 0 },
	["Feral Charge"]             = { 0, 21, 0 },
	["Leader of the Pack"]       = { 0, 31, 0 },
	["Mangle - Cat"]             = { 0, 41, 0 },
	["Mangle - Bear"]            = { 0, 41, 0 },
	["Berserk"]                  = { 0, 51, 0 },
	["Nature's Swiftness"]       = { 0, 0, 21 },
	["Swiftmend"]                = { 0, 0, 31 },
	["Tree of Life"]             = { 0, 0, 41 },
	["Wild Growth"]              = { 0, 0, 51 },
	
	-- Hunter
	["Intimidation"]             = { 21, 0, 0 },
	["Bestial Wrath"]            = { 31, 0, 0 },
	["The Beast Within"]         = { 41, 0, 0 },
	["Aimed Shot"]               = { 0, 11, 0 },
	["Readiness"]                = { 0, 21, 0 },
	["Trueshot Aura"]            = { 0, 31, 0 },
	["Silencing Shot"]           = { 0, 41, 0 },
	["Chimera Shot"]             = { 0, 51, 0 },
	["Scatter Shot"]             = { 0, 0, 11 },
	["Counterattack"]            = { 0, 0, 21 },
	["Wyvern Sting"]             = { 0, 0, 31 },
	["Explosive Shot"]           = { 0, 0, 51 },
	
	-- Mage
	["Focus Magic"]              = { 11, 0, 0 },
	["Presence of Mind"]         = { 21, 0, 0 },
	["Arcane Power"]             = { 31, 0, 0 },
	["Slow"]                     = { 41, 0, 0 },
	["Arcane Barrage"]           = { 51, 0, 0 },
	["Pyroblast"]                = { 0, 11, 0 },
	["Blast Wave"]               = { 0, 21, 0 },
	["Combustion"]               = { 0, 31, 0 },
	["Dragon's Breath"]          = { 0, 41, 0 },
	["Living Bomb"]              = { 0, 51, 0 },
	["Icy Veins"]                = { 0, 0, 11 },
	["Cold Snap"]                = { 0, 0, 21 },
	["Ice Barrier"]              = { 0, 0, 31 },
	["Summon Water Elemental"]   = { 0, 0, 41 },
	["Deep Freeze"]              = { 0, 0, 51 },
	
	-- Paladin
	["Divine Favor"]             = { 21, 0, 0 },
	["Holy Shock"]               = { 31, 0, 0 },
	["Divine Illumination"]      = { 41, 0, 0 },
	["Beacon of Light"]          = { 51, 0, 0 },
	["Blessing of Kings"]        = { 0, 1, 0 },
	["Blessing of Sanctuary"]    = { 0, 21, 0 },
	["Holy Shield"]              = { 0, 31, 0 },
	["Avenger's Shield"]         = { 0, 41, 0 },
	["Hammer of the Righteous"]  = { 0, 51, 0 },
	["Seal of Command"]          = { 0, 0, 11 },
	["Repentence"]               = { 0, 0, 31 },
	["Crusader Strike"]          = { 0, 0, 41 },
	["Divine Storm"]             = { 0, 0, 51 },
	
	-- Priest
	["Inner Focus"]              = { 11, 0, 0 },
	["Divine Spirit"]            = { 21, 0, 0 },
	["Power Infusion"]           = { 31, 0, 0 },
	["Pain Suppression"]         = { 41, 0, 0 },
	["Penance"]                  = { 51, 0, 0 },
	["Desperate Prayer"]         = { 0, 11, 0 },
	["Spirit of Redemption"]     = { 0, 21, 0 },
	["Lightwell"]                = { 0, 31, 0 },
	["Circle of Healing"]        = { 0, 41, 0 },
	["Guardian Spirit"]          = { 0, 51, 0 },
	["Mind Flay"]                = { 0, 0, 11 },
	["Silence"]                  = { 0, 0, 21 },
	["Vampiric Embrace"]         = { 0, 0, 21 },
	["Shadowform"]               = { 0, 0, 31 },
	["Vampiric Touch"]           = { 0, 0, 41 },
	["Dispersion"]               = { 0, 0, 51 },
	
	-- Rogue
	["Cold Blood"]               = { 21, 0, 0 },
	["Mutilate"]                 = { 41, 0, 0 },
	["Hunger for Blood"]         = { 51, 0, 0 },
	["Riposte"]                  = { 0, 11, 0 },
	["Blade Flurry"]             = { 0, 21, 0 },
	["Adrenaline Rush"]          = { 0, 31, 0 },
	["Surprise Attacks"]         = { 0, 41, 0 },
	["Killing Spree"]            = { 0, 51, 0 },
	["Ghostly Strike"]           = { 0, 0, 11 },
	["Preparation"]              = { 0, 0, 21 },
	["Hemorrhage"]               = { 0, 0, 21 },
	["Premeditation"]            = { 0, 0, 31 },
	["Cheating Death"]           = { 0, 0, 31 },
	["Shadowstep"]               = { 0, 0, 41 },
	["Shadow Dance"]             = { 0, 0, 51 },
	
	-- Shaman
	["Elemental Mastery"]        = { 31, 0, 0 },
	["Totem of Wrath"]           = { 41, 0, 0 },
	["Thunderstorm"]             = { 51, 0, 0 },
	["Unleashed Rage"]           = { 0, 26, 0 },
	["Stormstrike"]              = { 0, 31, 0 },
	["Lava Lash"]                = { 0, 36, 0 },
	["Shamanistic Rage"]         = { 0, 41, 0 },
	["Feral Spirit"]             = { 0, 51, 0 },
	["Tidal Force"]              = { 0, 0, 11 },
	["Nature's Swiftness"]       = { 0, 0, 21 },
	["Mana Tide Totem"]          = { 0, 0, 31 },
	["Cleanse Spirit"]           = { 0, 0, 31 },
	["Earth Shield"]             = { 0, 0, 41 },
	["Riptide"]                  = { 0, 0, 51 },
	
	-- Warlock
	["Siphon Life"]              = { 21, 0, 0 },
	["Curse of Exhaustion"]      = { 21, 0, 0 },
	["Dark Pact"]                = { 31, 0, 0 },
	["Unstable Affliction"]      = { 41, 0, 0 },
	["Haunt"]                    = { 51, 0, 0 },
	["Fel Domination"]           = { 0, 11, 0 },
	["Soul Link"]                = { 0, 11, 0 },
	["Demonic Sacrifice"]        = { 0, 21, 0 },
	["Demonic Empowerment"]      = { 0, 31, 0 },
	["Demonic Knowledge"]        = { 0, 31, 0 },
	["Summon Felguard"]          = { 0, 41, 0 },
	["Metamorphosis"]            = { 0, 51, 0 },
	["Shadowburn"]               = { 0, 0, 21 },
	["Nether Protection"]        = { 0, 0, 26 },
	["Conflagrate"]              = { 0, 0, 31 },
	["Soul Leech"]               = { 0, 0, 31 },
	["Shadow Fury"]              = { 0, 0, 41 },
	["Chaos Bolt"]               = { 0, 0, 51 },
	
	-- Warrior
	["Sweeping Strikes"]         = { 21, 0, 0 },
	["Second Wind"]              = { 31, 0, 0 },
	["Mortal Strike"]            = { 31, 0, 0 },
	["Bladestorm"]               = { 51, 0, 0 },
	["Piercing Howl"]            = { 0, 11, 0 },
	["Death Wish"]               = { 0, 21, 0 },
	["Flurry"]                   = { 0, 26, 0 },
	["Blood Thirst"]             = { 0, 31, 0 },
	["Heroic Fury"]              = { 0, 41, 0 },
	["Rampage"]                  = { 0, 41, 0 },
	["Last Stand"]               = { 0, 0, 11 },
	["Concussion Blow"]          = { 0, 0, 21 },
	["Vigilance"]                = { 0, 0, 31 },
	["Devastate"]                = { 0, 0, 41 },
	["Shockwave"]                = { 0, 0, 51 },
}

local talent_specs = {
	["DEATHKNIGHT"] = {
		{ 31, 0, 0, "blood" },
		{ 0, 31, 0, "frost" },
		{ 0, 0, 31, "unholy" },
	},
	["DRUID"] = {
		{ 0, 0, 21, "resto"},
		{ 31, 0, 0, "bal"},
		{ 0, 41, 0, "feral"},
		{ 0, 21, 21, "FC-resto" },
	},
	["HUNTER"] = {
		{ 31, 0, 0, "BM" },
		{ 0, 31, 0, "MM" },
		{ 0, 0, 31, "surv" },
	},
	["MAGE"] = {
		{ 51, 0, 0, "arcane" },
		{ 0, 30, 0, "fire" },
		{ 0, 0, 31, "frost" },
	},
	["PALADIN"] = {
		{ 31, 0, 0, "holy" },
		{ 0, 31, 0, "prot" },
		{ 0, 0, 41, "ret" },
	},
	["PRIEST"] = {
		{ 0, 0, 21, "shadow" },
		{ 0, 21, 0, "holy" },
		{ 31, 0, 0, "disc" },
	},
	["ROGUE"] = {
		{ 41, 0, 0, "ass" },
		{ 0, 31, 0, "combat" },
		{ 0, 0, 51, "sub" },
	},
	["SHAMAN"] = {
		{ 21, 0, 0, "el" },
		{ 0, 21, 0, "enh" },
		{ 0, 0, 21, "resto" },
	},
	["WARLOCK"] = {
		{ 0, 0, 22, "destro" },
		{ 41, 0, 0, "affl" },
		{ 0, 41, 0, "demo" },
	},
	["WARRIOR"] = {
		{ 31, 0, 0, "arms" },
		{ 0, 31, 0, "fury" },
		{ 0, 0, 31, "prot" },
	},
}

function HarmonyArena:COMBAT_LOG_EVENT_UNFILTERED( event, ... )
	local event, guid = select( 2, ... );
	local unit = self.unit[ guid ];
	if unit then
		local spellid, spellname = select( 9, ... );
		if spellid and spellname and abilities[spellname] then
			-- talents
			local s1, s2, s3 = unpack( abilities[spellname] );
			local t = self.db.global.talents[ guid ];
			t[1] = max( t[1], s1 );
			t[2] = max( t[2], s2 );
			t[3] = max( t[3], s3 );
			if( t[1] + t[2] + t[3] > 71 ) then
				t[1], t[2], t[3] = s1, s2, s3;
			end
			
			self:UpdateSpec( unit, guid );
		end
	end
end

function HarmonyArena:UpdateSpec( unit, guid )
	local t = self.db.global.talents[ guid ];
	if t then
		local class = select( 2, UnitClass( unit ) );
		local desc = "";
		for i,spec in ipairs( talent_specs[ class ] ) do
			s1, s2, s3, d = unpack( spec );
			if t[1] >= s1 and t[2] >= s2 and t[3] >= s3 then
				desc = d;
			end
		end
		
		self:SetSpec( unit, desc, t[1], t[2], t[3] );
	end
end
