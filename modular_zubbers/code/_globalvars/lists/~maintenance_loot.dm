//Loot pool used by default maintenance loot spawners
GLOBAL_LIST_INIT(maintenance_loot, list(
	GLOB.trash_loot = maint_trash_weight,
	GLOB.common_loot = maint_common_weight,
	GLOB.uncommon_loot = maint_uncommon_weight,
	GLOB.rarity_loot = maint_rarity_weight,
	GLOB.oddity_loot = maint_oddity_weight
))

GLOBAL_LIST_INIT(trash_pile_loot, list(
	GLOB.uncommon_loot = maint_uncommon_weight,
	GLOB.rarity_loot = maint_rarity_weight,
	GLOB.oddity_loot = maint_oddity_weight
))

//Loot pool that is copied from maint loot but doesn't get changed due to holidays
GLOBAL_LIST_INIT(dumpster_loot, GLOB.maintenance_loot.Copy())
