/datum/phystool_mode/color_mode
	name = "Color mode"
	desc = "Use LMB to color an object. Use RMB to set default color. Use in hands to choose color."

	var/selected_color

/datum/phystool_mode/color_mode/use_act(mob/user)
	. = ..()
	selected_color = input(user, "Pick new effects color", "Physgun color") as color|null

/datum/phystool_mode/color_mode/main_act(atom/target, mob/user)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		if(L.client)
			user.balloon_alert(user, "Can't color!")
			return FALSE
	if(!selected_color)
		selected_color = COLOR_WHITE
	target.color = selected_color
	return TRUE

/datum/phystool_mode/color_mode/secondnary_act(atom/target, mob/user)
	. = ..()
	target.color = initial(target.color)
	return TRUE
