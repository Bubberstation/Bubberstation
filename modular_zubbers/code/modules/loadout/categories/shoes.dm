//Title Capitalization for names please!!!

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

/datum/loadout_item/shoes/jackboots
	name = "Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots

// Thedragmeme's donator reward, they've decided to make them available to everybody.
/datum/loadout_item/shoes/jackboots/heel
	name = "High-Heel Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/heel

/datum/loadout_item/shoes/kneeboot
	name = "Knee Boots"
	item_path = /obj/item/clothing/shoes/jackboots/knee

/datum/loadout_item/shoes/recolorable_jackboots
	name = "Recolorable Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/recolorable

/datum/loadout_item/shoes/jackboots/sec
	name = "Security Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/sec
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC)

/datum/loadout_item/shoes/jackboots/peacekeeper
	name = "Armadyne combat boots"
	item_path = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC)

/datum/loadout_item/shoes/jackboots/gogo_boots
	name = "Tactical Go-Go boots"
	item_path = /obj/item/clothing/shoes/jackboots/gogo_boots
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC)

/*
*	MISC BOOTS
*/

/datum/loadout_item/shoes/timbs
	name = "Fashionable Boots"
	item_path = /obj/item/clothing/shoes/jackboots/timbs

/datum/loadout_item/shoes/jungle
	name = "Jungle Boots"
	item_path = /obj/item/clothing/shoes/jungleboots

/datum/loadout_item/shoes/winter_boots
	name = "Winter Boots"
	item_path = /obj/item/clothing/shoes/winterboots

/datum/loadout_item/shoes/work_boots
	name = "Work Boots"
	item_path = /obj/item/clothing/shoes/workboots

/datum/loadout_item/shoes/work_boots/heeled
	name = "Heeled Work Boots"
	item_path = /obj/item/clothing/shoes/workboots/heeled

/datum/loadout_item/shoes/work_boots/old
	name = "Old Work Boots"
	item_path = /obj/item/clothing/shoes/workboots/old

/datum/loadout_item/shoes/mining_boots
	name = "Mining Boots"
	item_path = /obj/item/clothing/shoes/workboots/mining

/datum/loadout_item/shoes/mining_boots/heeled
	name = "Heeled Mining Boots"
	item_path = /obj/item/clothing/shoes/workboots/mining/heeled

/datum/loadout_item/shoes/russian_boots
	name = "Russian Boots"
	item_path = /obj/item/clothing/shoes/russian

/datum/loadout_item/shoes/bubber/clown/pink/squeak //Unlike the rest, these make noise. Job locked.
	name = "Pink Clown Heels"
	item_path = /obj/item/clothing/shoes/clown_shoes/bubber/clussy
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/bubber/clown/pink/mute //Less silly = Unrestricted
	name = "Squeakless Pink Clown Heels"
	item_path = /obj/item/clothing/shoes/latex_heels/bubber/clussy/mute

/datum/loadout_item/shoes/bubber/clown/jester/amazing
	name = "Striped Jester Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/bubber/jester
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/latex_heels
	name = "Latex Heels"
	item_path = /obj/item/clothing/shoes/latex_heels

/datum/loadout_item/shoes/pirate_boots
	name = "Pirate Boots"
	item_path = /obj/item/clothing/shoes/pirate

/datum/loadout_item/shoes/Wheely_heels
	name = "Wheely-Heels"
	item_path = /obj/item/clothing/shoes/wheelys

/datum/loadout_item/shoes/horseshoes
	name = "Horseshoes"
	item_path = /obj/item/clothing/shoes/horseshoe

/datum/loadout_item/shoes/diesel_m
	name = "Male Diesel Boots"
	item_path = /obj/item/clothing/shoes/jackboots/diesel_m

/datum/loadout_item/shoes/diesel_f
	name = "Female Diesel Boots"
	item_path = /obj/item/clothing/shoes/jackboots/diesel_f

/datum/loadout_item/shoes/frontier_colonist
	name = "Frontier Boots"
	item_path = /obj/item/clothing/shoes/jackboots/frontier_colonist/loadout

/datum/loadout_item/shoes/jackboots/toeless
	name = "Toeless Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/toeless

/datum/loadout_item/shoes/workboots/toeless
	name = "Toeless Workboots"
	item_path = /obj/item/clothing/shoes/workboots/toeless

/*
*	COWBOY
*/

/datum/loadout_item/shoes/brown_cowboy_boots
	name = "Brown Cowboy Boots"
	item_path = /obj/item/clothing/shoes/cowboy

/datum/loadout_item/shoes/black_cowboy_boots
	name = "Black Cowboy Boots"
	item_path = /obj/item/clothing/shoes/cowboy/black

/datum/loadout_item/shoes/white_cowboy_boots
	name = "White Cowboy Boots"
	item_path = /obj/item/clothing/shoes/cowboy/white

/datum/loadout_item/shoes/cowboyboots
	name = "Cowboy Boots (Brown)"
	item_path = /obj/item/clothing/shoes/cowboyboots

/datum/loadout_item/shoes/cowboyboots_black
	name = "Cowboy Boots (Black)"
	item_path = /obj/item/clothing/shoes/cowboyboots/black

/*
*	SNEAKERS
*/

/datum/loadout_item/shoes/black_sneakers
	name = "Black Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/black

/datum/loadout_item/shoes/blue_sneakers
	name = "Blue Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/blue

/datum/loadout_item/shoes/brown_sneakers
	name = "Brown Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/brown

/datum/loadout_item/shoes/green_sneakers
	name = "Green Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/green

/datum/loadout_item/shoes/purple_sneakers
	name = "Purple Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/purple

/datum/loadout_item/shoes/orange_sneakers
	name = "Orange Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/orange

/datum/loadout_item/shoes/yellow_sneakers
	name = "Yellow Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/yellow

/datum/loadout_item/shoes/white_sneakers
	name = "White Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/white

/*
*	LEG WRAPS
*/

/datum/loadout_item/shoes/gildedcuffs
	name = "Gilded Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps

/datum/loadout_item/shoes/silvercuffs
	name = "Silver Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/silver

/datum/loadout_item/shoes/redcuffs
	name = "Red Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/red

/datum/loadout_item/shoes/bluecuffs
	name = "Blue Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/blue

/datum/loadout_item/shoes/cuffs/colourable
	name = "Colourable Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/colourable

/datum/loadout_item/shoes/clothwrap
	name = "Colourable Cloth Wraps"
	item_path = /obj/item/clothing/shoes/wraps/cloth

/*
*	MISC
*/

/datum/loadout_item/shoes/laceup
	name = "Laceup Shoes"
	item_path = /obj/item/clothing/shoes/laceup

/datum/loadout_item/shoes/recolorable_laceups
	name = "Recolorable Laceups"
	item_path = /obj/item/clothing/shoes/colorable_laceups

/datum/loadout_item/shoes/recolorable_sandals
	name = "Recolorble Sandals"
	item_path = /obj/item/clothing/shoes/colorable_sandals

/datum/loadout_item/shoes/high_heels
	name = "High Heels"
	item_path = /obj/item/clothing/shoes/high_heels

/datum/loadout_item/shoes/black_heels
	name = "Fancy Heels"
	item_path = /obj/item/clothing/shoes/fancy_heels

/datum/loadout_item/shoes/disco
	name = "Green Snakeskin Shoes"
	item_path = /obj/item/clothing/shoes/discoshoes

/datum/loadout_item/shoes/kim
	name = "Aerostatic Shoes"
	item_path = /obj/item/clothing/shoes/kim

/datum/loadout_item/shoes/dominaheels
	name = "Dominant Heels"
	item_path = /obj/item/clothing/shoes/latex_heels/domina_heels
	erp_item = TRUE

/datum/loadout_item/shoes/griffin
	name = "Griffon Boots"
	item_path = /obj/item/clothing/shoes/griffin

/datum/loadout_item/shoes/sandals
	name = "Sandals"
	item_path = /obj/item/clothing/shoes/sandal

/datum/loadout_item/shoes/sportshoes
	name = "Sport Shoes"
	item_path = /obj/item/clothing/shoes/sports

/datum/loadout_item/shoes/rollerskates
	name = "Roller Skates"
	item_path = /obj/item/clothing/shoes/wheelys/rollerskates

/datum/loadout_item/shoes/jingleshoes
	name = "Jester Shoes"
	item_path = /obj/item/clothing/shoes/jester_shoes

/*
*	SEASONAL
*/

/datum/loadout_item/shoes/christmas
	name = "Red Christmas Boots"
	item_path = /obj/item/clothing/shoes/winterboots/christmas

/datum/loadout_item/shoes/christmas/green
	name = "Green Christmas Boots"
	item_path = /obj/item/clothing/shoes/winterboots/christmas/green


/*
*	JOB-RESTRICTED
*/

/datum/loadout_item/shoes/jester
	name = "Clown's Jester Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/jester
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/clown_shoes/pink
	name = "Pink Clown Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/pink
	restricted_roles = list(JOB_CLOWN)

/*
*	DONATOR
*/

/datum/loadout_item/shoes/donator
	donator_only = TRUE

/datum/loadout_item/shoes/donator/blackjackboots
	name = "Black Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/black

/datum/loadout_item/shoes/donator/rainbow
	name = "Rainbow Converse"
	item_path = /obj/item/clothing/shoes/sneakers/rainbow

/datum/loadout_item/shoes/rax_armadyne_boots
	name = "Tactical Boots"
	item_path = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne/rax
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_MEDIC, JOB_CORRECTIONS_OFFICER)
	//ckeywhitelist = list("raxraus")

/datum/loadout_item/shoes/britches_shoes
	name = "Britches' shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/britches
	//ckeywhitelist = list("bloodrite")

/datum/loadout_item/shoes/metra_boots
	name = "Polished Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/netra
	//ckeywhitelist = list("netrakyram")

/datum/loadout_item/shoes/mikulegging //Having a Bikini be shoes instead of an under is foul, never do this again.
	name = "Starlight Singer Bikini"
	item_path = /obj/item/clothing/shoes/sneakers/mikuleggings
	//ckeywhitelist = list("grandvegeta")

/datum/loadout_item/shoes/dragheels
	name = "Fancy Heels (dragmeme)"
	item_path = /obj/item/clothing/shoes/fancy_heels/drag
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/shoes/noble_boots
	name = "Noble Boots"
	item_path = /obj/item/clothing/shoes/jackboots/noble
	//ckeywhitelist = list("grasshand")

/datum/loadout_item/shoes/elofy
	name = "Solar Admiral Boots"
	item_path = /obj/item/clothing/shoes/jackboots/elofy
	can_be_reskinned = TRUE
//	ckeywhitelist = list("october23")



