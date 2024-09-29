// Should let the roleplay borgs interact with the hilberts hotel thingy!
/obj/item/hilbertshotel/ghostdojo/attack_robot(mob/living/user)
	. = ..()
	if(.)
		return
	if(!src.Adjacent(user))
		return
	return promptAndCheckIn(user, user)
