/obj/structure/closet/examine(mob/user)
	. = ..()
	if(isobserver(user))
		. += span_info("It contains: [english_list(contents)].")
