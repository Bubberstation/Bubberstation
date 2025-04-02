/obj/item/bodypart
	var/bodypart_species

/// Sprite file location
#define PROTEAN_ORGAN_SPRITE 'modular_zubbers/icons/mob/species/protean/protean.dmi'

#define PROTEAN_STOMACH_FULL 10
#define PROTEAN_STOMACH_FALTERING 0.5
#define PROTEAN_METABOLISM_RATE 2000
/**
 * PROTEAN_BODYPART_DEFINE(path, health) Macro
 * This one is very simple. It is used to give a Protean's limbs the proper bodytypes and names.
 * This is an alternative to creating each /obj/item/bodypart/ child for every Protean limb.
 */
#define PROTEAN_BODYPART_DEFINE(path, health) \
##path {\
	max_damage = ##health; \
	bodypart_species = SPECIES_PROTEAN; \
	bodytype = parent_type::bodytype | BODYTYPE_NANO; \
}

/**
 * PROTEAN_DELIMB_DEFINE(path) Macro
 * Reworks the logic for delimbing. Once your limb gets mangled, it will fall off your body.
 */
#define PROTEAN_DELIMB_DEFINE(path) \
##path/try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus) {\
	if(((get_damage() + wounding_dmg) >= max_damage)) {\
		dismember();\
		qdel(src);\
	}\
}

// Core
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/head/mutant/protean, 120)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/head/mutant/protean)

PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/chest/mutant/protean, LIMB_MAX_HP_CORE)


// Limbs
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/arm/left/mutant/protean, 40)
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/arm/right/mutant/protean, 40)
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/leg/left/mutant/protean, 40)
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/leg/right/mutant/protean, 40)

PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/arm/left/mutant/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/arm/right/mutant/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/leg/left/mutant/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/leg/right/mutant/protean)

#undef PROTEAN_BODYPART_DEFINE
#undef PROTEAN_DELIMB_DEFINE
