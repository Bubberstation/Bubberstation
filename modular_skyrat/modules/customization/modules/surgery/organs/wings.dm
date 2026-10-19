/obj/item/organ/wings
	name = "wings"
	desc = "A pair of wings. Those may or may not allow you to fly... or at the very least flap."
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_WINGS
	mutantpart_key = "wings"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Bat", MUTANT_INDEX_COLOR_LIST = list("#335533"))
	organ_flags = ORGAN_EXTERNAL

/obj/item/organ/wings/custom
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings
	flight_level = WINGS_FLIGHTLESS

/datum/bodypart_overlay/mutant/wings
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/wings/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/wings/functional
	color_source = ORGAN_COLOR_INHERIT

/datum/bodypart_overlay/mutant/wings/functional/original_color
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/wings/functional/original_color/override_color(rgb_value)
	return COLOR_WHITE // We want to keep those wings as their original color, because it looks better.

/datum/bodypart_overlay/mutant/wings/functional/locked/get_global_feature_list()
	if(wings_open)
		return SSaccessories.sprite_accessories["wings_open"]
	return SSaccessories.sprite_accessories["wings_functional"]

// We need to overwrite this because all of these wings are locked.
/datum/bodypart_overlay/mutant/wings/functional/locked/get_random_appearance()
	var/list/valid_restyles = list()
	var/list/feature_list = get_global_feature_list()
	for(var/accessory in feature_list)
		var/datum/sprite_accessory/accessory_datum = feature_list[accessory]
		valid_restyles += accessory_datum

	return pick(valid_restyles)


/datum/bodypart_overlay/mutant/wings/functional/locked/original_color
	color_source = ORGAN_COLOR_OVERRIDE


/datum/bodypart_overlay/mutant/wings/functional/locked/original_color/override_color(rgb_value)
	return COLOR_WHITE // We want to keep those wings as their original color, because it looks better.


/obj/item/organ/wings/angel
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional/original_color

/obj/item/organ/wings/dragon
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional

/obj/item/organ/wings/robotic
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional

/obj/item/organ/wings/slime
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional

/obj/item/organ/wings/skeleton
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional/locked

/obj/item/organ/wings/fly
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional/locked

/obj/item/organ/wings/mothra
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional/locked/original_color

/obj/item/organ/wings/megamoth
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional/locked/original_color
