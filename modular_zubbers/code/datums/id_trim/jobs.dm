/datum/id_trim/job/blacksmith //Place Holder. You'll probably wanna come by and set these up correctly.
	assignment = "Blacksmith"
	trim_state = "trim_cargotechnician"
	department_color = COLOR_CARGO_BROWN
	subdepartment_color = COLOR_CARGO_BROWN
	sechud_icon_state = SECHUD_CARGO_TECHNICIAN
	minimal_access = list(
		ACCESS_BLACKSMITH,
		ACCESS_CARGO,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_MINING,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_SHIPPING,
		)
	extra_access = list(
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_QM,
		)
	job = /datum/job/blacksmith

/datum/id_trim/job/security_medic
	assignment = "Security Medic"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_securitymedic"
	department_color = COLOR_ASSEMBLY_BLACK
	subdepartment_color = COLOR_ASSEMBLY_BLACK
	sechud_icon_state = SECHUD_SECURITY_MEDIC
	extra_access = list(ACCESS_DETECTIVE)
	minimal_access = list(ACCESS_SECURITY, ACCESS_BRIG_ENTRANCE, ACCESS_BRIG, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY, ACCESS_MINERAL_STOREROOM, ACCESS_MAINT_TUNNELS)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)

/datum/id_trim/job/security_medic/New()
	. = ..()

	// Config check for if sec has maint access.
	if(CONFIG_GET(flag/security_has_maint_access))
		access |= list(ACCESS_MAINT_TUNNELS)

/datum/id_trim/job/blueshield
	extra_access = list(ACCESS_COURT, ACCESS_CARGO, ACCESS_GATEWAY) //Blueshield loses Brig and Security access and cannot perform arrests.
	minimal_access = list(
		ACCESS_BRIG_ENTRANCE, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_ENGINEERING, ACCESS_MAINT_TUNNELS, ACCESS_RESEARCH,
		ACCESS_RC_ANNOUNCE, ACCESS_COMMAND, ACCESS_WEAPONS,
	) //Blueshield loses access to the Detective's office.
	minimal_wildcard_access = list()
	template_access = list(ACCESS_CAPTAIN) //Blueshield can no longer change to any other ID trim

/datum/id_trim/job/blueshield/New()
	.=..()
	minimal_access |= list(ACCESS_CAPTAIN)
//BUBBER ADDITION: adds ACCESS_CAPTAIN to the Blueshield's minimal_access.
//Lowering the Blueshield's ID from CENTCOM to silver necessitates moving this access.

/datum/id_trim/job/nanotrasen_consultant
	minimal_wildcard_access = list()
	template_access = list(ACCESS_CAPTAIN) //NTRep can no longer change to any other ID trim