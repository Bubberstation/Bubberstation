/datum/job/junior_scientist
	title = "Research Student"
	flag = SCIENTIST
	department_head = list("Research Director")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 1
	supervisors = "the research director, and any other senior science staff"
	selection_color = "#9574cd"
	exp_requirements = 60
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/scientist/junior
	plasma_outfit = /datum/outfit/plasmaman/science

	access = list(ACCESS_ROBOTICS, ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY, ACCESS_MINERAL_STOREROOM, ACCESS_TECH_STORAGE, ACCESS_GENETICS)
	minimal_access = list(ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SCI
	bounty_types = CIV_JOB_SCI
	departments = DEPARTMENT_BITFLAG_SCIENCE
	starting_modifiers = list(/datum/skill_modifier/job/level/wiring/basic)
	display_order = JOB_DISPLAY_ORDER_SCIENTIST
	threat = 1.2

	family_heirlooms = list(
		/obj/item/toy/plush/slimeplushie
	)

	mail_goodies = list(
//		/obj/item/raw_anomaly_core/random = 10, no free cores for probies
//		/obj/item/disk/tech_disk/spaceloot = 2,
		/obj/item/camera_bug = 1
	)

/datum/outfit/job/scientist/junior
	name = "Research Student"
	jobtype = /datum/job/junior_scientist

	belt = /obj/item/pda/toxins
	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox



