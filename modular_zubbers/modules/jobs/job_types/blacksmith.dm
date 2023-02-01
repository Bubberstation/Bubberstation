/datum/job/blacksmith
	title = JOB_BLACKSMITH
	description = "Smith wares, Sell them."
	department_head = list(JOB_QUARTERMASTER)
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
	departments_list = list(
		/datum/job_department/cargo,
		)

	mail_goodies = list(
		/obj/item/book/random = 44,
		/obj/item/book/manual/random = 5,
		/obj/item/book/granter/action/spell/blind/wgw = 1,
	)

	family_heirlooms = list(/obj/item/pen/fountain, /obj/item/storage/dice)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

	voice_of_god_silence_power = 3
	rpg_title = "Ye olde Smithy"

/datum/outfit/job/blacksmith
	name = "Blacksmith"
	jobtype = /datum/job/blacksmith

	id_trim = /datum/id_trim/job/blacksmith
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/long
	backpack_contents = list(
		/obj/item/forging/hammer = 1,
		/obj/item/forging/tongs = 1,
		/obj/item/forging/billow = 1,
	)
	belt = /obj/item/modular_computer/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/color/brown



/* This section gives all languages to the curator. Not sure the blacksmith needs it. Probably a hold over from using curator as a base.
/datum/outfit/job/curator/post_equip(mob/living/carbon/human/translator, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	translator.grant_all_languages(source=LANGUAGE_CURATOR)
	translator.remove_blocked_language(GLOB.all_languages, source=LANGUAGE_ALL)*/
