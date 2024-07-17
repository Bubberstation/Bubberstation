GLOBAL_LIST_INIT(digest_modes, init_digest_modes())

/proc/init_digest_modes()
	var/list/digest_modes = list()
	for(var/datum/digest_mode/digest_mode as anything in subtypesof(/datum/digest_mode))
		var/datum/digest_mode/DM = new digest_mode()
		digest_modes[DM.name] = DM
	return digest_modes

/datum/digest_mode
	var/name = ""

/datum/digest_mode/proc/handle_belly(obj/vore_belly/vore_belly)
	return

/datum/digest_mode/none
	name = DIGEST_MODE_NONE

/datum/digest_mode/digest
	name = DIGEST_MODE_DIGEST
