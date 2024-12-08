/obj/effect/spawner/random/burgerstation
	icon = 'modular_zubbers/icons/obj/map_markers.dmi'
	icon_state = null

	spawn_loot_chance = 100
	loot = list()

	var/spawn_additional_loot_chance = 100
	var/list/additional_loot


/obj/effect/spawner/random/burgerstation/Initialize(mapload)
	. = ..()
	if(additional_loot?.len && prob(spawn_additional_loot_chance))
		var/loot_to_spawn = pick_weight_recursive(additional_loot)
		var/atom/movable/spawned_loot = make_item(loc, loot_to_spawn)
		spawned_loot.setDir(dir)


/obj/effect/spawner/random/burgerstation/blocking
	icon_state = "random_blocking"

	loot = list(
		/obj/effect/spawner/random/burgerstation/table = 100,
		/obj/structure/barricade/security = 50,
		/obj/structure/barricade/wooden = 200,
		/obj/structure/barricade/sandbags = 50,
		/obj/structure/bookcase/random = 20,
		/obj/structure/foamedmetal = 100,
		/obj/structure/foamedmetal/iron = 50,
		/obj/structure/foamedmetal/resin = 10,
		/obj/structure/girder = 200,
		/obj/structure/girder/reinforced = 50,
		/obj/structure/girder/displaced = 25,
		/obj/effect/spawner/random/structure/grille = 800,
		/obj/structure/hedge = 10,
		/obj/structure/holosign/barrier = 50,
		/obj/structure/holosign/barrier/cyborg = 25,
		/obj/structure/holosign/barrier/cyborg/hacked = 1,
		/obj/structure/holosign/barrier/engineering = 100,
		/obj/structure/inflatable = 300,
		/obj/structure/inflatable/door = 100,
		/obj/structure/mop_bucket = 50,
		/obj/structure/mop_bucket/janitorialcart = 10,
		/obj/structure/ore_box = 10,
		/obj/structure/reagent_dispensers/water_cooler = 10,
		/obj/structure/spider/stickyweb = 50,
		/obj/effect/mine/stun = 1,
		/obj/effect/mine/sound/bwoink = 1,
		/obj/effect/mine/kickmine = 1,
		/obj/structure/trash_pile = 100
	)

/obj/effect/spawner/random/burgerstation/loot
	icon_state = "random_loot"

	loot = list(
		/obj/effect/spawner/random/burgerstation/loot/with_maintenance_loot = 3000,
		/obj/effect/spawner/random/burgerstation/table = 200,
		/obj/effect/spawner/random/burgerstation/vending = 100,
		/obj/effect/spawner/random/burgerstation/atmos = 500,
		/obj/effect/spawner/random/burgerstation/liquid = 300,
		/obj/effect/spawner/random/burgerstation/power = 100,
		/obj/structure/trash_pile = 1500,
		/obj/structure/closet/crate/trashcart/filled = 400,
		/obj/item/storage/bag/trash/filled = 100,
		/obj/effect/decal/cleanable/garbage = 100,
		/obj/structure/closet/boxinggloves = 10,
		/obj/structure/closet/chefcloset = 10,
		/obj/structure/closet/crate/decorations = 100,
		/obj/structure/closet/crate/forging_items = 10,
		/obj/structure/closet/crate/freezer/blood = 25,
		/obj/structure/closet/crate/large/hats = 10,
		/obj/structure/closet/emcloset = 200,
		/obj/structure/closet/firecloset = 400,
		/obj/structure/closet/l3closet = 50,
		/obj/structure/closet/l3closet/janitor = 25,
		/obj/structure/closet/l3closet/scientist = 25,
		/obj/structure/closet/l3closet/security = 10,
		/obj/structure/closet/l3closet/virology = 10,
		/obj/structure/closet/lasertag/blue = 25,
		/obj/structure/closet/lasertag/red = 25,
		/obj/structure/closet/masks = 25,
		/obj/structure/closet/mini_fridge/grimy = 500,
		/obj/structure/closet/radiation = 25,
		/obj/structure/closet/secure_closet/personal = 100,
		/obj/structure/closet/toolcloset = 300,
		/obj/structure/closet/wardrobe/black = 100,
		/obj/structure/closet/wardrobe/grey = 100,
		/obj/structure/dresser = 100,
		/obj/structure/fermenting_barrel = 100,
		/obj/structure/filingcabinet = 50,
		/obj/structure/filingcabinet/chestdrawer = 25,
		/obj/structure/frame/computer = 50,
		/obj/structure/frame/machine = 50,


	)

/obj/effect/spawner/random/burgerstation/loot/with_maintenance_loot
	loot = list(
		/obj/structure/closet = 3000,
		/obj/structure/closet/cabinet = 200,
		/obj/structure/closet/cardboard = 25,
		/obj/structure/closet/cardboard/metal = 10,
		/obj/structure/closet/crate = 1000,
		/obj/structure/closet/crate/preopen = 500,
		/obj/structure/closet/crate/bin = 200,
		/obj/structure/closet/crate/cardboard = 100,
		/obj/structure/closet/crate/coffin = 50,
		/obj/structure/closet/crate/freezer = 100,
		/obj/structure/closet/crate/hydroponics = 100,
		/obj/structure/closet/crate/internals = 100,
		/obj/structure/closet/crate/large = 50,
		/obj/structure/closet/crate/mail = 50,
		/obj/structure/closet/crate/medical = 100,
		/obj/structure/closet/crate/necropolis = 5, //Don't worry, doesn't contain lavaland loot.
		/obj/structure/closet/crate/radiation = 100,
		/obj/structure/closet/crate/science = 100,
		/obj/structure/closet/crate/trashcart/laundry = 50,
		/obj/structure/closet/crate/trashcart = 50,
		/obj/structure/closet/crate/wooden = 200,
		/obj/structure/closet/preopen = 1000,
		/obj/structure/rack = 1000,
		/obj/structure/rack/shelf = 200,
		/obj/structure/safe = 50,
		/obj/structure/safe/floor = 10,



	)
	additional_loot = list(
		/obj/effect/spawner/random/maintenance = 100,
		/obj/effect/spawner/random/maintenance/two = 50,
		/obj/effect/spawner/random/maintenance/three = 25,
		/obj/effect/spawner/random/maintenance/four = 12,
	)

/obj/effect/spawner/random/burgerstation/liquid
	icon_state = "random_liquid"
	loot = list(
		/obj/structure/liquid_pump = 100,
		/obj/structure/reagent_dispensers/beerkeg = 10,
		/obj/structure/reagent_dispensers/cooking_oil = 5,
		/obj/structure/reagent_dispensers/foamtank = 50,
		/obj/structure/reagent_dispensers/fueltank = 400,
		/obj/structure/reagent_dispensers/fueltank/large = 100,
		/obj/structure/reagent_dispensers/watertank = 800,
		/obj/structure/reagent_dispensers/watertank/high = 100,

	)

/obj/effect/spawner/random/burgerstation/power
	icon_state = "random_power"
	loot = list(
		/obj/machinery/power/floodlight = 100,
		/obj/machinery/power/emitter = 5,
		/obj/machinery/power/port_gen/pacman = 400,
		/obj/machinery/power/port_gen/pacman/pre_loaded = 200,
		/obj/machinery/power/port_gen/pacman/super = 100,
		/obj/machinery/power/shieldwallgen = 10,



	)

/obj/effect/spawner/random/burgerstation/atmos
	icon_state = "random_atmos"
	loot = list(
		/obj/machinery/pipedispenser = 40,
		/obj/machinery/pipedispenser/disposal = 20,
		/obj/machinery/pipedispenser/disposal/transit_tube = 10,
		/obj/machinery/portable_atmospherics/canister = 75,
		/obj/machinery/portable_atmospherics/canister/air = 400,
		/obj/machinery/portable_atmospherics/canister/carbon_dioxide = 20,
		/obj/machinery/portable_atmospherics/canister/helium = 10,
		/obj/machinery/portable_atmospherics/canister/miasma = 5,
		/obj/machinery/portable_atmospherics/canister/nitrogen = 40,
		/obj/machinery/portable_atmospherics/canister/oxygen = 200,
		/obj/machinery/portable_atmospherics/canister/water_vapor = 50,
		/obj/machinery/portable_atmospherics/pump = 400,
		/obj/machinery/portable_atmospherics/scrubber = 400,
		/obj/machinery/shieldgen = 100,
		/obj/machinery/space_heater = 800,
		/obj/structure/tank_dispenser/oxygen = 50,
		/obj/structure/tank_holder/oxygen = 100,
		/obj/structure/tank_holder/oxygen/red = 25,
		/obj/structure/tank_holder/oxygen/yellow = 25,
		/obj/structure/tank_holder/generic = 25,
		/obj/structure/tank_holder/anesthetic = 1,

	)

/obj/effect/spawner/random/burgerstation/vending
	icon_state = "random_vending"
	loot = list(
		/obj/machinery/vending/assist = 400,
		/obj/machinery/vending/autodrobe = 200,
		/obj/machinery/vending/barbervend = 50,
		/obj/machinery/vending/boozeomat = 100,
		/obj/machinery/vending/cigarette = 50,
		/obj/machinery/vending/cigarette/beach = 25,
		/obj/machinery/vending/cigarette/syndicate = 10,
		/obj/machinery/vending/clothing = 100,
		/obj/machinery/vending/dinnerware = 100,
		/obj/machinery/vending/donksofttoyvendor = 50,
		/obj/machinery/vending/dorms = 100,
		/obj/machinery/vending/games = 50,
		/obj/machinery/vending/hydronutrients = 50,
		/obj/machinery/vending/hydroseeds = 100,
		/obj/machinery/vending/sovietsoda = 200,
		/obj/machinery/vending/sustenance = 100,
		/obj/machinery/vending/toyliberationstation = 1, //As a treat :^)
		/obj/machinery/vending/vendcation = 50,
		/obj/machinery/vending/wardrobe/syndie_wardrobe = 1, //As a treat :^)
		/obj/machinery/vending/wardrobe/sec_wardrobe/red = 5,
		/obj/machinery/vending/halloween_chocolate = 100
	)
	additional_loot = list(
		/obj/effect/mapping_helpers/broken_machine = 1
	)
	spawn_additional_loot_chance = 10

/obj/effect/spawner/random/burgerstation/table //Flat tables only. No racks!
	icon_state = "random_table"
	spawn_loot_chance = 100
	loot = list(
		/obj/structure/table = 200,
		/obj/structure/table/glass = 10,
		/obj/structure/table/reinforced = 10,
		/obj/structure/table/reinforced/plasmarglass = 1,
		/obj/structure/table/reinforced/plastitaniumglass = 1,
		/obj/structure/table/reinforced/rglass = 5,
		/obj/structure/table/reinforced/titaniumglass = 1,
		/obj/structure/table/rolling = 1,
		/obj/structure/table/wood = 100,
		/obj/structure/table/wood/poker = 25,
		/obj/structure/table/wood/fancy/black = 1,
		/obj/structure/table/wood/fancy/blue = 1,
		/obj/structure/table/wood/fancy/cyan = 1,
		/obj/structure/table/wood/fancy/green = 1,
		/obj/structure/table/wood/fancy/orange = 1,
		/obj/structure/table/wood/fancy/purple = 1,
		/obj/structure/table/wood/fancy/red = 1,
		/obj/structure/table/wood/fancy/royalblack = 1,
		/obj/structure/table/wood/fancy/royalblue = 1,
	)

	additional_loot = list(
		/obj/machinery/chem_dispenser/drinks = 1,
		/obj/machinery/chem_dispenser/drinks/beer = 1,
		/obj/machinery/coffeemaker = 20,
		/obj/machinery/coffeemaker/impressa = 10,
		/obj/machinery/dish_drive = 5,
		/obj/machinery/dish_drive/bullet = 1,
		/obj/machinery/fax = 1,
		/obj/machinery/microwave = 10,
		/obj/machinery/plantgenes = 5,
		/obj/machinery/pollution_scrubber = 10,
		/obj/machinery/reagentgrinder = 20,
		/obj/machinery/recharger = 5,
		/obj/machinery/smartfridge/disks = 10,
		/obj/structure/bedsheetbin = 20,
		/obj/structure/chem_separator = 20,
		/obj/structure/desk_bell = 20,
		/obj/structure/large_mortar = 10,
		/obj/structure/microscope = 10,
		/obj/structure/reagent_dispensers/servingdish = 10,
		/obj/structure/towel_bin = 50,
		/obj/structure/votebox = 5,
		/obj/effect/spawner/random/maintenance = 100,
		/obj/effect/spawner/random/maintenance/two = 50,
		/obj/effect/spawner/random/maintenance/three = 25
	)

/obj/effect/spawner/random/burgerstation/odd
	icon_state = "random_odd"
	spawn_loot_chance = 100
	loot = list(
		/obj/effect/spawner/random/structure/crate_abandoned = 600,
		/obj/effect/spawner/random/burgerstation/table = 100,
		/obj/machinery/biogenerator = 15,
		/obj/machinery/chem_dispenser/mutagen = 1,
		/obj/machinery/chem_dispenser/mutagensaltpeter = 1,
		/obj/machinery/chem_heater = 15,
		/obj/machinery/chem_mass_spec = 5,
		/obj/machinery/chem_master = 10,
		/obj/machinery/chem_master/condimaster = 20,
		/obj/machinery/deepfryer = 50,
		/obj/machinery/dna_infuser = 1,
		/obj/machinery/electrolyzer = 15,
		/obj/machinery/fat_sucker = 30,
		/obj/machinery/fishing_portal_generator = 30,
		/obj/machinery/food_cart = 40,
		/obj/machinery/gibber = 10,
		/obj/machinery/griddle = 10,
		/obj/machinery/grill = 10,
		/obj/machinery/harvester = 5,
		/obj/machinery/hydroponics/constructable = 200,
		/obj/machinery/icecream_vat = 40,
		/obj/machinery/limbgrower = 5,
		/obj/machinery/medical_kiosk = 30,
		/obj/machinery/medipen_refiller = 20,
		/obj/machinery/mod_installer = 5,
		/obj/machinery/monkey_recycler = 30,
		/obj/machinery/oven = 10,
		/obj/machinery/oven/range = 10,
		/obj/machinery/oven/stone = 30,
		/obj/machinery/photocopier = 40,
		/obj/machinery/plate_press = 30,
		/obj/machinery/primitive_stove = 20,
		/obj/machinery/processor = 30,
		/obj/machinery/processor/slime = 10,
		/obj/machinery/recharge_station = 50,
		/obj/machinery/roulette = 75,
		/obj/machinery/seed_extractor = 30,
		/obj/machinery/self_actualization_device = 5,
		/obj/machinery/sheetifier = 30,
		/obj/machinery/skill_station = 30,
		/obj/machinery/smartfridge/drying/rack = 80,
		/obj/machinery/smoke_machine = 10,
		/obj/machinery/space_heater/improvised_chem_heater = 200,
		/obj/machinery/stasis = 10,
		/obj/machinery/stove = 20,
		/obj/machinery/syndicatebomb/training = 40,
		/obj/machinery/washing_machine = 100,
		/obj/structure/altar_of_gods = 5,
		/obj/structure/aquarium/prefilled = 100,
		/obj/structure/bonfire/grill_pre_attached = 200,
		/obj/structure/cannon/trash = 50,
		/obj/structure/carving_block = 100,
		/obj/structure/destructible/cult/pants_altar = 5,
		/obj/structure/guillotine = 10,
		/obj/structure/kitchenspike = 75,
		/obj/structure/loom = 25,
		/obj/structure/mannequin/plastic = 100,
		/obj/structure/mannequin/skeleton = 25,
		/obj/structure/mannequin/wood = 75,
		/obj/structure/mecha_wreckage/clarke = 25,
		/obj/structure/mecha_wreckage/ripley = 50,
		/obj/structure/mecha_wreckage/odysseus = 5,
		/obj/structure/millstone = 10,
		/obj/structure/sauna_oven = 25,
		/obj/structure/spirit_board = 50,
		/obj/structure/toiletbong = 100,
		/obj/structure/training_machine = 10,
		/obj/effect/spawner/random/burgerstation/loot/odd_safe = 400
	)

/obj/effect/spawner/random/burgerstation/loot/odd_safe
	loot = null
	additional_loot = list(
		/obj/structure/safe = 1,
		/obj/structure/safe/floor = 1
	)

/obj/effect/spawner/random/burgerstation/loot/odd_safe/Initialize(mapload)
	loot = GLOB.oddity_loot
	. = ..()

