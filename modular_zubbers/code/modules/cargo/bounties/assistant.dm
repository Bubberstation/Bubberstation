// Migrated TG Bounties

/datum/bounty/item/assistant/strange_object
	name = "Strange Object"
	description = "Nanotrasen has taken an interest in strange objects. Find one in maintenance, and ship it off to CentCom right away."
	reward = CARGO_CRATE_VALUE * 2.4
	wanted_types = list(/obj/item/relic = TRUE)

/datum/bounty/item/assistant/scooter
	name = "Scooter"
	description = "Nanotrasen has determined walking to be wasteful. Ship a scooter to CentCom to speed operations up."
	reward = CARGO_CRATE_VALUE * 2.16 // the mat hoffman
	wanted_types = list(/obj/vehicle/ridden/scooter = TRUE)
	include_subtypes = FALSE

/datum/bounty/item/assistant/skateboard
	name = "Skateboard"
	description = "Nanotrasen has determined walking to be wasteful. Ship a skateboard to CentCom to speed operations up."
	reward = CARGO_CRATE_VALUE * 1.8 // the tony hawk
	wanted_types = list(
		/obj/vehicle/ridden/scooter/skateboard = TRUE,
		/obj/item/melee/skateboard = TRUE,
	)

/datum/bounty/item/assistant/stunprod
	name = "Stunprod"
	description = "CentCom demands a stunprod to use against dissidents. Craft one, then ship it."
	reward = CARGO_CRATE_VALUE * 2.6
	wanted_types = list(/obj/item/melee/baton/security/cattleprod = TRUE)

/datum/bounty/item/assistant/spear
	name = "Spears"
	description = "CentCom's security forces are going through budget cuts. You will be paid if you ship a set of spears."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 5
	wanted_types = list(/obj/item/spear = TRUE)

/datum/bounty/item/assistant/toolbox
	name = "Stocked Toolbox"
	description = "There's an absence of robustness at Central Command. Ship them a fully packed toolbox as a solution, containing a screwdriver, wrench, welding tool, crowbar, analyzer, and wirecutters."
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/item/storage/toolbox = TRUE)
	/// List of tools that we want to see sorted into a toolbox
	var/static/list/static_packing_list = list(
		/obj/item/screwdriver,
		/obj/item/wrench,
		/obj/item/weldingtool,
		/obj/item/crowbar,
		/obj/item/analyzer,
		/obj/item/wirecutters,
	)

/datum/bounty/item/assistant/toolbox/applies_to(obj/shipped)
	var/list/packing_list = static_packing_list.Copy()
	for(var/obj/item_contents as anything in shipped.contents)
		for(var/match_type in packing_list)
			if(istype(item_contents, match_type))
				packing_list -= match_type
				break
		if(!length(packing_list))
			return ..()
	return FALSE

/datum/bounty/item/assistant/toolbox/ship(obj/shipped)
	. = ..()
	for(var/obj/object as anything in shipped.contents)
		if(!is_type_in_list(object, static_packing_list))
			object.forceMove(shipped.drop_location())

/datum/bounty/item/assistant/statue
	name = "Statue"
	description = "Central Command would like to commission an artsy statue for the lobby. Ship one out, when possible."
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/structure/statue = TRUE)

/datum/bounty/item/assistant/baseball_bat
	name = "Baseball Bat"
	description = "Baseball fever is going on at CentCom! Be a dear and ship them some baseball bats, so that management can live out their childhood dream."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 5
	wanted_types = list(/obj/item/melee/baseball_bat = TRUE)

/datum/bounty/item/assistant/donut
	name = "Donuts"
	description = "CentCom's security forces are facing heavy losses against the Syndicate. Ship donuts to raise morale."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 6
	wanted_types = list(/obj/item/food/donut = TRUE)

/datum/bounty/item/assistant/monkey_hide
	name = "Monkey Hide"
	description = "One of the scientists at CentCom is interested in testing products on monkey skin. Your mission is to acquire monkey's hide and ship it."
	reward = CARGO_CRATE_VALUE * 3
	wanted_types = list(/obj/item/stack/sheet/animalhide/monkey = TRUE)

/datum/bounty/item/assistant/comfy_chair
	name = "Comfy Chairs"
	description = "Commander Pat is unhappy with his chair. He claims it hurts his back. Ship some alternatives out to humor him."
	reward = CARGO_CRATE_VALUE * 3
	required_count = 5
	wanted_types = list(/obj/structure/chair/comfy = TRUE)

/datum/bounty/item/assistant/monkey_cubes
	name = "Monkey Cubes"
	description = "Due to a recent genetics accident, Central Command is in serious need of monkeys. Your mission is to ship monkey cubes."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 3
	wanted_types = list(/obj/item/food/monkeycube = TRUE)

/datum/bounty/item/assistant/ied
	name = "IED"
	description = "Nanotrasen's maximum security prison at CentCom is undergoing personnel training. Ship a handful of IEDs to serve as a training tools."
	reward = CARGO_CRATE_VALUE * 6 // Boosted from default since they've been made harder to make.
	required_count = 3
	wanted_types = list(/obj/item/grenade/iedcasing = TRUE)

/datum/bounty/item/assistant/toys
	name = "Arcade Toys"
	description = "The vice president's son saw an ad for new toys on the telescreen and now he won't shut up about them. Ship some arcade toys over to ease his complaints."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 5
	wanted_types = list(/obj/item/toy = TRUE)

/datum/bounty/item/assistant/paper_bin
	name = "Paper Bins"
	description = "Our accounting division is all out of paper. We need a new shipment immediately."
	reward = CARGO_CRATE_VALUE * 5
	required_count = 5
	wanted_types = list(/obj/item/paper_bin = TRUE)

/datum/bounty/item/assistant/crayons
	name = "Crayons"
	description = "Dr. Jones's kid ate all of our crayons again. Please send us yours."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 7 // Edited down to 7. There's only 7 in a pack.
	wanted_types = list(/obj/item/toy/crayon = TRUE)

/datum/bounty/item/assistant/water_tank
	name = "Water Tank"
	description = "We need more water for our hydroponics bay. Find a water tank and ship it out to us."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/structure/reagent_dispensers/watertank = TRUE)

/datum/bounty/item/assistant/pneumatic_cannon
	name = "Pneumatic Cannon"
	description = "We're figuring out how hard we can launch supermatter shards out of a pneumatic cannon. Send us one as soon as possible."
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/item/pneumatic_cannon/ghetto = TRUE)

/datum/bounty/item/assistant/improvised_shells
	name = "Junk Shells"
	description = "Our assistant militia has chewed through all our iron supplies. To stop them making bullets out of station property, we need junk shells, pronto."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 5
	wanted_types = list(/obj/item/ammo_casing/junk = TRUE)

/datum/bounty/item/assistant/flamethrower
	name = "Flamethrower"
	description = "We have a moth infestation, send a flamethrower to help deal with the situation."
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/item/flamethrower = TRUE)

/datum/bounty/item/assistant/fish
	name = "Fish"
	description = "We need fish to populate our aquariums with. Fishes that are dead or bought from cargo will only be paid half as much."
	reward = CARGO_CRATE_VALUE * 9.5
	required_count = 4
	wanted_types = list(/obj/item/fish = TRUE, /obj/item/storage/fish_case = TRUE)
	///the penalty for shipping dead/bought fish, which can subtract up to half the reward in total.
	var/shipping_penalty

/datum/bounty/item/assistant/fish/New()
	..()
	shipping_penalty = reward * 0.5 / required_count

/datum/bounty/item/assistant/fish/applies_to(obj/shipped)
	. = ..()
	if(!.)
		return
	var/obj/item/fish/fishie = shipped
	if(istype(shipped, /obj/item/storage/fish_case))
		fishie = locate() in shipped
		if(!fishie || !is_type_in_typecache(fishie, wanted_types))
			return FALSE
	return can_ship_fish(fishie)

/datum/bounty/item/assistant/fish/proc/can_ship_fish(obj/item/fish/fishie)
	return TRUE

/datum/bounty/item/assistant/fish/ship(obj/shipped)
	. = ..()
	if(!.)
		return
	var/obj/item/fish/fishie = shipped
	if(istype(shipped, /obj/item/storage/fish_case))
		fishie = locate() in shipped
	if(fishie.status == FISH_DEAD || HAS_TRAIT(fishie, TRAIT_FISH_LOW_PRICE))
		reward -= shipping_penalty

///A subtype of the fish bounty that requires fish with a specific fluid type
/datum/bounty/item/assistant/fish/fluid
	reward = CARGO_CRATE_VALUE * 12
	///The required fluid type of the fish for it to be shipped
	var/fluid_type

/datum/bounty/item/assistant/fish/fluid/New()
	..()
	fluid_type = pick(AQUARIUM_FLUID_FRESHWATER, AQUARIUM_FLUID_SALTWATER, AQUARIUM_FLUID_SULPHWATEVER)
	name = "[fluid_type] Fish"
	description = "We need [LOWER_TEXT(fluid_type)] fish to populate our aquariums with. Fishes that are dead or bought from cargo will only be paid half as much."

/datum/bounty/item/assistant/fish/fluid/can_ship_fish(obj/item/fish/fishie)
	return (fluid_type in GLOB.fish_compatible_fluid_types[fishie.required_fluid_type])

// Bubber Bounties

/datum/bounty/item/assistant/towels
	name = "Towels"
	description = "Radioactive moths ate everything in the Central Command locker rooms. We need more towels immediately."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 6
	wanted_types = list(/obj/item/towel = TRUE)

/datum/bounty/item/assistant/clipboards
	name = "Clipboards"
	description = "Things are getting a bit disorderly, send Centcom some clipboards to get things back on track."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 4
	wanted_types = list(/obj/item/clipboard = TRUE)

/datum/bounty/item/assistant/mousetraps
	name = "Mousetraps"
	description = "A rodent rebellion is stirring in CentCom. Send us mousetraps to help stop their advance."
	reward = CARGO_CRATE_VALUE * 3.75
	required_count = 4
	wanted_types = list(/obj/item/assembly/mousetrap = TRUE)

/datum/bounty/item/assistant/dancefloor
	name = "wired floor tiles"
	description = "There's a distinct lack of flare to CentCom's recreational area. Wire up some dance flooring for us so we can make things pop. Make sure they're complete!"
	reward = CARGO_CRATE_VALUE * 9
	required_count = 9
	wanted_types = list(/obj/item/stack/tile/light = TRUE)

/datum/bounty/item/assistant/toysword
	name = "Toy Swords"
	description = "CentCom Security forces are looking for a safer way to train after their last... accident. Send them some toy swords to fiddle with."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 3
	wanted_types = list(/obj/item/toy/sword = TRUE)

/datum/bounty/item/assistant/bolas
	name = "Bolas"
	description = "A humanized monkey escaped containment and covered itself in cooking oil. Please send some bola's so CentCom can capture them."
	reward = CARGO_CRATE_VALUE * 5
	required_count = 5
	wanted_types = list(/obj/item/restraints/legcuffs/bola = TRUE)

/datum/bounty/item/assistant/coffin
	name = "Coffin"
	description = "A beloved station pet was found dead. Please expedite the grieving process by shipping a coffin right away."
	reward = CARGO_CRATE_VALUE * 3 //Coffins themselves export for 100 credits, but this is a bounty. Plus, you'd only get 50% when wrapping them with barcodes.
	wanted_types = list(/obj/structure/closet/crate/coffin = TRUE)

/datum/bounty/item/assistant/cargo_shelf
	name = "Cargo Shelves"
	description = "Centcom's packaging facility is getting a bit tight, send us some cargo shelving kits so we can make room."
	reward = CARGO_CRATE_VALUE * 3
	required_count = 4
	wanted_types = list(/obj/item/rack_parts/cargo_shelf = TRUE)

/datum/bounty/item/assistant/duffelbag
	name = "Duffelbags"
	description = "Centcom's assistant brigade needs duffelbags for a long haul. Ship some right away."
	reward = CARGO_CRATE_VALUE * 5
	required_count = 6
	wanted_types = list(/obj/item/storage/backpack/duffelbag = TRUE)

/datum/bounty/item/assistant/watermelon
	name = "Watermelons"
	description = "The new office craze is melon water. Send Centcom some watermelons so we can squeeze a few pitchers."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 6
	wanted_types = list(/obj/item/food/grown/watermelon = TRUE)

/datum/bounty/item/assistant/dogbed
	name = "Dog Bed"
	description = "After a series of unfortunate events, Central Command has found itself in need of a dog bed. Please ship one immediately."
	reward = CARGO_CRATE_VALUE * 3
	wanted_types = list(/obj/structure/bed/dogbed = TRUE)

/datum/bounty/item/assistant/blueprints
	name = "Crude Blueprints"
	description = "Centcom is looking for creative individuals from the civilian sector. Ship us your crude blueprints."
	reward = CARGO_CRATE_VALUE * 5.75
	wanted_types = list(/obj/item/shuttle_blueprints/crude = TRUE)

/datum/bounty/item/assistant/wheelchair
	name = "Motorized Wheelchair"
	description = "Older members of Command are having some issues getting around. Send us a motorized wheelchair so they have an easier time getting around."
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/vehicle/ridden/wheelchair/motorized = TRUE)

/datum/bounty/item/assistant/trapdoor
	name = "Trapdoor Kit"
	description = "It'll be better if we don't elaborate on why this is needed. Send Central Command a trapdoor kit and be rewarded."
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/item/trapdoor_kit = TRUE)
