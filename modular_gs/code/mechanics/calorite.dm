/datum/material/calorite
	name = "calorite"
	color = list(340/255, 150/255, 50/255,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0)
	strength_modifier = 1.5
	categories = list(
		MAT_CATEGORY_SILO = TRUE,
		MAT_CATEGORY_RIGID=TRUE,
		MAT_CATEGORY_BASE_RECIPES = FALSE, // doesn't seem to work :(
		MAT_CATEGORY_ITEM_MATERIAL = TRUE,
		MAT_CATEGORY_ITEM_MATERIAL_COMPLEMENTARY = TRUE,
	)
	sheet_type = /obj/item/stack/sheet/mineral/calorite
	ore_type = /obj/item/stack/ore/calorite
	value_per_unit = 110 / SHEET_MATERIAL_AMOUNT
	tradable = TRUE
	tradable_base_quantity = MATERIAL_QUANTITY_RARE
	beauty_modifier = 0.05
	armor_modifiers = list(MELEE = 1.1, BULLET = 1.1, LASER = 1.15, ENERGY = 1.15, BOMB = 1, BIO = 1, RAD = 1, FIRE = 0.7, ACID = 1.1) // Same armor as gold.
	mineral_rarity = MATERIAL_RARITY_PRECIOUS
	points_per_unit = 40 / SHEET_MATERIAL_AMOUNT
	fish_weight_modifier = 1.5 // fishing values copied from gold
	fishing_difficulty_modifier = -8
	fishing_cast_range = 1
	fishing_experience_multiplier = 0.75
	fishing_completion_speed = 1.2
	fishing_bait_speed_mult = 1.1
	fishing_deceleration_mult = 1.2
	fishing_bounciness_mult = 0.8
	fishing_gravity_mult = 1.2

/obj/item/stack/ore/calorite //GS13
	name = "calorite ore"
	singular_name = "calorite ore chunk"
	icon = 'modular_gs/icons/obj/mining.dmi'
	icon_state = "calorite ore"
	inhand_icon_state = "calorite ore"
	singular_name = "Calorite ore chunk"
	points = 40
	// custom_materials = list(/datum/material/calorite=MINERAL_MATERIAL_AMOUNT)
	mats_per_unit = list(/datum/material/calorite = SHEET_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/calorite
	mine_experience = 20
	scan_state = "rock_Calorite"
	merge_type = /obj/item/stack/ore/calorite

/obj/item/stack/sheet/mineral/calorite
	name = "calorite"
	icon = 'modular_gs/icons/obj/stack_objects.dmi'
	icon_state = "sheet-calorite"
	inhand_icon_state = "sheet-calorite"
	singular_name = "calorite sheet"
	sheettype = "calorite"
	novariants = TRUE
	grind_results = list(/datum/reagent/consumable/lipoifier = 2)
	// point_value = 40
	// custom_materials = list(/datum/material/calorite=MINERAL_MATERIAL_AMOUNT)
	mats_per_unit = list(/datum/material/calorite = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/mineral/calorite
	material_type = /datum/material/calorite
	walltype = /turf/closed/wall/mineral/calorite

/datum/material/calorite/on_applied(atom/source, amount, multiplier) // used to be material_flags instead of multiplier
	. = ..()
	// if(!(material_flags & MATERIAL_AFFECT_STATISTICS))
	// 	return

	if (isobj(source))
		var/obj/source_obj = source
		source_obj.damtype = FAT

/datum/material/calorite/on_removed(atom/source, multiplier) // used to be material_flags instead of multiplier
	// if(!(material_flags & MATERIAL_AFFECT_STATISTICS))
	// 	return ..()

	if (isobj(source))
		var/obj/source_obj = source
		source_obj.damtype = initial(source_obj.damtype)
		return ..()


/turf/closed/mineral/calorite //GS13
	mineralType = /obj/item/stack/ore/calorite
	scan_state = "rock_Calorite"

/obj/item/stack/sheet/mineral/calorite/five
	amount = 5

/obj/item/stack/sheet/mineral/calorite/ten
	amount = 10

/obj/item/stack/sheet/mineral/calorite/fifty
	amount = 50

GLOBAL_LIST_INIT(calorite_recipes, list ( \
	new/datum/stack_recipe("calorite tile", /obj/item/stack/tile/mineral/calorite, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	/*new/datum/stack_recipe("Calorite Ingots", /obj/item/ingot/calorite, time = 30), \*/
	new/datum/stack_recipe("Fatty statue", /obj/structure/statue/calorite/fatty, 5, time = 10 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_ONE_PER_TURF),\
	/*new/datum/stack_recipe("Calorite doors", /obj/structure/mineral_door/calorite, 5, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_APPLIES_MATS, category = CAT_DOORS),\*/
	))

/obj/item/stack/sheet/mineral/calorite/get_main_recipes()
	. = ..()
	. += GLOB.calorite_recipes

/obj/item/ingot/calorite
	custom_materials = list(/datum/material/calorite=1500)
