/datum/heretic_knowledge/New()
	. = ..()

	for (var/datum/heretic_knowledge/ultimate/ascension as anything in next_knowledge)
		next_knowledge -= ascension
