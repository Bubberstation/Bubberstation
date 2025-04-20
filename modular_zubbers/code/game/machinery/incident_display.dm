/**
 * Adds a disease outbreak epidemic function to incident displays
 */

/// Display days since last delam on incident sign
#define DISPLAY_DELAM (1<<0)
/// Display current number of tram hits on incident sign
#define DISPLAY_TRAM (1<<1)
/// Display current number of tram hits on incident sign
#define DISPLAY_DISEASE (1<<2)

#define TREND_RISING "rising"
#define TREND_FALLING "falling"

#define NAME_DELAM "delamination incident display"
#define NAME_TRAM "tram incident display"
#define NAME_DISEASE "epidemic display"

#define DESC_DELAM "A signs describe how long it's been since the last delamination incident. Features an advert for SAFETY MOTH."
#define DESC_TRAM "A display that provides the number of tram related safety incidents this shift."
#define DESC_DISEASE "A display that provides the number of active disease outbreak cases on shift.<br/><span class='boldwarning'>Doctor-Patient confidentiality is not practised on this station.</span>" // BUBBER EDIT ADDITION - Disease Counter


/obj/machinery/incident_display
	icon = 'modular_zubbers/icons/obj/machines/incident_display.dmi'
	/// Disease metric digits color
	var/disease_display_color = "#4bfba5"
	/// Current active event diseases
	var/current_disease_metric = 0
	/// Previous event disease metric
	var/prev_disease_metric = 0
	var/static/list/disease_slogan_good = list(
		"In the event of an epidemic, please try not to panic.",
		"In the event of an epidemic, please try not to breathe.",
		"Please look out for invisible and potentially lethal diseases.",
		"Staff are reminded not to laugh at Patients whilst they are present. Thank you.",
		"Don't interact with other crew members, you don't know where they've been.",
		"Crew members are reminded not to be sick.",
	)
	var/static/list/disease_slogan_bad = list(
		"If you have any questions, first ask yourself why that might be.",
		"Please be on high alert for invisible and potentially lethal diseases!",
		"Staff are reminded not to laugh at Patients whilst they are present. Thank you.",
		"We hope you've enjoyed your stay at the medbay, but not so much that you don't leave... please, eventually leave.",
		"Pretending your doctor is better than they are may aid recovery.",
		"Don't interact with other crew members, you don't know where they've been.",
		"Quality of treatment may depend on Patient behaviour.",
		"Cured Patients should leave the medbay before they catch something else.",
		"Please don't ask how our vaccines work, as, we are not exactly sure.",
	)
	/// How long between slogans
	var/slogan_delay = 10 MINUTES
	COOLDOWN_DECLARE(slogan_cooldown)
	verb_say = "beeps"
	verb_ask = "beeps"
	verb_exclaim = "beeps"

/// Counter board for disease outbreak
/obj/machinery/incident_display/disease
	name = NAME_DISEASE
	desc = DESC_DISEASE
	sign_features = DISPLAY_DISEASE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/incident_display/disease, 32)

/obj/machinery/incident_display/post_machine_initialize()
	. = ..()
	COOLDOWN_START(src, slogan_cooldown, rand(0, slogan_delay))

/obj/machinery/incident_display/process()
	if(COOLDOWN_FINISHED(src, slogan_cooldown) && (sign_features & DISPLAY_DISEASE))
		if(current_disease_metric == 0)
			speak(pick(disease_slogan_good))
		else
			speak(pick(disease_slogan_bad))

		COOLDOWN_START(src, slogan_cooldown, slogan_delay)

	return ..()

/**
 * Speak the given message verbally
 *
 * Checks if the machine is powered and the message exists
 *
 * Arguments:
 * * message - the message to speak
 */
/obj/machinery/incident_display/proc/speak(message)
	if(machine_stat & (BROKEN|NOPOWER))
		return
	if(!message)
		return

	say(message)

/obj/machinery/incident_display/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!isliving(user))
		return

	var/mob/living/living_user = user

	if(held_item?.tool_behaviour == TOOL_WELDER && !living_user.combat_mode && atom_integrity < max_integrity)
		context[SCREENTIP_CONTEXT_LMB] = "repair display"

	if(held_item?.tool_behaviour == TOOL_MULTITOOL && !living_user.combat_mode)
		if(sign_features == DISPLAY_TRAM)
			context[SCREENTIP_CONTEXT_LMB] = "change to disease mode"
		else if(sign_features == DISPLAY_DISEASE)
			context[SCREENTIP_CONTEXT_LMB] = "change to delam mode"
		else if(sign_features == DISPLAY_DELAM)
			context[SCREENTIP_CONTEXT_LMB] = "change to tram mode"

	return CONTEXTUAL_SCREENTIP_SET

/// Switch modes with multitool
/obj/machinery/incident_display/multitool_act(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return FALSE

	if(sign_features == DISPLAY_TRAM)
		tool.play_tool_sound(src)
		balloon_alert(user, "set to disease")
		name = NAME_DISEASE
		desc = DESC_DISEASE
		sign_features = DISPLAY_DISEASE
		update_appearance()
		return TRUE
	else if(sign_features == DISPLAY_DISEASE)
		tool.play_tool_sound(src)
		balloon_alert(user, "set to delam")
		name = NAME_DELAM
		desc = DESC_DELAM
		sign_features = DISPLAY_DELAM
		update_delam_count(SSpersistence.rounds_since_engine_exploded, SSpersistence.delam_highscore)
		update_appearance()
		return TRUE
	else
		tool.play_tool_sound(src)
		balloon_alert(user, "set to tram")
		name = NAME_TRAM
		desc = DESC_TRAM
		sign_features = DISPLAY_TRAM
		update_tram_count(src, SSpersistence.tram_hits_this_round)
		update_appearance()
		return TRUE

/**
 * Update the disease count on the display
 *
 * Use the provided args to update the incident display when in disease mode.
 * Arguments:
 * * current - current active event disease metric
 * * previous - previous cached event disease metric
 */
/obj/machinery/incident_display/proc/update_disease_count(source, current, previous)
	current_disease_metric = min(current, 199)
	prev_disease_metric = min(previous, 199)
	update_appearance()

/obj/machinery/incident_display/examine(mob/user)
	. = ..()
	if(sign_features & DISPLAY_DISEASE)
		. += span_notice("It can be changed to display delam-free shifts with a [EXAMINE_HINT("multitool")].")
		. += span_info("The station has [current_disease_metric] reported active infections incident\s at the moment.")
		if(current_disease_metric == 0)
			. += span_notice("<b>[pick(disease_slogan_good)]</b><br/>")
		else
			. += span_notice("<b>[pick(disease_slogan_bad)]</b><br/>")

#undef DISPLAY_DELAM
#undef DISPLAY_TRAM
#undef DISPLAY_DISEASE

#undef NAME_DELAM
#undef NAME_TRAM
#undef NAME_DISEASE

#undef DESC_DELAM
#undef DESC_TRAM
#undef DESC_DISEASE

#undef TREND_RISING
#undef TREND_FALLING
