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

/datum/uplink_item/dangerous/Hyeseong
	name = "Hyeseong Modular Laser Rifle"
	desc = "One of the newest Cybersun products. This weapon can switch modes on the fly, from a lethal laser to a shotgun to even a plasma grenade. These are rare, and don't come cheap. Luckily for you, it also can slowly recharge itself."
	item = /obj/item/gun/energy/modular_laser_rifle
  
/datum/uplink_item/dangerous/stetchkin
	name = "Stetchkin APS Machine Pistol kit"
	desc = "A burst-fire weapon dating all the way back to the first Soviet Union, reproduced and found uncommonly among Syndicate agents."
	item = /obj/item/storage/toolbox/guncase/skyrat/pistol/aps
	cost = 8
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS
