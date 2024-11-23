/// Maximum damage taken when splashed with salt
#define SALT_SENSITIVE_SPLASH_SALT_DAMAGE_CAP 20

/datum/quirk/sodium_sensetivity
	name = "Sodium Sensitivity"
	desc = "Your body is sensitive to sodium, and is burnt upon contact. Ingestion or contact with it is not advised."
	value = -2
	gain_text = span_danger("You remember that advice about reducing your sodium intake.")
	lose_text = span_notice("You remember how good salt makes things taste!")
	medical_record_text = "Patient is highly allergic to to sodium, and should not come into contact with it under any circumstances."
	mob_trait = TRAIT_SALT_SENSITIVE
	hardcore_value = 1
	icon = FA_ICON_BIOHAZARD

/datum/quirk/sodium_sensetivity/add(client/client_source)
	// Register reagent interactions
	RegisterSignal(quirk_holder, COMSIG_REAGENT_PROCESS_SALT, PROC_REF(process_salt))
	RegisterSignal(quirk_holder, COMSIG_REAGENT_EXPOSE_SALT, PROC_REF(expose_salt))

/datum/quirk/sodium_sensetivity/remove()
	// Unregister reagent interactions
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_PROCESS_SALT)
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_EXPOSE_SALT)

/// Handle effects applied when Salt is processed by the mob
/datum/quirk/sodium_sensetivity/proc/process_salt(mob/living/carbon/affected_mob, /datum/reagent/handled_reagent, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

	// Play burning sound
	playsound(affected_mob, SFX_SEAR, 30, TRUE)

	// Do minor burn damage
	affected_mob.adjustFireLoss(2 * REM * seconds_per_tick)

/// Handle effects applied by being exposed to Salt
/datum/quirk/sodium_sensetivity/proc/expose_salt(mob/living/carbon/affected_mob, datum/reagent/handled_reagent, methods, reac_volume, show_message, touch_protection)
	SIGNAL_HANDLER

	// Play burning sound
	playsound(quirk_holder, SFX_SEAR, 30, TRUE)

	// Damage cap taken from bugkiller
	// Intended to prevent instant crit from beaker splash
	var/damage = min(round(0.4 * reac_volume, 0.1), SALT_SENSITIVE_SPLASH_SALT_DAMAGE_CAP)
	if(damage < 1)
		return

	// Cause burn damage based on amount
	quirk_holder.adjustFireLoss(damage)

#undef SALT_SENSITIVE_SPLASH_SALT_DAMAGE_CAP
