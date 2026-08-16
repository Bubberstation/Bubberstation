/// Amount of burn and brute damage healed per second
#define SUPERPARTICLE_HEALIUM_HEALING_PER_SECOND (0.2)
/// Damage treshhold below which healing effect works
#define SUPERPARTICLE_HEALIUM_HEALING_DMG_TRESHHOLD (30)

/atom/movable/screen/alert/status_effect/atmosgenbuff
	name = "Superparticle Field"
	desc = "Your are immune to cold conditions of space"
	icon = 'modular_zubbers/icons/obj/machines/superparticle_projector.dmi'
	icon_state = "superparticle_projector"

/datum/status_effect/atmosgenbuff
	id = "atmosgen_buff"
	duration = 3 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/atmosgenbuff
	var/static/list/traits_to_give = list(
		TRAIT_RESISTCOLD,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_NOBREATH,
	)

/datum/status_effect/atmosgenbuff/on_apply()
	. = ..()
	owner.add_traits(traits_to_give, REF(src))

/datum/status_effect/atmosgenbuff/on_remove()
	. = ..()
	owner.remove_traits(traits_to_give, REF(src))

/datum/status_effect/atmosgenbuff_carbon
	id = "atmosgen_buff_carbon"
	duration = 3 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	tick_interval = 10 SECONDS
	alert_type = null

/datum/status_effect/atmosgenbuff_carbon/tick(seconds_between_ticks)
	if(iscarbon(owner))
		var/list/batteries = list()
		for(var/obj/item/stock_parts/power_store/cell in assoc_to_values(owner.get_all_cells()))
			if(cell.charge < cell.maxcharge)
				batteries += cell
		if(batteries.len)
			var/obj/item/stock_parts/power_store/to_charge = pick(batteries)
			to_charge.charge += min(to_charge.maxcharge - to_charge.charge, to_charge.maxcharge/10)
	if(iscyborg(owner))
		var/mob/living/silicon/robot/borg = owner
		var/obj/item/stock_parts/power_store/to_charge = borg.cell
		to_charge.charge += min(to_charge.maxcharge - to_charge.charge, to_charge.maxcharge/10)
	return ..()

/datum/status_effect/atmosgenbuff_healium
	id = "atmosgen_buff_healium"
	duration = 3 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null
	var/healed_last_tick = FALSE

/datum/status_effect/atmosgenbuff_healium/tick(seconds_between_ticks)
	healed_last_tick = FALSE
	var/need_mob_update = FALSE

	if(owner.get_brute_loss() > 0 & owner.get_brute_loss() < SUPERPARTICLE_HEALIUM_HEALING_DMG_TRESHHOLD)
		need_mob_update += owner.adjust_brute_loss(-SUPERPARTICLE_HEALIUM_HEALING_PER_SECOND, updating_health = FALSE)
		healed_last_tick = TRUE

	if(owner.get_fire_loss() > 0 & owner.get_fire_loss() < SUPERPARTICLE_HEALIUM_HEALING_DMG_TRESHHOLD)
		need_mob_update += owner.adjust_fire_loss(-SUPERPARTICLE_HEALIUM_HEALING_PER_SECOND, updating_health = FALSE)
		healed_last_tick = TRUE

	if(need_mob_update)
		owner.updatehealth()

	if(healed_last_tick)
		new /obj/effect/temp_visual/heal(get_turf(owner), COLOR_RED)
	return ..()

#undef SUPERPARTICLE_HEALIUM_HEALING_PER_SECOND
#undef SUPERPARTICLE_HEALIUM_HEALING_DMG_TRESHHOLD
