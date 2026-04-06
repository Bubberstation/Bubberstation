//ASH WEAPON
/obj/item/melee/macahuitl
	name = "ash macahuitl"
	desc = "A weapon that looks like it will leave really bad marks."
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing.dmi'
	lefthand_file = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_left.dmi'
	righthand_file = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_right.dmi'
	icon_state = "macahuitl"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2)

	force = 15
	wound_bonus = 15
	exposed_wound_bonus = 10

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null
	resistance_flags = FIRE_PROOF | LAVA_PROOF

/datum/crafting_recipe/ash_recipe/macahuitl
	name = "Ash Macahuitl"
	result = /obj/item/melee/macahuitl
	reqs = list(
		/obj/item/stack/sheet/bone = 2,
		/obj/item/stack/sheet/sinew = 2,
		/obj/item/stack/sheet/animalhide/goliath_hide = 2,
	)

	category = CAT_WEAPON_MELEE
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED
