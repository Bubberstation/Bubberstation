//Night vision for all cats
/mob/living/basic/pet/cat
	lighting_cutoff_red = 25
	lighting_cutoff_green = 30
	lighting_cutoff_blue =  20

// SYNDICATS!
/mob/living/basic/pet/cat/syndicat
	name = "Syndie Cat"
	desc = "OH GOD! RUN!! IT CAN SMELL THE DISK!"
	icon = 'modular_zubbers/icons/mob/simple/pets.dmi'
	held_lh = 'modular_zubbers/icons/mob/inhands/pets_held_lh.dmi'
	held_rh = 'modular_zubbers/icons/mob/inhands/pets_held_rh.dmi'
	icon_state = "syndicat"
	icon_living = "syndicat"
	icon_dead = "syndicat_dead"
	held_state = "syndicat"
	health = 80
	maxHealth = 80
	melee_damage_lower = 20
	melee_damage_upper = 35
	mobility_flags = MOBILITY_FLAGS_DEFAULT
	ai_controller = /datum/ai_controller/basic_controller/simple_hostile
	faction = list(FACTION_CAT, ROLE_SYNDICATE)
	gold_core_spawnable = NO_SPAWN
	// it's clad in blood-red armor
	damage_coeff = list(BRUTE = 0.8, BURN = 0.9, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	habitable_atmos = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = -1
	maximum_survivable_temperature = INFINITY
	unsuitable_atmos_damage = 0
	lighting_cutoff_red = 25
	lighting_cutoff_green = 35	// More green for what they see out of their eyes
	lighting_cutoff_blue =  20

/mob/living/basic/pet/cat/syndicat/Initialize(mapload)
	. = ..()
	var/obj/item/implant/toinstall = list(/obj/item/implant/weapons_auth, /obj/item/implant/explosive)
	for(var/obj/item/implant/original_implants as anything in toinstall)
		var/obj/item/implant/copied_implant = new original_implants.type
		copied_implant.implant(src, silent = TRUE, force = TRUE)
	add_traits(list(TRAIT_NEGATES_GRAVITY, TRAIT_DISK_VERIFIER), INNATE_TRAIT) // Trained syndicat meower!
