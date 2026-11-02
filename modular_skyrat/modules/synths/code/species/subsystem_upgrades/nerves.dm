// subsystem_upgrade that affects the CNS
/datum/status_effect/subsystem_upgrade/nerves
	id = "nerves"

// Grounded Nerves - Immunity to being zapped
/datum/status_effect/subsystem_upgrade/nerves/grounded

/datum/status_effect/subsystem_upgrade/nerves/grounded/subsystem_upgrade_gained()
	ADD_TRAIT(owner, TRAIT_SHOCKIMMUNE, TRAIT_STATUS_EFFECT(id))

/datum/status_effect/subsystem_upgrade/nerves/grounded/subsystem_upgrade_lost()
	REMOVE_TRAIT(owner, TRAIT_SHOCKIMMUNE, TRAIT_STATUS_EFFECT(id))

// Spliced Nerves - Reduced stun time and stamina damage taken
/datum/status_effect/subsystem_upgrade/nerves/spliced

/datum/status_effect/subsystem_upgrade/nerves/spliced/subsystem_upgrade_gained()
	var/mob/living/carbon/human/human_owner = owner
	human_owner.physiology.stun_mod *= 0.5
	human_owner.physiology.stamina_mod *= 0.8

/datum/status_effect/subsystem_upgrade/nerves/spliced/subsystem_upgrade_lost()
	var/mob/living/carbon/human/human_owner = owner
	human_owner.physiology.stun_mod *= 2
	human_owner.physiology.stamina_mod *= 1.25
