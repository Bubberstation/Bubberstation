/obj/item/clothing/head/helmet/space/voskhod
	name = "\proper Voskhod-P depowered combat helmet"
	desc = "A composite graphene-plasteel helmet with a ballistic nylon inner padding, complete with a deployable airtight polycarbonate visor and respirator system. <br>\
	This particular unit's rebreathers have been salvaged off; unable to resynthesize any more breathable air for the user."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/head_muzzled.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/head.dmi'
	icon_state = "nri_soldier"
	armor_type = /datum/armor/hev_suit_nri
	supports_variations_flags = NONE
	slowdown = 1

/obj/item/clothing/suit/space/voskhod
	name = "\proper Voskhod-P depowered combat armor"
	desc = "A hybrid set of space-resistant armor built on a modified mass-produced 'Dawn' space suit, polyurea coated durathread-lined light plasteel plates hinder mobility as little as possible while the onboard life support system aids the user in combat. \
	The power cell is what makes the armor work without hassle, a sticker in the power supply unit warns anyone reading to responsibly manage battery levels. <br>\
	These 'paralyzed', marketable variations of the suit come with most of their main features removed: from the infamous wound-tending systems, to the less appreciated death alarms."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/spacesuit.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/suit.dmi'
	icon_state = "nri_soldier"
	armor_type = /datum/armor/hev_suit_nri
	allowed = list(/obj/item/gun, /obj/item/melee/baton, /obj/item/melee/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	supports_variations_flags = NONE //It's already huge enough to look like it can work with digis
	slowdown = 1

/datum/crafting_recipe/voskhod_to_mod
	name = "Depowered Voskhod-To-Refurbished Voskhod MOD Conversion"
	desc = "While this is usually done on a specialised automated workbench, you can tinker with the suit manually for a longer while to achieve the same result."
	result = /obj/effect/spawner/random/voskhod_refit
	reqs = list(
		/obj/item/clothing/suit/space/voskhod = 1,
		/obj/item/clothing/head/helmet/space/voskhod = 1,
		/obj/item/crafting_conversion_kit/voskhod_refit = 1,
		/obj/item/storage/backpack/industrial/cin_surplus = 1,
		/obj/item/mod/core = 1,
		/obj/item/stock_parts/power_store/cell/high = 1,
		/obj/item/stack/sheet/plasteel = 10,
		/obj/item/stack/cable_coil = 15,
		/obj/item/assembly/health = 1,
	)
	tool_behaviors = list(TOOL_WELDER, TOOL_MULTITOOL)
	time = 30 SECONDS
	category = CAT_CLOTHING
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

/obj/effect/spawner/random/voskhod_refit
	name = "converted MODskhod spawner"
	icon = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "voskhod-chestplate-sealed"
	spawn_all_loot = TRUE
	spawn_loot_count = 1
	loot = list(/obj/item/mod/control/pre_equipped/voskhod)
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 10, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.95, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.45)

