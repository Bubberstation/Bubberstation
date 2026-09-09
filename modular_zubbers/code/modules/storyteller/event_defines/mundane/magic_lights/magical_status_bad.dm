#define MAGICAL_BLIND_BASE_TIME 5 SECONDS
#define MAGICAL_HUNGER_MULTIPLIER 8
#define BLOOD_DRAIN_ON_TICK -10

/datum/status_effect/magical_light/blindness
	id = "magical_light_blindness"
	duration = MAGICAL_BLIND_BASE_TIME
	tick_interval = STATUS_EFFECT_NO_TICK // Only apply and remove
	alert_type = /atom/movable/screen/alert/status_effect/magical_light/bad
	special_description = "some blinding radiance"

/datum/status_effect/magical_light/blindness/on_creation(mob/living/new_owner, potency, ...)
	. = ..()
	duration = potency ? (potency * MAGICAL_BLIND_BASE_TIME) : MAGICAL_BLIND_BASE_TIME

/datum/status_effect/magical_light/blindness/on_apply()
	if(!iscarbon(owner))
		return FALSE

	owner.become_blind(id)
	return TRUE

/datum/status_effect/magical_light/blindness/on_remove()
	owner.cure_blind(id)

// Makes you hungee
/datum/status_effect/magical_light/hunger
	id = "magical_light_hunger"
	duration = 60 SECONDS
	tick_interval = STATUS_EFFECT_NO_TICK
	alert_type = null
	special_description = "nutriment draining properties"

/datum/status_effect/magical_light/hunger/on_apply()
	if(!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/human_owner = owner
	human_owner.physiology.hunger_mod *= MAGICAL_HUNGER_MULTIPLIER
	return TRUE

/datum/status_effect/magical_light/hunger/on_remove()
	var/mob/living/carbon/human/human_owner = owner
	human_owner.physiology.hunger_mod /= MAGICAL_HUNGER_MULTIPLIER

/datum/status_effect/magical_light/blood_drain
	id = "magical_light_blood_drain"
	duration = 10 SECONDS
	tick_interval = 2 SECONDS
	alert_type = null
	special_description = "blood draining properties"
	var/potency = 1

/datum/status_effect/magical_light/blood_drain/on_creation(mob/living/new_owner, potency, ...)
	. = ..()
	src.potency = potency

/datum/status_effect/magical_light/blood_drain/on_apply()
	if(ishuman(owner))
		return TRUE
	return FALSE

/datum/status_effect/magical_light/blood_drain/tick(seconds_between_ticks)
	owner.adjust_blood_volume(BLOOD_DRAIN_ON_TICK * potency)

#undef MAGICAL_BLIND_BASE_TIME
#undef MAGICAL_HUNGER_MULTIPLIER
#undef BLOOD_DRAIN_ON_TICK
