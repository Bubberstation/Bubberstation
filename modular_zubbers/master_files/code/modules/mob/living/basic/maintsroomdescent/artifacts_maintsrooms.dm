///most of these are just stabilized extracts
/obj/item/slimecross/stabilized/purple/soul
	name = "Strange comforting rock"
	desc = "A strange rock that secretes a kind of slime that when smeared on wounds will heal them almost supernaturally, and when placed on your belt will automatically move to said wounds."
	icon = 'icons/obj/science/slimecrossing.dmi'
	icon_state = "base"
	colour = COLOR_WHITE
	effect_desc = "Provides a regeneration effect"

/datum/status_effect/stabilized/purple/soul
	id = "soul_artifact"
	colour = COLOR_WHITE
	/// Whether we healed from our last tick
	healed_last_tick = FALSE

/datum/status_effect/stabilized/purple/soul/tick(seconds_between_ticks)
	healed_last_tick = FALSE
	var/need_mob_update = FALSE

	if(owner.get_brute_loss() > 0)
		need_mob_update += owner.adjust_brute_loss(-0.8, updating_health = FALSE)
		healed_last_tick = TRUE

	if(owner.get_fire_loss() > 0)
		need_mob_update += owner.adjust_fire_loss(-0.8, updating_health = FALSE)
		healed_last_tick = TRUE

	if(owner.get_tox_loss() > 0)
		// Forced, so slimepeople are healed as well.
		need_mob_update += owner.adjust_tox_loss(-0.8, updating_health = FALSE, forced = TRUE)
		healed_last_tick = TRUE

	if(need_mob_update)
		owner.updatehealth()

	// Technically, "healed this tick" by now.
	if(healed_last_tick)
		new /obj/effect/temp_visual/heal(get_turf(owner), COLOR_WHITE)

	return ..()

/obj/item/slimecross/stabilized/yellow/battery
	name = "Strange electric rock"
	desc = "A strange rock that feels charged to the touch."
	icon = 'icons/obj/science/slimecrossing.dmi'
	icon_state = "base"
	colour = COLOR_BLUE_GRAY
	effect_desc = "Charges electronics"

/datum/status_effect/stabilized/yellow/battery
	id = "battery_artifact"
	colour = COLOR_BLUE_GRAY
	cooldown = 10
	max_cooldown = 10

/datum/status_effect/stabilized/yellow/battery/get_examine_text()
	return span_warning("Nearby electronics seem just a little more charged wherever [owner.p_they()] go[owner.p_es()].")

/datum/status_effect/stabilized/yellow/battery/tick(seconds_between_ticks)
	if(cooldown > 0)
		cooldown--
		return ..()
	cooldown = max_cooldown
	var/list/batteries = list()
	for(var/obj/item/stock_parts/power_store/C in assoc_to_values(owner.get_all_cells()))
		if(C.charge < C.maxcharge)
			batteries += C
	if(batteries.len)
		var/obj/item/stock_parts/power_store/ToCharge = pick(batteries)
		ToCharge.charge += min(ToCharge.maxcharge - ToCharge.charge, ToCharge.maxcharge/100) //10 tens better than the yellow extract but this is meh.
	return ..()

/obj/item/slimecross/stabilized/blue/gravi//extremely strong, no slip from blue but better, speed bonus from light pink but no pacifism and no crit healing, and the movespeed modifier ignore from red.
	name = "Strange weightless rock"
	desc = "A strange rock that feels almost completely weightless."
	icon = 'icons/obj/science/slimecrossing.dmi'
	icon_state = "base"
	colour = COLOR_DARK_BROWN
	effect_desc = "grounds you and helps you maintain your speed"

/datum/status_effect/stabilized/blue/gravi
	id = "gravi_artifact"
	colour = COLOR_DARK_BROWN

/datum/status_effect/stabilized/blue/gravi/on_apply()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/lightpink)
	ADD_TRAIT(owner, TRAIT_NO_SLIP_ALL, TRAIT_STATUS_EFFECT(id))
	owner.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/equipment_speedmod)
	return. = ..()

/datum/status_effect/stabilized/blue/gravi/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/lightpink)
	REMOVE_TRAIT(owner, TRAIT_NO_SLIP_ALL, TRAIT_STATUS_EFFECT(id))
	owner.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/equipment_speedmod)
	return ..()
