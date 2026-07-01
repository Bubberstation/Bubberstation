/obj/machinery/flatpacker/colony_fabricator
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	base_icon_state = "flatpacker"
	icon_state = "flatpacker"
	circuit = null
	obj_flags = parent_type::obj_flags | NO_DEBRIS_AFTER_DECONSTRUCTION
	/// The item we turn into when repacked.
	var/repacked_type = /obj/item/flatpacked_machine/flatpacker

/obj/machinery/flatpacker/colony_fabricator/Initialize(mapload)
	. = ..()
	component_parts = list()
	var/obj/item/circuitboard/machine/flatpacker/default_board = new(src)
	default_board.flatten_component_list(src)
	qdel(default_board)
	RefreshParts()
	AddElement(/datum/element/repackable, repacked_type, 5 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/flatpacker/colony_fabricator/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/flatpacker/colony_fabricator/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/flatpacker/colony_fabricator/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

/obj/item/flatpacked_machine/flatpacker
	name = "flat-packed flatpacker"
	icon_state = "flatpacker_packed"
	type_to_deploy = /obj/machinery/flatpacker/colony_fabricator
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
