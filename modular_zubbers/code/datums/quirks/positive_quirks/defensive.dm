/datum/quirk/defensive
	name = "Jerk"
	desc = "You are rude and impatient, and want people to get out of your way. "
	icon = FA_ICON_FROWN_OPEN
	medical_record_text = "Patient has anger issues."
	value = 6
	gain_text = span_notice("You feel like punching someone.")
	lose_text = span_notice("You feel calmer.")
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	COOLDOWN_DECLARE(shovingspam)

/datum/quirk/defensive/add(client/client_source)
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_LIVING_MOB_BUMP, PROC_REF(on_bump))

/datum/quirk/defensive/proc/on_bump(mob/living/bumped)
	SIGNAL_HANDLER
	ASYNC
		if(!COOLDOWN_FINISHED(src, shovingspam))
			return
		if(quirk_holder.get_active_held_item())
			return
		if(HAS_TRAIT(quirk_holder, TRAIT_RESTRAINED))
			return
		var/list/problems = oview(1, quirk_holder)
		var/list/actual_problems = list()
		for(var/mob/living/problem in problems)
			if(problem == quirk_holder)
				continue
			if(istype(problem, /mob/living))
				actual_problems |= problem
		var/mob/living/intheway = pick(actual_problems)
		if(prob(75))
			quirk_holder.ClickOn(intheway, list2params(list(RIGHT_CLICK = RIGHT_CLICK)))
		else
			quirk_holder.set_combat_mode(TRUE)
			quirk_holder.ClickOn(intheway)
		COOLDOWN_START(src, shovingspam, 5 SECONDS)

/datum/quirk/defensive/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_LIVING_MOB_BUMP)



