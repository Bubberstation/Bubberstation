#define MANATEE_VEHICLE_BOOST 2

// Space dolphins and manatees woo
/mob/living/basic/dolphin
	name = "space dolphin"
	desc = "So long, and thanks for all the fish."
	icon = 'modular_zubbers/icons/mob/simple/animals.dmi'
	icon_state = "dolphin"
	icon_living = "dolphin"
	icon_dead = "dolphin_dead"
	gold_core_spawnable = FRIENDLY_SPAWN
	mob_biotypes = MOB_ORGANIC | MOB_BEAST | MOB_AQUATIC
	butcher_results = list(/obj/item/food/fishmeat = 2)

	response_help_simple = "pet"
	response_help_continuous = "pets"
	response_disarm_simple = "gently shove"
	response_disarm_continuous = "gently shovess"
	response_harm_simple = "hit"
	response_harm_continuous = "hits"

	speed = 0
	pass_flags = PASSTABLE | PASSSTRUCTURE | PASSVEHICLE

	// Half of carp
	maxHealth = 25
	health = 25
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"

	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("chitters", "squeeks", "clicks")

	habitable_atmos = null
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500
	pressure_resistance = 200

	ai_controller = /datum/ai_controller/basic_controller/dolphin

	faction = list(FACTION_DOLPHIN)

/mob/living/basic/dolphin/Initialize(mapload)
	// Hyperspace movement needs to init before the supercall
	add_traits(list(TRAIT_FREE_HYPERSPACE_MOVEMENT, TRAIT_SPACEWALK), INNATE_TRAIT)
	. = ..()
	AddElement(/datum/element/ai_retaliate) // So we can actually get angry at people who hit us

/mob/living/basic/dolphin/manatee
	name = "space manatee"
	desc = "Large slow sea critters. Known for being very good at operating motor vehicles."
	gold_core_spawnable = NO_SPAWN

	icon_state = "manatee"
	icon_living = "manatee"
	icon_dead = "manatee_dead"

	maxHealth = 150
	health = 150
	speed = 1.2

/mob/living/basic/dolphin/manatee/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_LIVING_SET_BUCKLED, PROC_REF(on_buckle))

/mob/living/basic/dolphin/manatee/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_LIVING_SET_BUCKLED)

/mob/living/basic/dolphin/manatee/proc/on_buckle(mob/living/source, obj/vehicle/ridden/new_buckled)
	SIGNAL_HANDLER
	if(!istype(source))
		return
	// Manatees are great at operating motor vehicles, so they buff a vehicle they buckle to
	// Yes I know it's not just motor vehicles in that type, bite me
	if(istype(source.buckled, /obj/vehicle/ridden))
		var/obj/vehicle/ridden/old_vehicle = source.buckled
		old_vehicle.movedelay *= MANATEE_VEHICLE_BOOST // Reset vehicles we're leaving
	if(istype(new_buckled))
		new_buckled.movedelay /= MANATEE_VEHICLE_BOOST // Speed up vehicles we're buckling to


#undef MANATEE_VEHICLE_BOOST
