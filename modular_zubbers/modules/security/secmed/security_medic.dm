/datum/job/security_medic
	title = JOB_SECURITY_MEDIC
	description = "Patch up officers and prisoners, realize you don't have the tools to Tend Wounds, barge into Medbay and tell them how to do their jobs"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list(JOB_HEAD_OF_SECURITY)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_HOS
	minimal_player_age = 7
	exp_requirements = 120
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SECURITY
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "SECURITY_MEDIC"

	outfit = /datum/outfit/job/security_medic
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_MEDIC
	bounty_types = CIV_JOB_SEC
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/medical,
	)

	family_heirlooms = list(/obj/item/clothing/neck/stethoscope, /obj/item/book/manual/wiki/security_space_law)

	//This is the paramedic goodie list. Secmedics are paramedics more or less so they can use these instead of raiding medbay.
	mail_goodies = list(
		/obj/item/reagent_containers/hypospray/medipen = 20,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone = 10,
		/obj/item/reagent_containers/hypospray/medipen/salacid = 10,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 10,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 10,
		/obj/item/reagent_containers/hypospray/medipen/survival/luxury = 5
	)
	rpg_title = "Battle Cleric"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

/datum/outfit/job/security_medic
	name = "Security Medic"
	jobtype = /datum/job/security_medic

	belt = /obj/item/modular_computer/pda/security
	ears = /obj/item/radio/headset/headset_medsec
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/security_medic
	gloves = /obj/item/clothing/gloves/latex/nitrile
	shoes = /obj/item/clothing/shoes/jackboots/sec
	glasses = /obj/item/clothing/glasses/hud/secmed
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/security_medic
	l_hand = /obj/item/storage/medkit/brute
	head = /obj/item/clothing/head/beret/sec/peacekeeper/security_medic
/* 	backpack_contents = list(
		/obj/item/storage/box/gunset/firefly = 1, // FIX THIS LATER
		) */
	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec

	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/security_medic

/obj/effect/landmark/start/security_officer/Initialize(mapload)
	. = ..()
	new /obj/effect/landmark/start/security_medic(get_turf(src))

/obj/effect/landmark/start/security_medic
	name = "Security Medic"
	icon_state = "Security Medic"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/item/encryptionkey/headset_medsec
	name = "medical-security encryption key"
	icon_state = "sec_cypherkey"
	channels = list(RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SECURITY = 1)

/obj/item/radio/headset/headset_medsec
	name = "security medic's bowman headset"
	desc = "Used to hear how many security officers need to be stitched back together."
	icon = 'modular_zubbers/modules/security/secmed/icons/secmed_equipment.dmi'
	icon_state = "headset"
	keyslot = new /obj/item/encryptionkey/headset_medsec

/obj/item/radio/headset/headset_medsec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/clothing/glasses/hud/secmed
	name = "security-medical HUD"
	desc = "The choice for security medics all across the sector, provides advanced medical and simplified security readings."
	icon = 'modular_zubbers/modules/security/secmed/icons/secmed_equipment.dmi'
	icon_state = "hud"
	worn_icon_state = "healthhud"
	hud_type = DATA_HUD_MEDICAL_ADVANCED
	clothing_traits = list(TRAIT_MEDICAL_HUD)

/obj/item/clothing/glasses/hud/secmed/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_EYES))
		return
	// Extra hud because the bloody code doesn't support multihuds yet. I'll probably add multihud support soon enough. If you see this I didn't. ~Waterpig
	var/datum/atom_hud/extra_hud = GLOB.huds[DATA_HUD_SECURITY_BASIC]
	extra_hud.show_to(user)

/obj/item/clothing/glasses/hud/secmed/dropped(mob/living/carbon/human/user)
	. = ..()
	if(!istype(user) || user.glasses != src)
		return
	var/datum/atom_hud/extra_hud = GLOB.huds[DATA_HUD_SECURITY_BASIC]
	extra_hud.hide_from(user)

/obj/item/clothing/glasses/hud/secmed/sunglasses
	name = "security-medical HUD sunglasses"
	icon_state = "hud_protected"
	worn_icon_state = "sunhudsec"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	flags_cover = GLASSESCOVERSEYES

/obj/item/storage/bag/garment/secmed
	name = "Security medic's garment bag"
	desc = "A bag containing extra clothing for the security medic"

/obj/item/storage/bag/garment/secmed/PopulateContents()
	. = ..()
	new /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic(src)
	new /obj/item/clothing/suit/hazardvest/security_medic(src)
	new /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/blue(src)
	new /obj/item/clothing/suit/hazardvest/security_medic/blue(src)
	new /obj/item/clothing/head/helmet/sec/peacekeeper/security_medic(src)
	new /obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec(src)
	new /obj/item/clothing/under/rank/security/peacekeeper/security_medic/alternate(src)
	new /obj/item/clothing/under/rank/security/peacekeeper/security_medic(src)
	new /obj/item/clothing/under/rank/security/peacekeeper/security_medic/skirt(src)

/obj/structure/closet/secure_closet/security_medic
	name = "security medic's locker"
	req_access = list(ACCESS_BRIG)
	icon = 'modular_zubbers/icons/obj/closets/secmed_closet.dmi'
	icon_state = "secmed"

/obj/structure/closet/secure_closet/security_medic/PopulateContents()
	..()
	new /obj/item/radio/headset/headset_medsec(src)
	new /obj/item/clothing/glasses/hud/secmed/sunglasses(src)
	new /obj/item/storage/medkit/emergency(src)
	new /obj/item/clothing/suit/jacket/straight_jacket(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/storage/belt/security/medic/full(src)
	new /obj/item/storage/bag/garment/secmed(src)
