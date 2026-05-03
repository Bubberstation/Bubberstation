// subsystem_upgrade that affects the heart / circulatory system
/datum/status_effect/subsystem_upgrade/heart
	id = "circulation"

/// Muscled veins - Removes the need to have a heart
/datum/status_effect/subsystem_upgrade/heart/muscled_veins

/datum/status_effect/subsystem_upgrade/heart/muscled_veins/subsystem_upgrade_gained()
	ADD_TRAIT(owner, TRAIT_STABLEHEART, TRAIT_STATUS_EFFECT(id))

/datum/status_effect/subsystem_upgrade/heart/muscled_veins/subsystem_upgrade_lost()
	REMOVE_TRAIT(owner, TRAIT_STABLEHEART, TRAIT_STATUS_EFFECT(id))
