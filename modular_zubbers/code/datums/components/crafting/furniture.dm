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
