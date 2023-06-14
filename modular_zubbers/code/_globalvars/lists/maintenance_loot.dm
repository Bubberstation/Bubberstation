#define maint_trash_weight 4500
#define maint_common_weight 4500
#define maint_uncommon_weight 900
#define maint_rarity_weight 99
#define maint_oddity_weight 1
#define maint_holiday_weight 3500


GLOBAL_LIST_INIT(trash_loot, list(//junk: useless, very easy to get, or ghetto chemistry items
	/obj/item/ammo_box/foambox = 5,
	list(
		/obj/item/ammo_casing/spent = 1,
		/obj/item/ammo_casing/shotgun/buckshot/spent = 1,
	) = 100,
	list(
		/obj/item/bong = 10,
		/obj/item/bong/lungbuster = 5,
		/obj/item/extinguisher/crafted = 1,
	) = 50,
	list(
		/obj/item/book/bible = 100,
		/obj/item/book/bible/booze = 50,
		/obj/item/book/fish_catalog = 25,
	) = 25,
	list(
		/obj/item/bouquet = 1,
		/obj/item/bouquet/poppy = 1,
		/obj/item/bouquet/rose = 1,
		/obj/item/bouquet/sunflower = 1
	) = 10,
	/obj/item/broken_bottle = 100,
	/obj/item/broken_missile = 5,
	/obj/item/c_tube = 100,
	/obj/item/cane = 10,
	/obj/item/card/emagfake = 5,
	/obj/item/card/fuzzy_license = 1,
	/obj/item/cardboard_cutout = 5,
	/obj/item/clipboard = 5
	/obj/item/clothing/head/cone = 100,
	/obj/item/clothing/suit/caution = 100,
	/obj/item/clothing/suit/hazardvest = 25
	/obj/item/coffee_cartridge/bootleg = 5,
	/obj/item/coffee_cartridge = 10,
	/obj/item/coupon = 10,
	/obj/item/dice/d20 = 20,
	/obj/item/dice/d6 = 5,
	/obj/item/dice/d6/ebony = 1,
	/obj/item/dice/d6/space = 1,
	/obj/item/ectoplasm = 1,
	list(
		/obj/item/electronics/airalarm = 1,
		/obj/item/electronics/airlock = 1,
		/obj/item/electronics/apc = 1,
		/obj/item/electronics/firealarm = 1,
		/obj/item/electronics/firelock = 1,
	) = 50,
	list(
		/obj/item/food/badrecipe = 5,
		/obj/item/food/badrecipe/moldy = 10,
		/obj/item/food/badrecipe/moldy/bacteria = 25,
		/obj/item/food/egg/rotten = 10,
		/obj/item/food/boiledegg/rotten = 5,
		/obj/item/food/breadslice/moldy = 10,
		/obj/item/food/breadslice/moldy/bacteria = 25,
		/obj/item/food/deadmouse = 10,
		/obj/item/food/deadmouse/moldy = 25,
	) = 100,
	/obj/item/food/drug/moon_rock = 1,
	/obj/item/food/drug/saturnx = 1,


))



GLOBAL_LIST_INIT(common_loot, list( //common: basic items
	/obj/item/air_refresher = 25,
	list(
		/obj/item/airlock_painter = 1,
		/obj/item/airlock_painter/decal = 1,
		/obj/item/airlock_painter/decal/tile = 1
	) = 75,
	list(
		/obj/item/analyzer = 5,
		/obj/item/crowbar = 20,
		/obj/item/crowbar/red = 5,
		/obj/item/crowbar/large = 3,
		/obj/item/crowbar/large/emergency = 3,
		/obj/item/crowbar/large/old = 1,
		/obj/item/cultivator = 3,
		/obj/item/cultivator/rake = 5,
	) = 100,
	list(
		/obj/item/assembly/health = 25,
		/obj/item/assembly/igniter = 100,
		/obj/item/assembly/igniter/condenser = 25,
		/obj/item/assembly/infra = 25,
		/obj/item/assembly/mousetrap = 100,
		/obj/item/assembly/mousetrap/armed = 50,
		/obj/item/assembly/prox_sensor = 100,
		/obj/item/assembly/signaler = 100,
		/obj/item/assembly/timer = 100,
		/obj/item/assembly/voice = 50
	) = 100,
	list(
		/obj/item/bait_can/worm = 10,
		/obj/item/bait_can/worm/premium = 1,
		/obj/item/cutting_board = 5,
		/obj/item/fish_feed = 20,
		/obj/item/fishing_hook = 10,
		/obj/item/fishing_line = 5,
		/obj/item/fishing_rod = 5,
	) = 25,
	list(
		/obj/item/bedsheet/dorms = 10,
		/obj/item/bedsheet/dorms_double = 1
	) = 10,
	list(
		/obj/item/a_gift = 100,
		/obj/item/bikehorn = 50,
		/obj/item/bikehorn/airhorn = 25,
		/obj/item/bikehorn/rubberducky = 50,
		/obj/item/bikehorn/rubberducky/plasticducky = 25,
		/obj/item/clothing/accessory/badge/sheriff = 10,
		/obj/item/clothing/accessory/clown_enjoyer_pin = 25,
		/obj/item/clothing/accessory/mime_fan_pin = 25,
		/obj/item/clothing/accessory/pocketprotector = 5,
		/obj/item/clothing/accessory/pocketprotector/cosmetology = 10,
		/obj/item/clothing/accessory/pocketprotector/full = 25,
		/obj/item/clothing/accessory/pride = 10,
		/obj/item/clothing/gloves/boxing = 5,
		/obj/item/clothing/gloves/boxing/blue = 5,
		/obj/item/clothing/gloves/boxing/green = 5,
		/obj/item/clothing/gloves/boxing/yellow = 5,
		/obj/item/clothing/mask/facehugger/toy = 5,
		/obj/item/clothing/mask/gas/larpswat = 5,
		/obj/item/clothing/mask/gas/prop = 10,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/clothing/shoes/kindle_kicks = 5,
		/obj/item/clothing/shoes/wheelys = 15,
		/obj/item/clothing/shoes/wheelys/rollerskates = 5,
		/obj/item/clothing/shoes/wheelys/skishoes = 10,
		/obj/item/clothing/suit/hooded/flashsuit = 25,
		/obj/item/clothing/under/syndicate/tacticool = 50,
		/obj/item/clothing/under/syndicate/tacticool/skirt = 50,
		/obj/item/disk/nuclear/fake = 1,
		/obj/item/disk/nuclear/fake/obvious = 5,
		/obj/item/dualsaber/toy = 5,
		/obj/item/extendohand = 25,
		/obj/item/fakeartefact = 50,

	) = 100,
	/obj/item/blank_coffee_cartridge = 10,
	list(
		/obj/item/bodybag = 10,
		/obj/item/bodybag/bluespace = 1,
		/obj/item/bodybag/environmental = 5,
		/obj/item/bodybag/environmental/nanotrasen = 1,
		/obj/item/bodybag/environmental/prisoner = 1,
		/obj/item/bodybag/environmental/prisoner/pressurized = 1,
		/obj/item/bodybag/stasis = 5
	) = 25
	list(
		/obj/item/book/manual/random = 1,
		/obj/item/book/random = 10,
	) = 50,
	list(
		/obj/item/burner = 5,
		/obj/item/burner/fuel = 1,
		/obj/item/burner/oil = 1
	) = 25,
	list(
		/obj/item/camera = 10,
		/obj/item/camera/detective = 1,
		/obj/item/camera/spooky = 1,
		/obj/item/camera_film = 5
	) = 25,
	list(
		/obj/item/cardpack/resin = 1,
		/obj/item/cardpack/series_one = 1
	) = 25,
	/obj/item/chair/plastic = 50,
	/obj/item/chisel = 5,
	/obj/item/clothing/ears/earmuffs = 50,
	/obj/item/clothing/ears/headphones = 5,
	/obj/item/clothing/gloves/fingerless = 50,
	list(
		/obj/item/clothing/gloves/latex = 5,
		/obj/item/clothing/gloves/latex/nitrile = 1,
		/obj/item/clothing/mask/surgical = 10
	) = 25,
	/obj/item/clothing/gloves/tackler/offbrand = 50,
	list(
		/obj/item/clothing/mask/balaclava = 50,
		/obj/item/clothing/mask/fakemoustache = 25,
		/obj/item/clothing/mask/fakemoustache/italian = 5
		/obj/item/clothing/mask/fakemoustache/sticky = 5
	) = 75,
	list(
		/obj/item/clothing/mask/gas = 25,
		/obj/item/clothing/mask/gas/alt = 50,
		/obj/item/clothing/mask/gas/cyborg = 10,
		/obj/item/clothing/mask/gas/explorer = 5,
		/obj/item/clothing/mask/gas/glass = 50,
	) = 100,
	list(
		/obj/item/coin/adamantine = 1,
		/obj/item/coin/antagtoken = 5,
		/obj/item/coin/bananium = 1,
		/obj/item/coin/diamond = 1,
		/obj/item/coin/gold = 3,
		/obj/item/coin/iron = 4,
		/obj/item/coin/mythril = 2,
		/obj/item/coin/plasma = 2,
		/obj/item/coin/plastic = 3,
		/obj/item/coin/runite = 1,
		/obj/item/coin/silver = 4,
		/obj/item/coin/thunderdome = 1,
		/obj/item/coin/titanium = 1,
		/obj/item/coin/twoheaded = 1,
		/obj/item/coin/uranium = 2
	) = 75,
	list(
		/obj/item/computer_disk = 25,
		/obj/item/computer_disk/atmos = 1,
		/obj/item/computer_disk/engineering = 1,
		/obj/item/computer_disk/medical = 1,
		/obj/item/computer_disk/ordnance = 1,
		/obj/item/computer_disk/security = 1,
		/obj/item/computer_disk/advanced = 5,
		/obj/item/computer_disk/maintenance/camera = 10,
		/obj/item/computer_disk/maintenance/modsuit_control = 10,
		/obj/item/computer_disk/maintenance/scanner = 10,
		/obj/item/computer_disk/maintenance/theme = 10,
		/obj/item/computer_disk/virus/clown = 1,
		/obj/item/computer_disk/virus/mime = 1,
		/obj/item/disk/data = 25,
		/obj/item/disk/holodisk = 10,
		/obj/item/disk/holodisk/woospider = 5,
		/obj/item/disk/holodisk/example = 5,
		/obj/item/disk/tech_disk = 25,

	) = 50,
	/obj/item/dyespray = 10,
	/obj/item/emptysandbag = 5,
	/obj/item/experi_scanner = 5,
	list(
		/obj/item/extinguisher = 100,
		/obj/item/extinguisher/empty = 50,
		/obj/item/extinguisher/advanced = 5,
		/obj/item/extinguisher/advanced/empty = 10,
		/obj/item/extinguisher/mini = 25,
		/obj/item/extinguisher/mini/empty = 10,
	)
	/obj/item/extinguisher_refill = 20,
	list(
		/obj/item/flashlight = 25,
		/obj/item/flashlight/flare = 50
		/obj/item/flashlight/glowstick = 10,
		/obj/item/flashlight/glowstick/blue = 10,
		/obj/item/flashlight/glowstick/cyan = 10,
		/obj/item/flashlight/glowstick/orange = 10,
		/obj/item/flashlight/glowstick/pink = 10,
		/obj/item/flashlight/glowstick/red = 10,
		/obj/item/flashlight/glowstick/yellow = 10,
		/obj/item/flashlight/lamp = 10,
		/obj/item/flashlight/lamp/bananalamp = 5,
		/obj/item/flashlight/lamp/green = 5,
		/obj/item/flashlight/lantern = 5,
		/obj/item/flashlight/lantern/jade = 1,
		/obj/item/flashlight/pen = 5,
		/obj/item/flashlight/pen/paramedic = 5,
		/obj/item/flashlight/seclite = 10,
	) = 100,
	list(
		/obj/item/food/ant_candy = 5,
		/obj/item/food/bowled/amanitajelly = 1,
		/obj/item/food/bowled/spacylibertyduff = 1,
		/obj/item/food/bowled/wish = 5,
		/obj/item/food/brain_pate = 5,
		/obj/item/food/branrequests = 10,
		/obj/item/food/breadslice/spidermeat = 5,
		/obj/item/food/breadslice/xenomeat = 5,
		/obj/item/food/bubblegum/wake_up = 1,
		/obj/item/food/bubblegum/bubblegum = 1,
		/obj/item/food/bubblegum/wake_up = 1,
		/obj/item/food/burger/appendix = 1,
		/obj/item/food/burger/brain = 1,
		/obj/item/food/burger/catburger = 1,
		/obj/item/food/burger/human = 1,
		/obj/item/food/burger/rat = 5,
		/obj/item/food/burger/soylent = 1,
		/obj/item/food/burger/xeno = 1,
		/obj/item/food/butter/on_a_stick = 10,
		/obj/item/food/butterdog = 5,
		/obj/item/food/cakeslice/mothmallow = 1,
		/obj/item/food/candiedapple = 1,
		/obj/item/food/candy = 5,
		/obj/item/food/candy/bronx = 20,
		/obj/item/food/candy_corn = 1,
		/obj/item/food/candy_corn/prison = 20,
		/obj/item/food/candyheart = 1,
		/obj/item/food/canned/beans = 200,
		/obj/item/food/canned/desert_snails = 1,
		/obj/item/food/canned/envirochow = 25,
		/obj/item/food/canned/jellyfish = 1,
		/obj/item/food/canned/larvae = 1,
		/obj/item/food/canned/peaches = 25,
		/obj/item/food/canned/peaches/maint = 200,
		/obj/item/food/canned/pine_nuts = 1,
		/obj/item/food/canned/tomatoes = 25,
		/obj/item/food/canned/tuna = 50,
		/obj/item/food/cheesiehonkers = 10,
		/obj/item/food/chips = 10,
		/obj/item/food/chips/shrimp = 5,
		/obj/item/food/chococoin = 5,
		/obj/item/food/chocolatebar = 10,
		/obj/item/food/chocolateegg = 5,
		/obj/item/food/cnds = 25,
		/obj/item/food/cnds/banana_honk = 10,
		/obj/item/food/cnds/pretzel = 25,
		/obj/item/food/cnds/caramel = 25,
		/obj/item/food/cnds/peanut_butter = 25
		/obj/item/food/cnds/random = 100,
		/obj/item/food/cornchips/random = 100,
		/obj/item/food/dankpocket = 5,
		/obj/item/food/donkpocket = 25,
		/obj/item/food/donkpocket/berry = 5,
		/obj/item/food/donkpocket/honk = 10,
		/obj/item/food/donkpocket/pizza = 10,
		/obj/item/food/donkpocket/spicy = 5,
		/obj/item/food/donkpocket/teriyaki = 5
		/obj/item/food/donut/chaos = 25,
		/obj/item/food/egg = 25,
		/obj/item/food/egg/gland = 75,
		/obj/item/food/energybar = 75,
		/obj/item/food/fried_chicken = 50,
		/obj/item/food/gumball = 75,
		/obj/item/food/hotdog = 100,
		/obj/item/food/kebab/human = 75,
		/obj/item/food/kebab/monkey = 75,
		/obj/item/food/kebab/rat = 100,
		/obj/item/food/kebab/rat/double = 100,
		/obj/item/food/kebab/tail = 50,
		/obj/item/food/lasagna = 25,
		/obj/item/food/lollipop = 75,
		/obj/item/food/meatclown = 100,
		/obj/item/food/meatloaf_slice = 25,
		/obj/item/food/mint = 50,
		/obj/item/food/no_raisin = 75,
		/obj/item/food/nugget = 100,
		/obj/item/food/peanuts = 25,
		/obj/item/food/peanuts/ban_appeal = 75,
		/obj/item/food/peanuts/barbecue = 25,
		/obj/item/food/peanuts/honey_roasted = 25,
		/obj/item/food/peanuts/random = 100,
		/obj/item/food/peanuts/salted = 50,
		/obj/item/food/peanuts/wasabi = 75,
		/obj/item/food/pickle = 75,
		/obj/item/food/pie/cream = 100,
		/obj/item/food/pigblanket = 50

	) = 100,
	list(
		/obj/item/food/meat/slab/bear = 10,
		/obj/item/food/meat/slab/bugmeat = 50,
		/obj/item/food/meat/slab/chicken = 10,
		/obj/item/food/meat/slab/corgi = 25,
		/obj/item/food/meat/slab/gorilla = 5,
		/obj/item/food/meat/slab/human = 25,
		/obj/item/food/meat/slab/human/mutant/ethereal = 5,
		/obj/item/food/meat/slab/human/mutant/fly = 10,
		/obj/item/food/meat/slab/human/mutant/golem = 5,
		/obj/item/food/meat/slab/human/mutant/lizard = 5,
		/obj/item/food/meat/slab/human/mutant/moth = 5,
		/obj/item/food/meat/slab/human/mutant/plant = 10,
		/obj/item/food/meat/slab/human/mutant/shadow = 5,
		/obj/item/food/meat/slab/human/mutant/skeleton = 10,
		/obj/item/food/meat/slab/human/mutant/slime = 5,
		/obj/item/food/meat/slab/human/mutant/zombie = 100,
		/obj/item/food/meat/slab/meatproduct = 10,
		/obj/item/food/meat/slab/monkey = 50,
		/obj/item/food/meat/slab/mothroach = 25,
		/obj/item/food/meat/slab/mouse = 25,
		/obj/item/food/meat/slab/penguin = 5,
		/obj/item/food/meat/slab/pig = 25,
		/obj/item/food/meat/slab/pug = 5,
		/obj/item/food/meat/slab/rawcrab = 5,
		/obj/item/food/meat/slab/spider = 75,
		/obj/item/food/meat/slab/synthmeat = 50,
		/obj/item/food/meat/slab/xeno = 25
		/obj/item/food/meatball = 50,
		/obj/item/food/meatball/bear = 5,
		/obj/item/food/meatball/chicken = 5,
		/obj/item/food/meatball/corgi = 5,
		/obj/item/food/meatball/human = 50,
		/obj/item/food/meatball/xeno = 25,
		/obj/item/food/monkeycube = 100,
		/obj/item/food/monkeycube/bee = 25,
		/obj/item/food/monkeycube/chicken = 25,

	) = 100,
	list(
		/obj/item/food/grown/aloe = 25,
		/obj/item/food/grown/ambrosia/deus = 1,
		/obj/item/food/grown/ambrosia/vulgaris = 5,
		/obj/item/food/grown/banana = 75,
		/obj/item/food/grown/berries/poison = 50,
		/obj/item/food/grown/berries = 75,
		/obj/item/food/grown/berries/glow = 25,
		/obj/item/food/grown/bungopit = 200,
		/obj/item/food/grown/cannabis = 25,
		/obj/item/food/grown/citrus/orange = 50,
		/obj/item/food/grown/citrus/lemon = 25,
		/obj/item/food/grown/ghost_chili = 10,
		/obj/item/food/grown/herbs = 25,
		/obj/item/food/grown/icepepper = 10,
		/obj/item/food/grown/jumpingbeans = 25,
		/obj/item/food/grown/laugh = 5,
		/obj/item/food/grown/mushroom/amanita = 5,
		/obj/item/food/grown/mushroom/glowshroom = 10,
		/obj/item/food/grown/mushroom/glowshroom/glowcap = 5,
		/obj/item/food/grown/mushroom/glowshroom/shadowshroom = 5,
		/obj/item/food/grown/mushroom/libertycap = 10,
		/obj/item/food/grown/mushroom/odious_puffball = 200,
		/obj/item/food/grown/mushroom/reishi = 25,
		/obj/item/food/grown/onion = 25,
		/obj/item/food/grown/poppy = 25,
		/obj/item/food/grown/poppy/opiumpoppy = 25,
		/obj/item/food/grown/pumpkin = 25,
		/obj/item/food/grown/rainbow_flower = 25,
		/obj/item/food/grown/random = 100
		/obj/item/food/grown/rose = 25,
		/obj/item/food/grown/shell/eggy = 25,
		/obj/item/food/grown/tea/catnip = 25,
		/obj/item/food/grown/tomato = 75,




	) = 100,






))



GLOBAL_LIST_INIT(uncommon_loot, list(//uncommon: useful items
	/obj/item/airbag = 25,
	/obj/item/anesthetic_machine_kit = 10,
	/obj/item/anomaly_neutralizer = 25,
	/obj/item/aquarium_kit = 10,
	/obj/item/assembly/flash = 10,
	/obj/item/assembly/shock_kit = 25,
	/obj/item/autopsy_scanner = 10,
	/obj/item/ballistic_broken = 1,
	/obj/item/corpsman_broken = 1,
	/obj/item/banhammer = 5,
	/obj/item/barcode = 5,
	/obj/item/barcodescanner = 25,
	/obj/item/dest_tagger = 10,
	/obj/item/binoculars = 10,
	/obj/item/biopsy_tool = 50,
	list(
		/obj/item/blood_filter = 10,
		/obj/item/bonesetter = 25,
		/obj/item/cautery = 50,
		/obj/item/cautery/ashwalker = 25,
		/obj/item/circular_saw = 10,
		/obj/item/circular_saw/ashwalker = 5,
		/obj/item/defibrillator = 1

	) = 50,
	/obj/item/book/codex_gigas = 10,
	list(
		/obj/item/book/granter/crafting_recipe/boneyard_notes = 1,
		/obj/item/book/granter/crafting_recipe/cooking_sweets_101 = 10,
		/obj/item/book/granter/crafting_recipe/death_sandwich = 1,
		/obj/item/book/granter/crafting_recipe/pipegun_prime = 1,
		/obj/item/book/granter/crafting_recipe/trash_cannon = 1,
		/obj/item/book/granter/sign_language = 10
	) = 75,
	list(
		/obj/item/bot_assembly/cleanbot = 100,
		/obj/item/bot_assembly/ed209 = 25,
		/obj/item/bot_assembly/firebot = 50,
		/obj/item/bot_assembly/floorbot = 50,
		/obj/item/bot_assembly/honkbot = 25,
		/obj/item/bot_assembly/hygienebot = 25,
		/obj/item/bot_assembly/medbot = 50,
		/obj/item/bot_assembly/secbot = 25,
		/obj/item/bot_assembly/vim = 25
	) = 25,
	/obj/item/boxcutter = 10,
	list(
		/obj/item/choice_beacon/music = 5,
		/obj/item/choice_beacon/ingredient = 1
	) = 10,
	list(
		/obj/item/clothing/glasses/blindfold = 10,
		/obj/item/clothing/mask/muzzle = 10,
		/obj/item/clothing/suit/jacket/straight_jacket = 1,
		/obj/item/electropack = 25,
	) = 50,
	list(
		/obj/item/clothing/glasses/eyepatch = 25,
		/obj/item/clothing/glasses/fake_sunglasses = 100,
		/obj/item/clothing/glasses/trickblindfold = 25,
		/obj/item/clothing/head/costume/bearpelt = 75,
		/obj/item/clothing/head/costume/bunnyhead = 25,
		/obj/item/clothing/head/costume/canada = 50,
		/obj/item/clothing/head/costume/festive = 50,
		/obj/item/clothing/head/costume/foilhat = 25,
		/obj/item/clothing/head/costume/kitty = 25,
		/obj/item/clothing/head/costume/kitty/genuine = 5,
		/obj/item/clothing/head/costume/lizard = 5,
		/obj/item/clothing/head/costume/party = 10,
		/obj/item/clothing/head/costume/rabbitears = 25,
		/obj/item/clothing/head/costume/santa = 50,
		/obj/item/clothing/head/costume/sombrero = 100,
		/obj/item/clothing/head/costume/tv_head = 10,
		/obj/item/clothing/head/costume/ushanka = 100,
		/obj/item/clothing/head/hats/tophat = 50,
		/obj/item/clothing/head/soft/yankee = 25
		/obj/item/clothing/head/soft/yankee/rimless = 5,
		/obj/item/clothing/head/waldo = 10,
		/obj/item/clothing/head/wig/random = 100,
		/obj/item/clothing/mask/animal/cowmask = 25,
		/obj/item/clothing/mask/animal/frog = 25,
		/obj/item/clothing/mask/animal/horsehead = 25,
		/obj/item/clothing/mask/animal/pig = 25,
		/obj/item/clothing/mask/gondola = 25,
		/obj/item/clothing/mask/joy = 25,
		/obj/item/clothing/mask/luchador = 5,
		/obj/item/clothing/mask/luchador/enzo = 5,
		/obj/item/clothing/mask/luchador/rudos = 5,
		/obj/item/clothing/mask/luchador/tecnicos = 5,
		/obj/item/clothing/mask/party_horn = 25,
		/obj/item/clothing/neck/beads = 10,
		/obj/item/clothing/neck/necklace/dope = 25,
		/obj/item/clothing/shoes/ducky_shoes = 10,
		/obj/item/clothing/shoes/jackboots/timbs = 5,
		/obj/item/clothing/shoes/sports = 5,



	) = 25,
	list(
		/obj/item/clothing/gloves/color/fyellow = 100,
		/obj/item/clothing/gloves/color/ffyellow = 25
		/obj/item/clothing/gloves/color/fyellow/old = 25
		/obj/item/clothing/gloves/color/yellow = 10,
		/obj/item/clothing/gloves/color/yellow/heavy = 10,
		/obj/item/clothing/gloves/color/red = 50,
		/obj/item/clothing/gloves/color/red/insulated = 10,
		/obj/item/clothing/gloves/cut = 25,
	) = 75,
	list(
		/obj/item/clothing/suit/armor/bulletproof/old = 5,
		/obj/item/clothing/head/helmet/old = 10,
		/obj/item/clothing/head/helmet/toggleable/justice = 5,
		/obj/item/clothing/head/helmet/toggleable/justice/escape = 5,

	) = 10,
	list(
		/obj/item/clothing/head/utility/welding = 10,
		/obj/item/clothing/glasses/welding = 5,
		/obj/item/clothing/mask/gas/welding = 1
	) = 25,
	/obj/item/clothing/shoes/galoshes = 5,
	list(




	)

))



GLOBAL_LIST_INIT(rarity_loot, list(//rare: really good items
	/obj/item/aicard/aitater = 25,
	/obj/item/ammo_box/foambox/riot = 50,
	list(
		/obj/item/ammo_casing/shotgun/antitide = 1,
		/obj/item/ammo_casing/shotgun/beanbag = 1,
		/obj/item/ammo_casing/shotgun/beehive = 1,
		/obj/item/ammo_casing/shotgun/buckshot = 50,
		/obj/item/ammo_casing/shotgun/dart = 1,
		/obj/item/ammo_casing/shotgun/dragonsbreath = 1,
		/obj/item/ammo_casing/shotgun/express = 1,
		/obj/item/ammo_casing/shotgun/flechette = 1,
		/obj/item/ammo_casing/shotgun/frag12 = 1,
		/obj/item/ammo_casing/shotgun/honk = 25,
		/obj/item/ammo_casing/shotgun/hp = 1,
		/obj/item/ammo_casing/shotgun/hunter = 1,
		/obj/item/ammo_casing/shotgun/iceblox = 1,
		/obj/item/ammo_casing/shotgun/improvised = 100,
		/obj/item/ammo_casing/shotgun/incapacitate = 1,
		/obj/item/ammo_casing/shotgun/incendiary = 1,
		/obj/item/ammo_casing/shotgun/ion = 1,
		/obj/item/ammo_casing/shotgun/laserslug = 1,
		/obj/item/ammo_casing/shotgun/magnum = 1,
		/obj/item/ammo_casing/shotgun/pt20 = 1,
		/obj/item/ammo_casing/shotgun/pulverizer = 1,
		/obj/item/ammo_casing/shotgun/rip = 1,
		/obj/item/ammo_casing/shotgun/rubbershot = 100,
		/obj/item/ammo_casing/shotgun/stunslug = 25,
		/obj/item/ammo_casing/shotgun/techshell = 75
	),
	/obj/item/analyzer/ranged = 1,
	list(
		/obj/item/autosurgeon/organ/nif/disposable = 10,
		/obj/item/autosurgeon/organ/nif = 1
	) = 1,
	/obj/item/beacon = 1,
	list(
		/obj/item/clothing/glasses/hud/ar/projector/diagnostic = 50,
		/obj/item/clothing/glasses/hud/ar/projector/health = 25,
		/obj/item/clothing/glasses/hud/ar/projector/meson = 100,
		/obj/item/clothing/glasses/hud/ar/projector/science = 25,
		/obj/item/clothing/glasses/hud/ar/projector/security = 10

		/obj/item/clothing/glasses/hud/eyepatch/diagnostic = 50,
		/obj/item/clothing/glasses/hud/eyepatch/med = 25,
		/obj/item/clothing/glasses/hud/eyepatch/meson = 100,
		/obj/item/clothing/glasses/hud/eyepatch/sci = 25,
		/obj/item/clothing/glasses/hud/eyepatch/sec = 10

		/obj/item/clothing/glasses/hud/diagnostic = 50,
		/obj/item/clothing/glasses/hud/health = 25,
		/obj/item/clothing/glasses/material/mining = 100,
		/obj/item/clothing/glasses/meson = 100,
		/obj/item/clothing/glasses/science = 25,
		/obj/item/clothing/glasses/hud/security = 10

		/obj/item/clothing/glasses/hud/gun_permit = 25,
		/obj/item/clothing/glasses/hud/security/redsec = 5,
		/obj/item/clothing/glasses/meson/engine = 25,
		/obj/item/clothing/glasses/meson/engine/tray = 25,

		/obj/item/clothing/glasses/sunglasses/reagent = 1
		/obj/item/clothing/glasses/sunglasses/chemical = 1,
		/obj/item/clothing/glasses/sunglasses/spy = 1

	) = 10,
	list(
		/obj/item/clothing/glasses/sunglasses = 10,
		/obj/item/clothing/glasses/sunglasses/big = 1
	) = 25,
	list(
		/obj/item/clothing/head/collectable/captain = 1,
		/obj/item/clothing/head/collectable/chef = 1,
		/obj/item/clothing/head/collectable/hardhat = 1,
		/obj/item/clothing/head/collectable/hop = 1,
		/obj/item/clothing/head/collectable/hos = 1,
		/obj/item/clothing/head/collectable/kitty = 1,
		/obj/item/clothing/head/collectable/paper = 1,
		/obj/item/clothing/head/collectable/petehat = 1,
		/obj/item/clothing/head/collectable/pirate = 1,
		/obj/item/clothing/head/collectable/police = 1,
		/obj/item/clothing/head/collectable/rabbitears = 1,
		/obj/item/clothing/head/collectable/slime = 1,
		/obj/item/clothing/head/collectable/swat = 1,
		/obj/item/clothing/head/collectable/thunderdome = 1,
		/obj/item/clothing/head/collectable/tophat = 1,
		/obj/item/clothing/head/collectable/welding = 1,
		/obj/item/clothing/head/collectable/wizard = 1,
		/obj/item/clothing/head/collectable/xenom = 1
	) = 25,
	/obj/item/clothing/mask/gas/sechailer = 10,
	/obj/item/clothing/suit/hooded/bloated_human = 5,
	list(
		/obj/item/construction/plumbing = 1,
		/obj/item/construction/plumbing/engineering = 1,
		/obj/item/construction/plumbing/mining = 1,
		/obj/item/construction/plumbing/research = 1,
		/obj/item/construction/plumbing/service = 1,
		/obj/item/construction/rcd = 1,
		/obj/item/construction/rld = 10,
		/obj/item/construction/rtd = 10
	) = 5,
	/obj/item/cortical_cage = 5,
	/obj/item/detective_scanner = 25,
	list(
		/obj/item/dnainjector/chavmut = 10,
		/obj/item/dnainjector/clever = 1,
		/obj/item/dnainjector/clumsymut = 5,
		/obj/item/dnainjector/dwarf = 1,
		/obj/item/dnainjector/elvismut = 10,
		/obj/item/dnainjector/epimut = 5,
		/obj/item/dnainjector/gigantism = 1,
		/obj/item/dnainjector/glassesmut = 5,
		/obj/item/dnainjector/glow = 1,
		/obj/item/dnainjector/illiterate = 5,
		/obj/item/dnainjector/m2h = 5,
		/obj/item/dnainjector/piglatinmut = 5,
		/obj/item/dnainjector/stuttmut = 10,
		/obj/item/dnainjector/swedishmut = 10,
		/obj/item/dnainjector/timed/h2m = 1,
		/obj/item/dnainjector/tourmut = 1,
		/obj/item/dnainjector/twoleftfeet = 1,
		/obj/item/dnainjector/wackymut = 10,
	) = 10
	/obj/item/dog_bone = 5,
	/obj/item/door_seal = 5,
	list(
		/obj/item/encryptionkey/translation/beach_bum = 1,
		/obj/item/encryptionkey/translation/buzzwords = 1,
		/obj/item/encryptionkey/translation/gutter = 1,
		/obj/item/encryptionkey/translation/machine = 1,
		/obj/item/encryptionkey/translation/mushroom = 1,
		/obj/item/encryptionkey/translation/shadow = 1,
		/obj/item/encryptionkey/translation/skrellian = 1,
		/obj/item/encryptionkey/translation/slime = 1,
		/obj/item/encryptionkey/translation/spacer = 1,
		/obj/item/encryptionkey/translation/sylvan = 1,
		/obj/item/encryptionkey/translation/tajaran = 1,
		/obj/item/encryptionkey/translation/terrum = 1,
		/obj/item/encryptionkey/translation/teshari = 1,
		/obj/item/encryptionkey/translation/uncommon = 1,
		/obj/item/encryptionkey/translation/vox = 1,
		/obj/item/encryptionkey/translation/vulpkanin = 1,
		/obj/item/encryptionkey/translation/yangyu = 1,
	) = 5,
	/obj/item/etherealballdeployer = 5,
	list(
		/obj/item/firing_pin/clown = 100,
		/obj/item/firing_pin/clown/ultra = 50,
		/obj/item/firing_pin/explorer = 25,
		/obj/item/firing_pin/paywall/luxury = 50,
		/obj/item/firing_pin/tag/blue = 5,
		/obj/item/firing_pin/tag/red = 5,
		/obj/item/firing_pin/test_range = 10
	) = 5,








))



GLOBAL_LIST_INIT(oddity_loot, list(//oddity: strange or crazy items
	/obj/item/a_gift/anything = 100,
	list(
		/obj/item/clothing/head/helmet/abductor/fake = 10,
		/obj/item/abductor/mind_device = 1,
		/obj/item/abductor/gizmo = 1,
		/obj/item/abductor/silencer = 1,
		/obj/item/cautery/alien = 1,
		/obj/item/circular_saw/alien = 1,
		/obj/item/clothing/head/helmet/abductor = 1,


	) = 25,
	/obj/item/ai_module/toy_ai = 100,
	/obj/item/anomaly_releaser = 25,
	/obj/item/bombcore/training = 10,
	list(
		/obj/item/book/granter/action/spell/smoke/lesser = 1,
		/obj/item/book/granter/action/spell/blind/wgw = 1,
		/obj/item/book/granter/crafting_recipe/combat_baking = 1,
		/obj/item/book/granter/crafting_recipe/regal_condor = 1
	) = 25,
	/obj/item/bountytrap = 50,
	/obj/item/cardboard_cutout/adaptive = 25,
	/obj/item/chainsaw = 5,
	/obj/item/claymore/weak/weaker = 10,
	/obj/item/clothing/accessory/spy_bug = 5,
	list(
		/obj/item/clothing/glasses/chameleon = 1,
		/obj/item/clothing/glasses/chameleon/broken = 10,
		/obj/item/clothing/gloves/chameleon = 1,
		/obj/item/clothing/gloves/chameleon/broken = 10,
		/obj/item/clothing/head/chameleon = 1,
		/obj/item/clothing/head/chameleon/broken = 10,
		/obj/item/clothing/mask/chameleon = 1,
		/obj/item/clothing/mask/chameleon/broken = 10,
		/obj/item/clothing/neck/chameleon = 1,
		/obj/item/clothing/neck/chameleon/broken = 10
		/obj/item/clothing/shoes/chameleon/noslip = 1,
		/obj/item/clothing/shoes/chameleon/noslip/broken = 10,
		/obj/item/clothing/suit/chameleon = 1,
		/obj/item/clothing/suit/chameleon/broken = 10,
		/obj/item/clothing/under/chameleon = 1,
		/obj/item/clothing/under/chameleon/broken = 10,

		/obj/item/clothing/gloves/combat = 5,
		/obj/item/clothing/gloves/tackler/combat = 10,
		/obj/item/clothing/gloves/tackler/combat/insulated = 5,
		/obj/item/clothing/gloves/tackler/dolphin = 5,
		/obj/item/clothing/gloves/tackler/rocket = 5,

		/obj/item/clothing/mask/gas/syndicate = 5,

		/obj/item/clothing/shoes/bhop = 5,
		/obj/item/clothing/shoes/bhop/rocket = 1,

		/obj/item/clothing/shoes/gunboots/disabler = 5,




	) = 100,
	/obj/item/clothing/glasses/nightmare_vision = 5,
	/obj/item/clothing/head/helmet/monkey_sentience = 25,
	/obj/item/clothing/head/soft/grey/jolly = 5,
	/obj/item/crowbar/large/heavy = 5,
	/obj/item/device/traitor_announcer = 1,
	/obj/item/dice/d20/fate/stealth/one_use = 1,
	/obj/item/dnainjector/h2m = 1,
	/obj/item/flashlight/flashdark = 1,
	/obj/item/food/burger/ghost = 1,
	/obj/item/food/burger/crazy = 1,
	/obj/item/food/grown/banana/bunch = 1,
	/obj/item/food/grown/banana/bombanana = 1,
	/obj/item/food/grown/citrus/orange_3d = 1,
	/obj/item/food/grown/firelemon = 1,
	/obj/item/food/grown/kudzupod = 1,
	/obj/item/food/monkeycube/gorilla = 5,
	/obj/item/food/monkeycube/syndicate = 5,











))

//Loot pool used by default maintenance loot spawners
GLOBAL_LIST_INIT(maintenance_loot, list(

))

GLOBAL_LIST_INIT(ratking_trash, list(//Garbage: used by the regal rat mob when spawning garbage.

))

GLOBAL_LIST_INIT(ratking_coins, list(//Coins: Used by the regal rat mob when spawning coins.

))
