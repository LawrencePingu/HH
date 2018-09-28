--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------
This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
      Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomJobFields

Add your custom jobs under the following line:
---------------------------------------------------------------------------]]
TEAM_SWAT = DarkRP.createJob("S.W.A.T", {
color = Color(0, 0, 255, 255),
model = "models/payday2/units/murkywater_heavy_swat_player.mdl",
description = [[You should stay in the PD until backup is needed.
	            Do everything you can to keep the city safe.
				You and other S.W.A.T Team are the only law enforcer's who can raid]],
weapons = {"arrest_stick", "unarrest_stick", "m9k_acr", "stunstick", "door_ram", "weaponchecker"},
command = "/swat",
max = 5,
salary = 100,
admin = 0,
vote = true,
hasLicense = true,
category = "Government",
     })
TEAM_SWATM = DarkRP.createJob("S.W.A.T Medic", {
	color = Color(0, 0, 255, 255),
	model = "models/payday2/units/medic_player.mdl",
	description = [[Your duty is to heal on of your wounded operatives.
    	            You should stay in the PD until backup is needed.
	                Do everything you can to keep the city safe.
		            You also keep your team healed. You and other S.W.A.T Team are the only law enforcer's who can raid.]],
	weapons = {"arrest_stick", "unarrest_stick", "m9k_ragingbull", "stunstick", "door_ram", "weaponchecker", "med_kit"},
	command = "/swatm",
	max = 4,
	salary = 150,
	admin = 0,
	vote = true,
	hasLicense = true,
	category = "Government",
     })
TEAM_SWATC = DarkRP.createJob("S.W.A.T Chief", {
        color = Color(0, 0, 255, 255),
        model = "models/payday2/units/murkywater_captain_player.mdl",
        description = [[You should stay in the PD until backup is needed.
                        Do everything you can to keep the city safe.
                        You can heal your team, but it's not optinal unless theres
                        no medics alive. If theres no mayor, you're in charge.
				        You and other S.W.A.T Team are the only law enforcer's who can raid.]],
        weapons = {"arrest_stick", "unarrest_stick", "stunstick", "door_ram", "weaponchecker", "med_kit", "m9k_m3", "m9k_m16a4_acog", "m9k_remington1858"},
        command = "/swatc",
        max = 1,
        salary = 200,
        admin = 0,
        vote = true,
        hasLicense = true,
		category = "Government",
		NeedToChangeFrom = {TEAM_SWAT, TEAM_SWATM, TEAM_SWATS, TEAM_SWATJ}
     })
TEAM_SWATS = DarkRP.createJob("S.W.A.T Sniper", {
	    color = Color(0, 0 , 255 , 255),
		model = "models/payday2/units/murkywater_sniper_fbi_player.mdl",
		description = [[You are on the backline. Shoot for the head and DONT MISS!. You and other S.W.A.T Team are the only law enforcer's who can raid.]],
		weapons = {"arrest_stick", "unarrest_stick", "stunstick", "door_ram", "weaponchecker", "m9k_m98b", "m9k_colt1911"},
		command = "/swats",
		max = 2,
		salary = 175,
		admin = 0,
		vote = true,
		hasLicense = true,
		category = "Government",
		})
TEAM_SWATJ = DarkRP.createJob("S.W.A.T JUGGERNAUT", {
		color = Color(0, 0, 255, 255),
		model = "models/payday2/units/murkywater_bulldozer_player.mdl",
		description = [[Your the front line fighter the one everyone looks to for big jobs. You and other S.W.A.T Team are the only law enforcer's who can raid.]],
		weapons = {"m9k_ares_shrike","arrest_stick", "unarrest_stick","stunstick", "door_ram", "weaponchecker" },
		command = "/swatj",
		max = 1,
		salary = 100,
		admin = 0,
		vote = true,
		hasLicense = true,
		category = "Government",
		PlayerSpawn = function(ply) GAMEMODE:SetPlayerSpeed(ply, GAMEMODE.Config.walkspeed * 0.5, GAMEMODE.Config.runspeed * 0.75) ply:SetHealth(250) ply:SetGravity(1) return CLIENT end,
        PlayerDeath = function(ply) GAMEMODE:SetPlayerSpeed(ply, GAMEMODE.Config.walkspeed * 1, GAMEMODE.Config.runspeed * 1) return CLIENT end,
		})
TEAM_CHILD = DarkRP.createJob("CHILD_REN", {
		color = Color(0, 255, 255, 255),
		model = "models/gonzo/ncrrangerimproved/ncrrangerimproved.mdl",
		description = [[ONLY FOR PLAYER CHILD_REN (CO-OWNER)]],
		weapons = {"m9k_m98b"},
		command = "/CHILD",
		max = 1,
		salary = 0,
		admin = 1,
		ammo = {
		["m9k_dbarrel"] = 100,
		["m9k_minigun"] = 1000,
		["m9k_val"] = 250,
		["m9k_val"] = 50,
		["m9k_svt40"] = 75,
	    },
		PlayerSpawn = function(ply) GAMEMODE:SetPlayerSpeed(ply, GAMEMODE.Config.walkspeed * 1, GAMEMODE.Config.runspeed * 1) ply:SetHealth(150) ply:SetGravity(1) return CLIENT end,
        PlayerDeath = function(ply) GAMEMODE:SetPlayerSpeed(ply, GAMEMODE.Config.walkspeed * 1, GAMEMODE.Config.runspeed * 1) return CLIENT end,
		category = "Staff",
		})	
TEAM_RAPE = DarkRP.createJob("Rapist", {
		color = Color(255, 0, 191, 255),
		model = "models/player/odessa.mdl",
		description = [[Your a rapist. Rape people. You must advert RAPE]],
		weapons = {"weapon_rape"},
		command = "/Rapist",
		max = 2,
		salary = 15,
		admin = 0,
		vote = false,
		hasLicense = false,
		category = "Criminal",
		})
TEAM_THIEF = DarkRP.createJob("Thief", {
		color = Color(0,255,100,255),
		model = "models/player/phoenix.mdl",
		description = [[Your a thief. You only have RP Relation with your team. You must Advert Raid/Assist, Pd Raid/Assist]],
		weapons = {"lockpickadv_swep","keypad_cracker"},
		command = "/thief",
		max = 8,
		salary = 40,
		admin = 0,
		vote = false,
		hasLicense = false,
		category = "Criminal",
		})
TEAM_ZOMBIE = DarkRP.createJob("Zombie", {
        color = Color(60,0,0,255),
        model = "models/player/zombie_classic.mdl",
        description = [[You are a Zombie, you inhabit the sewers and are allowed to KOS anybody that comes near your hive]],
        weapons = {"m9k_machete"},
        command = "/zombie",
        max = 5,
        salary = 0,
        admin = 0,
        vote = false,
        hasLicense = false,
		category = "Criminal",
        })
TEAM_CHECKPOINT =DarkRP.createJob("Police Checkpoint Officer", {
		color = Color(0, 0, 255, 255),
		model = "models/player/riot.mdl",
		description = [[Your job is to man the police checkpoints. No other police jobs are allowed to do this. You must not raid thats the job of the S.W.A.T]],
		weapon = {"arrest_stick", "unarrest_stick", "m9k_acr", "stunstick", "weaponchecker"},
		command = "/checkpoint",
		max = 5,
		salary = 150,
		admin = 0,
		vote = true,
		hasLicense = true,
		category = "Government",
		})
TEAM_MAYORS =  DarkRP.createJob("Mayor", {
		color = Color(0, 0, 255, 255),
		model = "models/player/donald_trump.mdl",
		description = [[You'r the Mayor of the server. MaKE Law's, Help your Police Force and most importantly dont get killed]],
		weapon = {"arrest_stick", "unarrest_stick"},
		command = "/mayor",
		max = 1,
		salary = 300,
		admin = 0,
		vote = true,
		hasLicense = false,
		--The right's to be mayor
		mayor = true,
		category = "Government",
		})
TEAM_TERROR = DarkRP.createJob("TERRORIST", {
        color = Color(0,0,0,255),
        model = "models/player/kuma/taliban_bomber.mdl",
        description = [[Kill everyone with your terror and dont hold back. You must Advert Terror]],
        weapons = {"weapon_jihadbomb"},
        command = "/terrorist",
        max = 1,
        salary = 50 ,
        admin =0 ,
        vote = false,
        hasLicense = false,
		category = "Criminal",
        })
TEAM_BANKER = DarkRP.createJob("Banker", {
		color = Color(0, 161, 255, 255),
		model = "models/player/gman_high.mdl",
		description = [[You'r Job is to store player's printer's adn protect them with your life.]],
		weapons = {},
		command = "/Banker",
		max = 1,
		salary = 60,
		admin = 0,
		vote = true,
		hasLicense = false,
		category = "Citizens",
		})
TEAM_SERCURITY = DarkRP.createJob("Sercurity Guard", {
		color = Color(218, 218, 218, 255),
		model = {
		    "models/player/guard_pack/guard_09.mdl",
			"models/player/guard_pack/guard_08.mdl",
			"models/player/guard_pack/guard_07.mdl",
			"models/player/guard_pack/guard_06.mdl",
			"models/player/guard_pack/guard_05.mdl",
			"models/player/guard_pack/guard_04.mdl",
			"models/player/guard_pack/guard_03.mdl",
			"models/player/guard_pack/guard_02.mdl"
			},
		description = [[Your job is to work for player's such as Gun Dealer, Banker, ect.]],
		weapons = {"stunstick", "m9k_glock"},
		command = "/Sercurity",
		max = 4,
		salary = 30,
		admin = 0,
		vote = true,
		hasLicense = true,
		category = "Citizens",
		})
TEAM_POLICE = DarkRP.createJob("Police Officer", {
		      color = Color(0, 0, 255, 255),
		      model = {
		     "models/payday2/units/cop3_player.mdl",
		     "models/payday2/units/cop2_player.mdl",
		     "models/payday2/units/cop1_player.mdl"
		     },
		     description = [[Your job is to uphold the mayor's law's and enforce them on the other player's. 
			                 You must not raid thats the job of the S.W.A.T]],
		     weapons = {"arrest_stick", "unarrest_stick", "stunstick", "m9k_glock", "weaponchecker"},
		     command = "/Police",
		     max = 8,
		     salary = 30,
		     admin = 0,
		     vote = true,
		     hasLicense = true,
		     category = "Government",
		     })	
TEAM_CHIEF = DarkRP.createJob("Police Chief", {
             color = Color(0, 0, 255, 255),
			 model = "models/payday2/units/cop4_player.mdl",
			 description = [[Your job is to uphold the mayor's law's and enforce them on the other player's. 
			                 You must also guide your fellow Police officer's. 
							 You must not raid thats the job of the S.W.A.T]],
			 weapons = {"arrest_stick", "unarrest_stick", "stunstick", "m9k_model500", "weaponchecker", "m9k_fal" },
			 command = "/cheif",
			 max = 1,
			 salary = 200,
			 admin = 0,
			 vote = true,
			 hasLicense = true,
			 category = "Government",
			 NeedToChangeFrom = TEAM_POLICE
			 })
TEAM_STAFF = DarkRP.createJob("Staff On Duty", {
             color = Color(240, 240, 240, 255),
             model = "models/player/combine_super_soldier.mdl",
			 description = [[Staff on duty.Your OOC.
			                 Getting RDMED As Staff On Duty Is Not a Punishable Offence]],
			 weapons = {},
			 command = "/staff",
			 max = 200,
			 salary = 200,
			 admin = 1,
			 vote = false,
			 hasLicense = false,
			 category = "Staff",
			 })
TEAM_HITMAN = DarkRP.createJob("Hitman", {
              color = Color(0,255,100,255),
			  model = "models/player/leet.mdl",
			  description = [[You Must Accept Hit's and Kill You'r Targets. 
			                  Make Sure Your Customer Has Given a Valid RP Reason For The Hit.]],
			  weapons = {"m9k_vikhr", "m9k_m92beretta"},
			  command = "/Hitman",
			  max = 2,
			  salary = 20,
			  admin = 0,
			  vote = false,
			  hasLicense = true,
			  category = "Criminal",
			  })

--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CITIZEN
--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
    [TEAM_POLICE] = true,
    [TEAM_CHIEF] = true,
    [TEAM_MAYOR] = true,
	[TEAM_SWAT] = true,
	[TEAM_SWATM] = true,
	[TEAM_SWATC] = true,
	[TEAM_SWATS] = true,
	[TEAM_MAYORS] = true,
	[TEAM_CHECKPOINT] = true,
	[TEAM_SWATJ] = true,
	[TEAM_CHILD] = true,
}
--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
DarkRP.addHitmanTeam(TEAM_HITMAN)