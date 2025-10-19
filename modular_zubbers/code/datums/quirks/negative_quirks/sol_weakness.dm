/// Modular changes to the Sol Weakness quirk to adjust for the new Hemophage update

#define COFFIN_HEALING_COST 0.5
#define COFFIN_TYPE /obj/structure/closet/crate/coffin

/datum/quirk/sol_weakness
	name = "Sol Weakness"
	icon = FA_ICON_SUN
	desc = "Your sub-species of the Hemophage virus renders you weak to Solar radiation; \
		you must hide in a coffin or a closet during the day or risk burning to a crisp. \
		While in a coffin, your blood cost for self-healing is halved."
	gain_text = span_warning("You feel a sudden weakness in your body, and a burning sensation on your skin. \
		You should find a coffin to hide in during the day.")
	lose_text = span_notice("You feel safe in Sol's embrace once more.")
	medical_record_text = "Patient's strain of the hemophage virus is weak to sunlight. \
		Must avoid sunlight or risk burns."
	value = -4
	hardcore_value = 6
	quirk_flags = QUIRK_HIDE_FROM_SCAN | QUIRK_HUMAN_ONLY
	#ifdef SPECIES_HEMOPHAGE
	species_whitelist = list(SPECIES_HEMOPHAGE)
	#endif
	COOLDOWN_DECLARE(sun_burn)

	/// Tracks blood volume at the start of a healing tick
	var/list/_refund_start = list()

/datum/quirk/sol_weakness/add_to_holder(mob/living/new_holder, quirk_transfer = FALSE, client/client_source, unique = TRUE, announce = TRUE)
	#ifdef IS_BLOODSUCKER
	if(IS_BLOODSUCKER(new_holder))
		return FALSE
	#endif
	return ..()

/datum/quirk/sol_weakness/add()
	RegisterSignal(quirk_holder, COMSIG_MOB_HEMO_BLOOD_REGEN_TICK, PROC_REF(_on_hemo_heal_tick))

	// SSsunlight HUD and its events
	if(!quirk_holder.hud_used)
		RegisterSignal(quirk_holder, COMSIG_MOB_HUD_CREATED, PROC_REF(add_sun_timer_hud))
		return
	add_sun_timer_hud()

/datum/quirk/sol_weakness/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_HEMO_BLOOD_REGEN_TICK)
	_refund_start.Cut()
	SSsunlight.remove_sun_sufferer(quirk_holder)
	UnregisterSignal(SSsunlight, list(COMSIG_SOL_RISE_TICK, COMSIG_SOL_WARNING_GIVEN))


/datum/quirk/sol_weakness/proc/_on_hemo_heal_tick(mob/living/owner, seconds_between_ticks, datum/status_effect/effect)
	SIGNAL_HANDLER

	// Cancel healing entirely while sunlight is active
	if(SSsunlight.sunlight_active)
		return COMSIG_CANCEL_MOB_HEMO_BLOOD_REGEN

	// Only act on carbons that have a blood volume
	var/mob/living/carbon/carbon_mob = owner
	if(!istype(carbon_mob) || !("blood_volume" in carbon_mob.vars))
		return NONE

	// Only discount if physically inside a coffin right now
	if(!in_coffin())
		return NONE

	_refund_start[effect] = carbon_mob.blood_volume

	// Apply the refund after the healing tick completes
	addtimer(CALLBACK(src, PROC_REF(_apply_refund_after_tick), carbon_mob, effect), 0)
	return NONE

/datum/quirk/sol_weakness/proc/_apply_refund_after_tick(mob/living/carbon/hemophage_mob, datum/status_effect/effect)
	if(!istype(hemophage_mob) || !effect)
		return

	var/starting_blood_volume = _refund_start[effect]
	_refund_start -= effect
	if(isnull(starting_blood_volume))
		return
	if(!in_coffin())
		return
	if(!("blood_volume" in hemophage_mob.vars))
		return

	var/blood_spent = starting_blood_volume - hemophage_mob.blood_volume
	if(blood_spent <= 0)
		return

	// COFFIN_HEALING_COST = 0.5 refunds 50% of what was spent now that blood_count is no longer a variable
	var/blood_refund = blood_spent * (1 - COFFIN_HEALING_COST)
	hemophage_mob.blood_volume += blood_refund

/datum/quirk/sol_weakness/proc/add_sun_timer_hud()
	if(!quirk_holder.hud_used)
		CRASH("Sol Weakness quirk holder has no HUD")
	SSsunlight.add_sun_sufferer(quirk_holder)
	UnregisterSignal(quirk_holder, COMSIG_MOB_HUD_CREATED)
	RegisterSignal(SSsunlight, COMSIG_SOL_RISE_TICK, PROC_REF(sun_risen))
	RegisterSignal(SSsunlight, COMSIG_SOL_WARNING_GIVEN, PROC_REF(sun_warning))

/datum/quirk/sol_weakness/proc/sun_risen()
	SIGNAL_HANDLER
	if(!istype(quirk_holder.loc, /obj/structure))
		sun_burn()
	else
		if(in_coffin())
			quirk_holder.add_mood_event("vampsleep", /datum/mood_event/coffinsleep/quirk)
			sun_burn_message(span_warning("The sun is up, but you safely rest in your [quirk_holder.loc.name]."))
		else
			quirk_holder.add_mood_event("vampsleep", /datum/mood_event/daylight_bad_sleep)
			quirk_holder.adjustFireLoss(1)
			sun_burn_message(span_warning("[quirk_holder.loc] is not a coffin, but it keeps you safe enough."))

/datum/quirk/sol_weakness/proc/sun_burn()
	quirk_holder.add_mood_event("vampsleep", /datum/mood_event/daylight_sun_scorched)

	if(("blood_volume" in quirk_holder.vars) && quirk_holder.blood_volume > BLOOD_VOLUME_NORMAL * 0.71)
		quirk_holder.blood_volume -= 5
		sun_burn_message(span_warning("The sun burns your skin, but your blood protects you from the worst of it..."))
		quirk_holder.adjustFireLoss(1)
		return

	sun_burn_message(span_userdanger("THE SUN, IT BURNS!"))
	quirk_holder.adjustFireLoss(2)
	quirk_holder.adjust_fire_stacks(1)
	quirk_holder.ignite_mob()

/datum/quirk/sol_weakness/proc/sun_burn_message(text)
	SIGNAL_HANDLER
	if(!COOLDOWN_FINISHED(src, sun_burn))
		return
	to_chat(quirk_holder, text)
	COOLDOWN_START(src, sun_burn, 30 SECONDS)

/datum/quirk/sol_weakness/proc/sun_warning(atom/source, danger_level, vampire_warning_message, ghoul_warning_message)
	SIGNAL_HANDLER
	if(danger_level == DANGER_LEVEL_SOL_ROSE)
		vampire_warning_message = span_userdanger("Solar flares bombard the station with deadly UV light! Stay in cover for the next [TIME_BLOODSUCKER_DAY / 60] minutes or risk death!")
	SSsunlight.warn_notify(quirk_holder, danger_level, vampire_warning_message)

/datum/quirk/sol_weakness/proc/in_coffin()
	return istype(quirk_holder?.loc, COFFIN_TYPE)

#undef COFFIN_HEALING_COST
#undef COFFIN_TYPE
