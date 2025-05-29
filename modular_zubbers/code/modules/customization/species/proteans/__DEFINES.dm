/**THIS FILE MAY LOOK SCARY FUTURE CONTRIBUTOR. BUT DO NOT FRET.
 * These are Macros. Basically we have multiple body parts with identical logic. Each Macro will be explained bellow.
 * Instead of a 500 line file with identical code, element, or compoment: a macro is used as a short cut to condense the logic.
*/
/// Brute damage messages
#define LIGHT_NANO_BRUTE "scratched"
#define MEDIUM_NANO_BRUTE "festering"
#define HEAVY_NANO_BRUTE "falling apart"

/// Burn damage messages
#define LIGHT_NANO_BURN "scorched"
#define MEDIUM_NANO_BURN "melted"
#define HEAVY_NANO_BURN "boiling"

#define BRUTE_EXAMINE_NANO "deformation"
#define BURN_EXAMINE_NANO "scorching"

/obj/item/bodypart
	var/bodypart_species

/// Sprite file location
#define PROTEAN_ORGAN_SPRITE 'modular_zubbers/icons/mob/species/protean/protean.dmi'

#define PROTEAN_STOMACH_FULL 10
#define PROTEAN_STOMACH_FALTERING 0.5
#define PROTEAN_METABOLISM_RATE 2000
#define PROTEAN_LIMB_TIME 30 SECONDS
/**
 * PROTEAN_BODYPART_DEFINE(path, health) Macro
 * This one is very simple. It is used to give a Protean's limbs the proper bodytypes and names.
 * This is an alternative to creating each /obj/item/bodypart/ parent for every Protean limb.
 */
#define PROTEAN_BODYPART_DEFINE(path, health) \
##path {\
	max_damage = ##health; \
	bodypart_species = SPECIES_PROTEAN; \
	bodytype = BODYTYPE_NANO; \
	dmg_overlay_type = "robotic"; \
	brute_modifier = 0.8; \
	burn_modifier = 1.2; \
	light_brute_msg = LIGHT_NANO_BRUTE; \
	medium_brute_msg = MEDIUM_NANO_BRUTE; \
	heavy_brute_msg = HEAVY_NANO_BRUTE; \
	light_burn_msg = LIGHT_NANO_BURN; \
	medium_burn_msg = MEDIUM_NANO_BURN; \
	heavy_burn_msg = HEAVY_NANO_BURN; \
	damage_examines = list(BRUTE = BRUTE_EXAMINE_NANO, BURN = BURN_EXAMINE_NANO); \
	var/qdel_timer; \
}

/**
 * PROTEAN_DELIMB_DEFINE(path) Macro
 * Reworks the logic for delimbing. Once your limb gets mangled, it will fall off your body.
 */
#define PROTEAN_DELIMB_DEFINE(path) \
##path/try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus) {\
	if(((get_damage() + wounding_dmg) >= max_damage)) {\
		dismember(); \
		qdel_timer = QDEL_IN_STOPPABLE(src, PROTEAN_LIMB_TIME); \
	} \
}

/**
 * PROTEAN_LIMB_ATTACH(path) Macro
 * If you reattch your limb, it will delete the qdel timer.
 */
#define PROTEAN_LIMB_ATTACH(path) \
##path/can_attach_limb(limb_owner, special) {\
	. = ..(); \
	if(!.) {\
		return FALSE; \
	} \
	if(!isnull(qdel_timer)) { \
		deltimer(qdel_timer); \
	return TRUE; \
	} \
}

// Core
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/head/mutant/protean, 120)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/head/mutant/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/head/mutant/protean)

PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/chest/mutant/protean, LIMB_MAX_HP_CORE)


// Limbs
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/arm/left/mutant/protean, 40)
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/arm/right/mutant/protean, 40)

/// Legs are a little more special, so they're not macro'd
/obj/item/bodypart/leg/right/mutant/protean
	max_damage = 40
	bodypart_species = SPECIES_PROTEAN
	bodytype = BODYTYPE_NANO
	dmg_overlay_type = "robotic"
	brute_modifier = 0.8
	burn_modifier = 1.2
	light_brute_msg = LIGHT_NANO_BRUTE
	medium_brute_msg = MEDIUM_NANO_BRUTE
	heavy_brute_msg = HEAVY_NANO_BRUTE
	light_burn_msg = LIGHT_NANO_BURN
	medium_burn_msg = MEDIUM_NANO_BURN
	heavy_burn_msg = HEAVY_NANO_BRUTE
	damage_examines = list(BRUTE = BRUTE_EXAMINE_NANO, BURN = BURN_EXAMINE_NANO)
	digitigrade_type = /obj/item/bodypart/leg/right/mutant/protean/digitigrade
	var/qdel_timer

/obj/item/bodypart/leg/left/mutant/protean
	max_damage = 40
	bodypart_species = SPECIES_PROTEAN
	bodytype = BODYTYPE_NANO
	dmg_overlay_type = "robotic"
	brute_modifier = 0.8
	burn_modifier = 1.2
	light_brute_msg = LIGHT_NANO_BRUTE
	medium_brute_msg = MEDIUM_NANO_BRUTE
	heavy_brute_msg = HEAVY_NANO_BRUTE
	light_burn_msg = LIGHT_NANO_BURN
	medium_burn_msg = MEDIUM_NANO_BURN
	heavy_burn_msg = HEAVY_NANO_BRUTE
	damage_examines = list(BRUTE = BRUTE_EXAMINE_NANO, BURN = BURN_EXAMINE_NANO)
	digitigrade_type = /obj/item/bodypart/leg/left/mutant/protean/digitigrade
	var/qdel_timer

/obj/item/bodypart/leg/right/mutant/protean/digitigrade
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = BODYPART_ID_DIGITIGRADE
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE

/obj/item/bodypart/leg/right/mutant/protean/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()

/obj/item/bodypart/leg/left/mutant/protean/digitigrade
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = BODYPART_ID_DIGITIGRADE
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE

/obj/item/bodypart/leg/left/mutant/protean/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()

PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/arm/left/mutant/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/arm/right/mutant/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/leg/left/mutant/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/leg/right/mutant/protean)

PROTEAN_LIMB_ATTACH(/obj/item/bodypart/arm/left/mutant/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/arm/right/mutant/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/leg/left/mutant/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/leg/right/mutant/protean)

#undef PROTEAN_BODYPART_DEFINE
#undef PROTEAN_DELIMB_DEFINE
#undef PROTEAN_LIMB_ATTACH
