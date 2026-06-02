#define ENTHRALL_BROKEN -1
#define SLEEPER_AGENT 0
#define ENTHRALL_IN_PROGRESS 1
#define PARTIALLY_ENTHRALLED 2
#define FULLY_ENTHRALLED 3
#define OVERDOSE_ENTHRALLED 4

/datum/status_effect/mkultra
	id = "mkultra"
	alert_type = null
	tick_interval = 4 SECONDS
	status_type = STATUS_EFFECT_UNIQUE
	/// Assigns command type to regex values
	var/list/unpacked_commands = list()
	/// If this status effect bypasses mindshields
	var/mindshield_bypass
	/// If it's lewd. Will be set to TRUE if both players opt into ERP preferences
	var/erp_pref = FALSE
	/// The progress of the enthrallment
	var/progress
	var/resistance_tally
	var/delta_resist
	var/phase = ENTHRALL_IN_PROGRESS
	/// The mob this is receptive to.
	var/mob/living/enchanter

/** MKUltra
 *  * enchanter - The mob in which MKUltra responds to.
 *  * mindshield - If this status effect bypasses mindshields
 *  * progress_override - What progress it should be initally set as
 */

/datum/status_effect/mkultra/on_creation(mob/living/new_owner, mob/enchanter, mindshield = FALSE, progrogress_override = 1)
	. = ..()
	src.progress = progrogress_override
	src.enchanter = enchanter
	src.mindshield_bypass = mindshield
	if(!istype(enchanter) || isnull(enchanter))
		return
	if(!mindshield && TRAIT_MINDSHIELD)
		return

/// Listens for certain regex and triggers its proper command
/datum/status_effect/mkultra/proc/listener(mob/source, message)
	for(var/datum/mkultra_command/command in GLOB.mkultra_commands)
		if(findtext(message, command.trigger))
			command.execute(src, owner, source, message)

/atom/movable/screen/alert/status_effect/mkultra
	icon = 'modular_zubbers/icons/obj/vocal_cords.dmi'
	icon_state = "velvet_chords"
	name = "MKUltra"
	desc = "You are under the mind warping effects of MKUltra!"

