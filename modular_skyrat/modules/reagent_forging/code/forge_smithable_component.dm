#define ANVIL_HAMMER_HIT_GOOD 1
#define ANVIL_HAMMER_HIT_BAD 0
#define ANVIL_HAMMER_HIT_PERFECT 2
#define ANVIL_HAMMER_HIT_CANNOT_WORK 3
#define ANVIL_SMITHING_CHIP_QUALITY_BONUS 1

/datum/component/forge_smithable
	///the item that the component is attached to
	var/obj/item/parent_item
	///required type to attach to
	var/obj/item/required_type = /obj/item

	///the quality points of the incomplete item; goes up on good/perfect hits
	var/quality_points = 0
	///the quality points required for it to be considered usable for crafting
	var/completion_quality_points = 1
	///the required time before each strike to prevent spamming
	var/average_wait = 100 SECONDS
	///total current bad hits
	var/bad_hits_total = 0
	///the bad hits required for it to break; exceeding this will break the item
	var/bad_hit_maximum = 1
	///the number of current perfect hits
	var/current_perfects = 0
	///maximum number of perfect hits before perfect hits no longer improve the quality
	var/max_perfect_hits = 1
	var/can_perfect_hit = TRUE
	//what color does the parent item turn when heated? if null, then parent item doesn't change color when heated
	var/heat_color = null
	var/datum/callback/quench_callback = null
	var/datum/callback/passive_cool_callback = null
	COOLDOWN_DECLARE(heating_remainder)

/datum/component/forge_smithable/Initialize(completion_needed, can_perfect, max_perfection, max_breakage, wait_time, datum/callback/on_quench = null, datum/callback/on_passive_cool = null, datum/callback/on_forging_heat = null, color = "#FF4400")
	if(!istype(parent, required_type))
		return COMPONENT_INCOMPATIBLE
	parent_item = parent
	average_wait = wait_time
	completion_quality_points = completion_needed
	max_perfect_hits = max_perfection
	bad_hit_maximum = max_breakage
	can_perfect_hit = can_perfect

	quench_callback = on_quench
	passive_cool_callback = on_passive_cool
	if(!isnull(on_quench))
		RegisterSignal(parent_item, COMSIG_SMITHING_QUENCH, on_quench)
	if(!isnull(on_passive_cool))
		RegisterSignal(parent_item, COMSIG_SMITHING_PASSIVE_COOLED, on_passive_cool)//TYPE_PROC_REF(parent_item.type, on_passive_cool))
	heat_color = color

/datum/component/forge_smithable/proc/good_hit(amount = 1, playsound = FALSE)
	quality_points += amount
	if(playsound)
		playsound(parent_item, 'sound/items/weapons/parry.ogg', vol = 35, vary = TRUE, frequency = 1.3, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE, volume_preference = /datum/preference/numeric/volume/sound_ambience_volume)

/datum/component/forge_smithable/proc/perfect_hit(amount = 1, playsound = FALSE)
	good_hit(amount, FALSE)
	if(playsound)
		playsound(parent_item, 'sound/items/weapons/parry.ogg', vol = 35, vary = TRUE, frequency = 1.0, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE, volume_preference = /datum/preference/numeric/volume/sound_ambience_volume)
	if(current_perfects < max_perfect_hits)
		current_perfects += amount

/datum/component/forge_smithable/proc/bad_hit(amount = 2, playsound = FALSE)
	bad_hits_total += amount
	if(check_for_breakage())
		forging_breakage()
	else
		if(playsound)
			playsound(parent_item, 'sound/items/weapons/parry.ogg', vol = 35, vary = TRUE, frequency = 2.2, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE, volume_preference = /datum/preference/numeric/volume/sound_ambience_volume)

/datum/component/forge_smithable/proc/check_for_breakage()
	if(bad_hits_total > bad_hit_maximum)
		return TRUE
	return FALSE

/datum/component/forge_smithable/proc/forging_breakage(playsound = TRUE)
	if(playsound)
		conditional_pref_sound(parent_item, 'modular_skyrat/modules/reagent_forging/sound/forge.ogg', vol = 35, vary = TRUE, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE, pref_to_check = /datum/preference/numeric/volume/sound_ambience_volume)

	parent_item.balloon_alert_to_viewers("the [parent_item] shattered!")
	qdel(parent_item)
	qdel(src)

/datum/component/forge_smithable/proc/is_finished_smithing()
	if(quality_points >= completion_quality_points)
		return TRUE
	return FALSE

/datum/component/forge_smithable/proc/get_completion_ratio()
	return quality_points / completion_quality_points

/datum/component/forge_smithable/proc/is_perfected()
	if(current_perfects >= max_perfect_hits)
		return TRUE
	return FALSE

/datum/component/forge_smithable/proc/get_perfect_ratio()
	return current_perfects / max_perfect_hits

/datum/component/forge_smithable/proc/show_balloon_alert(mob/living/user, hit_quality)
	switch(hit_quality)
		if(ANVIL_HAMMER_HIT_CANNOT_WORK)
			parent_item.balloon_alert(user,"can't work!")
		if(ANVIL_HAMMER_HIT_BAD)
			parent_item.balloon_alert(user,"bad hit")
		if(ANVIL_HAMMER_HIT_GOOD)
			if(is_finished_smithing())
				if(is_perfected())
					parent_item.balloon_alert(user,"[parent_item] is perfected!")
				else
					parent_item.balloon_alert(user,"[parent_item] sounds done")
			else
				parent_item.balloon_alert(user, "good hit")
		if(ANVIL_HAMMER_HIT_PERFECT)
			if(is_finished_smithing() && is_perfected())
				parent_item.balloon_alert(user,"[parent_item] is perfected!")
			else
				parent_item.balloon_alert(user, "perfect hit!")

/datum/component/forge_smithable/proc/get_hit_quality(mob/living/user, obj/item/forging/hammer/tool)
	if(parent_item.GetComponent(/datum/component/reagent_imbued))
		var/datum/component/reagent_imbued/reagent_component = parent_item.GetComponent(/datum/component/reagent_imbued)
		if(reagent_component.imbued_reagent.reagent_list.len >= 1 && !HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING))
			return ANVIL_HAMMER_HIT_CANNOT_WORK

	if(HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING) && can_perfect_hit)
		if(user.mind.get_skill_level(/datum/skill/smithing) >= SKILL_LEVEL_LEGENDARY)
			return ANVIL_HAMMER_HIT_PERFECT
		if(!COOLDOWN_FINISHED(user, perfect_strike_window) && COOLDOWN_FINISHED(user, striking_cooldown))
			return ANVIL_HAMMER_HIT_PERFECT

	if(!COOLDOWN_FINISHED(user, striking_cooldown))
		return ANVIL_HAMMER_HIT_BAD

	return ANVIL_HAMMER_HIT_GOOD

/datum/component/forge_smithable/proc/reset()
	current_perfects = 0
	quality_points = 0
	bad_hits_total = 0

////////////////////// FOR ACTUAL SMITHING ACTIONS /////////////////////////

/datum/component/forge_smithable/proc/anvil_work(mob/living/user, obj/item/tool)
	if(COOLDOWN_FINISHED(src, heating_remainder))
		bad_hit()
		user.balloon_alert(user, "metal too cool")
		return ITEM_INTERACT_SUCCESS

	var/quality_points_to_give = 1 + (HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING) ? ANVIL_SMITHING_CHIP_QUALITY_BONUS : 0)
	var/hit_quality = get_hit_quality(user, tool)
	switch(hit_quality)
		if(ANVIL_HAMMER_HIT_CANNOT_WORK)
			bad_hit(playsound = TRUE)
			to_chat(user, span_warning("You don't know how to work with reagent imbued items!"))
		if(ANVIL_HAMMER_HIT_BAD)
			bad_hit(playsound = TRUE)
		if(ANVIL_HAMMER_HIT_GOOD)
			good_hit(amount = quality_points_to_give, playsound = TRUE)
			user.mind.adjust_experience(/datum/skill/smithing, 1) //A good hit gives mild experience
			do_sparks(1, FALSE, src)
		if(ANVIL_HAMMER_HIT_PERFECT)
			perfect_hit(amount = quality_points_to_give, playsound = TRUE)
			user.mind.adjust_experience(/datum/skill/smithing, 10) //A perfect hit gives good experience
			do_sparks(2, FALSE, parent_item)

	show_balloon_alert(user, hit_quality)

	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * average_wait
	COOLDOWN_START(user, striking_cooldown, skill_modifier)
	COOLDOWN_START(user, perfect_strike_window, skill_modifier + user.mind.get_skill_level(/datum/skill/smithing) DECISECONDS)

/datum/component/forge_smithable/proc/try_quench(datum/reagents/dunk_reagents, dunk_object, mob/living/user)
	if(dunk_reagents.chem_temp > MAX_QUENCH_HEAT)
		parent_item.balloon_alert(user, "[dunk_object] is too hot to cool [parent_item]!")
		return
	if(dunk_reagents.total_volume < MIN_VOLUME_TO_QUENCH)
		parent_item.balloon_alert(user, "[dunk_object] doesn't contain enough fluid to immerse [parent_item]!")
		return
	dunk_reagents.expose_temperature(600)
	if(!isnull(heat_color))
		parent_item.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY)
	quench_callback.Invoke(dunk_reagents, dunk_object, user)
	//SEND_SIGNAL(parent_item, COMSIG_SMITHING_QUENCH, dunk_reagents, dunk_object, user)

/datum/component/forge_smithable/proc/heat_for_smithing(heat_time, additive = FALSE)
	if(!isnull(heat_color))
		parent_item.add_atom_colour(color_transition_filter(heat_color, SATURATION_OVERRIDE), TEMPORARY_COLOUR_PRIORITY)
	if(additive)
		COOLDOWN_START(src, heating_remainder, heat_time + COOLDOWN_TIMELEFT(src, heating_remainder))
	else
		COOLDOWN_START(src, heating_remainder, heat_time)

/mob/living
	//the time between each strike
	COOLDOWN_DECLARE(striking_cooldown)
	//the time it takes to prepare a perfect strike. should always be > striking_cooldown
	COOLDOWN_DECLARE(perfect_strike_window)
