/mob/living/carbon/dragon
// Dergs!!

	icon = 'modular_zubbers/icons/mob/species/dragon/dragon.dmi'
	icon_state = "dragon_base"
	status_flags = 0
	pixel_x = -16
	base_pixel_x = -16
	maptext_height = 64
	maptext_width = 64
	mob_size = MOB_SIZE_LARGE
	layer = LARGE_MOB_LAYER //above most mobs, but below speechbubbles
	pressure_resistance = 200 //Because big, stompy xenos should not be blown around like paper.
	faction = list("derg")
	layer = LARGE_MOB_LAYER //above most mobs, but below speechbubbles

/mob/living/carbon/dragon/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_BRAWLING_KNOCKDOWN_BLOCKED, INNATE_TRAIT)
	AddComponent(/datum/component/seethrough_mob)

/mob/living/carbon/dragon/create_internal_organs()
	organs += new /obj/item/organ/internal/brain/dragon
	organs += new /obj/item/organ/internal/tongue
	organs += new /obj/item/organ/internal/eyes
	organs += new /obj/item/organ/internal/liver
	organs += new /obj/item/organ/internal/ears

/obj/item/organ/internal/brain/dragon
	name = "dragon brain"

/datum/species/lizard/dragon
// overgrown lizards
	name = "Dragon"


/datum/species/lizard/dragon/on_species_gain(mob/living/carbon/human/derg, datum/species/old_species, pref_load)


	derg = new /mob/living/carbon/dragon
	. = ..()
/* 	derg.icon = /mob/living/carbon/dragon::icon
	derg.icon_state = /mob/living/carbon/dragon::icon_state
 */
