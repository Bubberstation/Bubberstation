/datum/job/security_officer/security_sergeant
	title = "Security Sergeant"
	description = "Support Security's patrol coverage and coordinate with assigned departments."
	total_positions = 0
	spawn_positions = 0
	config_tag = null
	outfit = /datum/outfit/job/security/sergeant
	job_spawn_title = "Security Officer"
	job_flags = NONE

/datum/job/security_officer/security_sergeant/config_check()
	return type != /datum/job/security_officer/security_sergeant && ..()

/datum/job/security_officer/security_sergeant/after_roundstart_spawn(mob/living/spawning, client/player_client)
	return ..()

/datum/job/security_officer/security_sergeant/after_latejoin_spawn(mob/living/spawning)
	return ..()

/datum/job/security_officer/security_sergeant/setup_department(mob/living/carbon/human/spawning, client/player_client, move_to = FALSE)
	return null

/datum/job/security_officer/security_sergeant/get_lobby_icon()
	var/datum/outfit/job_outfit = outfit
	var/datum/id_trim/job_trim = job_outfit::id_trim
	return icon(job_trim::sechud_icon, job_trim::sechud_icon_state)

/obj/item/radio/headset/headset_sec/alt/department
	name = "department security bowman headset"

/obj/item/radio/headset/headset_sec/alt/department/medical
	keyslot2 = /obj/item/encryptionkey/headset_med

/obj/item/radio/headset/headset_sec/alt/department/science
	keyslot2 = /obj/item/encryptionkey/headset_sci

/obj/item/radio/headset/headset_sec/alt/department/engineering
	keyslot2 = /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/headset_sec/alt/department/cargo
	keyslot2 = /obj/item/encryptionkey/headset_cargo

/obj/item/radio/headset/headset_sec/alt/department/service
	keyslot2 = /obj/item/encryptionkey/headset_service

/obj/item/encryptionkey/headset_sec/sergeant_medsci
	name = "medical research security radio encryption key"
	channels = list(RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SCIENCE = 1)

/obj/item/encryptionkey/headset_sec/sergeant_engisupply
	name = "engineering cargo security radio encryption key"
	channels = list(RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_SUPPLY = 1)

/obj/item/radio/headset/headset_sec/alt/sergeant
	name = "security sergeant bowman headset"

/obj/item/radio/headset/headset_sec/alt/sergeant/medsci
	keyslot = /obj/item/encryptionkey/headset_sec/sergeant_medsci

/obj/item/radio/headset/headset_sec/alt/sergeant/engisupply
	keyslot = /obj/item/encryptionkey/headset_sec/sergeant_engisupply

/datum/job/security_officer/security_sergeant/medsci
	title = JOB_SECURITY_SERGEANT_MEDSCI
	total_positions = 1
	spawn_positions = 1
	config_tag = "SECURITY_SERGEANT_MEDSCI"
	outfit = /datum/outfit/job/security/sergeant/medsci
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/medical,
		/datum/job_department/science,
		)
	job_flags = STATION_JOB_FLAGS | JOB_ANTAG_PROTECTED

/datum/job/security_officer/security_sergeant/engisupply
	title = JOB_SECURITY_SERGEANT_ENGISUPPLY
	total_positions = 1
	spawn_positions = 1
	config_tag = "SECURITY_SERGEANT_ENGISUPPLY"
	outfit = /datum/outfit/job/security/sergeant/engisupply
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/engineering,
		/datum/job_department/cargo,
		)
	job_flags = STATION_JOB_FLAGS | JOB_ANTAG_PROTECTED

/datum/outfit/job/security/sergeant
	name = "Security Sergeant"
	jobtype = /datum/job/security_officer/security_sergeant
	id_trim = /datum/id_trim/job/security_officer/security_sergeant

/datum/outfit/job/security/sergeant/medsci
	name = JOB_SECURITY_SERGEANT_MEDSCI
	jobtype = /datum/job/security_officer/security_sergeant/medsci
	id_trim = /datum/id_trim/job/security_officer/security_sergeant/medsci
	ears = /obj/item/radio/headset/headset_sec/alt/sergeant/medsci

/datum/outfit/job/security/sergeant/engisupply
	name = JOB_SECURITY_SERGEANT_ENGISUPPLY
	jobtype = /datum/job/security_officer/security_sergeant/engisupply
	id_trim = /datum/id_trim/job/security_officer/security_sergeant/engisupply
	ears = /obj/item/radio/headset/headset_sec/alt/sergeant/engisupply

/datum/id_trim/job/security_officer/security_sergeant
	assignment = "Security Sergeant"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_sergeant"
	sechud_icon = 'modular_zubbers/modules/Catosec/icons/sergeant_icons.dmi'
	sechud_icon_state = "hud_sergeant_unassigned"
	honorifics = list("Sergeant", "Sgt.")

/datum/id_trim/job/security_officer/security_sergeant/New()
	. = ..()
	job = /datum/job/security_officer/security_sergeant

/datum/id_trim/job/security_officer/security_sergeant/medsci
	assignment = JOB_SECURITY_SERGEANT_MEDSCI
	sechud_icon_state = "hud_sergeant_medsci"
	department_color = COLOR_MEDICAL_BLUE
	subdepartment_color = COLOR_MEDICAL_BLUE
	additional_minimal_access = list(
		ACCESS_MEDICAL,
		ACCESS_MORGUE,
		ACCESS_RESEARCH,
		ACCESS_SCIENCE,
		ACCESS_ARMORY,
	)
	additional_extra_access = list(
		ACCESS_AUX_BASE,
		ACCESS_GENETICS,
		ACCESS_ORDNANCE_STORAGE,
		ACCESS_ORDNANCE,
		ACCESS_PARAMEDIC,
		ACCESS_PHARMACY,
		ACCESS_PLUMBING,
		ACCESS_ROBOTICS,
		ACCESS_SURGERY,
		ACCESS_VIROLOGY,
		ACCESS_XENOBIOLOGY,
	)
	job = /datum/job/security_officer/security_sergeant/medsci

/datum/id_trim/job/security_officer/security_sergeant/medsci/New()
	. = ..()
	job = /datum/job/security_officer/security_sergeant/medsci

/datum/id_trim/job/security_officer/security_sergeant/engisupply
	assignment = JOB_SECURITY_SERGEANT_ENGISUPPLY
	sechud_icon_state = "hud_sergeant_engisupply"
	department_color = COLOR_ENGINEERING_ORANGE
	subdepartment_color = COLOR_ENGINEERING_ORANGE
	additional_minimal_access = list(
		ACCESS_ATMOSPHERICS,
		ACCESS_BLACKSMITH,
		ACCESS_BIT_DEN,
		ACCESS_CARGO,
		ACCESS_ENGINEERING,
		ACCESS_MINING,
		ACCESS_SHIPPING,
		ACCESS_ARMORY,
	)
	additional_extra_access = list(
		ACCESS_AUX_BASE,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINE_EQUIP,
		ACCESS_MINING_STATION,
		ACCESS_TCOMMS,
	)
	job = /datum/job/security_officer/security_sergeant/engisupply

/datum/id_trim/job/security_officer/security_sergeant/engisupply/New()
	. = ..()
	job = /datum/job/security_officer/security_sergeant/engisupply
