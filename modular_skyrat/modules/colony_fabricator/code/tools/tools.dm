/// Default colony tool colours
#define COLONY_TOOL_COLORS "#D15B1B#7C8287"
/// The same, plus a green screen
#define COLONY_MULTITOOL_COLORS (COLONY_TOOL_COLORS + "#3EBE68")

/datum/greyscale_config/colony_tools
	name = "Colony Tools"
	icon_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_greyscale.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/colony_tools/colony_tools.json'

/datum/greyscale_config/colony_tools/inhand_left
	name = "Colony Tools (Left Hand)"
	icon_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_inhand_greyscale_left.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/colony_tools/colony_tools_inhand_left.json'

/datum/greyscale_config/colony_tools/inhand_right
	name = "Colony Tools (Right Hand)"
	icon_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_inhand_greyscale_right.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/colony_tools/colony_tools_inhand_right.json'

// The multitool gets a third colour for its screen
/datum/greyscale_config/colony_multitool
	name = "Colony Multitool"
	icon_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_greyscale.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/colony_tools/colony_multitool.json'

/datum/greyscale_config/colony_multitool/inhand_left
	name = "Colony Multitool (Left Hand)"
	icon_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_inhand_greyscale_left.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/colony_tools/colony_multitool_inhand_left.json'

/datum/greyscale_config/colony_multitool/inhand_right
	name = "Colony Multitool (Right Hand)"
	icon_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_inhand_greyscale_right.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/colony_tools/colony_multitool_inhand_right.json'

// Like the power drill, except no speed buff but has wirecutters as well? Just trust me on this one.

/obj/item/screwdriver/omni_drill
	name = "powered driver"
	desc = "The ultimate in multi purpose construction tools. With heads for wire cutting, bolt driving, and driving \
		screws, what's not to love? Well, the slow speed. Compared to other power drills these tend to be \
		<b>slower than even unpowered tools</b>."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "drill"
	post_init_icon_state = null
	inside_belt_icon_state = null
	worn_icon_state = "drill"
	inhand_icon_state = "colony_drill"
	lefthand_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_righthand.dmi'
	greyscale_config_inhand_left = /datum/greyscale_config/colony_tools/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/colony_tools/inhand_right
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	force = 10
	throwforce = 8
	throw_speed = 2
	throw_range = 3
	attack_verb_continuous = list("drills", "screws", "jabs", "whacks")
	attack_verb_simple = list("drill", "screw", "jab", "whack")
	hitsound = 'sound/items/tools/drill_hit.ogg'
	usesound = 'sound/items/tools/drill_use.ogg'
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 1.25
	power_use_amount = POWER_CELL_USE_LOW
	random_color = FALSE
	greyscale_config = /datum/greyscale_config/colony_tools
	greyscale_config_belt = null
	greyscale_colors = COLONY_TOOL_COLORS
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	/// Used on Initialize, how much time to cut cable restraints and zipties.
	var/snap_time_weak_handcuffs = 0 SECONDS
	/// Used on Initialize, how much time to cut real handcuffs. Null means it can't.
	var/snap_time_strong_handcuffs = null

/obj/item/screwdriver/omni_drill/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cell, /obj/item/stock_parts/power_store/cell/high, _has_cell_overlays = FALSE)
	AddElement(/datum/element/cell_overlay, "drill_cell")
	AddElement(/datum/element/gags_recolorable)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/item/screwdriver/omni_drill/update_greyscale()
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/item/screwdriver/omni_drill/get_all_tool_behaviours()
	return list(TOOL_WIRECUTTER, TOOL_SCREWDRIVER, TOOL_WRENCH)

/obj/item/screwdriver/omni_drill/examine(mob/user)
	. = ..()
	. += span_notice("Use <b>in hand</b> to switch configuration.\n")
	. += span_notice("It functions as a <b>[tool_behaviour]</b> tool.")

/obj/item/screwdriver/omni_drill/update_icon_state()
	. = ..()
	switch(tool_behaviour)
		if(TOOL_SCREWDRIVER)
			icon_state = initial(icon_state)
		if(TOOL_WRENCH)
			icon_state = "[initial(icon_state)]_bolt"
		if(TOOL_WIRECUTTER)
			icon_state = "[initial(icon_state)]_cut"

/obj/item/screwdriver/omni_drill/attack_self(mob/user, modifiers)
	. = ..()
	if(!user)
		return
	var/list/tool_list = list(
		"Screwdriver" = image(icon = icon, icon_state = "drill"),
		"Wrench" = image(icon = icon, icon_state = "drill_bolt"),
		"Wirecutters" = image(icon = icon, icon_state = "drill_cut"),
	)
	var/tool_result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
	if(!check_menu(user) || !tool_result)
		return
	RemoveElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
	switch(tool_result)
		if("Wrench")
			tool_behaviour = TOOL_WRENCH
			sharpness = NONE
		if("Wirecutters")
			tool_behaviour = TOOL_WIRECUTTER
			sharpness = NONE
			AddElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
		if("Screwdriver")
			tool_behaviour = TOOL_SCREWDRIVER
			sharpness = SHARP_POINTY
	playsound(src, 'sound/items/tools/change_drill.ogg', 50, vary = TRUE)
	update_appearance(UPDATE_ICON)

/obj/item/screwdriver/omni_drill/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/screwdriver/omni_drill/tool_use_check(mob/living/user, amount, heat_required)
	if(!(item_use_power(power_use_amount, user, TRUE) & COMPONENT_POWER_SUCCESS))
		balloon_alert(user, "no charge!")
		return FALSE
	return ..()

/obj/item/screwdriver/omni_drill/use_tool(atom/target, mob/living/user, delay, amount = 0, volume = 0, datum/callback/extra_checks)
	. = ..()
	if(.)
		item_use_power(power_use_amount, user)

// Slow two-handed prybar

/obj/item/crowbar/large/colony_prybar
	name = "prybar"
	desc = "A large, sturdy crowbar, painted orange. Swings hard enough to keep you a free man."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "prybar"
	inhand_icon_state = "colony_prybar"
	lefthand_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_righthand.dmi'
	greyscale_config_inhand_left = /datum/greyscale_config/colony_tools/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/colony_tools/inhand_right
	greyscale_config = /datum/greyscale_config/colony_tools
	greyscale_colors = COLONY_TOOL_COLORS
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	toolspeed = 1.3
	force = 12
	throwforce = 12
	attack_verb_continuous = list("attacks", "bashes", "batters", "bludgeons", "smashes", "whacks")
	attack_verb_simple = list("attack", "bash", "batter", "bludgeon", "smash", "whack")
	hitsound = SFX_SWING_HIT
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/crowbar/large/colony_prybar/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = 18)
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

/obj/item/crowbar/large/colony_prybar/proc/on_wield(obj/item/source, mob/living/carbon/user)
	SIGNAL_HANDLER
	inhand_icon_state = "colony_prybar_wielded"

/obj/item/crowbar/large/colony_prybar/proc/on_unwield(obj/item/source, mob/living/carbon/user)
	SIGNAL_HANDLER
	inhand_icon_state = "colony_prybar"

// Backpackable mining drill

/obj/item/pickaxe/drill/compact
	name = "compact mining drill"
	desc = "A powered mining drill, it drills all over the place. Compact enough to hopefully fit in a backpack."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "drilla"
	inhand_icon_state = "colony_compact_drill"
	lefthand_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_righthand.dmi'
	greyscale_config_inhand_left = /datum/greyscale_config/colony_tools/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/colony_tools/inhand_right
	greyscale_config = /datum/greyscale_config/colony_tools
	greyscale_colors = COLONY_TOOL_COLORS
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	worn_icon_state = "drill"
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.6
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/pickaxe/drill/compact/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

// Electric welder but not quite as strong

/obj/item/weldingtool/electric/arc_welder
	name = "arc welding tool"
	desc = "A specialized welding tool utilizing high powered arcs of electricity to weld things together. \
		Compared to other electrically-powered welders, this model is slow and highly power inefficient, \
		but it still gets the job done and chances are you printed this bad boy off for free."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "arc_welder"
	inhand_icon_state = "colony_arc_welder"
	lefthand_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_righthand.dmi'
	greyscale_config_inhand_left = /datum/greyscale_config/colony_tools/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/colony_tools/inhand_right
	greyscale_config = /datum/greyscale_config/colony_tools
	greyscale_colors = COLONY_TOOL_COLORS
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	usesound = 'modular_skyrat/modules/colony_fabricator/sound/arc_welder/arc_welder.ogg'
	light_range = 2
	light_power = 0.75
	toolspeed = 1.25
	power_use_amount = POWER_CELL_USE_INSANE
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)

/obj/item/weldingtool/electric/arc_welder/Initialize(mapload)
	. = ..()
	// the cell component's overlay ignores recolours, so cell_overlay draws it instead
	var/datum/component/cell/cell_component = GetComponent(/datum/component/cell)
	if(cell_component)
		cell_component.has_cell_overlays = FALSE
		cut_overlay(cell_component.cell_overlay)
		QDEL_NULL(cell_component.cell_overlay)
	AddElement(/datum/element/cell_overlay, "arc_welder_cell")
	AddElement(/datum/element/gags_recolorable)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

// rebuild the battery overlay on recolour
/obj/item/weldingtool/electric/arc_welder/update_greyscale()
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

// Field multitool

/obj/item/multitool
	/// Pulsing wires with this can't shock the user
	var/insulated_probes = FALSE

/obj/item/multitool/colony
	name = "field multitool"
	desc = "A rugged multitool built for construction and repair work far from any station. \
		Its probes are insulated from the casing, so it can be used to check live lines without much worry."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "multitool"
	icon_angle = 0
	inhand_icon_state = "colony_multitool"
	lefthand_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/colony_fabricator/icons/tools_righthand.dmi'
	greyscale_config = /datum/greyscale_config/colony_multitool
	greyscale_config_inhand_left = /datum/greyscale_config/colony_multitool/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/colony_multitool/inhand_right
	greyscale_colors = COLONY_MULTITOOL_COLORS
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	insulated_probes = TRUE
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.2,
	)

/obj/item/multitool/colony/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)


/// Draws a battery overlay while a cell is fitted
/datum/element/cell_overlay
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2
	/// Overlay icon state
	var/overlay_state

/datum/element/cell_overlay/Attach(datum/target, overlay_state)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE
	src.overlay_state = overlay_state
	RegisterSignal(target, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_update_overlays))
	RegisterSignals(target, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_EXITED), PROC_REF(on_contents_changed))
	var/obj/item/item_target = target
	item_target.update_appearance(UPDATE_OVERLAYS)

/datum/element/cell_overlay/Detach(datum/source)
	UnregisterSignal(source, list(COMSIG_ATOM_UPDATE_OVERLAYS, COMSIG_ATOM_ENTERED, COMSIG_ATOM_EXITED))
	return ..()

/datum/element/cell_overlay/proc/on_update_overlays(obj/item/source, list/overlays)
	SIGNAL_HANDLER
	if(locate(/obj/item/stock_parts/power_store/cell) in source)
		overlays += mutable_appearance(source.icon, overlay_state)

/datum/element/cell_overlay/proc/on_contents_changed(obj/item/source, atom/movable/thing)
	SIGNAL_HANDLER
	if(istype(thing, /obj/item/stock_parts/power_store/cell))
		source.update_appearance(UPDATE_OVERLAYS)

#undef COLONY_TOOL_COLORS
#undef COLONY_MULTITOOL_COLORS
