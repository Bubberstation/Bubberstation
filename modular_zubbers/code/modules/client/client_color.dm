
/mob/add_client_colour(datum/client_colour/new_color, source, force = FALSE)
	if(!source)
		stack_trace("[src] tried to add a client colour with no source.")
	. = ..()

/mob/remove_client_colour(source)
	if(ispath(source))
		stack_trace("[src] tried to remove a client colour with a path source.")
	. = ..()
