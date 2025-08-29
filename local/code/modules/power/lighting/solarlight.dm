/// I can't figure out day and night cycles so oopsies
/obj/machinery/solarlight
	name = "solarlight"
	desc = "A solar-charged piece of machinery for lighting roadways. Generates electricity when in contact with even the most distant sunlight."
	icon = 'local/icons/obj/lighting.dmi'
	icon_state = "solarlamp"
	density = TRUE
	use_power = NO_POWER_USE
	idle_power_usage = 0
	active_power_usage = 0
	max_integrity = 150
	integrity_failure = 0.33
	light_power = 1.75
	var/current_range = 7
	/// The camera installed into the light, if any
	var/obj/machinery/camera/solar_camera

/obj/machinery/solarlight/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_OBJ_PAINTED, TYPE_PROC_REF(/obj/machinery/solarlight, on_color_change))  //update light color when color changes
	update_light_state()

/obj/machinery/solarlight/proc/on_color_change(obj/machinery/power/flood_light, mob/user, obj/item/toy/crayon/spraycan/spraycan, is_dark_color)
	SIGNAL_HANDLER
	if(!spraycan.actually_paints)
		return

	update_light_state()

/obj/machinery/solarlight/Destroy()
	UnregisterSignal(src, COMSIG_OBJ_PAINTED)
	if(solar_camera)
		QDEL_NULL(solar_camera)
	. = ..()

/// change light color during operation
/obj/machinery/solarlight/proc/update_light_state()
	var/light_color =  NONSENSICAL_VALUE
	if(!isnull(color))
		light_color = color
	var/new_range = SSnightshift.nightshift_active ? 4 : 7
	set_light(new_range, light_power, light_color) // Exact range of internal cameras

/obj/machinery/solarlight/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	toggle_panel_open()
	to_chat(user, span_notice("You screw the [src.name]'s panel [panel_open ? "open" : "closed"]."))
	I.play_tool_sound(src)
	update_appearance()
	return TRUE

// Handles installing cameras
/obj/machinery/solarlight/attackby(obj/item/attacking_item, mob/living/user, params)
	if(panel_open && perform_install_checks(attacking_item, user, params))
		qdel(attacking_item)
		solar_camera = new /obj/machinery/camera/autoname(src)
		balloon_alert(user, "camera installed")
		update_camera_chunk()
		return ..()

/obj/machinery/solarlight/proc/perform_install_checks(obj/item/attacking_item, mob/living/user, params)
	if(solar_camera == null && istype(attacking_item, /obj/item/wallframe/camera))
		return TRUE
	return FALSE

/obj/machinery/solarlight/proc/update_camera_chunk()
	var/turf/our_turf = get_turf(src)
	GLOB.cameranet.updateChunk(our_turf.x, our_turf.y, our_turf.z)

/obj/machinery/solarlight/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(!panel_open && solar_camera)
		return
	balloon_alert_to_viewers("removing camera")
	if(do_after(user, 3 SECONDS, src))
		solar_camera.deconstruct(TRUE) // This is a little bit on the scuffed side but sue me, I couldn't get it working any better
		solar_camera = null
		update_camera_chunk()
		I.play_tool_sound(src)

/// Variant that starts with a camera installed, used on RimPoint
/obj/machinery/solarlight/camera_installed
	/// If defined, sets the camera's c_tag accordingly.
	var/c_tag

/obj/machinery/solarlight/camera_installed/Initialize(mapload)
	. = ..()
	solar_camera = new (src)
	if(c_tag)
		solar_camera.c_tag = c_tag
