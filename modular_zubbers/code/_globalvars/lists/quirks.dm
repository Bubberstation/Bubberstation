/// Neccesary for accessing non-instanced quirk whitelists, as initial() cannot access lists
GLOBAL_LIST_EMPTY(quirk_species_blacklist) //this needs to be generated before the line below calls the proc.
GLOBAL_LIST_INIT(quirk_species_whitelist, generate_quirk_species_lists())
// unfortunately we have to instance the quirks here or otherwise we cannot access a list,
// initial cannot access lists as they're not actually compile-time constants, only initialized at runtime
/proc/generate_quirk_species_lists()
	var/list/all_quirks = subtypesof(/datum/quirk)
	var/list/species_whitelist = list()
	var/list/species_blacklist = list()
	for(var/quirk_type in all_quirks)
		var/datum/quirk/quirk = new quirk_type()
		if(length(quirk.species_whitelist))
			species_whitelist[quirk.type] = list()
			for(var/species_id in quirk.species_whitelist)
				species_whitelist[quirk.type] += species_id
		if(length(quirk.species_blacklist))
			species_blacklist[quirk.type] = list()
			for(var/species_id in quirk.species_blacklist)
				species_blacklist[quirk.type] += species_id
		qdel(quirk)
	GLOB.quirk_species_blacklist = species_blacklist
	return species_whitelist


//Permanent Limp Quirk
GLOBAL_LIST_INIT(permanent_limp_choice, list(
	"Left, minor" = /datum/wound/perm_limp/left,
	"Left, moderate" = /datum/wound/perm_limp/left/moderate,
	"Left, major" = /datum/wound/perm_limp/left/major,
	"Right, minor" = /datum/wound/perm_limp/right,
	"Right, moderate" = /datum/wound/perm_limp/right/moderate,
	"Right, major" = /datum/wound/perm_limp/right/major,
))
