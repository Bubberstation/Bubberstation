#define ANVIL_HAMMER_HIT_GOOD 1
#define ANVIL_HAMMER_HIT_BAD 0
#define ANVIL_HAMMER_HIT_PERFECT 2
#define ANVIL_HAMMER_HIT_CANNOT_WORK 3
#define ANVIL_SMITHING_CHIP_QUALITY_BONUS 0.5

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

	//what happens when quenched or cooled?
	var/datum/callback/quench_callback = null
	var/datum/callback/passive_cool_callback = null
	//do we change the reagents imbued?
	var/quench_causes_reimbue = TRUE
	//index: what type of effect (ex. increase armor, increase AP, increase force)
	//element: by how much to increase
	var/list/quench_effects_perfection = list()
	var/list/quench_effects_incompletion = list()
	//use this to track the completion/perfection amounts last applied upon quench
	var/perfection_ratio_applied = 0
	var/completion_applied_multiplier = 0
	COOLDOWN_DECLARE(heating_remainder)

/* Gives a given item the smithable component -- which allows it to be picked up with tongs, smithed with a hammer, and quenched in reagent.
 *
 * completion_needed: The number of quality points (increased by hammer strikes) required to finish the item.
 * can_perfect: If perfect strikes are possible on this equipment piece.
 * max_perfection: Maximum perfection points to fully perfect this piece of equipment.
 * max_breakage: How many bad hits can be done before it breaks
 * wait_time: Time between strikes needed for it to no longer be considered a bad hit
 * on_quench: What function on the parent item to call when this item is quenched.
 * on_passive_cool: What function on the parent item to call when this item loses all heat.
 * on_forging_heat: What function on the parent item to call when this item is heated in a forge.
 * color: The color to use when the parent item is heated.
 * perfection_effects: What effects to apply based on the % perfection. (Associative list.)
 * incompletion_effects: What penalties to apply based on how incomplete this item is at quench. (Associative list.)
 */
/datum/component/forge_smithable/Initialize(completion_needed, can_perfect, max_perfection, max_breakage, wait_time, datum/callback/on_quench = null, datum/callback/on_passive_cool = null, datum/callback/on_forging_heat = null, color = "#FF4400", list/perfection_effects = null, list/incompletion_effects = null)
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
	if(length(color) > 0)
		heat_color = color
	if(!isnull(perfection_effects))
		quench_effects_perfection = perfection_effects
	if(!isnull(incompletion_effects))
		quench_effects_incompletion = incompletion_effects
	RegisterSignal(parent_item, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/component/forge_smithable/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_notice("It can be safely picked up with tongs.")
	examine_list += span_notice("It can be heated by being inserted into a forge.")
	examine_list += span_notice("It can be quenched in any open container that's large enough.")
	if(USER_CAN_SEE_SMITHING_INFO(user))
		examine_list += span_notice("You'd estimate that it's about [round(get_completion_ratio() * 100)]% complete.")
		examine_list += span_notice("The careful smithing makes it look about [round(get_perfect_ratio() * 100)]% perfected.")
		if(COOLDOWN_FINISHED(src, heating_remainder))
			examine_list += span_notice("The metal needs to be reheated before it is malleable again.")
		else
			examine_list += span_notice("The metal is hot enough to work.")

	else
		examine_list += span_notice("If you were more skilled at smithing you could discern more information from it...")


/datum/component/forge_smithable/proc/good_hit(amount = 1, playsound = FALSE)
	quality_points = clamp(amount + quality_points, 0, completion_quality_points)
	if(playsound)
		playsound(parent_item, 'sound/items/weapons/parry.ogg', vol = 45, vary = TRUE, frequency = 1.3, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, volume_preference = /datum/preference/numeric/volume/sound_ambience_volume)

/datum/component/forge_smithable/proc/perfect_hit(amount = 1, playsound = FALSE)
	good_hit(amount, FALSE)
	if(playsound)
		playsound(parent_item, 'sound/items/weapons/parry.ogg', vol = 45, vary = TRUE, frequency = 1.0, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, volume_preference = /datum/preference/numeric/volume/sound_ambience_volume)
	if(current_perfects < max_perfect_hits)
		current_perfects = clamp(current_perfects + amount, 0, max_perfect_hits)

/datum/component/forge_smithable/proc/bad_hit(amount = 2, playsound = FALSE)
	bad_hits_total += amount
	if(check_for_breakage())
		forging_breakage()
	else
		if(playsound)
			playsound(parent_item, 'sound/items/weapons/parry.ogg', vol = 35, vary = TRUE, frequency = 0.4, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, volume_preference = /datum/preference/numeric/volume/sound_ambience_volume)

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
	if(!HAS_TRAIT(user, TRAIT_DEAF))
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
		if(reagent_component.imbued_reagent.reagent_list.len >= 1 && !USER_CAN_REAGENT_IMBUE(user))
			return ANVIL_HAMMER_HIT_CANNOT_WORK

	if(!COOLDOWN_FINISHED(user, striking_cooldown))
		return ANVIL_HAMMER_HIT_BAD

	if(can_perfect_hit)
		if(user.mind.get_skill_level(/datum/skill/smithing) >= SKILL_LEVEL_LEGENDARY)
			return ANVIL_HAMMER_HIT_PERFECT
		if(!COOLDOWN_FINISHED(user, perfect_strike_window) && COOLDOWN_FINISHED(user, striking_cooldown))
			return ANVIL_HAMMER_HIT_PERFECT

	return ANVIL_HAMMER_HIT_GOOD

/datum/component/forge_smithable/proc/get_quality_points(mob/living/user, obj/item/tool)
	var/total_quality_points = 1

	total_quality_points *= get_material_quality_points_mult(parent_item.get_master_material())

	//toolspeed doesn't affect the speed at which you strike the anvil, but it DOES affect the quality points gained (and thus how quickly the item is finished completion)
	total_quality_points /= tool.toolspeed

	//if the user has advanced smithing, then they also get a smithing hit bonus
	if(HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING))
		total_quality_points += ANVIL_SMITHING_CHIP_QUALITY_BONUS

	//finally, all hits have a minimum quality amount
	total_quality_points = max(MINIMUM_SMITHING_QUALITY_POINTS, total_quality_points)

	return total_quality_points

/datum/component/forge_smithable/proc/reset(reset_perfects = FALSE)
	quality_points = 0
	bad_hits_total = 0
	if(reset_perfects)
		current_perfects = 0

////////////////////// FOR ACTUAL SMITHING ACTIONS /////////////////////////

/* Tries to apply a hit onto the item using the tool. Will calculate the appropriate hit quality and increase the completion based on that.
 *
 * user: The user who is trying to smith.
 * tool: The tool they are using to smith with.
 */
/datum/component/forge_smithable/proc/anvil_work(mob/living/user, obj/item/tool)
	if(COOLDOWN_FINISHED(src, heating_remainder))
		bad_hit()
		user.balloon_alert(user, "metal too cool")
		return ITEM_INTERACT_SUCCESS

	var/quality_points_to_give = get_quality_points(user, tool)
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
			user.mind.adjust_experience(/datum/skill/smithing, 5) //A perfect hit gives good experience
			do_sparks(2, FALSE, parent_item)

	show_balloon_alert(user, hit_quality)

	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * average_wait
	COOLDOWN_START(user, striking_cooldown, skill_modifier)
	COOLDOWN_START(user, perfect_strike_window, skill_modifier + (user.mind.get_skill_level(/datum/skill/smithing) DECISECONDS / 2))

/* Attempts to quench the item using the given reagents. The reagents source must fill certain criteria to be elligible to do this -- and various effects can apply depending on the reagents used and their temp.
 *
 * dunk_reagents: The reagents source to try and use.
 * dunk_object: The container of the reagents source.
 * user: The person trying to quench the item.
 * show_message: Should we show a message of the quench outcome?
 */
/datum/component/forge_smithable/proc/try_quench(datum/reagents/dunk_reagents, dunk_object, mob/living/user, show_message = TRUE)
	if(COOLDOWN_FINISHED(src, heating_remainder))
		if(show_message)
			parent_item.balloon_alert(user, "[parent_item] is too cool to successfully quench!")
		return FALSE
	if(!(dunk_reagents.flags & DUNKABLE))
		if(show_message)
			parent_item.balloon_alert(user, "[dunk_object] doesn't have a large enough hole to immerse [parent_item]!")
		return FALSE
	if(dunk_reagents.chem_temp > MAX_QUENCH_HEAT)
		if(show_message)
			parent_item.balloon_alert(user, "[dunk_object] is too hot to cool [parent_item]!")
		return FALSE
	if(dunk_reagents.total_volume < MIN_VOLUME_TO_QUENCH)
		if(show_message)
			parent_item.balloon_alert(user, "[dunk_object] doesn't contain enough fluid to immerse [parent_item]!")
		return FALSE

	dunk_reagents.expose_temperature(HEAT_GIVEN_FROM_QUENCHING_METAL)
	COOLDOWN_RESET(src, heating_remainder)
	playsound(parent_item, 'modular_skyrat/modules/reagent_forging/sound/hot_hiss.ogg', 50, TRUE)

	if(!isnull(heat_color))
		parent_item.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY)
	parent_item.update_integrity(max(round(lerp(0, parent_item.max_integrity, get_completion_ratio())), parent_item.get_integrity()))
	if(quench_causes_reimbue && USER_CAN_REAGENT_IMBUE(user))
		var/datum/component/reagent_imbued/my_imbue = parent_item.GetComponent(/datum/component/reagent_imbued)
		if(!isnull(my_imbue))
			my_imbue.set_reagent_imbue(dunk_reagents, FALSE, TRUE)
			if(show_message)
				parent_item.balloon_alert(user, "[parent_item] is imbued!")
	else if(show_message)
		parent_item.balloon_alert(user, "[parent_item] is quenched!")

	if(!isnull(quench_callback))
		quench_callback.Invoke(dunk_reagents, dunk_object, user)
	return TRUE

/* Heats the item up for smithing -- and also colors the item with heat colors if applicable.
 *
 * heat_time: The time until the item cools again.
 * additive: If reheating an already-hot item extends the time or not.
 */
/datum/component/forge_smithable/proc/heat_for_smithing(heat_time, additive = FALSE)
	if(!isnull(heat_color))
		parent_item.add_atom_colour(color_transition_filter(heat_color, SATURATION_OVERRIDE), TEMPORARY_COLOUR_PRIORITY)
	if(additive)
		COOLDOWN_START(src, heating_remainder, heat_time + COOLDOWN_TIMELEFT(src, heating_remainder))
	else
		COOLDOWN_START(src, heating_remainder, heat_time)

/* Sets the item's completion and perfection amount -- and applies the bonuses and penalties based on that.
 *
 * completion_amount: The completion points amount to set.
 * perfection_amount: The perfection points amount to set.
 */
/datum/component/forge_smithable/proc/set_completion_and_perfection(completion_amount, perfection_amount)
	quality_points = completion_amount
	current_perfects = perfection_amount
	apply_completion_perfection_modifiers(get_completion_ratio(), get_perfect_ratio())

/* Sets the item's completion and perfection amount perentage -- and applies the bonus and penalties based on that.
 *
 * completion_ratio: The completion amount to set (as a decimal from 0.0 - 1.0 inclusive)
 * perfection_ratio: The perfection amount to set (as a decimal from 0.0 - 1.0 inclusive)
 */
/datum/component/forge_smithable/proc/set_completion_and_perfection_ratios(completion_ratio, perfection_ratio)
	quality_points = round(completion_ratio * completion_quality_points)
	current_perfects = round(perfection_ratio * max_perfect_hits)
	apply_completion_perfection_modifiers(completion_ratio, perfection_ratio)

/* Applies the incompletion penalty and perfection bonus to the item with the given amounts.
 *
 * completion_ratio: The completion amount to set (as a decimal from 0.0 - 1.0 inclusive)
 * perfection_ratio: The perfection amount to set (as a decimal from 0.0 - 1.0 inclusive)
 */
/datum/component/forge_smithable/proc/apply_completion_perfection_modifiers(completion_ratio, perfection_ratio)
	for(var/index in quench_effects_perfection)
		give_added_modifying_effect_to_item(index, perfection_ratio_applied, perfection_ratio, parent_item, quench_effects_perfection[index])

	var/incompletion_multiplier
	var/incomplete_maximum_penalty
	if(completion_ratio < 1)
		incompletion_multiplier = 1 - lerp(MIN_INCOMPLETE_FORGING_SCALING_PENALTY, MAX_INCOMPLETE_FORGING_SCALING_PENALTY, completion_ratio)
	else
		incompletion_multiplier = 0
	for(var/index in quench_effects_incompletion)
		switch(index)
			if(FORGE_EFFECT_ARMOR)
				var/datum/armor/temp_armor = get_armor_by_type(parent_item.get_initial_armor_type())
				incomplete_maximum_penalty = temp_armor.generate_new_with_multipliers(list(ARMOR_ALL = -1))
			if(FORGE_EFFECT_ARMORPEN)
				incomplete_maximum_penalty = initial(parent_item.armour_penetration) * -1
			if(FORGE_EFFECT_BLOCKCHANCE)
				incomplete_maximum_penalty = initial(parent_item.block_chance) * -1
			if(FORGE_EFFECT_DURABILITY)
				incomplete_maximum_penalty = initial(parent_item.max_integrity) * -1
			if(FORGE_EFFECT_FORCE)
				incomplete_maximum_penalty = initial(parent_item.force) * -1
			if(FORGE_EFFECT_REAGENT_INJECT)
				var/datum/component/reagent_imbued/reagent_component = parent_item.GetComponent(/datum/component/reagent_imbued)
				if(!isnull(reagent_component))
					stack_trace("[parent_item] has an invalid reagent imbue-enhancing effect, because it has no reagent component!")
				incomplete_maximum_penalty = initial(reagent_component.inject_amount) * -1
			if(FORGE_EFFECT_TOOLSPEED)
				incomplete_maximum_penalty = initial(parent_item.toolspeed) * 2
			else
				stack_trace("Tried to modify [parent_item] with an invalid effect [index]!")
		give_added_modifying_effect_to_item(index, completion_applied_multiplier, incompletion_multiplier, parent_item, incomplete_maximum_penalty)

	perfection_ratio_applied = perfection_ratio
	completion_applied_multiplier = incompletion_multiplier

/mob/living
	//the time between each strike
	COOLDOWN_DECLARE(striking_cooldown)
	//the time it takes to prepare a perfect strike. should always be > striking_cooldown
	COOLDOWN_DECLARE(perfect_strike_window)

#undef ANVIL_HAMMER_HIT_GOOD
#undef ANVIL_HAMMER_HIT_BAD
#undef ANVIL_HAMMER_HIT_PERFECT
#undef ANVIL_HAMMER_HIT_CANNOT_WORK
#undef ANVIL_SMITHING_CHIP_QUALITY_BONUS
