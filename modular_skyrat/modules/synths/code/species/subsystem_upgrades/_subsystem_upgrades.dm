/**
 * ## subsystem_upgrade status effect
 *
 * Simple holder status effects that grants the owner mob basic buffs
 */
/datum/status_effect/subsystem_upgrade
	id = "subsystem_upgrade"
	alert_type = null
	duration = STATUS_EFFECT_PERMANENT
	tick_interval = STATUS_EFFECT_NO_TICK

/datum/status_effect/subsystem_upgrade/on_apply()
	if(!ishuman(owner))
		return FALSE

	subsystem_upgrade_gained()
	return TRUE

/datum/status_effect/subsystem_upgrade/on_remove()
	subsystem_upgrade_lost()

/// Called when applying to the mob.
/datum/status_effect/subsystem_upgrade/proc/subsystem_upgrade_gained()
	return

/// Called when removing from the mob.
/datum/status_effect/subsystem_upgrade/proc/subsystem_upgrade_lost()
	return
