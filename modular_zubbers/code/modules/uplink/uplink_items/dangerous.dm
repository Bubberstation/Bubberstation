/datum/uplink_item/dangerous/changelingzombie
	name = "Changeling Zombie Virus Vial"
	desc = "Stolen from a Nanotrasen research facility, this experimental vial infects people with the infectious variant of the changeling zombie virus on contact. \
	Our legal team says that this doesn't give you any sort of superpowers and should only be used on living beings other than yourself."

	progression_minimum = 30 MINUTES
	population_minimum = TRAITOR_POPULATION_LOWPOP

	item = /obj/item/reagent_containers/cup/glass/changeling_zombie_virus

	cost = 15

	purchasable_from = UPLINK_TRAITORS | UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS //Spies and loneops excluded.
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND //Technically this is NT research, so it isn't syndicate tech.

