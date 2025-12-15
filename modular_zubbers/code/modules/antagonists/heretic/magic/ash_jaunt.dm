/datum/action/cooldown/spell/jaunt/ethereal_jaunt/ash/Grant(mob/grant_to)
	. = ..()

	var/datum/antagonist/heretic/our_heretic = GET_HERETIC(grant_to)
	if(!our_heretic)
		return

	if(istype(our_heretic.heretic_path, /datum/heretic_knowledge_tree_column/ash))
		cooldown_time = 20 SECONDS
