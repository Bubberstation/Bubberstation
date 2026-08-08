/obj/structure/reagent_dispensers/reagent_smithing_basin
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

/obj/structure/reagent_dispensers/reagent_smithing_basin/prefilled
	reagent_id = /datum/reagent/fuel/oil/smithing

/obj/structure/reagent_dispensers/reagent_smithing_basin/update_overlays()
	. = ..()
	if(reagents.total_volume >= tank_volume)
		var/mutable_appearance/filling = mutable_appearance(icon, "water_basin_reagent_overlay")
		filling.color = mix_color_from_reagents(reagents.reagent_list)
		. += filling
		return

/obj/structure/reagent_dispensers/reagent_smithing_basin/Initialize(mapload)
	. = ..()
	if(!mapload)
		anchored = FALSE
	reagents.flags = reagents.flags | REFILLABLE | DUNKABLE
	check_fishable()
	START_PROCESSING(SSdcs, src)
	update_appearance()

/obj/structure/reagent_dispensers/reagent_smithing_basin/proc/check_fishable()
	if(isnull(fishable) && reagents.total_volume >= tank_volume)
		fishable = AddComponent(/datum/component/fishing_spot, /datum/fish_source/water_basin)
	else if(!isnull(fishable) && reagents.total_volume < tank_volume)
		RemoveComponentSource(src, /datum/component/fishing_spot)

/obj/structure/reagent_dispensers/reagent_smithing_basin/Destroy()
	QDEL_NULL(fishable)
	return ..()

/obj/structure/reagent_dispensers/reagent_smithing_basin/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING))
		. += span_notice("Dipping smithed items in this trough will imbue it with its chemicals!")
	else
		. += span_notice("You could use this for imbuing reagents into equipment if you knew the right trick...")
	. += span_notice("You could secure or unsecure it with a wrench.")
	. += span_notice("You could pry it apart with a crowbar.")

//heat from the contained reagents need to go into the atmosphere over time
/obj/structure/reagent_dispensers/reagent_smithing_basin/process(seconds_per_tick)
	var/datum/gas_mixture/current_air = return_air()
	if(reagents.total_volume < 1 || reagents.chem_temp == current_air.temperature)
		return PROCESS_KILL
	var/temp_difference = reagents.chem_temp - current_air.temperature
	current_air.temperature += temp_difference * seconds_per_tick * SMITHING_BASIN_HEATLOSS_COEFFICIENT
	reagents.chem_temp -= temp_difference * seconds_per_tick * SMITHING_BASIN_HEATLOSS_COEFFICIENT
	return

/obj/structure/reagent_dispensers/attackby(obj/item/attacking_item, mob/living/user, params)
	START_PROCESSING(SSdcs, src)
	var/datum/component/forge_smithable/smith_component = attacking_item.GetComponent(/datum/component/forge_smithable/)
	if(!isnull(smith_component))
		smith_component.try_quench(reagents, src, user)
		return ITEM_INTERACT_SUCCESS

	return ..()

/obj/structure/reagent_dispensers/reagent_smithing_basin/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	set_anchored(!anchored)
	balloon_alert_to_viewers(anchored ? "secured" : "unsecured")
	return TRUE

/obj/structure/reagent_dispensers/reagent_smithing_basin/crowbar_act(mob/living/user, obj/item/tool)
	if(DOING_INTERACTION(user, DOAFTER_SMITHING_WATER_BASIN))
		return

	tool.play_tool_sound(src)

	if (reagents.total_volume < 75)
		to_chat(user, span_notice("You begin to pry apart \the [src]..."))
	else
		to_chat(user, span_warning("As you begin prying apart \the [src] you notice that it's full of fluid... maybe you should reconsider?"))

	if(!do_after(user, 5 SECONDS, src, interaction_key = DOAFTER_SMITHING_WATER_BASIN))
		return FALSE

	//spill contents, then deconstruct
	if(reagents.total_volume > 0)
		knock_down()
	deconstruct(TRUE)
	return TRUE

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
