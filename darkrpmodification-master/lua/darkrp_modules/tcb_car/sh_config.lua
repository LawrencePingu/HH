/*---------------------------------------------------------------------------
	
	Creator: TheCodingBeast - TheCodingBeast.com
	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
	
---------------------------------------------------------------------------*/

--[[---------------------------------------------------------
	Variables
-----------------------------------------------------------]]
TCBDealer = TCBDealer or {}

TCBDealer.settings = {}
TCBDealer.dealerSpawns = {}
TCBDealer.vehicleTable = {}

--[[---------------------------------------------------------
	Version
-----------------------------------------------------------]]
TCBDealer.version = 1.4

--[[---------------------------------------------------------
	Settings
-----------------------------------------------------------]]
TCBDealer.settings.testDriveLength = 20
TCBDealer.settings.salePercentage = 75
TCBDealer.settings.storeDistance = 400
TCBDealer.settings.colorPicker = true
TCBDealer.settings.randomColor = true
TCBDealer.settings.checkSpawn = false
TCBDealer.settings.autoEnter = false
TCBDealer.settings.precache = true
TCBDealer.settings.debug = false

TCBDealer.settings.frameTitle = "TCB"

--[[---------------------------------------------------------
	Dealer Spawns
-----------------------------------------------------------]]
TCBDealer.dealerSpawns["rp_downtown_v4c_v2_drpext_6"] = {
	{
		pos = Vector(-2339, -5291, -134),
		ang = Angle(10.692081, 51.240364, 0),
		mdl = "models/Characters/Hostage_02.mdl",

		spawns = {
			{
				pos = Vector(-2126, -5029, -134),
				ang = Angle(30, 0, 0)
			}
		}
	},
	{
	    pos = Vector(3256, 3364, -131),
		ang = Angle(0.692930, -179.682846, 0),
		mdl = "models/Characters/Hostage_02.mdl",

		spawns = {
			{
				pos = Vector(2956.602783, 3387.841064, -131.968750),
				ang = Angle(2.606997, 88.336060, 0)
			}
			}
		},
		{
	    pos = Vector(-2427, -152, -131),
		ang = Angle(8.448003, -61.399754, 0),
		mdl = "models/Characters/Hostage_02.mdl",

		spawns = {
			{
				pos = Vector(-2252.722168, -424.604034, -131.968750),
				ang = Angle(20.328104, -88.591873, 0)
			},
			}
		},{
	    pos = Vector(-2773.422852, 4905.436523, -139.968750),
		ang = Angle(-3.366008, -145.182083, 0),
		mdl = "models/Characters/Hostage_02.mdl",

		spawns = {
			{
				pos = Vector(-3163.375732, 4626.337891, -139.968750),
				ang = Angle(6.467966, 177.839828, 0)
			}
			}
		},
}



--[[---------------------------------------------------------
	Vehicles - http://facepunch.com/showthread.php?t=1481400 / https://www.youtube.com/watch?v=WSTBFk6nX6k
-----------------------------------------------------------]]
TCBDealer.vehicleTable["audir8tdm"] = {
	price = 100000,
}

TCBDealer.vehicleTable["dbstdm"] = {
	price = 0,

	customCheck = function(ply) return CLIENT or table.HasValue({"superadmin", "admin"}, ply:GetUserGroup()) end,
	CustomCheckFailMsg = "This vehicle is only available for admins and higher!",
}

TCBDealer.vehicleTable["veyronsstdm"] = {
	price = 0,

	customCheck = function(ply) return CLIENT or table.HasValue({"superadmin", "admin", "donator"}, ply:GetUserGroup()) end,
	CustomCheckFailMsg = "This vehicle is only available for donators and higher!",
}

TCBDealer.vehicleTable["dod_challenger15tdm"] = {
	price = 35000,
}
TCBDealer.vehicleTable["che_camarozl1tdm"] = {
	price = 25000,
}
TCBDealer.vehicleTable["fer_250gtotdm"] = {
	price = 5000000,
}
TCBDealer.vehicleTable["reventonrtdm"] = {
	price = 500000,
}
TCBDealer.vehicleTable["p1tdm"] = {
	price = 100000,
}
TCBDealer.vehicleTable["miurap400tdm"] = {
	price = 250000,
}
TCBDealer.vehicleTable["supratdm"] = {
	price = 60000,
}
TCBDealer.vehicleTable["subimpreza05tdm"] = {
	price = 10000,
}
TCBDealer.vehicleTable["porcycletdm"] = {
	price = 1000,
}

TCBDealer.vehicleTable["cad_lmptdm"] = {
	price = 0,
	
	customCheck = function(ply) return CLIENT or table.HasValue({"superadmin", "admin", "donator"}, ply:GetUserGroup()) end,
	CustomCheckFailMsg = "This vehicle is only available for donators and higher!",
}

TCBDealer.vehicleTable["p1tdm"] = {
	price = 45000,
}

TCBDealer.vehicleTable["st1tdm"] = {
	price = 40000,
}

TCBDealer.vehicleTable["raptorsvttdm"] = {
	price = 25000,
}

TCBDealer.vehicleTable["nismor35_sgm"] = {
	price = 0,
	
	customCheck = function(ply) return CLIENT or table.HasValue({"superadmin", "admin", "donator"}, ply:GetUserGroup()) end,
	CustomCheckFailMsg = "This vehicle is only available for donators and higher!",
}

TCBDealer.vehicleTable["furaitdm"] = {
	price = 0,
	
	customCheck = function(ply) return CLIENT or table.HasValue({"superadmin", "admin", "donator"}, ply:GetUserGroup()) end,
	CustomCheckFailMsg = "This vehicle is only available for donators and higher!",
}

