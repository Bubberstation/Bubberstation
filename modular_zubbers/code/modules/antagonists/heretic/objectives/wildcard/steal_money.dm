/datum/objective/heretic_wildcard/steal_money
	name = "steal money"
	finish_text = "While a rogue God, the Capitalist appreciates true entrepreneurs. As your wallet swells, so too does your mind."
	knowledge_to_gain = list(/datum/heretic_knowledge/blood_to_money)
	knowledge_per_progress = 2
	max_progress = 1
	var/stolen = 0

/datum/objective/heretic_wildcard/steal_money/New(text)
	. = ..()

	target_amount = rand(1000, 1250)
	update_explanation_text()

/datum/objective/heretic_wildcard/steal_money/update_explanation_text()
	explanation_text = "Steal at least [target_amount] credits from crew members using your rituals. You will only receive points once you reach the maximum."

/datum/objective/heretic_wildcard/steal_money/apply_to(datum/antagonist/heretic/our_heretic)
	. = ..()

	RegisterSignal(our_heretic, COMSIG_HERETIC_STOLE_MONEY, PROC_REF(on_theft))

/datum/objective/heretic_wildcard/steal_money/proc/on_theft(datum/antagonist/heretic/signal_source, mob/living/carbon/victim, amount)
	SIGNAL_HANDLER

	stolen += amount
	if (stolen >= target_amount)
		increment_progress(signal_source)
