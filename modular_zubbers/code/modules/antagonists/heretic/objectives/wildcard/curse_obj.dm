/datum/objective/heretic_wildcard/curse
	name = "curse crewmembers"
	finish_text = "The Delectable Feast now continues as planned. With the blood of heathens - a delicacy - lips smack, teeth destroy, tongues roll. You feel yourself drooling a little..."
	knowledge_to_gain = list(/datum/heretic_knowledge/codex_morbus)
	knowledge_per_progress = 0.25

/datum/objective/heretic_wildcard/curse/New(text)
	. = ..()

	max_progress = rand(4, 5)
	update_explanation_text()

/datum/objective/heretic_wildcard/curse/update_explanation_text()
	explanation_text = "Curse at least [max_progress] crew members."

/datum/objective/heretic_wildcard/curse/apply_to(datum/antagonist/heretic/our_heretic)
	. = ..()

	RegisterSignal(our_heretic, COMSIG_HERETIC_CURSED_TARGET, PROC_REF(on_cursed))

/datum/objective/heretic_wildcard/curse/proc/on_cursed(datum/antagonist/heretic/signal_source, mob/living/carbon/target)
	SIGNAL_HANDLER

	increment_progress(signal_source, target)
