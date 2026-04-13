//FLAGS

/datum/crafting_recipe/gaypride
	name = "LGBT Pride Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/pride/gay
	category = CAT_FURNITURE

/datum/crafting_recipe/acepride
	name = "Ace Pride Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/pride/ace
	category = CAT_FURNITURE

/datum/crafting_recipe/bipride
	name = "Bisexual Pride Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/pride/bi
	category = CAT_FURNITURE

/datum/crafting_recipe/lesbianpride
	name = "Lesbian Pride Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/pride/lesbian
	category = CAT_FURNITURE

/datum/crafting_recipe/panpride
	name = "Pansexual Pride Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/pride/pan
	category = CAT_FURNITURE

/datum/crafting_recipe/transpride
	name = "Transgender Pride Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/pride/trans
	category = CAT_FURNITURE

/datum/crafting_recipe/ntflag
	name = "Nanotrasen Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 5,
		/obj/item/toy/crayon/blue = 1,
	)
	result = /obj/item/sign/flag/nanotrasen
	category = CAT_FURNITURE

/datum/crafting_recipe/galflag
	name = "GalFed Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 5,
	)
	result = /obj/item/sign/flag/galfed
	category = CAT_FURNITURE

/datum/crafting_recipe/sharkflag
	name = "Akula Democratic Union Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/ssc
	category = CAT_FURNITURE

/datum/crafting_recipe/teegeeflag
	name = "Terran Government Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/terragov
	category = CAT_FURNITURE

/datum/crafting_recipe/lizardflag
	name = "Tizira Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/tizira
	category = CAT_FURNITURE

/datum/crafting_recipe/mothflag
	name = "Mothic Fleet Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/mothic
	category = CAT_FURNITURE

/datum/crafting_recipe/teshflag
	name = "Teshari League for Self-Determination Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/mars
	category = CAT_FURNITURE

/datum/crafting_recipe/rusflag
	name = "Pan-Slavic Commonwealth Flag"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/nri
	category = CAT_FURNITURE

/datum/crafting_recipe/azuleaflag //why the fuck did skyrat make two of these???
	name = "Akula Democratic Union Banner"
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
	)
	result = /obj/item/sign/flag/azulea
	category = CAT_FURNITURE

/datum/crafting_recipe/usaflag
	name = "United States of America Flag"
	reqs = list(
		/obj/item/gun/ballistic/automatic/pistol/deagle = 1,
		/obj/item/stack/sheet/cloth = 7,
		/obj/item/food/burger = 7,
		/obj/item/reagent_containers/cup/glass/bottle/beer = 6,
	)
	result = /obj/item/sign/flag/usa
	category = CAT_FURNITURE
	requirements_mats_blacklist = list(/obj/item/gun/ballistic/automatic/pistol/deagle)

// STRUCTURES


/datum/crafting_recipe/detectiveboard
	name = "Detective's Notice Board"
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 1,
	)
	result = /obj/structure/detectiveboard
	time = 20 SECONDS
	category = CAT_FURNITURE

/datum/crafting_recipe/blackcoffin
	name = "Black Coffin"
	result = /obj/structure/closet/crate/coffin/blackcoffin
	tool_behaviors = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	reqs = list(
		/obj/item/stack/sheet/cloth = 1,
		/obj/item/stack/sheet/mineral/wood = 5,
		/obj/item/stack/sheet/iron = 1,
	)
	time = 15 SECONDS
	category = CAT_FURNITURE

//VAMPIRE STUFF

/datum/crafting_recipe/securecoffin
	name = "Secure Coffin"
	result = /obj/structure/closet/crate/coffin/securecoffin
	tool_behaviors = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/stack/sheet/plasteel = 5,
		/obj/item/stack/sheet/iron = 5,
	)
	time = 15 SECONDS
	category = CAT_FURNITURE

/datum/crafting_recipe/meatcoffin
	name = "Meat Coffin"
	result = /obj/structure/closet/crate/coffin/meatcoffin
	tool_behaviors = list(TOOL_KNIFE, TOOL_ROLLINGPIN)
	reqs = list(
		/obj/item/food/meat/slab = 5,
		/obj/item/restraints/handcuffs/cable = 1,
	)
	time = 15 SECONDS
	category = CAT_FURNITURE
	crafting_flags = parent_type::crafting_flags | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/metalcoffin
	name = "Metal Coffin"
	result = /obj/structure/closet/crate/coffin/metalcoffin
	reqs = list(
		/obj/item/stack/sheet/iron = 6,
		/obj/item/stack/rods = 2,
	)
	time = 10 SECONDS
	category = CAT_FURNITURE

/datum/crafting_recipe/ghoulrack
	name = "Persuasion Rack"
	result = /obj/structure/bloodsucker/ghoulrack
	tool_behaviors = list(TOOL_WELDER, TOOL_WRENCH)
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 3,
		/obj/item/stack/sheet/iron = 2,
		/obj/item/restraints/handcuffs/cable = 2,
	)
	time = 15 SECONDS
	category = CAT_FURNITURE
	crafting_flags = parent_type::crafting_flags | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/candelabrum
	name = "Candelabrum"
	result = /obj/structure/bloodsucker/candelabrum
	tool_behaviors = list(TOOL_WELDER, TOOL_WRENCH)
	reqs = list(
		/obj/item/stack/sheet/iron = 3,
		/obj/item/stack/rods = 1,
		/obj/item/flashlight/flare/candle = 1,
	)
	time = 10 SECONDS
	category = CAT_FURNITURE
	crafting_flags = parent_type::crafting_flags | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/bloodthrone
	name = "Blood Throne"
	result = /obj/structure/bloodsucker/bloodthrone
	tool_behaviors = list(TOOL_WRENCH)
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
		/obj/item/stack/sheet/iron = 5,
		/obj/item/stack/sheet/mineral/wood = 1,
	)
	time = 5 SECONDS
	category = CAT_FURNITURE
	crafting_flags = parent_type::crafting_flags | CRAFT_MUST_BE_LEARNED

