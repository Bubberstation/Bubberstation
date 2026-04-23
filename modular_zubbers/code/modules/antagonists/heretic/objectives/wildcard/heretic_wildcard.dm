/datum/objective/heretic_wildcard
	abstract_type = /datum/objective/heretic_wildcard
	var/list/datum/heretic_knowledge/knowledge_to_gain = list()

/datum/objective/heretic_wildcard/proc/apply_to(datum/antagonist/heretic/our_heretic)
	for (var/datum/heretic_knowledge/iter_knowledge as anything in knowledge_to_gain)
		our_heretic.gain_knowledge(iter_knowledge, HERETIC_KNOWLEDGE_SHOP)
		to_chat(our_heretic.owner, span_boldnotice("To accomplish your objectives, you have been given the [iter_knowledge::name] knowledge node for free."))

	return
