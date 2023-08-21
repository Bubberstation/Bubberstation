/datum/reagent/drug/methamphetamine/borer_version
	name = "Unknown Methamphetamine Isomer"
	overdose_threshold = 30
	addiction_types = list(/datum/addiction/stimulants = 12)

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

/datum/reagent/drug/methamphetamine/borer_version/overdose_start(mob/living/carbon/M)
	to_chat(M, span_notice("You suddenly feel like you can run for hours!"))

/datum/reagent/drug/methamphetamine/borer_version/overdose_process(mob/living/carbon/M, delta_time, times_fired)
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i in 1 to round(4 * REM * delta_time, 1))
			step(M, pick(GLOB.cardinals))
	if(SPT_PROB(10, delta_time))
		M.emote("laugh")
	if(SPT_PROB(18, delta_time))
		M.visible_message(span_danger("[M]'s hands flip out and flail everywhere!"))
		M.drop_all_held_items()
	..()
	M.adjustToxLoss(1 * REM * delta_time, FALSE, required_biotype = affected_biotype)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(1, 8) * REM * delta_time, required_organ_flag = affected_organ_flags)
	return ..()
