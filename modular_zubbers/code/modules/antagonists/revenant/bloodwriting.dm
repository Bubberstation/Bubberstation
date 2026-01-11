#define INFINITE_CHARGES -1

/datum/action/revenant/bloodwriting
	name = "Bloodwriting"
	desc = "Write messages on the ground. In BLOOD!!"
	button_icon = 'icons/effects/blood.dmi'
	button_icon_state = "bubblegumfoot"
	///The crayon used for the bloodwriting
	var/obj/item/toy/crayon/revenant/blood_crayon
	///used to check if the ability is active
	var/active = FALSE

/datum/action/revenant/bloodwriting/Trigger(mob/clicker, trigger_flags)
	. = ..()
	var/mob/living/basic/revenant/Rev = owner
	if(!Rev)
		return

	if(active)
		deactivate(Rev)
	else
		activate(Rev)

/datum/action/revenant/bloodwriting/proc/activate(mob/living/basic/revenant/Rev)
	active = TRUE

	if(!blood_crayon)
		blood_crayon = new()
		blood_crayon.drawtype = pick(blood_crayon.all_drawables)

	blood_crayon.forceMove(Rev)
	Rev.active_blood_crayon = blood_crayon

	blood_crayon.ui_interact(Rev, null)
	to_chat(Rev, span_notice("You start writing in blood."))

/datum/action/revenant/bloodwriting/proc/deactivate(mob/living/basic/revenant/Rev)
	active = FALSE

	if(blood_crayon)
		SStgui.close_uis(blood_crayon, Rev)
		qdel(blood_crayon)
		blood_crayon = null

	Rev.active_blood_crayon = null
	to_chat(Rev, span_notice("You stop writing in blood."))


//Revenant mob changes needed
/mob/living/basic/revenant/ClickOn(atom/target, params)
	if(active_blood_crayon)
		var/list/modifiers = params2list(params)

		if(active_blood_crayon.can_use_on(target, src, modifiers))
			return active_blood_crayon.use_on(target, src, modifiers)

	return ..()

/mob/living/basic/revenant
	var/obj/item/toy/crayon/revenant/active_blood_crayon

/mob/living/basic/revenant/Destroy()
	if(active_blood_crayon)
		qdel(active_blood_crayon)
		active_blood_crayon = null
	return ..()


//Crayon stuff neccessary for this
/obj/item/toy/crayon/revenant
	name = "bloodwriting"
	desc = "If you're reading this, something went wrong. yell at coders."
	icon = null
	icon_state = null
	charges = INFINITE_CHARGES
	self_contained = FALSE
	edible = FALSE
	can_change_colour = FALSE
	paint_color = COLOR_DARK_RED
	actually_paints = TRUE
	instant = TRUE
	pre_noise = FALSE
	post_noise = FALSE

/obj/item/toy/crayon/revenant/ui_state(mob/user)
	return GLOB.always_state

/obj/item/toy/crayon/revenant/ui_data(mob/user)
	. = ..()
	// Force literacy for bloodwriting UI
	.["is_literate_user"] = TRUE

#undef INFINITE_CHARGES
