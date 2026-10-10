/// Freshly reconstructed tissue is temporarily hyperactive after leaving Reviving Stasis, softening the first hits taken back in the fight.
/datum/status_effect/changeling_adrenal_surge
	id = "changeling_adrenal_surge"
	duration = 30 SECONDS
	status_type = STATUS_EFFECT_UNIQUE
	tick_interval = STATUS_EFFECT_NO_TICK
	alert_type = null
	/// Multiplicative reduction applied to incoming damage while this is active.
	var/damage_mod = 0.9

/datum/status_effect/changeling_adrenal_surge/on_apply()
	RegisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, PROC_REF(modify_damage))
	return TRUE

/datum/status_effect/changeling_adrenal_surge/on_remove()
	UnregisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS)

/datum/status_effect/changeling_adrenal_surge/proc/modify_damage(mob/living/source, list/damage_mods, ...)
	SIGNAL_HANDLER
	damage_mods += damage_mod
