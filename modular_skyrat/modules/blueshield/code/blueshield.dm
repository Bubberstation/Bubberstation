/datum/job/blueshield
	title = JOB_BLUESHIELD
	description = "Protect heads of staff, get your fancy gun stolen, cry as the captain touches the supermatter."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list(JOB_NT_REP)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "Central Command and the Nanotrasen Consultant"
	minimal_player_age = 7
	exp_requirements = 2400
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_COMMAND
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
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	id = /obj/item/card/id
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/headset_bs/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	implants = list(/obj/item/implant/mindshield)
	backpack = /obj/item/storage/backpack/blueshield
	satchel = /obj/item/storage/backpack/satchel/blueshield
	duffelbag = /obj/item/storage/backpack/duffelbag/blueshield
	messenger = /obj/item/storage/backpack/messenger/blueshield
	head = /obj/item/clothing/head/utility/welding
	box = /obj/item/storage/box/survival/security
	belt = /obj/item/storage/belt/utility/full/inducer
	r_pocket = /obj/item/modular_computer/pda/security
	r_hand = /obj/effect/spawner/random/blueshield_random

	id_trim = /datum/id_trim/job/blueshield

/datum/outfit/plasmaman/blueshield
	name = "Blueshield Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/blueshield
	uniform = /obj/item/clothing/under/plasmaman/blueshield

/obj/effect/spawner/random/blueshield_random
	name = "blueshield item spawner"
	loot = list(
		/obj/item/melee/baton/security/boomerang/loaded = 25,
		/obj/item/melee/baton/security = 25,
		/obj/item/storage/box/reynauld = 20, // and his friend,  dismas
		/obj/item/storage/box/pipe_gun = 25,
		/obj/item/book/granter/crafting_recipe/dusting/pipegun_prime = 10,
		/obj/item/gun/energy/laser/musket = 25,
		/obj/item/weaponcrafting/gunkit/nuclear = 20,
		/obj/item/stack/spacecash/c10000 = 15, //Figure that out yourself
		/obj/item/storage/box/highwayman = 15, //and hisfriend, Reynauld
	)

/obj/item/storage/box/pipe_gun
	name = "pipe gun set"

/obj/item/storage/box/pipe_gun/PopulateContents()
	new /obj/item/gun/ballistic/rifle/boltaction/pipegun(src)
	new /obj/item/ammo_box/advanced/s12gauge/rubber(src)
	new /obj/item/ammo_box/advanced/s12gauge/buckshot(src)

/obj/item/storage/box/highwayman
	name = "Highwayman Gunset"

/obj/item/storage/box/highwayman/PopulateContents()
	new /obj/item/gun/magic/midas_hand(src)
	new /obj/item/coin/gold(src)
	new /obj/item/coin/gold(src)
	new /obj/item/coin/gold(src)
	new /obj/item/coin/gold(src)
	new /obj/item/coin/gold(src)
	new /obj/item/coin/gold(src)
	new /obj/item/coin/gold(src)
	new /obj/item/storage/belt/bowie_sheath(src)
	new /obj/item/clothing/suit/armor/hos/trenchcoat/winter(src)

/obj/item/storage/box/reynauld
	name = "Holy Knight Set"

/obj/item/storage/box/reynauld/PopulateContents()
	new /obj/item/storage/box/holy/knight(src)
	new /obj/item/claymore/weak(src)
	new /obj/item/shield/buckler/reagent_weapon(src)
	new /obj/item/storage/belt/crusader(src)
	new /obj/item/storage/backpack/satchel/crusader(src)
	new /obj/item/restraints/legcuffs/bola(src)
	new /obj/item/restraints/legcuffs/bola(src)
