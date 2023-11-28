/datum/job/blueshield
	title = JOB_BLUESHIELD
	description = "Protect the Heads of Staff and get your hands dirty so they can keep theirs clean." // BUBBER EDIT
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list(JOB_NT_REP)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "All Command Staff and Central Command when applicable" // BUBBER EDIT
	minimal_player_age = 7
	exp_requirements = 2400
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SECURITY //Bubber Edit: Blueshields should be good sec.
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BLUESHIELD"

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_CMD

	outfit = /datum/outfit/job/blueshield
	plasmaman_outfit = /datum/outfit/plasmaman/blueshield
	display_order = JOB_DISPLAY_ORDER_BLUESHIELD
	bounty_types = CIV_JOB_SEC

	department_for_prefs = /datum/job_department/captain

	departments_list = list(
		/datum/job_department/central_command,
		/datum/job_department/command,
	)
	liver_traits = list(TRAIT_PRETENDER_ROYAL_METABOLISM)

	family_heirlooms = list(/obj/item/bedsheet/captain, /obj/item/clothing/head/beret/blueshield)

	mail_goodies = list(
		/obj/item/storage/fancy/cigarettes/cigars/havana = 10,
		/obj/item/stack/spacecash/c500 = 3,
		/obj/item/disk/nuclear/fake/obvious = 2,
		/obj/item/clothing/head/collectable/captain = 4,
	)

	veteran_only = TRUE
	job_flags = STATION_JOB_FLAGS | JOB_CANNOT_OPEN_SLOTS

/datum/outfit/job/blueshield
	name = "Blueshield"
	jobtype = /datum/job/blueshield
	uniform = /obj/item/clothing/under/rank/blueshield
	suit = /obj/item/clothing/suit/armor/vest/blueshield/jacket
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/headset_bs/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
<<<<<<< HEAD
=======
	backpack_contents = list(
		/obj/item/storage/box/gunset/blueshield = 1,
		/obj/item/gun/energy/e_gun/revolver = 1,
		/obj/item/storage/medkit/tactical/blueshield = 1,
		/obj/item/melee/baton/security/loaded = 1,)
>>>>>>> 6d93d20462a27f3351796f4b0ec8cafb715b2847
	implants = list(/obj/item/implant/mindshield)
	backpack = /obj/item/storage/backpack/blueshield
	satchel = /obj/item/storage/backpack/satchel/blueshield
	duffelbag = /obj/item/storage/backpack/duffelbag/blueshield
	messenger = /obj/item/storage/backpack/messenger/blueshield
	head = /obj/item/clothing/head/beret/blueshield
	box = /obj/item/storage/box/survival/security
	belt = /obj/item/modular_computer/pda/security
	r_pocket = /obj/item/flashlight/seclite

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/job/blueshield

/datum/outfit/plasmaman/blueshield
	name = "Blueshield Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/blueshield
	uniform = /obj/item/clothing/under/plasmaman/blueshield
<<<<<<< HEAD
=======

/obj/item/storage/box/gunset/blueshield
	name = "CMG-1 gunset"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gunset/blueshield/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/cmg/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/cmg(src)
	new /obj/item/ammo_box/magazine/multi_sprite/cmg(src)
	new /obj/item/ammo_box/magazine/multi_sprite/cmg/lethal(src)
	new /obj/item/ammo_box/magazine/multi_sprite/cmg/lethal(src)
	new /obj/item/suppressor/nanotrasen(src)

/obj/item/suppressor/nanotrasen
	name = "NT-S suppressor"
	desc = "A Nanotrasen brand small-arms suppressor, including a large NT logo stamped on the side."

/obj/item/ammo_casing/energy/laser/hellfire/bs
	projectile_type = /obj/projectile/beam/laser/hellfire
	e_cost = 83 //Lets it squeeze out a few more shots
	select_name = "maim"

/obj/item/gun/energy/laser/hellgun/blueshield
	name = "\improper Allstar SC-3 PDW 'Hellfire'"
	desc = "A prototype energy carbine, despite NT's ban on hellfire weaponry due to negative press. \
		Allstar continued to work on it, compacting it into a small form-factor for personal defense. \
		As part of the Asset Retention Program created by Nanotrasen, Allstar's prototype began to be put into use."
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'
	worn_icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_back.dmi'
	lefthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_righthand.dmi'
	icon_state = "hellfirepdw"
	worn_icon_state = "hellfirepdw"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hellfire/bs)
	company_flag = COMPANY_ALLSTAR
>>>>>>> 6d93d20462a27f3351796f4b0ec8cafb715b2847
