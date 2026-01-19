/datum/job/blacksmith
	title = JOB_BLACKSMITH
	description = "Smith wares, Sell them."
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_QM
	config_tag = "BLACKSMITH"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/blacksmith
	plasmaman_outfit = /datum/outfit/plasmaman/blacksmith

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR
	display_order = JOB_DISPLAY_ORDER_BLACKSMITH
	bounty_types = CIV_JOB_SMITH

	departments_list = list(
		/datum/job_department/cargo,
		)

	mail_goodies = list(
		/obj/item/stack/sheet/mineral/coal/ten = 20,
		/obj/item/stack/sheet/mineral/silver = 5,
		/obj/item/stack/sheet/mineral/gold = 5,
	)

	family_heirlooms = list(/obj/item/pen/fountain, /obj/item/forging/hammer, /obj/item/forging/tongs)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

	job_spawn_title = JOB_ASSISTANT

	voice_of_god_silence_power = 3
	rpg_title = "Smithy"

/datum/outfit/job/blacksmith
	name = "Blacksmith"
	jobtype = /datum/job/blacksmith

	id_trim = /datum/id_trim/job/blacksmith
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/long
	suit = /obj/item/clothing/suit/leatherapron
	backpack_contents = list(
		/obj/item/forging/hammer = 1,
		/obj/item/forging/tongs = 1,
		/obj/item/forging/billow = 1,
		/obj/item/stack/sheet/mineral/wood = 25,
	)
	belt = /obj/item/modular_computer/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/color/brown
