/datum/loadout_item/accessory/armband_security/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/glasses/medicpatch/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/glasses/medhud_glasses/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/glasses/aviator_health/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/glasses/prescription_aviator_health/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/glasses/retinal_projector_health/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/head/cowboyhat_sec/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/head/cowboyhat_secwide/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/head/ushanka/sec/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/head/navyblueofficerberet/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/suit/navybluejacketofficer/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/suit/security_jacket/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/suit/brit/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/suit/rax_peacekeeper_jacket/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/under/jumpsuit/rax_banded_uniform/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/under/jumpsuit/security_trousers/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/under/jumpsuit/security_peacekeeper/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/under/jumpsuit/utility_sec/New()
	. = ..()
	restricted_roles |= JOB_SECURITY_MEDIC

/datum/loadout_item/shoes/rax_armadyne_boots
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_MEDIC, JOB_CORRECTIONS_OFFICER)
//Every other item in this set is role restricted, and it's like they forgot the boots.
//I don't think anyone on Skyrat noticed because this is ckey whitelisted there.

//Flowers
/datum/loadout_item/head/donator/poppy
	donator_only = FALSE

/datum/loadout_item/head/donator/lily
	donator_only = FALSE

/datum/loadout_item/head/donator/geranium
	donator_only = FALSE

/datum/loadout_item/head/donator/fraxinella
	donator_only = FALSE

/datum/loadout_item/head/donator/harebell
	donator_only = FALSE

/datum/loadout_item/head/donator/rose
	donator_only = FALSE

/datum/loadout_item/head/donator/carbon_rose
	donator_only = FALSE

/datum/loadout_item/head/donator/sunflower
	donator_only = FALSE

/datum/loadout_item/head/donator/rainbow_bunch
	donator_only = FALSE

