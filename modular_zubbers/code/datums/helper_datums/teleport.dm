//Immune to teleportation sickness.
//Trained like astronauts or fighter pilots in those high-g training machines.
//Wizards don't get these because physical extertion is lame.
#define TRAIT_TELEPORTATION_TRAINED "teleportation_trained"

/datum/round_event/ghost_role/space_ninja/spawn_role()
	. = ..()
	for(var/mob/living/carbon/spawned_ninja in spawned_mobs)
		ADD_TRAIT(spawned_ninja,TRAIT_TELEPORTATION_TRAINED,ROLE_NINJA)

/mob/living/carbon/Initialize(...)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_POST_TELEPORT, PROC_REF(apply_teleportation_sickness))

/mob/living/carbon/Destroy(...)
	UnregisterSignal(src, COMSIG_MOVABLE_POST_TELEPORT)
	. = ..()

/mob/living/carbon/proc/apply_teleportation_sickness(destination, channel)

	if(channel == TELEPORT_CHANNEL_WORMHOLE || channel == TELEPORT_CHANNEL_FREE)
		return FALSE

	if(HAS_TRAIT(src,TRAIT_TELEPORTATION_TRAINED))
		return

	var/datum/status_effect/stacking/teleportation_sickness/existing_status = src.has_status_effect(/datum/status_effect/stacking/teleportation_sickness)
	if(existing_status)
		existing_status.add_stacks(1)
	else
		src.apply_status_effect(/datum/status_effect/stacking/teleportation_sickness,1)
	return TRUE

/atom/movable/screen/alert/status_effect/teleportation_sickness
	name = "Teleportation Sickness"
	desc = "Your recent teleportation has caused you to be under the effects of teleportation sickness. \
	Teleporting again may make cause you to vomit! \
	This effect goes away after a while."
	//icon = 'icons/hud/screen_alert.dmi'
	icon_state = "slime_bluespace_off"

/datum/status_effect/stacking/teleportation_sickness

	id = "teleportation_sickness"
	stacks = 0 //make sure to properly add stacks when applying the status effect!
	max_stacks = 2 //Maximum amount..

	stack_decay = 1 //Remove 1 stack every SEE ABOVE TIME
	stack_threshold = 2 //Trigger vomitting at this amount.
	consumed_on_threshold = FALSE //Makes the effect removed when consumed.

	delay_before_decay = 30 SECONDS
	tick_interval = 30 SECONDS //30 seconds per stack

	alert_type = /atom/movable/screen/alert/status_effect/teleportation_sickness

	remove_on_fullheal = TRUE

/datum/status_effect/stacking/teleportation_sickness/threshold_cross_effect()
	. = ..()
	//Vomit time.
	if(iscarbon(owner))
		var/mob/living/carbon/owner_as_carbon = owner
		owner_as_carbon.vomit(MOB_VOMIT_MESSAGE | MOB_VOMIT_STUN | MOB_VOMIT_KNOCKDOWN | MOB_VOMIT_FORCE,vomit_type = /obj/effect/decal/cleanable/vomit/nebula,distance = 0
	)
