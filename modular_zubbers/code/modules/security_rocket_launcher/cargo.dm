/datum/supply_pack/security/rocket_launcher
	name = "Security Missile Launcher Crate"
	desc = "Contains one \"VARS\" Variable Active Radar Missile System for security. No refunds."
	cost = CARGO_CRATE_VALUE * 160 //40 times the cost of lasers.
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/ballistic/rocketlauncher/security = 1)
	crate_name = "security missile launcher crate"
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE //Shits and giggles.

/datum/supply_pack/security/rocket_launcher_ammo
	name = "Security Missile Launcher Ammo Pack"
	desc = "Contains a box of 7 \"VARS\" HE missiles for the \"VARS\" Variable Active Radar Missile System."
	cost = CARGO_CRATE_VALUE * 20
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/security_missiles = 1)
	crate_name = "security missile launcher ammo crate"
