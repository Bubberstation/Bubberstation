#define D4C_CRAVE_TIME 15 MINUTES

/datum/quirk/dumb_for_cum
	name = "Dumb For Cum"
	desc = "You're totally addicted to seminal fluids. You need to consume them periodically, or face the consequences."
	value = -2
	gain_text = span_purple("You feel an insatiable craving for seminal fluids.")
	lose_text = span_purple("Cum didn't even taste that good, anyways.")
	medical_record_text = "Patient seems to have an unhealthy psychological obsession with seminal fluids."
	mob_trait = TRAIT_DUMB_CUM
	icon = FA_ICON_FAUCET_DRIP
	erp_quirk = TRUE
	var/timer_crave
	var/is_craving

/datum/quirk/dumb_for_cum/add(client/client_source)
	// Set timer
	timer_crave = addtimer(CALLBACK(src, PROC_REF(crave)), D4C_CRAVE_TIME, TIMER_STOPPABLE)

	// Register special reagent interaction
	RegisterSignal(quirk_holder, COMSIG_REAGENT_ADD_CUM, PROC_REF(handle_fluids))

/datum/quirk/dumb_for_cum/remove()
	// Remove status trait
	REMOVE_TRAIT(quirk_holder, TRAIT_DUMB_CUM_CRAVE, DUMB_CUM_TRAIT)

	// Remove penalty traits
	REMOVE_TRAIT(quirk_holder, TRAIT_ILLITERATE, DUMB_CUM_TRAIT)
	REMOVE_TRAIT(quirk_holder, TRAIT_DUMB, DUMB_CUM_TRAIT)
	REMOVE_TRAIT(quirk_holder, TRAIT_PACIFISM, DUMB_CUM_TRAIT)

	// Remove mood event
	quirk_holder.clear_mood_event(QMOOD_DUMB_CUM)

	// Remove timer
	deltimer(timer_crave)

	// Unregister special reagent interaction
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_ADD_CUM)

/// Proc to handle reagent interactions with bodily fluids
/datum/quirk/dumb_for_cum/proc/handle_fluids(datum/reagent/handled_reagent, amount)
	SIGNAL_HANDLER

	// Check if currently craving
	if(is_craving)
		// Remove craving
		uncrave()

/datum/quirk/dumb_for_cum/proc/crave()
	// Check if conscious
	if(quirk_holder.stat == CONSCIOUS)
		// Display emote
		quirk_holder.try_lewd_autoemote("sigh")

		// Define list of phrases
		var/list/trigger_phrases = list(
										"Your stomach rumbles a bit and cum comes to your mind.",\
										"Urgh, you should really get some cum...",\
										"Some jizz wouldn't be so bad right now!",\
										"You're starting to long for some more cum..."
									)
		// Alert user in chat
		to_chat(quirk_holder, span_love("[pick(trigger_phrases)]"))

	// Add active status trait
	ADD_TRAIT(quirk_holder, TRAIT_DUMB_CUM_CRAVE, DUMB_CUM_TRAIT)

	// Set craving variable
	is_craving = TRUE

	// Add illiterate, dumb, and pacifist
	ADD_TRAIT(quirk_holder, TRAIT_ILLITERATE, DUMB_CUM_TRAIT)
	ADD_TRAIT(quirk_holder, TRAIT_DUMB, DUMB_CUM_TRAIT)
	ADD_TRAIT(quirk_holder, TRAIT_PACIFISM, DUMB_CUM_TRAIT)

	// Add negative mood effect
	quirk_holder.add_mood_event(QMOOD_DUMB_CUM, /datum/mood_event/cum_craving)

/datum/quirk/dumb_for_cum/proc/uncrave()
	// Remove active status trait
	REMOVE_TRAIT(quirk_holder, TRAIT_DUMB_CUM_CRAVE, DUMB_CUM_TRAIT)

	// Set craving variable
	is_craving = FALSE

	// Remove penalty traits
	REMOVE_TRAIT(quirk_holder, TRAIT_ILLITERATE, DUMB_CUM_TRAIT)
	REMOVE_TRAIT(quirk_holder, TRAIT_DUMB, DUMB_CUM_TRAIT)
	REMOVE_TRAIT(quirk_holder, TRAIT_PACIFISM, DUMB_CUM_TRAIT)

	// Add positive mood event
	quirk_holder.add_mood_event(QMOOD_DUMB_CUM, /datum/mood_event/cum_stuffed)

	// Remove timer
	deltimer(timer_crave)
	timer_crave = null

	// Add new timer
	timer_crave = addtimer(CALLBACK(src, PROC_REF(crave)), D4C_CRAVE_TIME, TIMER_STOPPABLE)

// Equal to 'decharged' mood event
/datum/mood_event/cum_craving
	description = span_warning("I... NEED... CUM...")
	mood_change = -10

// Equal to 'charged' mood event
/datum/mood_event/cum_stuffed
	description = span_nicegreen("The cum feels so good inside me!")
	mood_change = 8
	timeout = 5 MINUTES

#undef D4C_CRAVE_TIME
