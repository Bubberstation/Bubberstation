/obj/item/slimecross/prismatic/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!(isturf(interacting_with) || isclothing(interacting_with)) || isspaceturf(interacting_with))
		return NONE
	var/colour_priority = WASHABLE_COLOUR_PRIORITY
	if(isclothing(interacting_with))
		colour_priority = FIXED_COLOUR_PRIORITY
	var/saturation_mode = SATURATION_MULTIPLY
	if (LAZYACCESS(modifiers, RIGHT_CLICK))
		saturation_mode = SATURATION_OVERRIDE
	user.do_attack_animation(interacting_with)
	interacting_with.add_atom_colour(color_transition_filter(paintcolor, saturation_mode), colour_priority)
	playsound(interacting_with, 'sound/effects/slosh.ogg', 20, TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimecross/prismatic/grey
	effect_desc = "When used it restores the orginal color of whatever it hits."

/obj/item/slimecross/prismatic/grey/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!(isturf(interacting_with) || isclothing(interacting_with)) || isspaceturf(interacting_with))
		return NONE
	user.do_attack_animation(interacting_with)
	if(isturf(interacting_with))
		interacting_with.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	if(isclothing(interacting_with))
		interacting_with.remove_atom_colour(FIXED_COLOUR_PRIORITY)
	playsound(interacting_with, 'sound/effects/slosh.ogg', 20, TRUE)
	return ITEM_INTERACT_SUCCESS
