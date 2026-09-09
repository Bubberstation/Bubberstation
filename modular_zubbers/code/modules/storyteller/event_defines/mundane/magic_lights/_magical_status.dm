/// The abstract type for all the different effects that can be given
/// via magical lights
/datum/status_effect/magical_light
	id = "magical_light"
	duration = 10 SECONDS
	status_type = STATUS_EFFECT_REPLACE
	show_duration = TRUE
	alert_type = /atom/movable/screen/alert/status_effect/magical_light
	/// A description shown when the magical light is examined by someone
	/// knowledgeable (Chaplains, Wizards)
	///
	/// "It's charged with magic that has [special_description]"
	var/special_description = "no special effect"

/datum/status_effect/magical_light/on_creation(mob/living/new_owner, potency, ...)
	. = ..()

/atom/movable/screen/alert/status_effect/magical_light
	name = "Magical aura"
	desc = "You feel an aura of magic around yourself"
	icon = 'modular_zubbers/icons/hud/screen_alert.dmi'
	icon_state = "magic_aura"

/atom/movable/screen/alert/status_effect/magical_light/good
	name = "Magical boon" // Take away my thesaurus, I dare you
	desc = "An aura of benevolent magic is surrounding you"
	icon_state = "magic_boon"

/atom/movable/screen/alert/status_effect/magical_light/bad
	name = "Magical malady"
	desc = "An aura of malevolent magic is surrounding you"
	icon_state = "magic_malady"
