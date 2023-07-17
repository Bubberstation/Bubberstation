/datum/job/head_of_security
	title = JOB_HEAD_OF_SECURITY
	description = "Coordinate security personnel, ensure they are not corrupt, \
		make sure every department is protected."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list(JOB_CAPTAIN)
	head_announce = list(RADIO_CHANNEL_SECURITY)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_CAPTAIN
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 300
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SECURITY
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "HEAD_OF_SECURITY"

	outfit = /datum/outfit/job/hos
	plasmaman_outfit = /datum/outfit/plasmaman/head_of_security
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/command,
		)

	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM, TRAIT_ROYAL_METABOLISM)

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_HEAD_OF_SECURITY
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law)
	rpg_title = "Guard Leader"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

	voice_of_god_power = 1.4 //Command staff has authority


/datum/job/head_of_security/get_captaincy_announcement(mob/living/captain)
	return "Due to staffing shortages, newly promoted Acting Captain [captain.real_name] on deck!"


/datum/outfit/job/hos
	name = "Head of Security"
	jobtype = /datum/job/head_of_security

	id = /obj/item/card/id/advanced/silver
	id_trim = /datum/id_trim/job/head_of_security
	uniform = /obj/item/clothing/under/rank/security/head_of_security
	suit = /obj/item/clothing/suit/armor/hos/trenchcoat
	suit_store = /obj/item/gun/energy/e_gun //KEPLER EDIT RESTORATION
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/flashlight/seclite = 1,
		/obj/item/modular_computer/pda/heads/hos = 1,
		/obj/item/choice_beacon/head_of_security = 1,
		)
	belt = /obj/item/storage/belt/security/full
	ears = /obj/item/radio/headset/heads/hos/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	gloves = /obj/item/clothing/gloves/color/black/security //SKYRAT EDIT CHANGE - Original: /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/hats/hos/beret
	shoes = /obj/item/clothing/shoes/jackboots/sec
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec

	box = /obj/item/storage/box/survival/security
	chameleon_extras = list(
		/obj/item/gun/energy/e_gun/hos,
		/obj/item/stamp/head/hos,
		)
	implants = list(/obj/item/implant/mindshield)

/datum/outfit/job/hos/mod
	name = "Head of Security (MODsuit)"

	suit_store = /obj/item/tank/internals/oxygen
	back = /obj/item/mod/control/pre_equipped/safeguard
	suit = null
	head = null
	mask = /obj/item/clothing/mask/gas/sechailer
	internals_slot = ITEM_SLOT_SUITSTORE

//TEST THIS OUT WHEN NEEDED

/obj/item/choice_beacon/head_of_security
	name = "gun choice beacon"
	desc = "whatever you choose will determine the outcome of space station 13 and the fate of the company so choose wisely."
	company_source = "Romulus Shipping Company"
	company_message = span_bold("Copy that SS13, supply pod enroute!")


/obj/item/choice_beacon/head_of_security/generate_display_names()
	var/static/list/hosgun_list
	if(!hosgun_list)
		hosgun_list = list()
		for(var/obj/item/storage/box/hosgun/box as anything in typesof(/obj/item/storage/box/hosgun))
			hosgun_list[initial(box.name)] = box
	return hosgun_list

/obj/item/storage/box/hosgun
	name = "Classic 3-round burst pistol 9mm"

/obj/item/storage/box/hosgun/PopulateContents()
	new /obj/item/storage/box/gunset/glock18_hos(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/storage/box/hecu_rations(src)
	new /obj/item/storage/fancy/cigarettes/cigars(src)

/obj/item/storage/box/hosgun/revolver
	name = "Romulus Officer Heavy Revolver .460"

/obj/item/storage/box/hosgun/revolver/PopulateContents()
	new /obj/item/storage/box/gunset/hos_revolver(src)
	new	/obj/item/clothing/neck/cloak/hos/redsec(src)
	new /obj/item/clothing/under/rank/security/head_of_security/redsec(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec(src)
	new /obj/item/clothing/shoes/jackboots/sec/redsec(src)
	new /obj/item/storage/box/nri_rations(src)
	new /obj/item/knife/combat(src)

/obj/item/storage/box/hosgun/glock
	name = "Solaris Police Dual 9mm Pistol"

/obj/item/storage/box/hosgun/glock/PopulateContents()
	new /obj/item/storage/box/gunset/glock17(src)
	new /obj/item/storage/box/gunset/glock17(src)
	new /obj/item/clothing/under/rank/security/head_of_security/peacekeeper/sol(src)
	new /obj/item/clothing/neck/tie/red(src)
	new /obj/item/storage/pill_bottle/probital(src)

