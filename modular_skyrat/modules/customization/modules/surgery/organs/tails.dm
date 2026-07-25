/obj/item/organ/tail
	mutantpart_key = "FEATURE_TAIL"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))
	var/can_wag = TRUE
	var/wagging = FALSE
	organ_flags = ORGAN_EXTERNAL

/datum/bodypart_overlay/mutant/tail
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/tail/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/tail/get_feature_key_for_overlay()
	return (wagging ? "wagging" : "") + feature_key

/datum/bodypart_overlay/mutant/tail/get_base_icon_state()
	return sprite_datum.icon_state

/datum/bodypart_overlay/mutant/tail/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner)
	var/mob/living/carbon/human/wearer = bodypart_owner.owner
	if(!wearer)
		return TRUE
	var/list/used_in_turf = list("tail")
	// Emote exception
	if(wearer.owned_turf?.name in used_in_turf)
		return FALSE

	if(!wearer.w_uniform && !wearer.wear_suit)
		return ..()

	// Can hide if wearing uniform
	if(feature_key in wearer.try_hide_mutant_parts)
		return FALSE

	if(wearer.wear_suit)
		// Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return TRUE

		// Hide accessory if flagged to do so
		else if(wearer.covered_slots & HIDETAIL)
			return FALSE

	return TRUE


/obj/item/organ/tail/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	if(sprite_accessory_flags & SPRITE_ACCESSORY_WAG_ABLE)
		wag_flags |= WAG_ABLE
	return ..()

/obj/item/organ/tail/cat
	mutantpart_info = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list("#FFAA00"))

/obj/item/organ/tail/monkey
	wag_flags = WAG_ABLE // waggable monkey tails
	mutantpart_info = list(MUTANT_INDEX_NAME = "Monkey", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

/obj/item/organ/tail/lizard
	mutantpart_info = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_COLOR_LIST = list("#DDFFDD"))

/obj/item/organ/tail/fluffy
	name = "fluffy tail"

/obj/item/organ/tail/fluffy/no_wag

///A tail that replicates the appearance of fish tails from DNA infusion, but without most of the code that makes them so special.
/obj/item/organ/tail/fake_fish
	name = /obj/item/organ/tail/fish::name
	desc = /obj/item/organ/tail/fish::desc
	icon = /obj/item/organ/tail/fish::icon
	icon_state = /obj/item/organ/tail/fish::icon_state
	post_init_icon_state = /obj/item/organ/tail/fish::post_init_icon_state
	greyscale_config = /obj/item/organ/tail/fish::greyscale_config
	greyscale_colors = /obj/item/organ/tail/fish::greyscale_colors

	bodypart_overlay = /obj/item/organ/tail/fish::bodypart_overlay
	wag_flags = /obj/item/organ/tail/fish::wag_flags
	restyle_flags = /obj/item/organ/tail/fish::restyle_flags

	// Fishlike reagents, you could serve it raw like fish
	food_reagents = /obj/item/organ/tail/fish::food_reagents
	// Seafood instead of meat, because it's a fish organ
	foodtype_flags = /obj/item/organ/tail/fish::foodtype_flags
	// Also just tastes like fish
	food_tastes = /obj/item/organ/tail/fish::food_tastes
	/// The fillet type this fish tail is processable into
	var/fillet_type = /obj/item/food/fishmeat/fish_tail
	/// The amount of fillets this gets processed into
	var/fillet_amount = 3

/obj/item/organ/tail/fake_fish/Initialize(mapload)
	. = ..()
	var/time_to_fillet = fillet_amount * 0.5 SECONDS
	AddElement(/datum/element/processable, TOOL_KNIFE, fillet_type, fillet_amount, time_to_fillet, screentip_verb = "Cut")

/obj/item/organ/tail/fake_fish/on_mob_insert(mob/living/carbon/owner)
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_GIBBER_ACT, PROC_REF(on_gibber_processed))

/obj/item/organ/tail/fake_fish/on_mob_remove(mob/living/carbon/owner)
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_GIBBER_ACT)

/obj/item/organ/tail/fake_fish/proc/on_gibber_processed(mob/living/carbon/owner, mob/living/user, obj/machinery/gibber, list/results)
	SIGNAL_HANDLER
	for(var/iteration in 1 to fillet_amount * 0.5)
		results += new fillet_type
