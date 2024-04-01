/datum/job/blueshield
	title = JOB_BLUESHIELD
	description = "Protect heads of staff, get your fancy gun stolen, cry as the captain touches the supermatter."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list(JOB_NT_REP)
	faction = FACTION_STATION
	total_positions = 6
	spawn_positions = 1
	supervisors = "Central Command and the Nanotrasen Consultant"
	minimal_player_age = 7
	exp_requirements = 2400
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_COMMAND
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BLUESHIELD"

	paycheck = PAYCHECK_LOWER
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
	suit = /obj/item/clothing/suit/armor/vest/old
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	id = /obj/item/card/id
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/headset_bs/alt
	glasses = /obj/item/clothing/glasses/hud/security // No sunglasses. Use the helmet provided
	implants = list(/obj/item/implant/mindshield)
	backpack = /obj/item/mod/control/pre_equipped/blueshield
	backpack_contents = list(/obj/item/stock_parts/cell/bluespace)
	head = /obj/item/clothing/head/utility/welding
	box = /obj/item/storage/box/survival/security
	belt = /obj/item/storage/belt/utility/full/inducer
	l_pocket = /obj/item/choice_beacon/blueshield
	r_pocket = /obj/item/modular_computer/pda/security
	id_trim = /datum/id_trim/job/blueshield

/datum/outfit/job/blueshield/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	back = /obj/item/mod/control/pre_equipped/blueshield


/obj/item/mod/control/pre_equipped/blueshield/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(src.type))

/datum/outfit/plasmaman/blueshield
	name = "Blueshield Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/blueshield
	uniform = /obj/item/clothing/under/plasmaman/blueshield

/datum/supply_pack/goody/blueshield_beacon
	name = "Blueshield armaments beacon single-pack"
	desc = "Contains a single blueshield supply beacon."
	cost = PAYCHECK_COMMAND * 5

	access = ACCESS_COMMAND
	contains = list(/obj/item/choice_beacon/blueshield)

/datum/supply_pack/security/blueshield_weapons
	name = "Blueshield combined armaments"
	desc = "Contains 6 select pieces of blueshield equipment."

	access = ACCESS_COMMAND
	cost = PAYCHECK_COMMAND * 15
	contains = list(/obj/effect/spawner/random/blueshield_random = 3, /obj/effect/spawner/random/blueshield_random/bad = 3)

/obj/item/choice_beacon/blueshield
	name = "Blueshield armaments beacon"
	desc = "This has to be a joke, right?"

	company_source = "Central Command economic division"
	company_message = span_bold("Thank you for partaking in our trash warehouse cleanu- Wait you aren't supposed to know that.")

	w_class = WEIGHT_CLASS_SMALL

/obj/item/choice_beacon/blueshield/generate_display_names()
	return list(
		"Advanced weaponry" = /obj/effect/spawner/random/blueshield_random,
		"Specialized weaponry" = /obj/effect/spawner/random/blueshield_random/bad
		)

/obj/effect/spawner/random/blueshield_random
	name = "Exclusive weapons from NT's finest warehouse"
	loot = list(
		/obj/item/melee/baton/security/boomerang/loaded = 20,
		/obj/item/storage/box/reynauld = 25, // and his friend,  dismas
		/obj/item/storage/box/pipe_gun = 25,
		/obj/item/storage/box/pipe_gun/plus = 10,
		/obj/item/storage/box/rebar = 20,
		/obj/item/gun/energy/laser/musket = 20,
		/obj/item/gun/energy/pulse/shitty = 5,
		/obj/item/storage/box/highwayman = 25, //and his friend, Reynauld
	)

/obj/item/storage/box/rebar
	name = "Rebar crossbow kit"

/obj/item/storage/box/rebar/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/rifle/rebarxbow(src)
	for(i = 0, i < 7, i++)
		new /obj/item/ammo_casing/rebar(src)

/obj/item/gun/energy/pulse/shitty
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/bad, /obj/item/ammo_casing/energy/laser/pulse/bad, /obj/item/ammo_casing/energy/electrode/bad) // Lies and deception
	pin = /obj/item/firing_pin

/obj/item/ammo_casing/energy/disabler/bad
	projectile_type = /obj/projectile/beam/disabler/bad

/obj/projectile/beam/disabler/bad
	damage = 3 // You have a lot of ammunition in this thing. good luck

/obj/item/ammo_casing/energy/electrode/bad
	e_cost = STANDARD_CELL_CHARGE * 20
	projectile_type = /obj/projectile/energy/electrode/bad

/obj/projectile/energy/electrode/bad
	damage = 0

/obj/item/ammo_casing/energy/laser/pulse/bad
	e_cost = STANDARD_CELL_CHARGE * 40 // A gun with one bullet
	projectile_type = /obj/projectile/beam/pulse/bad

/obj/projectile/beam/pulse/bad
	damage = 0

/obj/projectile/beam/pulse/bad/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	playsound(src, 'sound/effects/reee.ogg', 20, TRUE)

/obj/effect/spawner/random/blueshield_random/bad
	name = "Less exclusive weapons"
	loot = list(
		/obj/item/storage/toolbox/robust/plus = 20,
		/obj/item/storage/box/explosive_spear = 10,
		/obj/item/storage/toolbox/haunted = 5,
		/obj/item/fish/clownfish/lube/robust = 20,
		/obj/item/melee/baton/security/cattleprod = 20,
		/obj/item/melee/baton/security/cattleprod/teleprod = 15,
		/obj/item/book/granter/action/spell/clowning = 15,
		/obj/item/storage/box/clown/lubeplus = 15,
		/obj/item/storage/box/ied_kit = 15,
		/obj/item/storage/box/flamethrower_kit = 10, // This is not a normal flamethrower. Comes with very dangerous tanks
		/obj/item/melee/energy/sword/bananium = 1, // Because you are a clown if you pick this
	)


/obj/item/storage/box/clown/lubeplus/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/spray/cyborg_lube(src)
	new /obj/item/reagent_containers/spray/cyborg_lube(src)
	new /obj/item/grown/bananapeel(src)
	new /obj/item/grown/bananapeel(src)
	new /obj/item/food/pie/cream(src)
	new /obj/item/book/granter/action/spell/summon_cheese(src)

/obj/item/book/granter/action/spell/clowning
	granted_action = /datum/action/cooldown/spell/conjure_item/clown_pockets
	action_name = "clown"

/obj/item/storage/toolbox/robust/plus
	force = 15
	wound_bonus = 25

/obj/item/tank/internals/plasma/superheat/Initialize(mapload)
	. = ..()
	desc += "\nSomething tells you this is really dangerous"

/obj/item/tank/internals/plasma/superheat/populate_gas()
	. = ..()
	air_contents.add_gas(/datum/gas/tritium)
	air_contents.gases[/datum/gas/tritium][MOLES] = (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)
	air_contents.temperature = 1000

/obj/item/storage/box/explosive_spear/PopulateContents()
	. = ..()
	for(var/i = 0, i<7, i++)
		new /obj/item/spear/explosive(src)

/obj/item/fish/clownfish/lube/robust
	force = 18
	armour_penetration = 50

/obj/item/storage/box/flamethrower_kit
	name = "Terrible idea kit"
	desc = "The label on this states: \"Do not open near clown. Danger of permanently killing yourself and everything around you\""

/obj/item/storage/box/flamethrower_kit/PopulateContents()
	new /obj/item/flamethrower/full(src)
	new /obj/item/tank/internals/plasma/superheat(src)
	new /obj/item/tank/internals/plasma/superheat(src)
/obj/item/storage/box/ied_kit
	name = "Improvised explosive kit"
	desc = "The label on this states: \"We had some of these laying around back from the incident at ******. Good luck\""

/obj/item/storage/box/ied_kit/PopulateContents()
	new /obj/item/grenade/iedcasing/spawned(src)
	new /obj/item/grenade/iedcasing/spawned(src)
	new /obj/item/grenade/iedcasing/spawned(src)
	new /obj/item/grenade/iedcasing/spawned(src)
	new /obj/item/grenade/iedcasing/spawned(src)
	new /obj/item/grenade/iedcasing/spawned(src)
	new /obj/item/lighter/bright(src) // At least you get a cool lighter!

/obj/item/storage/box/pipe_gun
	name = "pipe gun set"

/obj/item/storage/box/pipe_gun/PopulateContents()
	new /obj/item/gun/ballistic/rifle/boltaction/pipegun(src)
	new /obj/item/ammo_box/advanced/s12gauge/rubber(src)
	new /obj/item/ammo_box/advanced/s12gauge/buckshot(src)

/obj/item/storage/box/pipe_gun/plus/PopulateContents()
	. = ..()
	new /obj/item/book/granter/crafting_recipe/dusting/pipegun_prime(src)

/obj/item/storage/box/highwayman
	name = "Highwayman Gunset"

/obj/item/storage/box/highwayman/PopulateContents()
	new /obj/item/gun/ballistic/rifle/boltaction/pipegun/dismas(src)
	new /obj/item/ammo_casing/rebar(src)
	new /obj/item/ammo_casing/rebar(src)
	new /obj/item/ammo_casing/rebar(src)
	new /obj/item/ammo_casing/rebar(src)
	new /obj/item/ammo_casing/rebar(src)
	new /obj/item/ammo_casing/rebar(src)
	new /obj/item/storage/belt/bowie_sheath(src)
	new /obj/item/clothing/suit/armor/hos/trenchcoat/winter(src)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/dismas
	name = "flintlock pistol"
	desc = "An excellent weapon for flushing out tunnel rats and enemy assistants, but its rifling leaves much to be desired."
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "smoothbore"
	inhand_icon_state = "gun"
	worn_icon_state = null
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	fire_sound = 'sound/weapons/gun/sniper/shot.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/rebarxbow/normal
	initial_caliber = CALIBER_SHOTGUN
	alternative_caliber = null
	can_modify_ammo = TRUE
	can_bayonet = FALSE
	projectile_damage_multiplier = 1

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
	new /obj/item/nullrod/rosary(src)
