#define AUTO_SMITHING_SPEED_PENALTY 6 DECISECONDS
#define ANVIL_HAMMER_HIT_GOOD 1
#define ANVIL_HAMMER_HIT_BAD 0
#define ANVIL_HAMMER_HIT_PERFECT 2
#define ANVIL_SMITHING_CHIP_QUALITY_BONUS 1

/obj/structure/reagent_anvil
	name = "smithing anvil"
	desc = "Essentially a big block of metal that you can hammer other metals on top of, crucial for anyone working metal by hand."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "anvil_empty"

	anchored = TRUE
	density = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)

/obj/structure/reagent_anvil/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/falling_hazard, damage = 40, wound_bonus = 10, hardhat_safety = FALSE, crushes = TRUE)

/obj/structure/reagent_anvil/update_appearance()
	. = ..()
	cut_overlays()
	if(!length(contents))
		return

	var/image/overlayed_item = image(icon = contents[1].icon, icon_state = contents[1].icon_state)
	overlayed_item.transform = matrix(, 0, 0, 0, 0.8, 0)
	add_overlay(overlayed_item)

/obj/structure/reagent_anvil/examine(mob/user)
	. = ..()
	. += span_notice("You can place <b>hot metal objects</b> on this using some <b>tongs</b>.")
	. += span_notice("It can be (un)secured by <b>Right Clicking</b> with your bare hand.")

	if(length(contents))
		. += span_notice("It has [contents[1]] sitting on it.")
		//if(istype(contents[1],/obj/item/forging/incomplete))
		. += span_notice("<b>Left Click</b> with a <b>forging mallet</b> to <b>hammer the metal with precise strikes</b>.")
		if(HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING))
			. += span_notice("If you strike precisely enough, you can get a <b>perfect hit!</b>")
		else
			. += span_notice("If you had the right skillchip, you could work the metal to a higher quality...")
		. += span_notice("<b>Right Click</b> with a <b>forging mallet</b> to <b>hammer the metal with a steady tempo</b>.")
		. += span_notice("You could remove [contents[1]] with some <b>tongs.</b>")

/obj/structure/reagent_anvil/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!can_interact(user) || !user.can_perform_action(src))
		return

	set_anchored(!anchored)
	balloon_alert_to_viewers(anchored ? "secured" : "unsecured")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/reagent_anvil/wrench_act(mob/living/user, obj/item/tool)
	balloon_alert_to_viewers("deconstructing...")

	if(!do_after(user, 2 SECONDS, src))
		balloon_alert_to_viewers("stopped deconstructing")
		return TRUE

	tool.play_tool_sound(src)
	deconstruct(TRUE)
	return TRUE

/obj/structure/reagent_anvil/atom_deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/iron/ten(get_turf(src))
	return ..()

/obj/structure/reagent_anvil/tong_act(mob/living/user, obj/item/tool)
	var/obj/item/forging/forge_item = tool
	var/obj/obj_anvil_search = locate() in contents

	if(forge_item.in_use)
		balloon_alert(user, "already in use")
		return ITEM_INTERACT_SUCCESS

	var/obj/obj_tong_search = locate() in forge_item.contents
	if(obj_anvil_search && !obj_tong_search)
		obj_anvil_search.forceMove(forge_item)
		update_appearance()
		forge_item.icon_state = "tong_full"
		return ITEM_INTERACT_SUCCESS

	if(!obj_anvil_search && obj_tong_search)
		obj_tong_search.forceMove(src)
		update_appearance()
		forge_item.icon_state = "tong_empty"
		return ITEM_INTERACT_SUCCESS

/obj/structure/reagent_anvil/hammer_act(mob/living/user, obj/item/tool)
	conditional_pref_sound(src, 'modular_skyrat/modules/reagent_forging/sound/forge.ogg', vol = 35, vary = TRUE, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE, pref_to_check = /datum/preference/numeric/volume/sound_ambience_volume)

	//do we have an incomplete item to hammer out? if so, here is our block of code
	var/obj/item/forging/incomplete/locate_incomplete = locate() in contents
	if(locate_incomplete)
		if(istype(tool, /obj/item/forging/hammer))
			var/obj/item/forging/hammer/hammer_tool = tool
			return hammer_work(user, hammer_tool, locate_incomplete)
		else
			balloon_alert(user, "You need a forging hammer to forge!")


	//okay, so we didn't find an incomplete item to hammer, do we have a hammerable item?
	var/obj/locate_obj = locate() in contents
	if(locate_obj && (locate_obj.skyrat_obj_flags & ANVIL_REPAIR))
		if(locate_obj.GetComponent(/datum/component/reagent_imbued))
			var/datum/component/reagent_imbued/reagent_component = locate_obj.GetComponent(/datum/component/reagent_imbued)
			if(reagent_component.imbued_reagent.reagent_list.len >= 1 && !HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING))
				to_chat(user, span_danger("You don't know the right trick to repair imbued weapons!"))
				return ITEM_INTERACT_BLOCKING
		if(locate_obj.get_integrity() >= locate_obj.max_integrity)
			balloon_alert(user, "already repaired")
			return ITEM_INTERACT_BLOCKING

		locate_obj.repair_damage(locate_obj.get_integrity() + 10)
		user.mind.adjust_experience(/datum/skill/smithing, 5) //repairing does give some experience
		conditional_pref_sound(src, 'modular_skyrat/modules/reagent_forging/sound/forge.ogg', vol = 35, vary = TRUE, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE, pref_to_check = /datum/preference/numeric/volume/sound_ambience_volume)

	return ITEM_INTERACT_SUCCESS

/obj/structure/reagent_anvil/hammer_act_secondary(mob/living/user, obj/item/tool)
	var/obj/item/forging/incomplete/my_anvil_item = contents[1]
	if(!isnull(my_anvil_item))
		balloon_alert_to_viewers("hammering steadily...")
		while(!should_stop_autohammering())
			var/wait_between_swings = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) DECISECONDS
			if(istype(my_anvil_item, /obj/item/forging/incomplete))
				wait_between_swings *= my_anvil_item.average_wait
			else
				wait_between_swings += 1 SECONDS
			wait_between_swings += AUTO_SMITHING_SPEED_PENALTY

			if(!do_after(user, wait_between_swings, target = src))
				balloon_alert_to_viewers("stopped hammering")
				break
			else
				hammer_act(user, tool)

		return ITEM_INTERACT_SUCCESS

/obj/structure/reagent_anvil/proc/hammer_work(mob/living/user, obj/item/forging/hammer/tool, obj/item/forging/incomplete/incomplete_item)
	if(incomplete_item.is_finished_smithing()) //to prevent people from getting perfect perfects
		user.balloon_alert(user, "[incomplete_item] seems ready")
		return ITEM_INTERACT_SUCCESS

	if(COOLDOWN_FINISHED(incomplete_item, heating_remainder))
		incomplete_item.bad_hit()
		balloon_alert(user, "metal too cool")
		return ITEM_INTERACT_SUCCESS

	var/quality_points_to_give = 1 + (HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING) ? ANVIL_SMITHING_CHIP_QUALITY_BONUS : 0)
	switch(get_hit_quality(user, tool))
		if(ANVIL_HAMMER_HIT_BAD)
			incomplete_item.bad_hit(playsound = TRUE)
			balloon_alert(user, "bad hit")
		if(ANVIL_HAMMER_HIT_GOOD)
			incomplete_item.good_hit(amount = quality_points_to_give, playsound = TRUE)
			balloon_alert(user, "good hit")
			user.mind.adjust_experience(/datum/skill/smithing, 1) //A good hit gives mild experience
			do_sparks(1, FALSE, src)
		if(ANVIL_HAMMER_HIT_PERFECT)
			incomplete_item.perfect_hit(amount = quality_points_to_give, playsound = TRUE)
			balloon_alert(user, "perfect hit!")
			user.mind.adjust_experience(/datum/skill/smithing, 10) //A perfect hit gives good experience
			do_sparks(2, FALSE, src)

	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * incomplete_item.average_wait
	//todo: change tool cooldown to be attached onto the user
	COOLDOWN_START(user, striking_cooldown, skill_modifier)
	COOLDOWN_START(user, perfect_strike_window, skill_modifier + user.mind.get_skill_level(/datum/skill/smithing) DECISECONDS)

	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/reagent_anvil/proc/get_hit_quality(mob/living/user, obj/item/forging/hammer/tool)
	if(HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING))
		if(user.mind.get_skill_level(/datum/skill/smithing) >= SKILL_LEVEL_LEGENDARY)
			return ANVIL_HAMMER_HIT_PERFECT
		if(!COOLDOWN_FINISHED(user, perfect_strike_window) && COOLDOWN_FINISHED(user, striking_cooldown))
			return ANVIL_HAMMER_HIT_PERFECT

	if(!COOLDOWN_FINISHED(user, striking_cooldown))
		return ANVIL_HAMMER_HIT_BAD

	return ANVIL_HAMMER_HIT_GOOD

/obj/structure/reagent_anvil/proc/should_stop_autohammering()
	if(istype(contents[1], /obj/item/forging/incomplete))
		var/obj/item/forging/incomplete/my_incomplete_item = contents[1]
		if(my_incomplete_item.is_finished_smithing())
			return TRUE
		if(COOLDOWN_FINISHED(my_incomplete_item, heating_remainder))
			return TRUE
		return FALSE


/obj/structure/reagent_anvil/onZImpact(turf/impacted_turf, levels, message = TRUE)
	var/mob/living/poor_target = locate(/mob/living) in impacted_turf
	if(!poor_target)
		return ..()

	poor_target.apply_damage(60 * levels, forced = TRUE)

	if(istype(poor_target, /mob/living/carbon)) //If this mob is a carbon, break a few of their limbs
		poor_target.take_bodypart_damage(40 * levels, wound_bonus = 5 * levels)
		poor_target.take_bodypart_damage(40 * levels, wound_bonus = 5 * levels)

	poor_target.AddElement(/datum/element/squish, 30 SECONDS)
	poor_target.visible_message(
		span_bolddanger("[src] falls on [poor_target], crushing them!"),
		span_userdanger("You are crushed by [src]!")
	)
	poor_target.Paralyze(5 SECONDS)
	poor_target.emote("scream")
	playsound(poor_target, 'sound/effects/magic/clockwork/fellowship_armory.ogg', 50, TRUE)
	add_memory_in_range(poor_target, 7, /datum/memory/witness_vendor_crush, protagonist = poor_target, antognist = src)
	return TRUE
