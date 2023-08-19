/datum/reagent/drug/methamphetamine/borer_version
	name = "Unknown Methamphetamine Isomer"
	overdose_threshold = 40

/datum/reagent/drug/methamphetamine/borer_version/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	var/high_message = pick("You feel hyper.", "You feel like you need to go faster.", "You feel like you can run the world.")
	if(DT_PROB(2.5, delta_time))
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("tweaking", /datum/mood_event/stimulant_medium, name)
	M.AdjustStun(-40 * REM * delta_time)
	M.AdjustKnockdown(-40 * REM * delta_time)
	M.AdjustUnconscious(-40 * REM * delta_time)
	M.AdjustParalyzed(-40 * REM * delta_time)
	M.AdjustImmobilized(-40 * REM * delta_time)
	M.adjustStaminaLoss(-2 * REM * delta_time, 0)
	M.set_jitter_if_lower(5 SECONDS)
	if(DT_PROB(2.5, delta_time))
		M.emote(pick("twitch", "shiver"))
	..()
	. = TRUE

/datum/reagent/drug/methamphetamine/borer_version/overdose_start(mob/living/carbon/M)
	to_chat(M, span_notice("You suddenly feel like you can run for hours!"))

/datum/reagent/drug/methamphetamine/borer_version/overdose_process(mob/living/carbon/M, delta_time, times_fired)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, (rand(5, 10) / 10) * REM * seconds_per_tick, required_organ_flag = affected_organ_flags)
	return ..()
