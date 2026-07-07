/datum/job/assistant/security
	title = JOB_SECURITY_ASSISTANT
	description = "Help Security with low-risk tasks and learn the basics of Security."
	total_positions = 2
	spawn_positions = 2
	supervisors = "any Security Staff"
	outfit = /datum/outfit/job/assistant/security
	paycheck_department = ACCOUNT_SEC
	display_order = JOB_DISPLAY_ORDER_SECURITY_ASSISTANT
	job_spawn_title = JOB_ASSISTANT
	department_for_prefs = null
	departments_list = list(
		/datum/job_department/security,
	)
	config_tag = "SECURITY_ASSISTANT"

/datum/job/assistant/security/get_outfit(consistent)
	return outfit

/datum/job/assistant/engineering
	title = JOB_ENGINEERING_ASSISTANT
	description = "Help Engineering with low-risk tasks and learn the basics of Engineering."
	total_positions = 2
	spawn_positions = 2
	supervisors = "any Engineering Staff"
	outfit = /datum/outfit/job/assistant/engineering
	paycheck_department = ACCOUNT_ENG
	display_order = JOB_DISPLAY_ORDER_ENGINEERING_ASSISTANT
	job_spawn_title = JOB_ASSISTANT
	department_for_prefs = null
	departments_list = list(
		/datum/job_department/engineering,
	)
	config_tag = "ENGINEERING_ASSISTANT"

/datum/job/assistant/engineering/get_outfit(consistent)
	return outfit

/datum/job/assistant/science
	title = JOB_SCIENCE_ASSISTANT
	description = "Help Science with low-risk tasks and learn the basics of Research."
	total_positions = 2
	spawn_positions = 2
	supervisors = "any Science Staff"
	outfit = /datum/outfit/job/assistant/science
	paycheck_department = ACCOUNT_SCI
	display_order = JOB_DISPLAY_ORDER_SCIENCE_ASSISTANT
	job_spawn_title = JOB_ASSISTANT
	department_for_prefs = null
	departments_list = list(
		/datum/job_department/science,
	)
	config_tag = "SCIENCE_ASSISTANT"

/datum/job/assistant/science/get_outfit(consistent)
	return outfit

/datum/job/assistant/medical
	title = JOB_MEDICAL_ASSISTANT
	description = "Help Medical with low-risk tasks and learn the basics of Medicine."
	total_positions = 2
	spawn_positions = 2
	supervisors = "any Medical Staff"
	outfit = /datum/outfit/job/assistant/medical
	paycheck_department = ACCOUNT_MED
	display_order = JOB_DISPLAY_ORDER_MEDICAL_ASSISTANT
	job_spawn_title = JOB_ASSISTANT
	department_for_prefs = null
	departments_list = list(
		/datum/job_department/medical,
	)
	config_tag = "MEDICAL_ASSISTANT"

/datum/job/assistant/medical/get_outfit(consistent)
	return outfit

/datum/job/assistant/supply
	title = JOB_SUPPLY_ASSISTANT
	description = "Help Cargo with low-risk tasks and learn the basics of Cargo."
	total_positions = 2
	spawn_positions = 2
	supervisors = "any Cargo Staff"
	outfit = /datum/outfit/job/assistant/supply
	paycheck_department = ACCOUNT_CAR
	display_order = JOB_DISPLAY_ORDER_SUPPLY_ASSISTANT
	job_spawn_title = JOB_ASSISTANT
	department_for_prefs = null
	departments_list = list(
		/datum/job_department/cargo,
	)
	config_tag = "SUPPLY_ASSISTANT"

/datum/job/assistant/supply/get_outfit(consistent)
	return outfit

/datum/outfit/job/assistant/security
	name = JOB_SECURITY_ASSISTANT
	jobtype = /datum/job/assistant/security
	id_trim = /datum/id_trim/job/assistant/security
	belt = /obj/item/modular_computer/pda/assistant
	ears = /obj/item/radio/headset/headset_sec
	uniform = /obj/item/clothing/under/color/red
	shoes = /obj/item/clothing/shoes/jackboots/sec
	gloves = /obj/item/clothing/gloves/color/black/security
	glasses = /obj/item/clothing/glasses/hud/security
	suit = /obj/item/clothing/suit/armor/vest/alt/sec
	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec

	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

/datum/outfit/job/assistant/security/give_jumpsuit(mob/living/carbon/human/target)
	return

/datum/outfit/job/assistant/engineering
	name = JOB_ENGINEERING_ASSISTANT
	jobtype = /datum/job/assistant/engineering
	id_trim = /datum/id_trim/job/assistant/engineering
	uniform = /obj/item/clothing/under/color/yellow
	belt = /obj/item/storage/belt/utility/full/engi
	ears = /obj/item/radio/headset/headset_eng
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/modular_computer/pda/assistant

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	messenger = /obj/item/storage/backpack/messenger/eng

/datum/outfit/job/assistant/engineering/give_jumpsuit(mob/living/carbon/human/target)
	return

/datum/outfit/job/assistant/science
	name = JOB_SCIENCE_ASSISTANT
	jobtype = /datum/job/assistant/science
	id_trim = /datum/id_trim/job/assistant/science
	uniform = /obj/item/clothing/under/color/lightpurple
	belt = /obj/item/modular_computer/pda/assistant
	ears = /obj/item/radio/headset/headset_sci
	shoes = /obj/item/clothing/shoes/sneakers/white

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/science
	duffelbag = /obj/item/storage/backpack/duffelbag/science
	messenger = /obj/item/storage/backpack/messenger/science

/datum/outfit/job/assistant/science/give_jumpsuit(mob/living/carbon/human/target)
	return

/datum/outfit/job/assistant/medical
	name = JOB_MEDICAL_ASSISTANT
	jobtype = /datum/job/assistant/medical
	id_trim = /datum/id_trim/job/assistant/medical

	uniform = /obj/item/clothing/under/color/darkblue
	belt = /obj/item/modular_computer/pda/assistant
	ears = /obj/item/radio/headset/headset_med
	shoes = /obj/item/clothing/shoes/sneakers/white
	l_hand = /obj/item/storage/medkit/emergency

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	messenger = /obj/item/storage/backpack/messenger/med

	box = /obj/item/storage/box/survival/medical

/datum/outfit/job/assistant/medical/give_jumpsuit(mob/living/carbon/human/target)
	return

/datum/outfit/job/assistant/supply
	name = JOB_SUPPLY_ASSISTANT
	jobtype = /datum/job/assistant/supply
	id_trim = /datum/id_trim/job/assistant/supply

	backpack_contents = list(
		/obj/item/boxcutter = 1,
	)
	uniform = /obj/item/clothing/under/color/lightbrown
	belt = /obj/item/modular_computer/pda/assistant
	ears = /obj/item/radio/headset/headset_cargo
	l_hand = /obj/item/universal_scanner

/datum/outfit/job/assistant/supply/give_jumpsuit(mob/living/carbon/human/target)
	return
