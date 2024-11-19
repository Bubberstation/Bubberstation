
#define COFFIN_HEALING_COST 0.5

/datum/quirk/sol_weakness
	name = "Sol Weakness"
	icon = FA_ICON_SUN
	desc = "Your sub-species of the Hemophage virus renders you weak to Solar radiation, \
		you will have to hide in a coffin or a closet during the day, or risk burning to a crisp. \
		Thankfully, you will also heal your wounds at half cost in a coffin."
	gain_text = span_warning("You feel a sudden weakness in your body, and a burning sensation on your skin. \
		You should find a coffin to hide in during the day.")
	lose_text = span_notice("You feel safe in Sol's embrace once more.")
	medical_record_text = "Patient's strain of the hemophage virus is weak to sunlight. \
		They will have to hide in a coffin or a closet during the day, or risk burning to a crisp."
	value = -4
	hardcore_value = 6
	species_whitelist = list(SPECIES_HEMOPHAGE)
	quirk_flags = QUIRK_HIDE_FROM_SCAN | QUIRK_HUMAN_ONLY
	COOLDOWN_DECLARE(sun_burn)

/datum/quirk/sol_weakness/add()
	RegisterSignal(quirk_holder, COMSIG_MOB_HEMO_BLOOD_REGEN_TICK, PROC_REF(on_blood_healing))
	if(!quirk_holder.hud_used)
		RegisterSignal(quirk_holder, COMSIG_MOB_HUD_CREATED, PROC_REF(add_sun_timer_hud))
		return
	add_sun_timer_hud()

/datum/quirk/sol_weakness/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_HEMO_BLOOD_REGEN_TICK)
	SSsunlight.remove_sun_sufferer(quirk_holder)
	UnregisterSignal(SSsunlight, list(COMSIG_SOL_RISE_TICK, COMSIG_SOL_WARNING_GIVEN))

/datum/quirk/sol_weakness/can_add(mob/target)
	. = ..()
	if(!.)
		return
	return !IS_BLOODSUCKER(target)

/datum/quirk/sol_weakness/proc/on_blood_healing(mob/owner, seconds_between_ticks, datum/status_effect/blood_regen_active/effect)
	if(effect && in_coffin())
		// cheaper healing as long as you're in a coffin
		effect.cost_blood = COFFIN_HEALING_COST
	else
		effect.cost_blood = initial(effect.cost_blood)
	// prevent healing if sol is active
	return SSsunlight.sunlight_active ? COMSIG_CANCEL_MOB_HEMO_BLOOD_REGEN : NONE

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
			sun_burn_message(span_warning("The sun is up, but you safely rest in your [quirk_holder.loc]."))
		else
			quirk_holder.add_mood_event("vampsleep", /datum/mood_event/daylight_bad_sleep)
			quirk_holder.adjustFireLoss(1)
			sun_burn_message(span_warning("[quirk_holder.loc] is not a coffin, but it keeps you safe enough."))

/datum/quirk/sol_weakness/proc/sun_burn()
	quirk_holder.add_mood_event("vampsleep", /datum/mood_event/daylight_sun_scorched)
	if(quirk_holder.blood_volume > BLOOD_VOLUME_NORMAL * 0.71) // 397.6
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
	return istype(quirk_holder.loc, /obj/structure/closet/crate/coffin)

/datum/status_effect/blood_regen_active/tick(seconds_between_ticks)
	if(SEND_SIGNAL(owner, COMSIG_MOB_HEMO_BLOOD_REGEN_TICK, seconds_between_ticks, src) & COMSIG_CANCEL_MOB_HEMO_BLOOD_REGEN)
		return
	. = ..()

#undef COFFIN_HEALING_COST
