/datum/id_trim/job/medical_doctor/New()
	. = ..()
	extra_access += list(
		ACCESS_MORGUE_SECURE,
	)

/datum/id_trim/job/quartermaster/New()
	. = ..()
	minimal_access += list(
		ACCESS_WEAPONS,
		ACCESS_BLACKSMITH,
	)

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
	sechud_icon_state = SECHUD_SYNDICATE_INTERDYNE
	extra_access = list(ACCESS_DETECTIVE)
	minimal_access = list(
		ACCESS_SECURITY,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_BRIG,
		ACCESS_COURT,
		ACCESS_WEAPONS,
		ACCESS_MECH_SECURITY,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MEDICAL,
		ACCESS_MORGUE,
		)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_HOS,
		ACCESS_CHANGE_IDS,
		)

/datum/id_trim/job/security_medic/New()
	. = ..()

	// Config check for if sec has maint access.
	if(CONFIG_GET(flag/security_has_maint_access))
		access |= list(ACCESS_MAINT_TUNNELS)
