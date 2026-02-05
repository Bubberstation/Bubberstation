/datum/loadout_category/shoes
	category_name = "Shoes"
	category_ui_icon = FA_ICON_SHOE_PRINTS
	type_to_generate = /datum/loadout_item/shoes
	tab_order = /datum/loadout_category/head::tab_order + 11

/datum/loadout_item/shoes
	abstract_type = /datum/loadout_item/shoes

/datum/loadout_item/shoes/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.shoes)
		LAZYADD(outfit.backpack_contents, outfit.shoes)
	outfit.shoes = item_path

/*
*	JACKBOOTS
*/

/datum/loadout_item/shoes/boots
	group = "Boots"
	abstract_type = /datum/loadout_item/shoes/boots

/datum/loadout_item/shoes/boots/jackboots
	name = "Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots

/datum/loadout_item/shoes/boots/jackboots/recolorable
	name = "Jackboots (Recolorable)"
	item_path = /obj/item/clothing/shoes/jackboots/recolorable

/datum/loadout_item/shoes/boots/metra_boots
	name = "Polished Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/netra
	//ckeywhitelist = list("netrakyram")

/datum/loadout_item/shoes/boots/jackboots/sec
	name = "Security Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/sec
	restricted_roles = list(ALL_JOBS_SEC)

// Thedragmeme's donator reward, they've decided to make them available to everybody.
/datum/loadout_item/shoes/boots/jackboots/heel
	name = "High-Heel Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/heel

/datum/loadout_item/shoes/boots/jackboots/rax_armadyne_boots
	name = "Tactical Boots"
	item_path = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne/rax
	//ckeywhitelist = list("raxraus")
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/shoes/boots/jackboots/kneeboots
	name = "Knee Boots"
	item_path = /obj/item/clothing/shoes/jackboots/knee

/datum/loadout_item/shoes/boots/jackboots/peacekeeper
	name = "Armadyne Combat Boots"
	item_path = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/shoes/boots/jackboots/gogo_boots
	name = "Tactical Go-Go boots"
	item_path = /obj/item/clothing/shoes/jackboots/gogo_boots
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/shoes/boots/diesel_m
	name = "Male Diesel Boots"
	item_path = /obj/item/clothing/shoes/jackboots/diesel_m

/datum/loadout_item/shoes/boots/diesel_f
	name = "Female Diesel Boots"
	item_path = /obj/item/clothing/shoes/jackboots/diesel_f

/datum/loadout_item/shoes/boots/frontier_colonist
	name = "Frontier Boots"
	item_path = /obj/item/clothing/shoes/jackboots/frontier_colonist/loadout

/datum/loadout_item/shoes/boots/jackboots/toeless
	name = "Toeless Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/toeless

/datum/loadout_item/shoes/boots/kim
	name = "Aerostatic Boots"
	item_path = /obj/item/clothing/shoes/jackboots/kim

/datum/loadout_item/shoes/boots/jackboots/black
	name = "Black Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/black

/datum/loadout_item/shoes/boots/elofy
	name = "Solar Admiral Boots"
	item_path = /obj/item/clothing/shoes/jackboots/elofy
//	ckeywhitelist = list("october23")

/*
*	MISC BOOTS
*/

/datum/loadout_item/shoes/boots/jackboots/timbs
	name = "Fashionable Boots"
	item_path = /obj/item/clothing/shoes/jackboots/timbs

/datum/loadout_item/shoes/boots/jackboots/jungle
	name = "Jungle Boots"
	item_path = /obj/item/clothing/shoes/jungleboots

/datum/loadout_item/shoes/boots/winter_boots
	name = "Winter Boots"
	item_path = /obj/item/clothing/shoes/winterboots

/datum/loadout_item/shoes/boots/work_boots
	name = "Work Boots"
	item_path = /obj/item/clothing/shoes/workboots

/datum/loadout_item/shoes/boots/work_boots/heeled
	name = "Heeled Work Boots"
	item_path = /obj/item/clothing/shoes/workboots/heeled

/datum/loadout_item/shoes/boots/work_boots/old
	name = "Work Boots (Old)"
	item_path = /obj/item/clothing/shoes/workboots/old

/datum/loadout_item/shoes/boots/mining_boots
	name = "Mining Boots"
	item_path = /obj/item/clothing/shoes/workboots/mining

/datum/loadout_item/shoes/boots/mining_boots/heeled
	name = "Heeled Mining Boots"
	item_path = /obj/item/clothing/shoes/workboots/mining/heeled

/datum/loadout_item/shoes/boots/russian_boots
	name = "Russian Boots"
	item_path = /obj/item/clothing/shoes/russian

/datum/loadout_item/shoes/boots/pirate_boots
	name = "Pirate Boots"
	item_path = /obj/item/clothing/shoes/pirate

/datum/loadout_item/shoes/boots/work_boots/toeless
	name = "Toeless Workboots"
	item_path = /obj/item/clothing/shoes/workboots/toeless

/datum/loadout_item/shoes/boots/noble_boots
	name = "Noble Boots"
	item_path = /obj/item/clothing/shoes/jackboots/noble
	//ckeywhitelist = list("grasshand")

/*
*	COWBOY
*/

/datum/loadout_item/shoes/cowboy
	group = "Cowboy Boots"
	abstract_type = /datum/loadout_item/shoes/cowboy

/datum/loadout_item/shoes/cowboy/cowboyboots
	name = "Cowboy Boots (Brown)"
	item_path = /obj/item/clothing/shoes/cowboyboots

/datum/loadout_item/shoes/cowboy/boots_black
	name = "Cowboy Boots (Black)"
	item_path = /obj/item/clothing/shoes/cowboyboots/black


/*
*	LEG WRAPS
*/

/datum/loadout_item/shoes/tribal
	group = "Tribal Footwear"
	abstract_type = /datum/loadout_item/shoes/tribal

/datum/loadout_item/shoes/tribal/gildedcuffs
	name = "Gilded Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps

/datum/loadout_item/shoes/tribal/silvercuffs
	name = "Silver Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/silver

/datum/loadout_item/shoes/tribal/redcuffs
	name = "Red Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/red

/datum/loadout_item/shoes/tribal/bluecuffs
	name = "Blue Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/blue

/datum/loadout_item/shoes/tribal/cuffs/colourable
	name = "Colourable Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/colourable

/datum/loadout_item/shoes/tribal/clothwrap
	name = "Colourable Cloth Wraps"
	item_path = /obj/item/clothing/shoes/wraps/cloth

/*
*	FORMAL
*/

/datum/loadout_item/shoes/formal
	group = "Formal Shoes"
	abstract_type = /datum/loadout_item/shoes/formal

/datum/loadout_item/shoes/formal/laceups/recolorable
	name = "Laceup Shoes (Recolorable)"
	item_path = /obj/item/clothing/shoes/colorable_laceups

/datum/loadout_item/shoes/formal/dominaheels
	name = "Dominant Heels"
	item_path = /obj/item/clothing/shoes/latex_heels/domina_heels
	erp_item = TRUE

/datum/loadout_item/shoes/formal/high_heels
	name = "High Heels"
	item_path = /obj/item/clothing/shoes/high_heels

/datum/loadout_item/shoes/formal/black_heels
	name = "Fancy Heels"
	item_path = /obj/item/clothing/shoes/fancy_heels

/datum/loadout_item/shoes/formal/disco
	name = "Green Snakeskin Shoes"
	item_path = /obj/item/clothing/shoes/discoshoes

/datum/loadout_item/shoes/formal/dragheels
	name = "Fancy Heels (dragmeme)"
	item_path = /obj/item/clothing/shoes/fancy_heels/drag
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/shoes/formal/bubber/clown/pink/mute //Less silly = Unrestricted
	name = "Pink Heels"
	item_path = /obj/item/clothing/shoes/latex_heels/bubber/clussy/mute

/datum/loadout_item/shoes/formal/latex_heels
	name = "Latex Heels"
	item_path = /obj/item/clothing/shoes/latex_heels

//Casual

/datum/loadout_item/shoes/casual
	group = "Casual Shoes"
	abstract_type = /datum/loadout_item/shoes/casual

/datum/loadout_item/shoes/casual/sneakers/black_sneakers
	name = "Sneakers (Recolorble)"
	item_path = /obj/item/clothing/shoes/sneakers/black

/datum/loadout_item/shoes/casual/sandals
	name = "Sandals"
	item_path = /obj/item/clothing/shoes/sandal

/datum/loadout_item/shoes/casual/sandals/recolorable
	name = "Sandals (Recolorble)"
	item_path = /obj/item/clothing/shoes/colorable_sandals

/datum/loadout_item/shoes/casual/sportshoes
	name = "Sport Shoes"
	item_path = /obj/item/clothing/shoes/sports

/datum/loadout_item/shoes/casual/rainbow
	name = "Rainbow Converse"
	item_path = /obj/item/clothing/shoes/sneakers/rainbow

//Fun
/datum/loadout_item/shoes/fun
	group = "Costume and Other Silly Shoes"
	abstract_type = /datum/loadout_item/shoes/fun

/datum/loadout_item/shoes/fun/mikulegging
	name = "Starlight Singer Bikini"
	item_path = /obj/item/clothing/shoes/sneakers/mikuleggings
	//ckeywhitelist = list("grandvegeta")

/datum/loadout_item/shoes/fun/rollerskates
	name = "Roller Skates"
	item_path = /obj/item/clothing/shoes/wheelys/rollerskates

/datum/loadout_item/shoes/fun/jingleshoes
	name = "Jester Shoes"
	item_path = /obj/item/clothing/shoes/jester_shoes

/datum/loadout_item/shoes/fun/griffin
	name = "Griffon Boots"
	item_path = /obj/item/clothing/shoes/griffin

/datum/loadout_item/shoes/fun/wheely
	name = "Wheely-Heels"
	item_path = /obj/item/clothing/shoes/wheelys

/datum/loadout_item/shoes/fun/horseshoes
	name = "Horseshoes"
	item_path = /obj/item/clothing/shoes/horseshoe

/datum/loadout_item/shoes/fun/romans
	name = "Roman Sandals"
	item_path = /obj/item/clothing/shoes/roman

/datum/loadout_item/shoes/fun/saints
	name = "Saints Sneakers"
	item_path = /obj/item/clothing/shoes/saints

/datum/loadout_item/shoes/fun/jackfrost
	name = "Frosty Boots"
	item_path = /obj/item/clothing/shoes/jackbros

/*
*	SEASONAL
*/

/datum/loadout_item/shoes/fun/christmas
	name = "Red Christmas Boots"
	item_path = /obj/item/clothing/shoes/winterboots/christmas

/datum/loadout_item/shoes/fun/christmas/green
	name = "Green Christmas Boots"
	item_path = /obj/item/clothing/shoes/winterboots/christmas/green


/*
*	JOB-RESTRICTED
*/

/datum/loadout_item/shoes/fun/jester
	name = "Clown's Jester Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/jester
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/fun/clown_shoes/pink
	name = "Pink Clown Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/pink
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/fun/britches_shoes
	name = "Britches' Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/britches
	restricted_roles = list(JOB_CLOWN)
	//ckeywhitelist = list("bloodrite")

/datum/loadout_item/shoes/fun/bubber/clown/pink/squeak //Unlike the rest, these make noise. Job locked.
	name = "Pink Clown Heels"
	item_path = /obj/item/clothing/shoes/clown_shoes/bubber/clussy
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/fun/bubber/clown/jester/amazing
	name = "Striped Jester Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/bubber/jester
	restricted_roles = list(JOB_CLOWN)

