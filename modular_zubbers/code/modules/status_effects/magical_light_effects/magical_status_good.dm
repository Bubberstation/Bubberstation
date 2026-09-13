#define GOOD_MOOD_LENGTH 4 MINUTES

// Good mood and a small movespeed modifier buff
/datum/status_effect/magical_light/good_mood
	id = "magical_light_good_mood"
	duration = GOOD_MOOD_LENGTH
	tick_interval = STATUS_EFFECT_NO_TICK
	alert_type = null
	special_description = "a soothing effect on sentient minds"
	var/potency = 1

/datum/status_effect/magical_light/good_mood/on_creation(mob/living/new_owner, potency, ...)
	. = ..()
	src.potency = potency

/datum/status_effect/magical_light/good_mood/on_apply()
	if(!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/human_owner = owner
	var/datum/mood_event/event_to_apply
	switch(potency)
		if(1 to 2)
			event_to_apply = /datum/mood_event/good_magic_mood
		if(3 to 4)
			event_to_apply = /datum/mood_event/good_magic_mood/great
		if(5 to INFINITY)
			event_to_apply = /datum/mood_event/good_magic_mood/amazing
	human_owner.add_mood_event("magic", event_to_apply)
	human_owner.add_movespeed_modifier(/datum/movespeed_modifier/magic_mood)
	return TRUE

/datum/status_effect/magical_light/good_mood/on_remove()
	var/mob/living/carbon/human/human_owner = owner
	human_owner.clear_mood_event("magic")
	human_owner.remove_movespeed_modifier(/datum/movespeed_modifier/magic_mood)

/datum/movespeed_modifier/magic_mood
	multiplicative_slowdown = -0.08

/datum/mood_event/good_magic_mood
	description = span_nicegreen("I feel pretty good right now!\n")
	mood_change = 2
	timeout = GOOD_MOOD_LENGTH

/datum/mood_event/good_magic_mood/great
	description = span_nicegreen("I feel great right now, feels like there's energy soothing my mind!\n")
	mood_change = 4

/datum/mood_event/good_magic_mood/amazing
	description = span_nicegreen("Just feeling amazing for some reason!\n")
	mood_change = 8

/datum/status_effect/magical_light/healing
	id = "magical_light_good_mood"
	duration = 15 SECONDS
	tick_interval = 3 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/magical_light/good
	special_description = "a regenerative effect on all things living"
	var/potency = 1

/datum/status_effect/magical_light/healing/on_creation(mob/living/new_owner, potency, ...)
	. = ..()
	src.potency = potency

/datum/status_effect/magical_light/healing/on_apply()
	if(isliving(owner))
		return TRUE
	return FALSE

/datum/status_effect/magical_light/healing/tick(seconds_between_ticks)
	. = ..()
	var/mob/living/living_owner = owner
	living_owner.adjust_brute_loss(-6 * potency, forced = TRUE) // 30 brute total on 1 potency
	living_owner.adjust_fire_loss(-4 * potency, forced = TRUE) // 20 burn total. Burns are worse to heal irl
	living_owner.adjust_tox_loss(-3 * potency, forced = TRUE) // 15 tox, heals slimes

/// Special type that makes it possible to bring a body back to life.
/// The chance is extremely low, and it's hard to know the lights rolled this
/// Just don't bet on it, though having it proc on a dead antag sec is dragging
/// through maints would be hilarious.
///
/// Also heals organs
/datum/status_effect/magical_light/healing/revivify
	special_description = "an <span class='nicegreen'>extremely powerful</span> regenerative effect on all things"

/datum/status_effect/magical_light/healing/revivify/tick(seconds_between_ticks)
	. = ..()
	var/mob/living/living_owner = owner
	var/list/healed_organ_slots = list(
		ORGAN_SLOT_BRAIN,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
		)
	for(var/slot in healed_organ_slots)
		living_owner.adjust_organ_loss(slot, -5)
	if(iscarbon(owner) && prob(5)) // 1 - (0.95^5) = 0.22 ... that means a 22% chance it revives them, if they're defibbable
		var/mob/living/carbon/carb_owner = owner
		if(carb_owner.can_defib())
			carb_owner.revive(HEAL_BODY)
			playsound(carb_owner, 'sound/effects/magic.ogg', 50, FALSE, SHORT_RANGE_SOUND_EXTRARANGE)


#undef GOOD_MOOD_LENGTH
