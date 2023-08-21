/datum/reagent/drug/methamphetamine/borer_version
	name = "Unknown Methamphetamine Isomer"

/datum/reagent/drug/methamphetamine/borer_version/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	var/high_message = pick("You feel hyper.", "You feel like you need to go faster.", "You feel like you can run the world.")
	if(SPT_PROB(2.5, delta_time))
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("tweaking", /datum/mood_event/stimulant_medium, name)
	M.AdjustStun(-40 * REM * delta_time)
	M.AdjustKnockdown(-40 * REM * delta_time)
	M.AdjustUnconscious(-40 * REM * delta_time)
	M.AdjustParalyzed(-40 * REM * delta_time)
	M.AdjustImmobilized(-40 * REM * delta_time)
	M.adjustStaminaLoss(-2 * REM * delta_time, 0)
	M.set_jitter_if_lower(5 SECONDS)
	if(SPT_PROB(2.5, delta_time))
		M.emote(pick("twitch", "shiver"))
	..()
	. = TRUE

