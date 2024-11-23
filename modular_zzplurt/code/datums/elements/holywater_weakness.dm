/// Maximum damage taken when splashed with Holy Water
#define HWWEAK_SPLASH_DAMAGE_CAP 20

/**
 * Holy Water weakness element
 *
 * A mob with this element will be penalized for interacting with holy water.
 *
 * When the reagent processes inside a mob:
 * * Gain disgust
 * * Lose nutrition
 *
 * When a mob is exposed to the reagent:
 * * Play a burning sound
 * * Apply fire damage based on amount
 */
/datum/element/holywater_weakness
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH_ON_HOST_DESTROY
	argument_hash_start_idx = 2

/datum/element/holywater_weakness/Attach(datum/target)
	. = ..()

	// Check for living target
	if (!isliving(target))
		return ELEMENT_INCOMPATIBLE

	// Register holy water reagent interactions
	RegisterSignal(target, COMSIG_REAGENT_PROCESS_HOLYWATER, PROC_REF(process_holywater))
	RegisterSignal(target, COMSIG_REAGENT_EXPOSE_HOLYWATER, PROC_REF(expose_holywater))

/datum/element/holywater_weakness/Detach(datum/source)
	. = ..()

	// Unregister signals
	UnregisterSignal(source, COMSIG_REAGENT_PROCESS_HOLYWATER)
	UnregisterSignal(source, COMSIG_REAGENT_EXPOSE_HOLYWATER)

/// Handle effects applied by digesting Holy Water
/datum/element/holywater_weakness/proc/process_holywater(mob/living/carbon/affected_mob)
	SIGNAL_HANDLER

	// Check that target mob exists
	if(!affected_mob)
		return

	// Add disgust and reduce nutrition
	affected_mob.adjust_disgust(2)
	affected_mob.adjust_nutrition(-6)

/// Handle effects applied by being exposed to Holy Water
/datum/element/holywater_weakness/proc/expose_holywater(mob/living/carbon/affected_mob, datum/reagent/handled_reagent, methods, reac_volume, show_message, touch_protection)
	SIGNAL_HANDLER

	// Check that target mob exists
	if(!affected_mob)
		return

	// Play burning sound
	playsound(affected_mob, SFX_SEAR, 30, TRUE)

	// Damage cap taken from bugkiller
	// Intended to prevent instant crit from beaker splash
	var/damage = min(round(0.4 * reac_volume, 0.1), HWWEAK_SPLASH_DAMAGE_CAP)
	if(damage < 1)
		return

	// Cause burn damage based on amount
	affected_mob.adjustFireLoss(damage)

#undef HWWEAK_SPLASH_DAMAGE_CAP
