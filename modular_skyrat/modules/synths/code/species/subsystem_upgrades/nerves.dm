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
	MODIFY_PHYSIOLOGY(human_owner, PHYS_COEFF_STUN, 0.5)
	MODIFY_PHYSIOLOGY(human_owner, STAMINA, 0.8)

/datum/status_effect/subsystem_upgrade/nerves/spliced/subsystem_upgrade_lost()
	var/mob/living/carbon/human/human_owner = owner
	MODIFY_PHYSIOLOGY(human_owner, PHYS_COEFF_STUN, 2)
	MODIFY_PHYSIOLOGY(human_owner, STAMINA, 1.25)
