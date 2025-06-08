/obj/item/mod/module/hydraulic_movement
	icon = 'modular_gs/icons/obj/clothing/modsuit/mod_modules.dmi'
	icon_state = "hydraulic_mod"
	name = "MOD hydraulic movement assistance module"
	desc = "A module created by GATO, installed across the suit, featuring a system of hydraulic pistons \
		that support and lighten vast amounts of excess weight to provide easier movement."
	complexity = 1
	incompatible_modules = list(/obj/item/mod/module/hydraulic_movement)
	idle_power_cost = 5
	var/amount = -2
	var/modifier_name = "hydraulic_mod"

/obj/item/mod/module/hydraulic_movement/locked
	name = "MOD hydraulic movement assistance module (locked)"
	removable = FALSE

/obj/item/mod/module/hydraulic_movement/on_suit_activation()
	var/mob/living/carbon/human/wearer = mod.wearer
	wearer.add_fat_delay_modifier(modifier_name, amount)

	if(!HAS_TRAIT_FROM(wearer, TRAIT_NO_HELPLESSNESS, src))
		ADD_TRAIT(wearer, TRAIT_NO_HELPLESSNESS, src)

	if(HAS_TRAIT_FROM(wearer, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT))
		REMOVE_TRAIT(wearer, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT)
//	if(HAS_TRAIT_FROM(wearer, TRAIT_CLUMSY, HELPLESSNESS_TRAIT))
//		REMOVE_TRAIT(wearer, TRAIT_CLUMSY, HELPLESSNESS_TRAIT)
//	if(HAS_TRAIT_FROM(wearer, TRAIT_NEARSIGHT, HELPLESSNESS_TRAIT))
//		wearer.cure_nearsighted(HELPLESSNESS_TRAIT)
//	if(HAS_TRAIT_FROM(wearer, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT))
//		REMOVE_TRAIT(wearer, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT)
	if(HAS_TRAIT_FROM(wearer, TRAIT_MUTE, HELPLESSNESS_TRAIT))
		REMOVE_TRAIT(wearer, TRAIT_MUTE, HELPLESSNESS_TRAIT)
	if(HAS_TRAIT_FROM(wearer, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT))
		REMOVE_TRAIT(wearer, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT)
		REMOVE_TRAIT(wearer, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
		wearer.update_disabled_bodyparts()
//	if(HAS_TRAIT_FROM(wearer, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT))
//		REMOVE_TRAIT(wearer, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT)
	if(HAS_TRAIT_FROM(wearer, TRAIT_NO_MISC, HELPLESSNESS_TRAIT))
		REMOVE_TRAIT(wearer, TRAIT_NO_MISC, HELPLESSNESS_TRAIT)
	if(HAS_TRAIT_FROM(wearer, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT))
		REMOVE_TRAIT(wearer, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT)
//	if(HAS_TRAIT_FROM(wearer, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT))
//		REMOVE_TRAIT(wearer, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT)

/obj/item/mod/module/hydraulic_movement/on_suit_deactivation(deleting = FALSE)
	if(deleting)
		return
	if(HAS_TRAIT_FROM(mod.wearer, TRAIT_NO_HELPLESSNESS, src))
		REMOVE_TRAIT(mod.wearer, TRAIT_NO_HELPLESSNESS, src)
	mod.wearer.remove_fat_delay_modifier(modifier_name)

/datum/design/module/hydraulic_movement
	name = "Hydraulic Assistance Module"
	id = "mod_hydraulic"
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 200)
	build_path = /obj/item/mod/module/hydraulic_movement
	desc = "A GATO-designed module that supports plumper bodies and allows easier movement."

/obj/item/mod/module/calovoltaic
	icon = 'modular_gs/icons/obj/clothing/modsuit/mod_modules.dmi'
	icon_state = "calovoltaic_mod"
	name = "MOD calovoltaic generator module"
	desc = "A module created by GATO, capable of burning adipose tissue \
		to generate power for the suit it is installed onto."
	module_type = MODULE_TOGGLE
	complexity = 1
	incompatible_modules = list(/obj/item/mod/module/calovoltaic)
	var/rate = 5

/obj/item/mod/module/calovoltaic/locked
	name = "MOD calovoltaic generator module (locked)"
	removable = FALSE

/obj/item/mod/module/storage/locked
	name = "MOD storage containment module (locked)"
	removable = FALSE

/obj/item/mod/module/calovoltaic/on_select()
	. = ..()
	if(active)
		balloon_alert(mod.wearer, "activated!")
	else
		balloon_alert(mod.wearer, "deactivated!")

/obj/item/mod/module/calovoltaic/on_active_process(delta_time)
	if(istype(mod.wearer, /mob/living/carbon))
		var/mob/living/carbon/C = mod.wearer
		var/adjusted_rate = rate * C.weight_loss_rate
		if(C.fatness_real > 0 && (C.fatness_real - adjusted_rate) >= adjusted_rate)
			C.adjust_fatness(-rate, FATTENING_TYPE_WEIGHT_LOSS)
			mod.cell.give(rate)

/datum/design/module/calovoltaic
	name = "Calovoltaic Generator Module"
	id = "mod_calovoltaic"
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/plasma = 500)
	build_path = /obj/item/mod/module/calovoltaic
	desc = "A GATO-designed module for burning excess fat to make power for your suit."

/obj/item/mod/construction/armor/exoskeleton
	theme = /datum/mod_theme/exoskeleton

/obj/item/mod/control/Initialize(mapload, new_theme, new_skin)
	. = ..()
	gs13_icon_update()

/obj/item/mod/control/proc/gs13_icon_update()
	if(theme.use_gs_icon == TRUE)
		icon = 'modular_gs/icons/obj/clothing/modsuit/mod_clothing.dmi'
		mob_overlay_icon = 'modular_gs/icons/mob/clothing/modsuit/mod_clothing.dmi'
		icon_state = "[theme]-control"
		item_state = "[theme]-control"

		helmet.icon = 'modular_gs/icons/obj/clothing/modsuit/mod_clothing.dmi'
		helmet.mob_overlay_icon = 'modular_gs/icons/mob/clothing/modsuit/mod_clothing.dmi'
		helmet.icon_state = "[theme]-helmet"
		helmet.item_state = "[theme]-helmet"

		chestplate.icon = 'modular_gs/icons/obj/clothing/modsuit/mod_clothing.dmi'
		chestplate.mob_overlay_icon = 'modular_gs/icons/mob/clothing/modsuit/mod_clothing.dmi'
		chestplate.icon_state = "[theme]-chestplate"
		chestplate.item_state = "[theme]-chestplate"

		gauntlets.icon = 'modular_gs/icons/obj/clothing/modsuit/mod_clothing.dmi'
		gauntlets.mob_overlay_icon = 'modular_gs/icons/mob/clothing/modsuit/mod_clothing.dmi'
		gauntlets.icon_state = "[theme]-gauntlets"
		gauntlets.item_state = "[theme]-gauntlets"

		boots.icon = 'modular_gs/icons/obj/clothing/modsuit/mod_clothing.dmi'
		boots.mob_overlay_icon = 'modular_gs/icons/mob/clothing/modsuit/mod_clothing.dmi'
		boots.icon_state = "[theme]-boots"
		boots.item_state = "[theme]-boots"

/datum/mod_theme
	var/use_gs_icon = FALSE

/datum/mod_theme/exoskeleton
	use_gs_icon = TRUE
	name = "exoskeleton"
	desc = "The design for a GATO-branded mobility exoskeleton"
	extended_desc = "To combat the obesity epidemic that spreads on its stations, \
		GATO scientists have worked hard to create this simple yet efficient way to support \
		people whose weight proves restrictive and help them on their journey to lose it."
	default_skin = "exoskeleton"
	complexity_max = 5
	armor = list(MELEE = 5, BULLET = 5, LASER = 5, ENERGY = 5, BOMB = 5, BIO = 5, FIRE = 5, ACID = 5, WOUND = 5, RAD = 5)
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = 1
	min_cold_protection_temperature = -1
	permeability_coefficient = 1
	siemens_coefficient = 1
	slowdown_inactive = 0
	slowdown_active = 0
	inbuilt_modules = list(/obj/item/mod/module/hydraulic_movement, /obj/item/mod/module/calovoltaic, /obj/item/mod/module/storage)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals)
	skins = list(
		"exoskeleton" = list(
			HELMET_LAYER = NECK_LAYER,
			HELMET_FLAGS = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				UNSEALED_INVISIBILITY = NONE,
				SEALED_INVISIBILITY = NONE,
				SEALED_COVER = NONE,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				SEALED_INVISIBILITY = NONE,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
			),
		),
		"invisible" = list(
			HELMET_LAYER = NECK_LAYER,
			HELMET_FLAGS = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				UNSEALED_INVISIBILITY = NONE,
				SEALED_INVISIBILITY = NONE,
				SEALED_COVER = NONE,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				SEALED_INVISIBILITY = NONE,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
			),
		)
	)

/datum/mod_theme/exoskeleton/locked
	inbuilt_modules = list(/obj/item/mod/module/hydraulic_movement/locked, /obj/item/mod/module/calovoltaic/locked, /obj/item/mod/module/storage/locked)

/obj/item/mod/control/pre_equipped/exoskeleton
	desc = "A pre-built GATO mobility exoskeleton, designed to support high weights, favor movement and weight loss."
	theme = /datum/mod_theme/exoskeleton
	cell = /obj/item/stock_parts/cell/upgraded/plus

/obj/item/mod/control/pre_equipped/exoskeleton/locked
	name = "MOD control unit (locked)"
	desc = "A pre-built GATO mobility exoskeleton, designed to support high weights, favor movement and weight loss. This model's modules cannot be removed."
	theme = /datum/mod_theme/exoskeleton/locked

/datum/design/module/exoskeleton
	name = "MOD exoskeleton"
	id = "mod_exoskeleton"
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 5000, /datum/material/plasma = 5000)
	build_path = /obj/item/mod/control/pre_equipped/exoskeleton
	desc = "A GATO-designed assistance exoskeleton based on MODsuit tech."
	build_type = MECHFAB
	construction_time = 10 SECONDS
	category = list("MODsuit Chassis", "MODsuit Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/gear/hands/exoskeleton
	name = "MOD exoskeleton"
	category = LOADOUT_CATEGORY_HANDS
	path = /obj/item/mod/control/pre_equipped/exoskeleton/locked
	cost = 3
