/datum/objective/prank
	target_amount = 10
	var/prank_score = 0
/datum/objective/prank/New()
	explanation_text = "Prank and humiliate [target_amount] of station crewmembers."

/datum/objective/prank/check_completion()
	for(var/obj/item/photo/E as anything in GLOB.photos)
		if(!istype(team, /datum/team/abductor_team))
			return FALSE
		var/datum/team/abductor_team/T = team
		return prank_score >= target_amount
	return FALSE


/obj/item/photo/blogger

/obj/item/photo/var/stored_shenanigans

/datum/prank
	var/embarassments = 0
/datum/prank/proc/check_prank(placeholder, mobs_spotted, dead_spotted, mobs, turfs, blueprints, clone_area)
	return

/datum/prank/naked/check_prank(placeholder, mobs_spotted, dead_spotted, mobs, turfs, blueprints, clone_area)
	. = 0
	for(var/mob/living/carbon/human/human in mobs)
		var/clothes = locate(/obj/item/clothing) in human.contents
		if(clothes) // has clothing :()
			continue
		else
			.++

/obj/item/camera/proc/process_pranks(placeholder, mobs_spotted, dead_spotted, mobs, turfs, blueprints, clone_area) // BUBBER EDIT
	var/datum/objective/prank/prank_objective = locate(/datum/objective/prank) in usr.mind.objectives
	var/list/pranks = typesof(/datum/prank)
	for(pranks)
		var/datum/prank/current_prank = new pranks.type
		if(current_prank.check_prank(placeholder, mobs_spotted, dead_spotted, mobs, turfs, blueprints, clone_area))
			prank_objective.prank_score++

GLOBAL_LIST_EMPTY(photos)
