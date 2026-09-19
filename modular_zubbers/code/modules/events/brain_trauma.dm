/datum/round_event/brain_trauma/traumatize(mob/living/carbon/human/H)

	var/static/list/possible_traumas = list(
		/datum/brain_trauma/special/imaginary_friend,
		/datum/brain_trauma/magic/poltergeist,
		/datum/brain_trauma/magic/antimagic,
		/datum/brain_trauma/magic/stalker,
		/datum/brain_trauma/mild/phobia/ocky_icky,
		/datum/brain_trauma/special/godwoken,
		/datum/brain_trauma/special/bluespace_prophet,
		/datum/brain_trauma/special/quantum_alignment,
		/datum/brain_trauma/special/psychotic_brawling,
		/datum/brain_trauma/special/tenacity,
		/datum/brain_trauma/special/death_whispers,
		/datum/brain_trauma/special/existential_crisis,
		/datum/brain_trauma/special/beepsky,
	)

	H.gain_trauma(pick(possible_traumas),TRAUMA_RESILIENCE_SURGERY)
