/mob/living/vv_edit_var(var_name, var_value)
	switch(var_name)
		if(NAMEOF(src, current_size))
			update_size(var_value)
			. = TRUE
		if(NAMEOF(src, size_multiplier))
			update_size(var_value)
			. = TRUE

	if(!isnull(.))
		datum_flags |= DF_VAR_EDITED
		return

	return ..()
