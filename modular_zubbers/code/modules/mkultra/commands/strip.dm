/datum/mkultra_command/strip
	name = "Strip"
	description = "Have your enthralled strip for you."
	feedback = "strips off all their clothes."
	trigger = "strip|remove your clothes|derobe|nude"
	phase_requirement = 2
	erp_command = TRUE
	cooldown = 20 SECONDS

/datum/mkultra_command/strip/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	var/datum/status_effect/mkultra/ultra = status
	if(!.)
		return FALSE
	var/mob/living/carbon/human/person = owner
	var/obj/item/items = owner.get_contents()
	for(var/obj/item/stuff in items)
		if(stuff == person.wear_suit)
			person.dropItemToGround(stuff)
			continue
		if(stuff == person.w_uniform)
			person.dropItemToGround(stuff)
			continue
	to_chat(person, span_userlove("Before you can even think about it, your own hands move to take off your clothes in response to [ultra.get_gender()]'s command!"))
