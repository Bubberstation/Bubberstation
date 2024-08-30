// Liquid Panty Dropper effect
/mob/living/carbon/proc/clothing_burst(throw_clothes = FALSE)
	// Variable for if the action succeeded
	var/user_disrobed = FALSE

	// Get worn items
	var/items = get_contents()

	// Iterate over worn items
	for(var/obj/item/item_worn in items)
		// Ignore non-mob (storage)
		if(!ismob(item_worn.loc))
			continue

		// Ignore held items
		if(is_holding(item_worn))
			continue

		// Check for anything covering a body part
		if(item_worn.body_parts_covered)
			// Set the success variable
			user_disrobed = TRUE

			// Drop the target item
			dropItemToGround(item_worn, TRUE)

			// Throw item to a random spot
			if(throw_clothes)
				item_worn.throw_at(pick(oview(7,get_turf(src))),10,1)

	// When successfully disrobing a target
	if(user_disrobed)
		// Display a chat message
		visible_message(span_userlove("[src] suddenly bursts out of [p_their()] clothes!"), span_userlove("You suddenly burst out of your clothes!"))

		// Play the ripped poster sound
		playsound(loc, 'sound/items/poster_ripped.ogg', 50, 1)
