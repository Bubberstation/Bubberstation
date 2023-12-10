/datum/phystool_mode/size_mode
	name = "Size tool"
	desc = "Use LMB to increase the size of an object. Use RMB to decrease the size of an object."

/datum/phystool_mode/size_mode/main_act(atom/target, mob/user)
	. = ..()
	if(isturf(target))
		return FALSE
	change_size(target, 2)
	return TRUE

/datum/phystool_mode/size_mode/secondnary_act(atom/target, mob/user)
	. = ..()
	if(isturf(target))
		return FALSE
	change_size(target, 0.5)
	return TRUE

/datum/phystool_mode/size_mode/proc/change_size(atom/target, value)
	if(isliving(target))
		var/mob/living/living_target = target
		if(living_target.client)
			return
	var/translate_x = value * ( target.transform.b / value )
	var/translate_y = value * ( target.transform.e / value )
	if(((translate_x || translate_y) >= 8) || ((translate_x || translate_y) <= 0.125))
		translate_x = target.transform.b
		translate_y = target.transform.e
	target.transform = target.transform.Translate(translate_x, translate_y)
	target.pixel_x *= value
	target.pixel_y *= value
	target.transform = target.transform.Scale(value)
	target.maptext_height = 32 * value
