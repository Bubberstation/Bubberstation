/datum/job/junior_doctor
	title = "Medical Resident"
	flag = JR_DOCTOR
	department_head = list("Chief Medical Officer")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer, and any other senior medical staff"
	selection_color = "#74b5e0"

	outfit = /datum/outfit/job/doctor/junior
	departments = DEPARTMENT_BITFLAG_MEDICAL
	plasma_outfit = /datum/outfit/plasmaman/medical

	access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CHEMISTRY, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_VIROLOGY, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CLONING, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_MED
	bounty_types = CIV_JOB_MED

	display_order = JOB_DISPLAY_ORDER_MEDICAL_DOCTOR
	threat = 0.5

	starting_modifiers = list(/datum/skill_modifier/job/surgery, /datum/skill_modifier/job/affinity/surgery)

	family_heirlooms = list(
		/obj/item/storage/firstaid/ancient/heirloom
	)

	mail_goodies = list(
		/obj/effect/spawner/lootdrop/organ_spawner = 5,
//		/obj/effect/spawner/lootdrop/memeorgans = 1
	)

/datum/outfit/job/doctor/junior
	name = "Medical Resident"
	jobtype = /datum/job/junior_doctor

	belt = /obj/item/pda/medical
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/doctor
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat
	l_hand = /obj/item/storage/firstaid/regular
	suit_store = /obj/item/flashlight/pen

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med

	chameleon_extras = /obj/item/gun/syringe
