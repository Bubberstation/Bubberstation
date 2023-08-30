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


/datum/reagent/lidopaine/borer_version
	name = "Unknown Lidopaine Isomer"
	description = "A paining agent used often for... being a jerk, metabolizes faster than lidocaine."
	metabolization_rate = 0.4 * REAGENTS_METABOLISM

/datum/reagent/lidopaine/borer_version/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	to_chat(M, span_userdanger("Your body aches with unimaginable pain!"))
	M.adjustStaminaLoss(5 * REM * delta_time, 0)
	if(prob(30))
		INVOKE_ASYNC(M, TYPE_PROC_REF(/mob, emote), "scream")
	if(prob(60))
		M.adjustOrganLoss(ORGAN_SLOT_HEART,3 * REM * delta_time, 85)
