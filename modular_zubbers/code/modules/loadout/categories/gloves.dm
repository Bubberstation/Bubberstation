//Title Capitalization for names please!!!

/datum/loadout_category/gloves
	category_name = "Gloves"
	category_ui_icon = FA_ICON_HAND
	type_to_generate = /datum/loadout_item/gloves
	tab_order = /datum/loadout_category/head::tab_order + 8

/datum/loadout_item/gloves
	abstract_type = /datum/loadout_item/gloves

/datum/loadout_item/gloves/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(equipper.dna?.species?.outfit_important_for_life)
		if(!visuals_only)
			to_chat(equipper, "Your loadout gloves were not equipped directly due to your species outfit.")
			LAZYADD(outfit.backpack_contents, item_path)
	else
		if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.gloves)
			LAZYADD(outfit.backpack_contents, outfit.gloves)
		outfit.gloves = item_path

/datum/loadout_item/gloves/fingerless
	name = "Fingerless Gloves"
	item_path = /obj/item/clothing/gloves/fingerless

/datum/loadout_item/gloves/black
	name = "Black Gloves"
	item_path = /obj/item/clothing/gloves/color/black

/datum/loadout_item/gloves/blue
	name = "Blue Gloves"
	item_path = /obj/item/clothing/gloves/color/blue

/datum/loadout_item/gloves/brown
	name = "Brown Gloves"
	item_path = /obj/item/clothing/gloves/color/brown

/datum/loadout_item/gloves/green
	name = "Green Gloves"
	item_path = /obj/item/clothing/gloves/color/green

/datum/loadout_item/gloves/grey
	name = "Grey Gloves"
	item_path = /obj/item/clothing/gloves/color/grey

/datum/loadout_item/gloves/light_brown
	name = "Light Brown Gloves"
	item_path = /obj/item/clothing/gloves/color/light_brown

/datum/loadout_item/gloves/orange
	name = "Orange Gloves"
	item_path = /obj/item/clothing/gloves/color/orange

/datum/loadout_item/gloves/purple
	name = "Purple Gloves"
	item_path = /obj/item/clothing/gloves/color/purple

/datum/loadout_item/gloves/red
	name = "Red Gloves"
	item_path = /obj/item/clothing/gloves/color/red

/datum/loadout_item/gloves/yellow
	name = "Yellow Gloves"
	item_path = /obj/item/clothing/gloves/color/ffyellow

/datum/loadout_item/gloves/white
	name = "White Gloves"
	item_path = /obj/item/clothing/gloves/color/white

/datum/loadout_item/gloves/rainbow
	name = "Rainbow Gloves"
	item_path = /obj/item/clothing/gloves/color/rainbow

/datum/loadout_item/gloves/evening
	name = "Evening Gloves"
	item_path = /obj/item/clothing/gloves/evening

/datum/loadout_item/gloves/kim
	name = "Aerostatic Gloves"
	item_path = /obj/item/clothing/gloves/kim

/datum/loadout_item/gloves/maid_arm_covers
	name = "Colourable Maid Arm Covers"
	item_path = /obj/item/clothing/gloves/maid_arm_covers

/datum/loadout_item/gloves/armwraps
	name = "Colourable Arm Wraps"
	item_path = /obj/item/clothing/gloves/bracer/wraps

/datum/loadout_item/gloves/bubber/clown //I would job lock these but, they're just gloves.
	name = "Pink Clown Gloves"
	item_path = /obj/item/clothing/gloves/bubber/clussy

/datum/loadout_item/gloves/lace_gloves
	name = "Lace Gloves"
	item_path = /obj/item/clothing/gloves/evening/lace
	donator_only = TRUE

/datum/loadout_item/gloves/rubber_gloves
	name = "Long Rubber Gloves"
	item_path = /obj/item/clothing/gloves/longrubbergloves

/datum/loadout_item/gloves/rubber_gloves/med
	name = "Long Rubber Medical Gloves"
	item_path = /obj/item/clothing/gloves/latex/nitrile/longrubbergloves
	restricted_roles = list(ALL_JOBS_MEDICAL, JOB_GENETICIST)

/datum/loadout_item/gloves/tactical_maid //Donor item for skyefree
	name = "Tactical Maid Gloves"
	item_path = /obj/item/clothing/gloves/tactical_maid
	donator_only = TRUE

/datum/loadout_item/gloves/color/black/security
	name = "Security Gloves"
	item_path = /obj/item/clothing/gloves/color/black/security
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/gloves/combat/peacekeeper/armadyne
	name = "Armadyne Combat Gloves"
	item_path = /obj/item/clothing/gloves/combat/peacekeeper/armadyne
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/gloves/frontier_colonist
	name = "Frontier Gloves"
	item_path = /obj/item/clothing/gloves/frontier_colonist/loadout

/datum/loadout_item/gloves/cat
	name = "Cat Gloves"
	item_path = /obj/item/clothing/gloves/cat

/datum/loadout_item/gloves/blutigen_wraps
	name = "Blutigen Wraps"
	item_path = /obj/item/clothing/gloves/fingerless/blutigen_wraps
	//ckeywhitelist = list("random516")

/datum/loadout_item/gloves/netra_gloves
	name = "Black and Silver Gloves"
	item_path = /obj/item/clothing/gloves/netra
	//ckeywhitelist = list("netrakyram")

/datum/loadout_item/gloves/mikugloves
	name = "Starlight Singer Gloves"
	item_path = /obj/item/clothing/gloves/mikugloves
	//ckeywhitelist = list("grandvegeta")

/datum/loadout_item/gloves/elofy
	name = "Solar Admiral Gloves"
	item_path = /obj/item/clothing/gloves/elofy
//	ckeywhitelist = list("october23")

/datum/loadout_item/gloves/hypnoring_sharkenning
	name = "Suspiciously Glossy Ring"
	item_path = /obj/item/clothing/gloves/ring/hypno/sharkenning
	ckeywhitelist = list("thesharkenning", "tecktonic")

/datum/loadout_item/gloves/lt3_gloves
	name = "Charcoal Fingerless Gloves"
	item_path = /obj/item/clothing/gloves/skyy

/*
*	RINGS
*/

/datum/loadout_item/gloves/silverring
	name = "Silver Ring"
	item_path = /obj/item/clothing/gloves/ring/silver

/datum/loadout_item/gloves/goldring
	name = "Gold Ring"
	item_path = /obj/item/clothing/gloves/ring

/datum/loadout_item/gloves/diamondring
	name = "Diamond Ring"
	item_path = /obj/item/clothing/gloves/ring/diamond

/datum/loadout_item/gloves/hypnoring_coffee
	name = "Hypnodemon's Ring"
	item_path = /obj/item/clothing/gloves/ring/hypno/coffeepot
	//ckeywhitelist = list("coffeepot")

/datum/loadout_item/gloves/hypnoring_bippy
	name = "Hypnodemon's Ring"
	item_path = /obj/item/clothing/gloves/ring/hypno/bippys
	ckeywhitelist = list("bippys")

