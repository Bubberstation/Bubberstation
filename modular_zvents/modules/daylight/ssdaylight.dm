/area
	var/daylight = FALSE

/area/Initialize(mapload)
	. = ..()
	initialize_daylight()

/area/proc/initialize_daylight()
	if(daylight)
		SSdaylight.queue_area_for_setup(src)
	else
		SSdaylight.remove_daylight_from_area(src)


SUBSYSTEM_DEF(daylight)
	name = "Daylight Controller"
	wait = 10 SECONDS
	runlevels = RUNLEVEL_GAME
	dependencies = list(
		/datum/controller/subsystem/mapping,
		/datum/controller/subsystem/lighting
	)

	var/list/obj/effect/light_emitter/daylight/all_emitters = list()

	var/current_intensity = 1
	var/current_color = "#ffffff"

	var/day_length = 1 HOURS
	var/daylight_fraction = 0.66

	var/cycle_locked = TRUE
	var/time_locked = FALSE
	var/manual_time = -1

	var/list/setup_queue = list()
	var/setup_running = FALSE


	var/static/list/day_colors = list(
		"0.00" = "#ff8c4d",
		"0.15" = "#ffd4b0",
		"0.30" = "#fff4ea",
		"0.50" = "#ffffff",
		"0.70" = "#fff8e1",
		"0.85" = "#ffaa70",
		"1.00" = "#ff6a4d"
	)
	var/static/night_color = "#4a6ab9"

/datum/controller/subsystem/daylight/proc/queue_area_for_setup(area/A)
	if(!istype(A) || QDELETED(A) || !(A in GLOB.areas) || !A.daylight)
		return FALSE

	if(A in setup_queue)
		return FALSE

	setup_queue += A

	if(!setup_running)
		setup_running = TRUE
		INVOKE_ASYNC(src, PROC_REF(process_setup_queue))

	return TRUE

/datum/controller/subsystem/daylight/proc/process_setup_queue()
	var/list/areas_to_process = setup_queue.Copy()
	setup_queue.Cut()

	while(areas_to_process.len)
		var/area/A = areas_to_process[areas_to_process.len]
		areas_to_process.len--

		if(!istype(A) || QDELETED(A) || !(A in GLOB.areas) || !A.daylight)
			continue

		for(var/turf/T in A.contents)
			if(locate(/obj/effect/light_emitter/daylight) in T)
				continue

			var/obj/effect/light_emitter/daylight/new_emitter = new(T)
			register_emitter(new_emitter)
			CHECK_TICK

		stoplag(1)


	setup_running = FALSE
	if(setup_queue.len)
		setup_running = TRUE
		INVOKE_ASYNC(src, PROC_REF(process_setup_queue))

/datum/controller/subsystem/daylight/proc/remove_daylight_from_area(area/A)
	if(!istype(A) || QDELETED(A) || !(A in GLOB.areas))
		return

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

/datum/controller/subsystem/daylight/proc/update_all_emitters()
	for(var/obj/effect/light_emitter/daylight/E as anything in all_emitters)
		if(!QDELETED(E))
			E.apply_current_state()

/datum/controller/subsystem/daylight/proc/set_intensity_and_color(intensity, color, force = FALSE)
	intensity = clamp(intensity, 0, 1)
	var/changed = force || abs(current_intensity - intensity) > 0.001 || current_color != color
	if(!changed)
		return

	current_intensity = intensity
	current_color = color
	INVOKE_ASYNC(src, PROC_REF(update_all_emitters))

/datum/controller/subsystem/daylight/proc/get_target_intensity_and_color()
	var/target_intensity = 0
	var/target_color = night_color

	if(manual_time >= 0)
		target_intensity = manual_time
		target_color = (manual_time >= 0.9 ? "#ffffff" : manual_time >= 0.1 ? "#ffaa70" : night_color)

	else if(time_locked || cycle_locked)
		target_intensity = current_intensity
		target_color = current_color

	else
		var/cycle_progress = (world.time / day_length) % 1

		if(cycle_progress < daylight_fraction)
			var/day_progress = cycle_progress / daylight_fraction

			target_intensity = (day_progress < 0.2 ? day_progress / 0.2 : day_progress > 0.8 ? (1 - day_progress) / 0.2 : 1)

			var/list/keys = day_colors
			var/lower = 0
			var/upper = 1
			var/lower_key = "0.00"
			var/upper_key = "1.00"

			for(var/k in keys)
				var/val = text2num(k)
				if(val <= day_progress && val > lower)
					lower = val
					lower_key = k
				if(val >= day_progress && val < upper)
					upper = val
					upper_key = k

			var/color1 = day_colors[lower_key]
			var/color2 = day_colors[upper_key]
			var/mix = (upper > lower) ? (day_progress - lower) / (upper - lower) : 0
			target_color = color_interpolate(color1, color2, mix)

		else
			target_intensity = 0
			target_color = night_color

	return list(target_intensity, target_color)

/datum/controller/subsystem/daylight/fire()
	var/list/target = get_target_intensity_and_color()
	var/t_intensity = target[1]
	var/t_color = target[2]

	var/intensity_diff = abs(current_intensity - t_intensity) > 0.005
	var/color_diff = (current_color != t_color)

	if(intensity_diff || color_diff)
		if(intensity_diff)
			var/step = (t_intensity - current_intensity) * 0.05
			current_intensity = clamp(current_intensity + step, 0, 1)

		if(color_diff)
			current_color = t_color

		INVOKE_ASYNC(src, PROC_REF(update_all_emitters))


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
		SSdaylight.set_intensity_and_color(value, color, force = TRUE)

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
	flags_1 = NO_TURF_MOVEMENT

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
