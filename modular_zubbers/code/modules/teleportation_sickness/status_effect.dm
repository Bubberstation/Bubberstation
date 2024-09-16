/atom/movable/screen/alert/status_effect/teleportation_sickness
	name = "Teleportation Sickness"
	desc = "Your recent teleportation has caused you to be under the effects of teleportation sickness. \
	Teleporting again may make cause you to vomit! \
	This effect goes away after a while."
	icon = 'modular_zubbers/icons/hud/screen_alert.dmi'
	icon_state = "teleportation_sickness"

/datum/status_effect/teleportation_sickness

	id = "teleportation_sickness"

	duration = 30 SECONDS

	alert_type = /atom/movable/screen/alert/status_effect/teleportation_sickness

	remove_on_fullheal = TRUE

	show_duration = TRUE

/datum/status_effect/teleportation_sickness/proc/do_vomit()

	//Vomit time.
	if(!iscarbon(owner))
		return FALSE

	var/mob/living/carbon/owner_as_carbon = owner
	owner_as_carbon.vomit(
		MOB_VOMIT_MESSAGE | MOB_VOMIT_STUN | MOB_VOMIT_FORCE,
		vomit_type = /obj/effect/decal/cleanable/vomit/nebula,
		distance = 0
	)

	qdel(src)

	return TRUE