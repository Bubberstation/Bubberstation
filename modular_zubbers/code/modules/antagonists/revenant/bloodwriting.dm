#define INFINITE_CHARGES -1

/datum/action/cooldown/spell/pointed/revenant/bloodwriting
	name = "Bloodwriting"
	desc = "Write messages on the ground. In BLOOD!!"
	button_icon = 'icons/effects/blood.dmi'
	button_icon_state = "bubblegumfoot"
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	cooldown_time = 2.5 SECONDS

	///The crayon used for the bloodwriting
	var/obj/item/toy/crayon/revenant/blood_crayon
	var/obj/item/toy/crayon/revenant/active_blood_crayon
	///used to check if the ability is active
	active_msg = "You start writing in blood."
	deactive_msg = "You stop writing in blood."
	aim_assist = FALSE
	unset_after_click = FALSE
	var/list/click_params


/datum/action/cooldown/spell/pointed/revenant/bloodwriting/on_activation(mob/on_who)
	. = ..()
	if(!blood_crayon)
		blood_crayon = new()
		blood_crayon.drawtype = pick(blood_crayon.all_drawables)

	blood_crayon.forceMove(on_who)
	active_blood_crayon = blood_crayon

	blood_crayon.ui_interact(on_who, null)

/datum/action/cooldown/spell/pointed/revenant/bloodwriting/on_deactivation(mob/on_who, refund_cooldown)
	. = ..()
	if(blood_crayon)
		SStgui.close_uis(blood_crayon, on_who)
		QDEL_NULL(blood_crayon)

	active_blood_crayon = null

/datum/action/cooldown/spell/pointed/revenant/bloodwriting/is_valid_target(atom/cast_on)
	return isturf(cast_on)

/datum/action/cooldown/spell/pointed/revenant/bloodwriting/cast(atom/cast_on)
	. = ..()
	if(active_blood_crayon)
		if(!IsAvailable())
			return FALSE

		if(!active_blood_crayon.can_use_on(cast_on, owner))
			return FALSE
		StartCooldown()
		active_blood_crayon.use_on(cast_on, owner, click_params)
		return TRUE
	return FALSE

/datum/action/cooldown/spell/pointed/revenant/bloodwriting/InterceptClickOn(mob/living/clicker, params, atom/target)
	src.click_params = params2list(params) //hacky solution, but I am sick and tired of working on this. I will not fiddle with porting everything in cast() down here.
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
