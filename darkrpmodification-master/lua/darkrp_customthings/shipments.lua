--[[---------------------------------------------------------------------------
DarkRP custom shipments and guns
---------------------------------------------------------------------------

This file contains your custom shipments and guns.
This file should also contain shipments and guns from DarkRP that you edited.

Note: If you want to edit a default DarkRP shipment, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the shipment to this file and edit it.

The default shipments and guns can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomShipmentFields


Add shipments and guns under the following line:
---------------------------------------------------------------------------]]
DarkRP.createShipment("Double Barrel", {
	model = "models/weapons/w_double_barrel_shotgun.mdl", -- The model of the item that hovers above the shipment
	entity = "m9k_dbarrel", -- the entity that comes out of the shipment
	price = 55000, -- the price of one shipment
	amount = 10, -- how many of the item go in one purchased shipment
	separate = true, -- whether the item is sold separately (usually used for guns)
	pricesep = 5500, -- the price of a separately sold item
 
	-- The following fields are OPTIONAL. If you do not need them, or do not need to change them from their defaults, REMOVE them.
	noship = false, -- whether this item has a shipment
	allowed = {TEAM_GUN, TEAM_BLCKMARKT}, -- OPTIONAL, which teams are allowed to buy this shipment/separate gun
	shipmodel = "models/items/item_item_crate.mdl",
    sortOrder = 100, -- The position of this thing in its category. Lower number means higher up.
	})
	