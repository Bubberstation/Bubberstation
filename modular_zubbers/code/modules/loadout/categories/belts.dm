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

/datum/loadout_item/belts/deforest_frontiermedkit
	name = "Empty Frontier Medical Kit"
	item_path = /obj/item/storage/medkit/frontier

/datum/loadout_item/belts/chestrig
	name = "Chest rig"
	item_path = /obj/item/storage/belt/military

/datum/loadout_item/belts/cin_chestrig
	name = "CIN Surplus Chest Rig"
	item_path = /obj/item/storage/belt/military/cin_surplus

/datum/loadout_item/belts/medicalbelt
	name = "Medical Belt"
	item_path = /obj/item/storage/belt/medical
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CORONER, JOB_CHEMIST, JOB_CHIEF_MEDICAL_OFFICER, JOB_PARAMEDIC)

/datum/loadout_item/belts/sciencebag
	name = "Science Bag"
	item_path = /obj/item/storage/bag/xeno
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST)

/datum/loadout_item/belts/toolbelt
	name = "Tool Belt"
	item_path = /obj/item/storage/belt/utility
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ROBOTICIST)

/datum/loadout_item/belts/trashbag
	name = "Trash Bag"
	item_path = /obj/item/storage/bag/trash

/datum/loadout_item/belts/constructionbag
	name = "Construction Bag"
	item_path = /obj/item/storage/bag/construction
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_CHIEF_ENGINEER)

/datum/loadout_item/belts/plantbag
	name = "Plant Bag"
	item_path = /obj/item/storage/bag/plants

/datum/loadout_item/belts/servingtray
	name = "Serving Tray"
	item_path = /obj/item/storage/bag/tray

/datum/loadout_item/belts/chemistrybag
	name = "chemistry bag"
	item_path = /obj/item/storage/bag/chemistry
	restricted_roles = list(JOB_CHEMIST, JOB_CHIEF_MEDICAL_OFFICER)
