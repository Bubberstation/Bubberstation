// subsystem_upgrade that affects the player's limbs
/datum/status_effect/subsystem_upgrade/ligaments
	id = "ligaments"

// Reinforced ligaments - Easier to break, but cannot be dismembered
/datum/status_effect/subsystem_upgrade/ligaments/reinforced

/datum/status_effect/subsystem_upgrade/ligaments/reinforced/subsystem_upgrade_gained()
	owner.add_traits(list(TRAIT_NODISMEMBER, TRAIT_EASILY_WOUNDED), TRAIT_STATUS_EFFECT(id))

/datum/status_effect/subsystem_upgrade/ligaments/reinforced/subsystem_upgrade_lost()
	owner.remove_traits(list(TRAIT_NODISMEMBER, TRAIT_EASILY_WOUNDED), TRAIT_STATUS_EFFECT(id))
