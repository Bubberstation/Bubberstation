/datum/brain_trauma/severe/monophobia/proc/check_alone()
	var/check_radius = 7
	if(owner.is_blind())
		check_radius = 1
	for(var/mob/M in oview(owner, check_radius))
		if(!isliving(M)) //ghosts ain't people
			continue
		if(istype(M, /mob/living/simple_animal/pet) || istype(M, /mob/living/basic/pet) || M.ckey)
			return FALSE
	for(var/obj/item/toy/plush/plush in oview(owner, 1))
		if(plush.stuffed)
			return FALSE
	for(var/obj/item/toy/plush/plush in  owner.held_items) //Now you have an excuse to carry a shark plushie around all the time
		if(plush.stuffed)
			return FALSE
	for(var/mob/M in owner.held_items) //makes sure to check hands for your tiny friends!
		if(!isliving(M))
			continue
		if(istype(M, /mob/living/simple_animal/pet) || istype(M, /mob/living/basic/pet) || M.ckey)
			return FALSE
	return TRUE
