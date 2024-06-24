/datum/loadout_item/accessory/armband_security/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/glasses/medicpatch/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/glasses/medhud_glasses/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/glasses/aviator_health/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/glasses/prescription_aviator_health/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/glasses/retinal_projector_health/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/head/cowboyhat_sec/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/head/cowboyhat_secwide/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/head/ushanka/sec/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/head/navyblueofficerberet/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/navybluejacketofficer/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/security_jacket/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/brit/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/rax_peacekeeper_jacket/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/under/jumpsuit/rax_banded_uniform/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/under/jumpsuit/security_trousers/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/under/jumpsuit/security_peacekeeper/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/under/jumpsuit/utility_sec/New()
	. = ..()
	LAZYOR(restricted_roles,JOB_SECURITY_MEDIC)

/datum/loadout_item/shoes/rax_armadyne_boots
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_MEDIC, JOB_CORRECTIONS_OFFICER)
//Every other item in this set is role restricted, and it's like they forgot the boots.
//I don't think anyone on Skyrat noticed because this is ckey whitelisted there.

/datum/loadout_item/pocket_items/flag_solfed
	name = "Folded Solarian State Flag"
