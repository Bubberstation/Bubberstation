/datum/status_effect/protean_low_power_mode
	id = "proteanlowpower"
	tick_interval = STATUS_EFFECT_NO_TICK

	alert_type = /atom/movable/screen/alert/status_effect/protean_low_power_mode

/atom/movable/screen/alert/status_effect/protean_low_power_mode
	name = "Low Power Mode"
	desc = "You are running on low power mode, this slows you down but means you'll use way less material to sustain yourself"
	icon = 'modular_zubbers/icons/hud/screen_alert.dmi'
	icon_state = "protean_lowpower"

/datum/status_effect/protean_low_power_mode/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown_low_power)

/datum/status_effect/protean_low_power_mode/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown_low_power)

/datum/movespeed_modifier/protean_slowdown_low_power
	multiplicative_slowdown = 5

/datum/status_effect/protean_low_power_mode/reform
	duration = 7 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/protean_low_power_mode/reform

/atom/movable/screen/alert/status_effect/protean_low_power_mode/reform
	name = "Freshly reformed"
	desc = "You have just reformed from inside your modsuit, leaving you slowed down and weaker as you finalize your form"
	icon_state = "protean_reform"

/datum/status_effect/protean_low_power_mode/reform/on_apply()
	. = ..()
	var/mob/living/carbon/human/human_owner = owner
	if(istype(human_owner))
		human_owner.physiology.damage_resistance -= 100 // Double the damage

/datum/status_effect/protean_low_power_mode/reform/on_remove()
	. = ..()
	var/mob/living/carbon/human/human_owner = owner
	if(istype(human_owner))
		human_owner.physiology.damage_resistance += 100

