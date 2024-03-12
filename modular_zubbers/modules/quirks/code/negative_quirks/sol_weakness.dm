
#define COFFIN_HEALING_COST 0.5

/datum/quirk/sol_weakness
	name = "Sol Weakness"
	icon = FA_ICON_SUN
	desc = "Your sub-species of the Hemophage virus renders you weak to Solar radiation, \
		you will have to hide in a coffin or a closet during the day, or risk burning to a crisp. \
		Thankfully, you will also heal your wounds at half cost in a coffin."
	gain_text = span_notice("You feel a sudden weakness in your body, and a burning sensation on your skin. \
		You should find a coffin to hide in during the day.")
	lose_text = span_notice("You feel safe in Sol's embrace once more.")
	medical_record_text = "Patient's strain of the hemophage virus is weak to sunlight. \
		They will have to hide in a coffin or a closet during the day, or risk burning to a crisp."
	value = -4
	hardcore_value = 6
	quirk_flags = QUIRK_HIDE_FROM_SCAN | QUIRK_PROCESSES | QUIRK_HUMAN_ONLY // Time to see how many hemophages are going to get staked
	var/atom/movable/screen/bloodsucker/sunlight_counter/sun_hud
	COOLDOWN_DECLARE(sun_burn)

/datum/quirk/sol_weakness/add()
	if(!quirk_holder.hud_used)
		return
	sun_hud = new(null, quirk_holder.hud_used)
	quirk_holder.hud_used.infodisplay += sun_hud
	quirk_holder.hud_used.show_hud(quirk_holder.hud_used.hud_version)
	SSsunlight.add_sun_sufferer(src)
	RegisterSignal(SSsunlight, COMSIG_SOL_RISE_TICK, PROC_REF(sun_risen))
	RegisterSignal(SSsunlight, COMSIG_SOL_WARNING_GIVEN, PROC_REF(sun_warning))
	update_hud()

/datum/quirk/sol_weakness/remove()
	if(sun_hud)
		quirk_holder.hud_used.infodisplay -= sun_hud
		QDEL_NULL(sun_hud)
	SSsunlight.remove_sun_sufferer(src)
	UnregisterSignal(SSsunlight, list(COMSIG_SOL_RISE_TICK, COMSIG_SOL_WARNING_GIVEN))

/datum/quirk/sol_weakness/can_add(mob/target)
	return ishemophage(target) && !IS_BLOODSUCKER(target)

/datum/quirk/sol_weakness/process(seconds_per_tick)
	var/datum/status_effect/blood_regen_active/regen = quirk_holder?.has_status_effect(/datum/status_effect/blood_regen_active)
	if(in_coffin() && ishemophage(quirk_holder))
		if(!regen)
			return
		// free healing as long as you're in a coffin
		regen.cost_blood = COFFIN_HEALING_COST
	else if(regen?.blood_to_health_multiplier == COFFIN_HEALING_COST)
		regen.cost_blood = initial(regen.blood_to_health_multiplier)
	update_hud()

/datum/quirk/sol_weakness/proc/update_hud()
	SIGNAL_HANDLER
	sun_hud?.update_sol_hud()

/datum/quirk/sol_weakness/proc/sun_risen()
	SIGNAL_HANDLER
	if(!istype(quirk_holder.loc, /obj/structure))
		sun_burn()
	else
		if(in_coffin())
			quirk_holder.add_mood_event("vampsleep", /datum/mood_event/coffinsleep/quirk)
			sun_burn_message(span_warning("The sun is up, but you sleep soundly in your [quirk_holder.loc]."))
		else
			quirk_holder.add_mood_event("vampsleep", /datum/mood_event/daylight_bad_sleep)
			quirk_holder.adjustFireLoss(1)
			sun_burn_message(span_warning("[quirk_holder.loc] is not a coffin, but it keeps you safe enough."))

/datum/quirk/sol_weakness/proc/sun_burn()
	quirk_holder.add_mood_event("vampsleep", /datum/mood_event/daylight_sun_scorched)
	if(quirk_holder.blood_volume > BLOOD_VOLUME_MAXIMUM * 0.5)
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

/datum/quirk/sol_weakness/proc/sun_warning(atom/source, danger_level, vampire_warning_message, vassal_warning_message)
	SIGNAL_HANDLER
	if(danger_level == DANGER_LEVEL_SOL_ROSE)
		vampire_warning_message = span_userdanger("Solar flares bombard the station with deadly UV light! Stay in cover for the next [TIME_BLOODSUCKER_DAY / 60] minutes or risk death!")
	SSsunlight.warn_notify(quirk_holder, danger_level, vampire_warning_message)

/datum/quirk/sol_weakness/proc/in_coffin()
	return istype(quirk_holder.loc, /obj/structure/closet/crate/coffin)

#undef COFFIN_HEALING_COST
