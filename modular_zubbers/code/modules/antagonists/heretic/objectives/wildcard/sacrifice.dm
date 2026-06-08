/datum/objective/heretic_wildcard/sacrifice
	name = "sacrifice crewmembers"
	finish_text = "The Blooded Axe bleeds with the blood of your victim. It smiles on you - and you feel your mind expanding..."
	knowledge_to_gain = list(/datum/heretic_knowledge/hunt_and_sacrifice, /datum/heretic_knowledge/reroll_targets)
	max_progress = 3
	//knowledge_per_progress = 2 // handled in the sac ritual

/datum/objective/heretic_wildcard/sacrifice/New(text)
	. = ..()

	update_explanation_text()

/datum/objective/heretic_wildcard/sacrifice/update_explanation_text()
	explanation_text = "Sacrifice at least [max_progress] crewmembers."
