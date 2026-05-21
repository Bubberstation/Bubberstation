/datum/action/cooldown/hide //Copy-pasted from the alien larva, but removed a couple alien-specific things. for some reason the alien one didn't work.
	name = "Hide"
	desc = "Allows you to hide beneath tables and certain objects, like some kind of rodent"
	button_icon = 'icons/mob/actions/actions_xeno.dmi'
	button_icon_state = "alien_hide"
	/// The layer we are on while hiding
	var/hide_layer = ABOVE_NORMAL_TURF_LAYER

/datum/action/cooldown/hide/Activate(atom/target)
	if(owner.layer == hide_layer)
		owner.layer = initial(owner.layer)
		owner.visible_message(
			span_notice("[owner] slowly peeks up from the ground..."),
			span_noticealien("You stop hiding."),
		)
		ADD_TRAIT(owner, TRAIT_IGNORE_ELEVATION, ACTION_TRAIT)

	else
		owner.layer = hide_layer
		owner.visible_message(
			span_name("[owner] scurries to the ground!"),
			span_noticealien("You are now hiding."),
		)
		REMOVE_TRAIT(owner, TRAIT_IGNORE_ELEVATION, ACTION_TRAIT)

	return TRUE
