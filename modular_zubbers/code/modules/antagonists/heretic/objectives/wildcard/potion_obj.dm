/datum/objective/heretic_wildcard/potions
	name = "have crew consume potions"
	finish_text = "You can feel it coursing through each and everyone of them. The Light is closer now."
	knowledge_per_progress = 0.1 // really not antagonistic
	knowledge_to_gain = list(/datum/heretic_knowledge/crucible)

/datum/objective/heretic_wildcard/potions/New(text)
	. = ..()

	max_progress = rand(9, 10)
	update_explanation_text()

/datum/objective/heretic_wildcard/potions/update_explanation_text()
	explanation_text = "Have [max_progress] separate crewmembers consume eldritch potions."

/datum/objective/heretic_wildcard/potions/apply_to(datum/antagonist/heretic/our_heretic)
	. = ..()

	RegisterSignal(our_heretic, COMSIG_HERETIC_POTION_CONSUMED, PROC_REF(potion_consumed))

/datum/objective/heretic_wildcard/potions/proc/potion_consumed(datum/antagonist/heretic/our_heretic, obj/item/eldritch_potion/potion, mob/living/consumer)
	SIGNAL_HANDLER

	if (IS_HERETIC_OR_MONSTER(consumer))
		return

	increment_progress(our_heretic, consumer)
