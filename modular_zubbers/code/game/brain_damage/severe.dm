/datum/brain_trauma/severe/monophobia/check_alone()
	. = ..()
	for(var/obj/item/toy/plush/plush in oview(owner, 1))
		if(plush.stuffed)
			return FALSE
	for(var/obj/item/toy/plush/plush in  owner.held_items) //Now you have an excuse to carry a shark plushie around all the time
		if(plush.stuffed)
			return FALSE
	for(var/obj/item/toy/nyamagotchi/cat in oview(owner, 1))
		if(cat.alive == 1)
			return FALSE
	for(var/obj/item/toy/nyamagotchi/cat in  owner.held_items) // virtual pets are friends too!
		if(cat.alive == 1)
			return FALSE
	for(var/mob/M in owner.held_items) //makes sure to check hands for your tiny friends!
		if(!isliving(M))
			continue
		if(istype(M, /mob/living/basic/pet) || M.ckey)
			return FALSE
