/datum/material/calorite
	name = "calorite"
	sheet_type = /obj/item/stack/sheet/mineral/calorite
	color = list(340/255, 150/255, 50/255,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0)
	strength_modifier = 1.5
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	beauty_modifier = 0.05
	armor_modifiers = list(MELEE = 1.1, BULLET = 1.1, LASER = 1.15, ENERGY = 1.15, BOMB = 1, BIO = 1, RAD = 1, FIRE = 0.7, ACID = 1.1) // Same armor as gold.

/datum/material/calorite/on_applied_obj(obj/source, amount, material_flags)
	. = ..()
	if(!(material_flags & MATERIAL_AFFECT_STATISTICS))
		return

	var/obj/source_obj = source
	source_obj.damtype = FAT

/datum/material/calorite/on_removed_obj(obj/source, material_flags)
	if(!(material_flags & MATERIAL_AFFECT_STATISTICS))
		return ..()

	var/obj/source_obj = source
	source_obj.damtype = initial(source_obj.damtype)
	return ..()


/turf/closed/mineral/calorite //GS13
	mineralType = /obj/item/stack/ore/calorite
	scan_state = "rock_Calorite"

/obj/item/stack/ore/calorite //GS13
	name = "calorite ore"
	icon = 'GainStation13/icons/obj/mining.dmi'
	icon_state = "calorite ore"
	item_state = "calorite ore"
	singular_name = "Calorite ore chunk"
	points = 40
	custom_materials = list(/datum/material/calorite=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/calorite
	mine_experience = 20

/obj/item/stack/sheet/mineral/calorite
	name = "calorite"
	icon = 'GainStation13/icons/obj/stack_objects.dmi'
	icon_state = "sheet-calorite"
	item_state = "sheet-calorite"
	singular_name = "calorite sheet"
	sheettype = "calorite"
	novariants = TRUE
	grind_results = list(/datum/reagent/consumable/lipoifier = 2)
	point_value = 40
	custom_materials = list(/datum/material/calorite=MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/mineral/calorite
	material_type = /datum/material/calorite
	walltype = /turf/closed/wall/mineral/calorite

GLOBAL_LIST_INIT(calorite_recipes, list ( \
	new/datum/stack_recipe("Calorite tile", /obj/item/stack/tile/mineral/calorite, 1, 4, 20), \
	new/datum/stack_recipe("Calorite Ingots", /obj/item/ingot/calorite, time = 30), \
	new/datum/stack_recipe("Fatty statue", /obj/structure/statue/calorite/fatty, 5, one_per_turf = 1, on_floor = 1),\
	new/datum/stack_recipe("Calorite doors", /obj/structure/mineral_door/calorite, 5, one_per_turf = 1, on_floor = 1),\
	))

/obj/item/stack/sheet/mineral/calorite/get_main_recipes()
	. = ..()
	. += GLOB.calorite_recipes


/obj/item/stack/tile/mineral/calorite  //GS13
	name = "Calorite tile"
	singular_name = "Calorite floor tile"
	desc = "A tile made out of calorite. Bwoomph."
	icon = 'GainStation13/icons/obj/tiles.dmi'
	icon_state = "tile_calorite"
	turf_type = /turf/open/floor/mineral/calorite
	mineralType = "calorite"

/obj/item/stack/tile/mineral/calorite/hide  //GS13 - disguised variant
	name = "Floor tile"
	singular_name = "calorite floor tile"
	desc = "A tile totally made out of steel."
	icon_state = "tile"
	turf_type = /turf/open/floor/mineral/calorite/hide

/obj/item/stack/tile/mineral/calorite/strong  //GS13 - strong variant
	name = "Infused calorite tile"
	singular_name = "Infused calorite floor tile"
	desc = "A tile made out of stronger variant of calorite. Bwuurp."
	icon_state = "tile_calorite_strong"
	turf_type = /turf/open/floor/mineral/calorite/strong

/obj/item/stack/tile/mineral/calorite/dance  //GS13 - glamourous variant!
	name = "Calorite dance floor"
	singular_name = "Calorite dance floor tile"
	desc = "A dance floor made out of calorite, for a party both you and your waistline will never forget!."
	icon_state = "tile_calorite_dance"
	turf_type = /turf/open/floor/mineral/calorite/dance


/turf/open/floor/mineral/calorite
	name = "Calorite floor"
	icon = 'GainStation13/icons/turf/floors.dmi'
	icon_state = "calorite"
	floor_tile = /obj/item/stack/tile/mineral/calorite
	icons = list("calorite","calorite_dam")
	var/last_event = 0
	var/active = null
	///How much fatness is added to the user upon crossing?
	var/fat_to_add = 25

/turf/open/floor/mineral/calorite/Entered(mob/living/carbon/M)
	if(!istype(M, /mob/living/carbon))
		return FALSE
	else
		M.adjust_fatness(fat_to_add, FATTENING_TYPE_ITEM)

// calorite floor, disguised version - GS13

/turf/open/floor/mineral/calorite/hide
	name = "Steel floor"
	icon_state = "calorite_hide"
	floor_tile = /obj/item/stack/tile/mineral/calorite/hide
	icons = list("calorite_hide","calorite_dam")

// calorite floor, powerful version - GS13

/turf/open/floor/mineral/calorite/strong
	name = "Infused calorite floor"
	icon_state = "calorite_strong"
	floor_tile = /obj/item/stack/tile/mineral/calorite/strong
	icons = list("calorite_strong","calorite_dam")
	fat_to_add = 100

// calorite dance floor, groovy! - GS13

/turf/open/floor/mineral/calorite/dance
	name = "Calorite dance floor"
	icon_state = "calorite_dance"
	floor_tile = /obj/item/stack/tile/mineral/calorite/dance
	icons = list("calorite_dance","calorite_dam")


/obj/structure/statue/calorite
	icon = 'GainStation13/icons/obj/statue.dmi'
	max_integrity = 400
	custom_materials = list(/datum/material/calorite=MINERAL_MATERIAL_AMOUNT*5)

/obj/structure/statue/calorite/fatty
	name = "Fatty statue"
	desc = "A statue of a well-rounded fatso."
	icon_state = "fatty"
	var/active = null
	var/last_event = 0

/obj/structure/statue/calorite/fatty/proc/beckon()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			for(var/mob/living/carbon/human/M in orange(3,src))
				to_chat(M, "<span class='warning'>You feel the statue calling to you, urging you to touch it...</span>")
			last_event = world.time
			active = null
			return
	return

/obj/structure/statue/calorite/fatty/proc/statue_fatten(mob/living/carbon/M)
	if(!M.adjust_fatness(20, FATTENING_TYPE_ITEM))
		to_chat(M, "<span class='warning'>Nothing happens.</span>")
		return

	if(M.fatness < FATNESS_LEVEL_FATTER)
		to_chat(M, "<span class='warning'>The moment your hand meets the statue, you feel a little warmer...</span>")
	else if(M.fatness < FATNESS_LEVEL_OBESE)
		to_chat(M, "<span class='warning'>Upon each poke of the statue, you feel yourself get a little heavier.</span>")
	else if(M.fatness < FATNESS_LEVEL_EXTREMELY_OBESE)
		to_chat(M, "<span class='warning'>With each touch you keep getting fatter... But the fatter you grow, the more enticed you feel to poke the statue.</span>")
	else if(M.fatness < FATNESS_LEVEL_BARELYMOBILE)
		to_chat(M, "<span class='warning'>The world around you blur slightly as you focus on prodding the statue, your waistline widening further...</span>")
	else if(M.fatness < FATNESS_LEVEL_IMMOBILE)
		to_chat(M, "<span class='warning'>A whispering voice gently compliments your massive body, your own mind begging to touch the statue.</span>")
	else
		to_chat(M, "<span class='warning'>You can barely reach the statue past your floor-covering stomach! And yet, it still calls to you...</span>")

/obj/structure/statue/calorite/fatty/Bumped(atom/movable/AM)
	beckon()
	..()

/obj/structure/statue/calorite/fatty/Crossed(var/mob/AM)
	.=..()
	if(!.)
		if(istype(AM))
			beckon()

/obj/structure/statue/calorite/fatty/Moved(atom/movable/AM)
	beckon()
	..()

/obj/structure/statue/calorite/fatty/attackby(obj/item/W, mob/living/carbon/M, params)
	statue_fatten(M)

/obj/structure/statue/calorite/fatty/attack_hand(mob/living/carbon/M)
	statue_fatten(M)

/obj/structure/statue/calorite/fatty/attack_paw(mob/living/carbon/M)
	statue_fatten(M)


/turf/closed/wall/mineral/calorite //GS13
	name = "calorite wall"
	desc = "A wall with calorite plating. Burp."
	icon = 'GainStation13/icons/turf/calorite_wall.dmi'
	icon_state = "calorite"
	sheet_type = /obj/item/stack/sheet/mineral/calorite
	canSmoothWith = list(/turf/closed/wall/mineral/calorite, /obj/structure/falsewall/calorite)

/turf/closed/wall/mineral/calorite/proc/fatten()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			for(var/mob/living/carbon/human/M in orange(3,src))
				M.adjust_fatness(30, FATTENING_TYPE_ITEM)
			last_event = world.time
			active = null
			return
	return

/turf/closed/wall/mineral/calorite/Bumped(atom/movable/AM)
	fatten()
	..()

/turf/closed/wall/mineral/calorite/attackby(obj/item/W, mob/user, params)
	fatten()
	return ..()

/turf/closed/wall/mineral/calorite/attack_hand(mob/user)
	fatten()
	. = ..()

/obj/structure/falsewall/calorite            //GS13
	name = "calorite wall"
	desc = "A wall with calorite plating. Burp."
	icon = 'GainStation13/icons/turf/calorite_wall.dmi'
	icon_state = "calorite"
	mineral = /obj/item/stack/sheet/mineral/calorite
	walltype = /turf/closed/wall/mineral/calorite
	canSmoothWith = list(/obj/structure/falsewall/calorite, /turf/closed/wall/mineral/calorite)
	var/active = null
	var/last_event = 0

/obj/structure/falsewall/calorite/proc/fatten()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			for(var/mob/living/carbon/human/M in orange(3,src))
				M.adjust_fatness(30, FATTENING_TYPE_ITEM)
			last_event = world.time
			active = null
			return
	return

/obj/structure/falsewall/calorite/Bumped(atom/movable/AM)
	fatten()
	..()

/obj/structure/falsewall/calorite/attackby(obj/item/W, mob/user, params)
	fatten()
	return ..()

/obj/structure/falsewall/calorite/attack_hand(mob/user)
	fatten()
	. = ..()

/obj/item/ingot/calorite
	custom_materials = list(/datum/material/calorite=1500)
