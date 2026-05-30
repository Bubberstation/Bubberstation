/* Borers are disabled until someone possibly fixes (or removes) them in the future.
/datum/uplink_item/dangerous/cortical_borer
	name = "Cortical Borer Egg"
	desc = "The egg of a cortical borer. The cortical borer is a parasite that can produce chemicals upon command, as well as \
			learn new chemicals through the blood if old enough. Be careful as there is no way to get the borer to pledge allegiance \
			to yourself. The egg is extremely fragile, do not crush it in your hand nor throw it. \
			The egg is required to sit out in the open in order to hatch. (Cannot be hidden in closets, etc.)"
	progression_minimum = 20 MINUTES
	item = /obj/effect/mob_spawn/ghost_role/borer_egg/traitor
	cost = 20
*/

/datum/uplink_item/dangerous/stetchkin
	name = "Stetchkin APS Machine Pistol kit"
	desc = "A burst-fire weapon dating all the way back to the first Soviet Union, reproduced and found uncommonly among Syndicate agents."
	item = /obj/item/storage/toolbox/guncase/skyrat/pistol/aps
	cost = 8
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/dangerous/regal_condor_kit
	name = "Unnamed weapon parts kit"
	desc = "An ominous kit of gun parts in a sleek suitcase, additionally containing several specially cut and refined telecrystals. The kit was supplied with a note that says: \"You'll figure out the rest\"."
	item = /obj/item/weaponcrafting/gunkit/regal_condor
	cost = 4
	cant_discount = TRUE
	surplus = 0
	population_minimum = TRAITOR_POPULATION_LOWPOP + 5
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS
