/obj/structure/reagent_dispensers/smithing_trough
	name = "smithing trough"
	desc = "A basin meant to quench heated smithing equipment and cool it."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "water_basin"
	anchored = TRUE
	density = TRUE
	can_be_tanked = FALSE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)
	reagent_id = null
	//deliberate choice -- matches the volume of a bluespace beaker
	tank_volume = 300

	/// Tracks if you can fish from this basin
	var/datum/component/fishing_spot/fishable

/obj/structure/reagent_dispensers/smithing_trough/prefilled
	reagent_id = /datum/reagent/fuel/oil/smithing

/obj/structure/reagent_dispenser/smithing_trough/Initialize()
	. = ..()
	check_fishable()

/obj/structure/reagent_dispenser/smithing_trough/check_fishable()
	if(isnull(fishable) && reagents.total_volume >= tank_volume)
		fishable = AddComponent(/datum/component/fishing_spot, /datum/fish_source/water_basin)
	else if(!isnull(fishable) && reagents.total_volume < tank_volume)
		RemoveComponentSource(src, /datum/component/fishing_spot)


/obj/structure/reagent_water_basin/Destroy()
	QDEL_NULL(fishable)
	return ..()

/obj/structure/reagent_dispensers/smithing_trough/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING))
		. += span_notice("Dipping smithed items in this trough will imbue it with its chemicals!")
	else
		. += span_notice("You could use this for imbuing reagents into equipment if you knew the right trick...")

/obj/structure/reagent_dispensers/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/forging/incomplete))
		var/obj/item/forging/incomplete/incomplete_item = attacking_item
		if(can_quench(user, incomplete_item))
			var/obj/item/quenched_item = do_quench(user, incomplete)
			if(can_imbue(user, incomplete_item, FALSE))

			return ITEM_INTERACT_SUCCESS

	return ..()

/obj/structure/reagent_dispensers/tong_act(mob/living/user, obj/item/tool)
	var/obj/item/tongs_contents = locate(/obj/item) in tool.contents
	if(!tongs_contents)
		to_chat(user, span_notice("No item to dip!"))
		return ITEM_INTERACT_BLOCKING
	else
		. = attackby(tongs_contents, user)
		if(tool.contents.len == 0)
			tool.icon_state = "tong_empty"

/// Fishing source for fishing out of basins that have been upgraded, contains saltwater fish (lizard fish fall under this too!)
/datum/fish_source/water_basin
	catalog_description = "Filled Blacksmithing Quenching Troughs"
	fish_table = list(
		/obj/item/fish/clownfish = 15,
		/obj/item/fish/pufferfish = 10,
		/obj/item/fish/cardinal = 15,
		/obj/item/fish/greenchromis = 15,
		/obj/item/fish/lanternfish = 5,
		/obj/item/fish/moonfish/dwarf = 15,
		/obj/item/fish/gunner_jellyfish = 15,
		/obj/item/fish/needlefish = 10,
		/obj/item/fish/armorfish = 10,
		/obj/item/fish/swordfish = 10,
		/obj/effect/spawner/random/maintenance = 10,
		/obj/effect/spawner/random/trash/garbage = 15,
	)
