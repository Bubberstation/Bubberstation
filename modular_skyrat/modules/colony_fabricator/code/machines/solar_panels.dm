// Solar panels

/obj/machinery/power/solar/deployable
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/solar

/obj/machinery/power/solar/deployable/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 1 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/power/solar/deployable/examine(mob/user)
	. = ..()
	. += span_notice("Its glass can be upgraded with <b>two sheets</b> of titanium, plasma, or plastitanium glass.")

/obj/machinery/power/solar/deployable/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/static/list/glass_tiers = list(
		/datum/material/glass = 1,
		/datum/material/alloy/titaniumglass = 2,
		/datum/material/alloy/plasmaglass = 3,
		/datum/material/alloy/plastitaniumglass = 4,
	)
	if(!isstack(tool))
		return NONE
	var/obj/item/stack/sheet/glass_sheets = tool
	var/new_tier = glass_tiers[glass_sheets.material_type]
	if(!new_tier)
		return NONE
	if(new_tier <= power_tier)
		balloon_alert(user, "already as good!")
		return ITEM_INTERACT_BLOCKING
	if(!glass_sheets.use(2))
		balloon_alert(user, "need two sheets!")
		return ITEM_INTERACT_BLOCKING
	drop_upgrade_glass()
	power_tier = new_tier
	material_type = glass_sheets.material_type
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	balloon_alert(user, "glass upgraded")
	update_appearance(UPDATE_OVERLAYS)
	return ITEM_INTERACT_SUCCESS

/// Hands back the two sheets of any upgraded glass on this panel
/obj/machinery/power/solar/deployable/proc/drop_upgrade_glass()
	if(power_tier <= 1)
		return
	new material_type.sheet_type(drop_location(), 2)

/obj/machinery/power/solar/deployable/crowbar_act(mob/user, obj/item/I)
	return

/obj/machinery/power/solar/deployable/on_deconstruction(disassembled)
	if(disassembled)
		drop_upgrade_glass()
	var/obj/item/solar_assembly/assembly = locate() in src
	if(assembly)
		qdel(assembly)
	return ..()

// previously NO_DECONSTRUCTION
/obj/machinery/power/solar/deployable/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/power/solar/deployable/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/power/solar/deployable/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

// Solar panel deployable item

/obj/item/flatpacked_machine/solar
	name = "flat-packed solar panel"
	icon_state = "solar_panel_packed"
	type_to_deploy = /obj/machinery/power/solar/deployable
	deploy_time = 2 SECONDS
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1,
	)

// Solar trackers

/obj/machinery/power/tracker/deployable
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/solar_tracker

/obj/machinery/power/tracker/deployable/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 1 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/power/tracker/deployable/crowbar_act(mob/user, obj/item/item_acting)
	return NONE

// previously NO_DECONSTRUCTION
/obj/machinery/power/tracker/deployable/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/power/tracker/deployable/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/power/tracker/deployable/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

/obj/machinery/power/tracker/deployable/on_deconstruction(disassembled)
	var/obj/item/solar_assembly/assembly = locate() in src
	if(assembly)
		qdel(assembly)
	return ..()

// Solar tracker deployable item

/obj/item/flatpacked_machine/solar_tracker
	name = "flat-packed solar tracker"
	icon_state = "solar_tracker_packed"
	type_to_deploy = /obj/machinery/power/tracker/deployable
	deploy_time = 3 SECONDS
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 3.5,
	)
