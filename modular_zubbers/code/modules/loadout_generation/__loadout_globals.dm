GLOBAL_LIST_INIT(loadout_blacklist_terms,list(
	"debug",
	"admin",
	"god",
	"dev",
	"centcom",
	"central com",

))

GLOBAL_LIST_INIT(loadout_blacklist,generate_loadout_blacklist())

GLOBAL_LIST_EMPTY(loadout_blacklist_names)
