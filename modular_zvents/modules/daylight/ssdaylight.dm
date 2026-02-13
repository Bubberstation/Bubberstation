#define LUMINOSITY_DAYLIGHT 1.5  // Unused, but kept for compatibility if needed
/area
	var/daylight = FALSE

/area/Initialize(mapload)
	. = ..()
	initialize_daylight()

/area/Destroy()
	. = ..()
	remove_daylight()

/area/proc/initialize_daylight()
	if(daylight)
		SSdaylight.daylight_areas += src
		SSdaylight.update_area(src)

/area/proc/remove_daylight()
	if(daylight)
		SSdaylight.daylight_areas -= src

SUBSYSTEM_DEF(daylight)
	name = "Daylight Controller"
	wait = 1 SECONDS
	runlevels = RUNLEVEL_GAME
	dependencies = list(
		/datum/controller/subsystem/mapping,
		/datum/controller/subsystem/lighting
	)

	var/static/list/daylight_areas = list()
	var/static/list/obj/effect/light_emitter/daylight/all_emitters = list()

	var/current_intensity = 1
	var/current_color = "#ffffff"
	var/list/current_rgb = list(255, 255, 255)

	var/target_intensity = 1
	var/target_color = "#ffffff"
	var/start_intensity = 1
	var/start_color = "#ffffff"
	var/transition_steps = 0
	var/const/TRANSITION_STEPS = 6

	var/daylight_fraction = 0.77

	var/delta_cycle_progress = 0.05
	var/cycle_locked = FALSE
	var/time_locked = FALSE
	var/manual_time = -1

	var/list/setup_queue = list()
	var/setup_running = FALSE

	var/last_cycle_progress = -1

	var/static/list/day_colors = list(
		"0.00"  = "#ff704d",
		"0.10"  = "#ffab81",
		"0.20"  = "#ffd1a8",
		"0.35"  = "#fffdf7",
		"0.50"  = "#fffdf7",
		"0.65"  = "#fffdf7",
		"0.78"  = "#ffda9f",
		"0.88"  = "#ffb875",
		"0.94"  = "#ff8f5c",
		"1.00"  = "#ff5f3a"
	)
	var/static/night_color = "#b1b1b1"

	var/daylight_update_cooldown = 2 MINUTES
	// Daylight cycle in minutes
	var/daylight_cycle = 60
	COOLDOWN_DECLARE(daylight_update_cd)

/datum/controller/subsystem/daylight/Initialize()
	SSticker.station_time_rate_multiplier = 1440 / daylight_cycle

	current_rgb = hex2rgb(current_color)
	var/initial_progress = station_time() / (24 HOURS)
	last_cycle_progress = initial_progress
	current_intensity = clamp(initial_progress / daylight_fraction, 0, 1)
	current_color = get_daylight_color(current_intensity)
	update_current(current_intensity, current_color)

	return SS_INIT_SUCCESS

/datum/controller/subsystem/daylight/proc/update_area(area/A)
	if(!istype(A) || QDELETED(A) || !A.daylight)
		return
	A.set_base_lighting(current_color, round(current_intensity * 255, 1))

/datum/controller/subsystem/daylight/proc/remove_daylight_from_area(area/A)
	if(!istype(A) || QDELETED(A) || !(A in GLOB.areas))
		return

	daylight_areas -= A
	for(var/turf/T in A.contents)
		for(var/obj/effect/light_emitter/daylight/E in T)
			qdel(E)

/datum/controller/subsystem/daylight/proc/register_emitter(obj/effect/light_emitter/daylight/emitter)
	if(!emitter || QDELETED(emitter) || (emitter in all_emitters))
		return
	all_emitters += emitter
	emitter.apply_current_state()

/datum/controller/subsystem/daylight/proc/unregister_emitter(obj/effect/light_emitter/daylight/emitter)
	all_emitters -= emitter

/datum/controller/subsystem/daylight/proc/change_turf_light(turf/T, intensity, color)

/datum/controller/subsystem/daylight/proc/update_all_areas()
	if(setup_running)
		return
	setup_running = TRUE
	for(var/area/A in daylight_areas)
		update_area(A)
		stoplag(1)
	setup_running = FALSE

/datum/controller/subsystem/daylight/proc/set_target(intensity, color)
	target_intensity = clamp(intensity, 0, 1)
	target_color = color
	start_intensity = current_intensity
	start_color = current_color
	transition_steps = TRANSITION_STEPS

/datum/controller/subsystem/daylight/proc/set_intensity_and_color(intensity, color, force = FALSE)
	if(force)
		transition_steps = 0
		update_current(intensity, color)
	else
		set_target(intensity, color)

/datum/controller/subsystem/daylight/proc/update_current(intensity, color)
	var/changed = abs(current_intensity - intensity) > 0.001 || current_color != color
	if(!changed)
		return

	current_intensity = intensity
	current_color = color
	current_rgb = hex2rgb(color)

	if(changed)
		update_all_areas()
		for(var/obj/effect/light_emitter/daylight/E in all_emitters)
			E.apply_current_state()
		SEND_SIGNAL(src, COMSIG_DAYLIGHT_UPDATED, current_intensity, current_color)

/datum/controller/subsystem/daylight/proc/get_daylight_color(progress = 0)
	progress = clamp(progress, 0, 1)

	if(progress <= 0)
		return "#ff704d"
	if(progress >= 1)
		return "#ff5f3a"

	var/list/keys = sort_list(day_colors)

	var/lower = 0
	var/upper = 1
	var/lower_key = "0.00"
	var/upper_key = "1.00"

	for(var/key in keys)
		var/val = text2num(key)
		if(val <= progress && val > lower)
			lower = val
			lower_key = key
		if(val >= progress && val < upper)
			upper = val
			upper_key = key

	var/color1 = day_colors[lower_key]
	var/color2 = day_colors[upper_key]

	if(lower == upper || lower_key == upper_key)
		return color1

	var/mix = (progress - lower) / (upper - lower)
	return color_interpolate(color1, color2, mix)

/datum/controller/subsystem/daylight/fire()
	if(transition_steps > 0)
		var/fraction = 1 - (transition_steps - 1) / TRANSITION_STEPS
		var/new_intensity = lerp(start_intensity, target_intensity, fraction)
		var/new_color = color_interpolate(start_color, target_color, fraction)
		update_current(new_intensity, new_color)
		transition_steps--

	if(!COOLDOWN_FINISHED(src, daylight_update_cd))
		return
	COOLDOWN_START(src, daylight_update_cd, daylight_update_cooldown)

	var/auto_cycle = (manual_time < 0 && !time_locked && !cycle_locked)
	var/cycle_progress = station_time() / (24 HOURS)

	if(auto_cycle)
		if(last_cycle_progress < 0)
			last_cycle_progress = cycle_progress
		else
			if(cycle_progress < last_cycle_progress - 0.01)
				message_admins("A new day has dawned on the station!")
				SEND_SIGNAL(src, COMSIG_DAYLIGHT_NEW_DAY)
				SEND_SIGNAL(src, COMSIG_DAYLIGHT_DAY_START)

			else if(last_cycle_progress < daylight_fraction && cycle_progress >= daylight_fraction)
				message_admins("Night has fallen on the station.")
				SEND_SIGNAL(src, COMSIG_DAYLIGHT_NIGHT_START)

	if(!auto_cycle)
		return
	if(abs(cycle_progress - last_cycle_progress) < delta_cycle_progress)
		return
	var/new_value = 0
	var/color = night_color

	if(cycle_progress > daylight_fraction || cycle_progress < (1 - daylight_fraction))
		new_value = 0.01
		color = night_color
	else
		new_value = clamp(1 - cycle_progress, 0, 1)
		color = get_daylight_color(new_value)

	set_target(new_value, color)
	last_cycle_progress = cycle_progress

/proc/hex2rgb(hex)
	if(!hex)
		return list(255, 255, 255)

	if(copytext(hex, 1, 2) == "#")
		hex = copytext(hex, 2)

	var/len = length(hex)
	if(len == 3)
		hex = "[copytext(hex,1,2)][copytext(hex,1,2)][copytext(hex,2,3)][copytext(hex,2,3)][copytext(hex,3,4)][copytext(hex,3,4)]"

	if(length(hex) != 6)
		return list(255, 255, 255)

	var/r = hex2num(copytext(hex, 1, 3))
	var/g = hex2num(copytext(hex, 3, 5))
	var/b = hex2num(copytext(hex, 5, 7))

	return list(r, g, b)


/proc/color_interpolate(color1, color2, ratio)
	var/list/c1 = hex2rgb(color1)
	var/list/c2 = hex2rgb(color2)
	var/r = round(c1[1] + (c2[1] - c1[1]) * ratio, 1)
	var/g = round(c1[2] + (c2[2] - c1[2]) * ratio, 1)
	var/b = round(c1[3] + (c2[3] - c1[3]) * ratio, 1)
	return rgb(r, g, b)


ADMIN_VERB(set_daylight_time, R_ADMIN, "Set Daylight Time (0-1)", "Force daylight intensity or return to auto", ADMIN_CATEGORY_EVENTS)
	if(!check_rights(R_ADMIN))
		return

	var/value = input(usr, "Set forced intensity (0 = night, 1 = day, -1 = auto)", "Daylight Control", -1) as num|null
	if(isnull(value))
		return

	value = clamp(value, -1, 1)
	SSdaylight.manual_time = (value < 0 ? -1 : value)
	SSdaylight.time_locked = (value >= 0)
	SSdaylight.cycle_locked = (value >= 0)

	if(value >= 0)
		var/color = (value >= 0.9 ? "#ffffff" : value >= 0.1 ? "#ffaa70" : SSdaylight.night_color)
		SSdaylight.set_intensity_and_color(value, color, TRUE)

	log_admin("[key_name(usr)] set daylight time to [value == -1 ? "AUTO" : value]")
	message_admins(span_adminnotice("[key_name_admin(usr)] set daytime: [value == -1 ? "auto" : value]"))

ADMIN_VERB(toggle_daylight_cycle_lock, R_ADMIN, "Toggle Daylight Cycle Lock", "Lock/unlock automatic day-night cycle", ADMIN_CATEGORY_EVENTS)
	if(!check_rights(R_ADMIN))
		return

	SSdaylight.cycle_locked = !SSdaylight.cycle_locked
	if(!SSdaylight.cycle_locked)
		SSdaylight.time_locked = FALSE
		SSdaylight.manual_time = -1

	log_admin("[key_name(usr)] [SSdaylight.cycle_locked ? "locked" : "unlocked"] daylight cycle")
	message_admins(span_adminnotice("[key_name_admin(usr)] [SSdaylight.cycle_locked ? "locked" : "unlocked"] daylight cycle"))


/obj/effect/light_emitter
	flags_1 = NO_TURF_MOVEMENT_1

/obj/effect/light_emitter/daylight
	set_luminosity = 2
	set_cap = 0.5
	var/initial_lum = 2
	var/initial_cap = 0.5

/obj/effect/light_emitter/daylight/Initialize(mapload)
	. = ..()
	initial_lum = set_luminosity
	initial_cap = set_cap
	if(SSdaylight)
		SSdaylight.register_emitter(src)

/obj/effect/light_emitter/daylight/proc/apply_current_state()
	if(!SSdaylight)
		return
	var/mult = SSdaylight.current_intensity
	light_power = initial_cap * mult
	light_color = SSdaylight.current_color
	update_light()

/obj/effect/light_emitter/daylight/Destroy()
	if(SSdaylight)
		SSdaylight.unregister_emitter(src)
	return ..()

#undef LUMINOSITY_DAYLIGHT
/datum/element/daylight_overlay
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY
	var/mutable_appearance/overlay

/datum/element/daylight_overlay/Attach(datum/target)
	. = ..()
	if(!istype(target, /turf))
		return ELEMENT_INCOMPATIBLE

	var/turf/T = target
	var/plane_offset = GET_TURF_PLANE_OFFSET(T)

	var/mutable_appearance/light = mutable_appearance('icons/effects/alphacolors.dmi', "white")
	light.layer = LIGHTING_PRIMARY_LAYER
	light.blend_mode = BLEND_ADD
	light.appearance_flags = RESET_TRANSFORM | RESET_ALPHA | RESET_COLOR
	light.alpha = round(SSdaylight.current_intensity * 255, 1)
	light.color = SSdaylight.current_color
	SET_PLANE_W_SCALAR(light, LIGHTING_PLANE, plane_offset)

	T.add_overlay(light)
	T.luminosity = 1
	overlay = light

	RegisterSignal(SSdaylight, COMSIG_DAYLIGHT_UPDATED, PROC_REF(update_overlay))

/datum/element/daylight_overlay/Detach(datum/source)
	. = ..()
	if(!istype(source, /turf))
		return
	var/turf/T = source
	T.cut_overlay(list(overlay))
	T.luminosity = 0

/datum/element/daylight_overlay/proc/update_overlay(datum/source, intensity, color)
	SIGNAL_HANDLER
	overlay.alpha = round(intensity * 255, 1)
	overlay.color = color
