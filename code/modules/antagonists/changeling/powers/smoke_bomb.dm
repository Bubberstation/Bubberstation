/datum/action/changeling/smoke_bomb
	name = "Noxious Cloud"
	desc = "We rapidly expel a dense cloud of noxious organic vapor, obscuring vision and disrupting anyone caught within it. \
		Victims cough, struggle to breathe, and may drop whatever they are holding, while beam weapons lose power when fired through the haze. Costs 20 chemicals."
	helptext = "The cloud does not care whether we are the one caught in it."
	button_icon_state = "digital_camouflage"
	category = "utility"
	chemical_cost = 20
	dna_cost = 0
	req_human = TRUE
	disabled_by_fire = FALSE
	/// Tiles the smoke spreads out from us.
	var/smoke_range = 4

/datum/action/changeling/smoke_bomb/sting_action(mob/living/user)
	..()
	if(user.movement_type & VENTCRAWLING)
		user.balloon_alert(user, "no room in the pipes!")
		return FALSE
	user.visible_message(
		span_warning("[user] convulses and belches a thick cloud of vapor!"),
		span_changeling("We vent a choking cloud of vapor."),
	)
	playsound(user, 'sound/effects/smoke.ogg', 50, TRUE)
	do_smoke(smoke_range, user, get_turf(user), smoke_type = /datum/effect_system/fluid_spread/smoke/bad)
	return TRUE
