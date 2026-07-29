/datum/loadout_category/belts
	category_name = "Belts"
	category_ui_icon = FA_ICON_USER_TIE
	type_to_generate = /datum/loadout_item/belts
	tab_order = /datum/loadout_category/head::tab_order + 6

/datum/loadout_item/belts
	abstract_type = /datum/loadout_item/belts

/datum/loadout_item/belts/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.belt)
		LAZYADD(outfit.backpack_contents, outfit.belt)
	outfit.belt = item_path

/datum/loadout_item/belts/fanny_pack_black
	name = "Black Fannypack"
	item_path = /obj/item/storage/belt/fannypack/black

/datum/loadout_item/belts/fanny_pack_blue
	name = "Blue Fannypack"
	item_path = /obj/item/storage/belt/fannypack/blue

/datum/loadout_item/belts/fanny_pack_brown
	name = "Brown Fannypack"
	item_path = /obj/item/storage/belt/fannypack

/datum/loadout_item/belts/fanny_pack_cyan
	name = "Cyan Fannypack"
	item_path = /obj/item/storage/belt/fannypack/cyan

/datum/loadout_item/belts/fanny_pack_green
	name = "Green Fannypack"
	item_path = /obj/item/storage/belt/fannypack/green

/datum/loadout_item/belts/fanny_pack_orange
	name = "Orange Fannypack"
	item_path = /obj/item/storage/belt/fannypack/orange

/datum/loadout_item/belts/fanny_pack_pink
	name = "Pink Fannypack"
	item_path = /obj/item/storage/belt/fannypack/pink

/datum/loadout_item/belts/fanny_pack_purple
	name = "Purple Fannypack"
	item_path = /obj/item/storage/belt/fannypack/purple

/datum/loadout_item/belts/fanny_pack_red
	name = "Red Fannypack"
	item_path = /obj/item/storage/belt/fannypack/red

/datum/loadout_item/belts/fanny_pack_yellow
	name = "Yellow Fannypack"
	item_path = /obj/item/storage/belt/fannypack/yellow

/datum/loadout_item/belts/fanny_pack_white
	name = "White Fannypack"
	item_path = /obj/item/storage/belt/fannypack/white

/datum/loadout_item/belts/lantern
	name = "Lantern"
	item_path = /obj/item/flashlight/lantern

/datum/loadout_item/belts/darksabresheath
	name = "Dark Sabre Sheath"
	item_path = /obj/item/storage/belt/sheath/sabre/darksabre
	//ckeywhitelist = list("inferno707")

/datum/loadout_item/belts/trinket_belt
	name = "Trinket Belt"
	item_path = /obj/item/storage/belt/fannypack/occult
	//ckeywhitelist = list("gamerguy14948")

/*
* Webbings
*/

/datum/loadout_item/belts/webbing
	name = "Webbing - Basic"
	item_path = /obj/item/storage/belt/webbing

/datum/loadout_item/belts/webbing_colonial
	name = "Webbing - Colonial"
	item_path = /obj/item/storage/belt/webbing/colonial_webbing

/datum/loadout_item/belts/webbing_vest_brown
	name = "Webbing - Vest, Brown"
	item_path = /obj/item/storage/belt/webbing_vest

/datum/loadout_item/belts/webbing_vest_black
	name = "Webbing - Vest, Black"
	item_path = /obj/item/storage/belt/webbing_vest/black

/datum/loadout_item/belts/webbing_vest_white
	name = "Webbing - Vest, White"
	item_path = /obj/item/storage/belt/webbing_vest/white

/datum/loadout_item/belts/webbing_pouch_brown
	name = "Webbing - Drop Pouches, Brown"
	item_path = /obj/item/storage/belt/webbing_pouch

/datum/loadout_item/belts/webbing_pouch_black
	name = "Webbing - Drop Pouches, Black"
	item_path = /obj/item/storage/belt/webbing_pouch/black

/datum/loadout_item/belts/webbing_pouch_white
	name = "Webbing - Drop Pouches, White"
	item_path = /obj/item/storage/belt/webbing_pouch/white

/datum/loadout_item/belts/webbing_pilot_standard
	name = "Webbing - Rigging, Standard"
	item_path = /obj/item/storage/belt/webbing_pilot

/datum/loadout_item/belts/webbing_pilot_low
	name = "Webbing - Rigging, Low Slung"
	item_path = /obj/item/storage/belt/webbing_pilot/low
