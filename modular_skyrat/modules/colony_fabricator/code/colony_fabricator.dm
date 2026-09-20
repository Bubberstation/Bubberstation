/obj/machinery/rnd/production/colony_lathe
	name = "rapid construction fabricator"
	desc = "These bad boys are seen just about anywhere someone would want or need to build fast, damn the consequences. \
		That tends to be colonies, especially on dangerous worlds, where the influences of this one machine can be seen \
		in every bit of architecture."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	icon_state = "colony_lathe"
	base_icon_state = "colony_lathe"
	circuit = null
	production_animation = "colony_lathe_working"
	light_color = LIGHT_COLOR_BRIGHT_YELLOW
	light_power = 5
	allowed_buildtypes = COLONY_FABRICATOR
	speedup_disabled = TRUE
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine
	/// The sound loop played while the fabricator is making something
	var/datum/looping_sound/colony_fabricator_running/soundloop
	/// What the hack wire was set to when we last built our design list
	var/designs_follow_hack = FALSE

/obj/machinery/rnd/production/colony_lathe/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 5 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	// We don't get new designs but can't print stuff if something's not researched, so we use the web that has everything researched
	stored_research = locate(/datum/techweb/admin) in SSresearch.techwebs
	soundloop = new(src, FALSE)
	// swap the generic R&D wires for ours so we hear about the hack wire
	QDEL_NULL(wires)
	set_wires(new /datum/wires/rnd/colony_lathe(src))
	if(!mapload)
		flick("colony_lathe_deploy", src) // Sick ass deployment animation

/obj/machinery/rnd/production/colony_lathe/Destroy()
	QDEL_NULL(soundloop)
	return ..()

// The screwdriver only opens the maintenance panel, since this machine repacks instead of deconstructing
/obj/machinery/rnd/production/colony_lathe/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/rnd/production/colony_lathe/screwdriver_act(mob/living/user, obj/item/tool)
	if(busy)
		balloon_alert(user, "busy printing!")
		return ITEM_INTERACT_BLOCKING
	tool.play_tool_sound(src, 50)
	panel_open = !panel_open
	balloon_alert(user, "panel [panel_open ? "opened" : "closed"]")
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/rnd/production/colony_lathe/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(panel_open && is_wire_tool(tool))
		wires.interact(user)
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/machinery/rnd/production/colony_lathe/update_icon_state()
	. = ..()
	if(panel_open && !busy)
		icon_state = "[base_icon_state]_t"

/obj/machinery/rnd/production/colony_lathe/examine(mob/user)
	. = ..()
	. += span_notice("Its maintenance panel can be [EXAMINE_HINT("screwed")] [panel_open ? "closed" : "open"].")
	if(panel_open)
		. += span_notice("The wires inside can be worked with a [EXAMINE_HINT("multitool")] or [EXAMINE_HINT("wirecutters")].")

/// Called by our wires when the hack wire changes, since the design list has to be rebuilt
/obj/machinery/rnd/production/colony_lathe/proc/refresh_hacked_designs()
	if(hacked == designs_follow_hack)
		return
	update_designs()
	update_static_data_for_all_viewers()

/obj/machinery/rnd/production/colony_lathe/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/rnd/production/colony_lathe/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

/obj/machinery/rnd/production/colony_lathe/ui_act(action, list/params, datum/tgui/ui)
	if(action != "build")
		return ..()

	if(disabled)
		say("Fabrication systems are offline.")
		return FALSE

	// contraband designs are autolathe designs, so we lend ourselves the autolathe's systems for one print
	var/datum/design/design = SSresearch.techweb_design_by_id(params["ref"])
	var/borrowing_autolathe_systems = istype(design) && !(design.build_type & allowed_buildtypes)
	if(borrowing_autolathe_systems)
		if(!hacked || !(design in cached_designs))
			say("This fabricator does not have the necessary keys to decrypt this design.")
			return FALSE
		allowed_buildtypes |= AUTOLATHE

	. = ..()

	if(borrowing_autolathe_systems)
		allowed_buildtypes = initial(allowed_buildtypes)

	if(.)
		soundloop.start()
		set_light(l_range = 1.5)
		update_appearance()

/obj/machinery/rnd/production/colony_lathe/finalize_build()
	. = ..()
	soundloop.stop()
	set_light(l_range = 0)
	update_appearance()
	flick("colony_lathe_finish_print", src)

// We take from all nodes even unresearched ones
/obj/machinery/rnd/production/colony_lathe/update_designs()
	var/previous_design_count = cached_designs.len

	cached_designs.Cut()

	designs_follow_hack = hacked

	for(var/design_id in SSresearch.techweb_designs)
		var/datum/design/design = SSresearch.techweb_designs[design_id]

		if((isnull(allowed_department_flags) || (design.departmental_flags & allowed_department_flags)) && (design.build_type & allowed_buildtypes))
			cached_designs |= design
			continue

		// contraband only shows up once somebody has found the hack wire
		if(hacked && (RND_CATEGORY_HACKED in design.category) && (design.build_type & AUTOLATHE))
			cached_designs |= design

	var/design_delta = cached_designs.len - previous_design_count

	if(design_delta > 0)
		say("Received [design_delta] new design[design_delta == 1 ? "" : "s"].")
		playsound(src, 'sound/machines/beep/twobeep_high.ogg', 50, TRUE)

	update_static_data_for_all_viewers()

// Item for carrying the lathe around and building it

/obj/item/flatpacked_machine
	name = "flat-packed rapid construction fabricator"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/packed_machines.dmi'
	icon_state = "colony_lathe_packed"
	w_class = WEIGHT_CLASS_BULKY
	/// What structure is created by this item.
	var/obj/type_to_deploy = /obj/machinery/rnd/production/colony_lathe
	/// How long it takes to create the structure in question.
	var/deploy_time = 4 SECONDS

/obj/item/flatpacked_machine/Initialize(mapload)
	. = ..()
	desc = initial(type_to_deploy.desc)
	give_deployable_component()
	give_manufacturer_examine()

/// Adds the deployable component, so that it can be overridden in case that's wanted
/obj/item/flatpacked_machine/proc/give_deployable_component()
	AddComponent(/datum/component/deployable, deploy_time, type_to_deploy)

/// Adds the manufacturer examine element to the flatpack machine, but can be overridden in the future
/obj/item/flatpacked_machine/proc/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/item/borg/apparatus/sheet_manipulator/Initialize(mapload)
	. = ..()
	storable += /obj/item/flatpacked_machine

/obj/item/borg/apparatus/circuit/Initialize(mapload)
	. = ..()
	storable += /obj/item/flatpacked_machine

// The R&D wires already carry a hack wire, we just have to hear about it to rebuild our design list

/datum/wires/rnd/colony_lathe
	holder_type = /obj/machinery/rnd/production/colony_lathe
	proper_name = "Rapid Construction Fabricator"

/datum/wires/rnd/colony_lathe/on_pulse(wire)
	. = ..()
	var/obj/machinery/rnd/production/colony_lathe/fabricator = holder
	fabricator.refresh_hacked_designs()

/datum/wires/rnd/colony_lathe/on_cut(wire, mend, source)
	. = ..()
	var/obj/machinery/rnd/production/colony_lathe/fabricator = holder
	fabricator.refresh_hacked_designs()
