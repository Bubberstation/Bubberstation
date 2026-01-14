#define INFINITE_CHARGES -1

/datum/action/cooldown/spell/revenant/bloodwriting
	name = "Bloodwriting"
	desc = "Write messages on the ground. In BLOOD!!"
	button_icon = 'icons/effects/blood.dmi'
	button_icon_state = "bubblegumfoot"
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	cooldown_time = 2.5 SECONDS

	///The crayon used for the bloodwriting
	var/obj/item/toy/crayon/revenant/blood_crayon
	///used to check if the ability is active
	var/active = FALSE

/datum/action/cooldown/spell/revenant/bloodwriting/cast(atom/cast_on)
	. = ..()
	var/mob/living/basic/revenant/rev = owner
	if(isnull(rev))
		return

	if(active)
		deactivate(rev)
	else
		activate(rev)

/datum/action/cooldown/spell/revenant/bloodwriting/proc/activate(mob/living/basic/revenant/rev)
	active = TRUE
	rev.write_ability = src

	if(!blood_crayon)
		blood_crayon = new()
		blood_crayon.drawtype = pick(blood_crayon.all_drawables)

	blood_crayon.forceMove(rev)
	rev.active_blood_crayon = blood_crayon

	blood_crayon.ui_interact(rev, null)
	to_chat(rev, span_notice("You start writing in blood."))

/datum/action/cooldown/spell/revenant/bloodwriting/proc/deactivate(mob/living/basic/revenant/rev)
	active = FALSE

	if(blood_crayon)
		SStgui.close_uis(blood_crayon, rev)
		QDEL_NULL(blood_crayon)

	rev.active_blood_crayon = null
	rev.write_ability = null
	to_chat(rev, span_notice("You stop writing in blood."))


//Revenant mob changes needed
/mob/living/basic/revenant/ClickOn(atom/target, params)
	if(active_blood_crayon)
		var/list/modifiers = params2list(params)
		if(!write_ability.IsAvailable())
			return

		if(active_blood_crayon.can_use_on(target, src, modifiers))
			write_ability.StartCooldown()
			return active_blood_crayon.use_on(target, src, modifiers)

	return ..()

/mob/living/basic/revenant
	var/obj/item/toy/crayon/revenant/active_blood_crayon
	var/datum/action/cooldown/spell/revenant/bloodwriting/write_ability

/mob/living/basic/revenant/Destroy()
	if(active_blood_crayon)
		QDEL_NULL(active_blood_crayon)
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
