/// How much harder printing hits the internal cell than it would the grid
#define RCF_CELL_ENERGY_MULTIPLIER 10

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
	/// Runs the fabricator where there is no powered area
	var/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell/high
	/// Designs we can only print once the station has researched them
	var/static/list/station_research_designs = list(
		"minerbag_holding",
	)
	/// The station's research, which decides when the designs above unlock
	var/datum/techweb/station_research
	/// How much we pull off the grid each tick to top the cell back up
	var/cell_charge_rate = STANDARD_CELL_RATE * 0.2

/obj/machinery/rnd/production/colony_lathe/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 5 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	// We don't get new designs but can't print stuff if something's not researched, so we use the web that has everything researched
	stored_research = locate(/datum/techweb/admin) in SSresearch.techwebs
	station_research = locate(/datum/techweb/science) in SSresearch.techwebs
	if(station_research)
		RegisterSignals(station_research, list(COMSIG_TECHWEB_ADD_DESIGN, COMSIG_TECHWEB_REMOVE_DESIGN), TYPE_PROC_REF(/obj/machinery/rnd/production, on_techweb_update))
	soundloop = new(src, FALSE)
	QDEL_NULL(wires)
	set_wires(new /datum/wires/rnd/colony_lathe(src))
	if(ispath(cell))
		cell = new cell(src)
	START_PROCESSING(SSmachines, src)
	if(!mapload)
		flick("colony_lathe_deploy", src) // Sick ass deployment animation

/obj/machinery/rnd/production/colony_lathe/Destroy()
	QDEL_NULL(soundloop)
	QDEL_NULL(cell)
	station_research = null
	return ..()

// The screwdriver only opens the panel, since this machine repacks instead of deconstructing
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
	if(panel_open && istype(tool, /obj/item/stock_parts/power_store/cell))
		if(!isnull(cell))
			balloon_alert(user, "already has a cell!")
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		cell = tool
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		balloon_alert(user, "cell installed")
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/machinery/rnd/production/colony_lathe/update_icon_state()
	. = ..()
	if(panel_open && !busy)
		icon_state = "[base_icon_state]_t"

/obj/machinery/rnd/production/colony_lathe/examine(mob/user)
	. = ..()
	. += span_notice("It runs off station power where it can, and off its own cell where it cannot.")
	if(isnull(cell))
		. += span_warning("Its cell housing is <b>empty</b>.")
	else
		. += span_notice("Its [cell.name] is charged to <b>[round(cell.percent())]%</b>.")
	. += span_notice("Its maintenance panel can be [EXAMINE_HINT("screwed")] [panel_open ? "closed" : "open"].")
	if(!panel_open)
		return
	. += span_notice("The wires inside can be worked with a [EXAMINE_HINT("multitool")] or [EXAMINE_HINT("wirecutters")].")
	. += span_notice("The cell can be levered out with a [EXAMINE_HINT("crowbar")].")

/// Rebuilds the design list when the hack wire changes
/obj/machinery/rnd/production/colony_lathe/proc/refresh_hacked_designs()
	if(hacked == designs_follow_hack)
		return
	update_designs()
	update_static_data_for_all_viewers()

/obj/machinery/rnd/production/colony_lathe/on_deconstruction(disassembled)
	if(isnull(cell))
		return ..()
	// a repack spawns the flatpack on our tile this tick, before taking us apart, so our cell goes back in it
	var/obj/item/flatpacked_machine/packed
	for(var/obj/item/flatpacked_machine/flatpack in drop_location())
		if(flatpack.created_at == world.time && ispath(flatpack.type_to_deploy, type))
			packed = flatpack
	if(disassembled && !isnull(packed))
		QDEL_NULL(packed.cell)
		packed.cell = cell
		cell.forceMove(packed)
	else
		cell.forceMove(drop_location())
	cell = null
	return ..()

// with a cell aboard we can work in an unpowered area
/obj/machinery/rnd/production/colony_lathe/powered(chan = power_channel, ignore_use_power = FALSE)
	if(!isnull(cell) && cell.charge() > 0)
		return TRUE
	return ..()

/obj/machinery/rnd/production/colony_lathe/directly_use_energy(amount, force = FALSE)
	. = ..()
	if(. || isnull(cell))
		return .
	// printing off the cell costs far more than printing off the grid
	return cell.use(amount * RCF_CELL_ENERGY_MULTIPLIER, force = force)

/obj/machinery/rnd/production/colony_lathe/process(seconds_per_tick)
	if(isnull(cell) || !cell.used_charge())
		return
	var/charge_given = charge_cell(cell_charge_rate * seconds_per_tick, cell)
	if(charge_given)
		update_appearance()

/obj/machinery/rnd/production/colony_lathe/crowbar_act(mob/living/user, obj/item/tool)
	if(!panel_open)
		return NONE
	if(isnull(cell))
		balloon_alert(user, "no cell!")
		return ITEM_INTERACT_BLOCKING
	tool.play_tool_sound(src, 50)
	user.put_in_hands(cell)
	balloon_alert(user, "cell removed")
	cell = null
	return ITEM_INTERACT_SUCCESS

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

	// contraband designs are autolathe designs, so we borrow those systems for one print
	var/datum/design/design = SSresearch.techweb_design_by_id(params["ref"])
	if(istype(design) && !station_has_researched(design.id))
		say("This design has not been researched by the station yet.")
		return FALSE
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
	techweb_updating = FALSE
	var/previous_design_count = cached_designs.len

	cached_designs.Cut()

	designs_follow_hack = hacked

	for(var/design_id in SSresearch.techweb_designs)
		var/datum/design/design = SSresearch.techweb_designs[design_id]

		if(!station_has_researched(design_id))
			continue

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

/// Designs in station_research_designs wait for the station to research them
/obj/machinery/rnd/production/colony_lathe/proc/station_has_researched(design_id)
	if(!(design_id in station_research_designs))
		return TRUE
	return !isnull(station_research) && station_research.researched_designs[design_id]

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
	/// Cell packed inside, for machines that run on one
	var/obj/item/stock_parts/power_store/cell
	/// When this flatpack was made, so a repacking machine can find the box it just went into
	var/created_at

/obj/item/flatpacked_machine/Initialize(mapload)
	. = ..()
	desc = initial(type_to_deploy.desc)
	give_deployable_component()
	give_manufacturer_examine()
	created_at = world.time
	if(ispath(type_to_deploy, /obj/machinery/rnd/production/colony_lathe))
		cell = new /obj/item/stock_parts/power_store/cell/high(src)
	RegisterSignal(src, COMSIG_DEPLOYABLE_DEPLOYED, PROC_REF(on_deployed))

/obj/item/flatpacked_machine/Destroy()
	QDEL_NULL(cell)
	return ..()

/obj/item/flatpacked_machine/examine(mob/user)
	. = ..()
	if(!ispath(type_to_deploy, /obj/machinery/rnd/production/colony_lathe))
		return
	if(isnull(cell))
		. += span_warning("Its cell housing is <b>empty</b>.")
		return
	. += span_notice("It is packed with a [cell.name] at <b>[round(cell.percent())]%</b>, which can be swapped by <b>clicking</b> it with another cell.")

/obj/item/flatpacked_machine/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/cell) || !ispath(type_to_deploy, /obj/machinery/rnd/production/colony_lathe))
		return ..()
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	if(isnull(cell))
		balloon_alert(user, "cell installed")
	else
		user.put_in_hands(cell)
		balloon_alert(user, "cell swapped")
	cell = tool
	return ITEM_INTERACT_SUCCESS

/// Hands our packed cell to the machine we just unpacked into
/obj/item/flatpacked_machine/proc/on_deployed(datum/source, obj/machinery/rnd/production/colony_lathe/fabricator)
	SIGNAL_HANDLER

	if(!istype(fabricator) || isnull(cell))
		return
	QDEL_NULL(fabricator.cell)
	fabricator.cell = cell
	cell.forceMove(fabricator)
	cell = null

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

// The R&D wires already carry a hack wire, we only need to hear about it

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

#undef RCF_CELL_ENERGY_MULTIPLIER
