/datum/element/mkultra
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2
	/// MKUltra commands
	var/static/list/commands = subtypesof(/datum/mkultra_command)
	/// The bulk status effect
	var/datum/status_effect/chem/mkultra/effect

/datum/element/mkultra/Attach(datum/target, mob/owner, mindshield)
	. = ..()
	var/mob/living/carbon/human/host = target
	if(istype(host))
		return ELEMENT_INCOMPATIBLE
	host.apply_status_effect(/datum/status_effect/mkultra, owner, mindshield)

/datum/element/mkultra/Detach(datum/source, ...)
	. = ..()
	var/mob/living/carbon/human/host = source
	host.remove_status_effect(/datum/status_effect/mkultra)
	effect = null
