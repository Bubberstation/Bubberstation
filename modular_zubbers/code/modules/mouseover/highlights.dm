/client/
	//MOUSEOVER THINGS
	var/datum/callback/mouseover_callback   // Cached callback, see /client/New()
	var/obj/mouseover_highlight_dummy       // Dummy atom to hold the appearance of our highlighted atom, see comments in /client/proc/refresh_mouseover_highlight.
	var/datum/weakref/current_highlight_atom      // Current weakref to highlighted atom, used for checking if we're mousing over the same atom repeatedly.
	var/image/current_highlight             // Current dummy image holding our highlight.

	var/mouseover_refresh_timer             // Holds an ID to the timer used to update the mouseover highlight.
	var/last_mouseover_params               // Stores mouse/keyboard params as of last mouseover, to check for shift being held.
	var/last_mouseover_highlight_time       // Stores last world.time we mouseover'd, to prevent it happening more than once per world.tick_lag.
	var/mouseover
	var/mouseover_rainbow
// Making these procs systematic in view of a future where we have a
// proper system for queuing/caching/updating vis contents cleanly.
#define add_vis_contents(A, B)    A.vis_contents |= (B)
#define remove_vis_contents(A, B) A.vis_contents -= (B)
#define clear_vis_contents(A)     A.vis_contents.Cut()
#define set_vis_contents(A, B)    A.vis_contents = (B)
/client/proc/new_mouseover_callback()
	mouseover = TRUE
	mouseover_rainbow = TRUE
	return mouseover_callback = CALLBACK(src, PROC_REF(refresh_mouseover_highlight_timer))
/client/New()
	new_mouseover_callback()
	. = ..()
/mob/Login()
	. = ..()
	client?.delete_mouseover_images()

/client/proc/refresh_mouseover_highlight_timer(atom/movable/current_atom, object)

	animate(
		mouseover_highlight_dummy,
		pixel_y = 0,
		pixel_x = 0,
		pixel_w = 0,
		pixel_z = 0,
		time = 0.5 SECONDS,
		easing = BACK_EASING,
		alpha = 0,
	)

/client/proc/delete_mouseover_images()
//	QDEL_NULL(current_highlight_atom)
	images -= current_highlight
	qdel(current_highlight)
	current_highlight = null
	current_highlight_atom = null
//	deltimer(mouseover_refresh_timer)
//	mouseover_refresh_timer = null
// Main body of work happens in this proc.
/client/proc/refresh_mouseover_highlight(object, params, check_adjacency = FALSE)
	var/list/modifiers = params2list(params)
	if(!modifiers["shift"])
		return
	if(!mouseover)
		return FALSE
	// Verify if we should be showing a highlight at all.
	if(!istype(object, /atom/movable) || istype(object, /mob) || istype(object, /obj/structure) || (check_adjacency && !mob.Adjacent(object)))
		return FALSE

	var/atom/movable/AM = object
	if(get_dist(mob, object) > 1 || AM.anchored)
		return FALSE

	// Generate our dummy objects if they got nulled/discarded.
	if(!current_highlight)
		current_highlight = new /image
		current_highlight.appearance_flags |= (KEEP_TOGETHER|RESET_COLOR)
		images += current_highlight
	if(!mouseover_highlight_dummy)
		mouseover_highlight_dummy = new

	// Copy over the atom's appearance to our holder object.
	// client.images does not respect pixel offsets for images, but vis contents does,
	// and images have vis contents - so we throw a null image into client.images, then
	// throw a holder object with the appearance of the mouse-overed atom into its vis contents.
	mouseover_highlight_dummy.appearance = AM
	mouseover_highlight_dummy.name = ""
	mouseover_highlight_dummy.verbs.Cut()
	mouseover_highlight_dummy.vis_flags |= VIS_INHERIT_ID
	mouseover_highlight_dummy.dir = AM.dir
	mouseover_highlight_dummy.transform = AM.transform

	// For some reason you need to explicitly zero the pixel offsets of the holder object
	// or anything with a pixel offset will not line up with the highlight. Thanks DM.
	mouseover_highlight_dummy.pixel_x = 0
	mouseover_highlight_dummy.pixel_y = 0
	mouseover_highlight_dummy.pixel_w = 0
	mouseover_highlight_dummy.pixel_z = 0

	// Replane to be over the UI, make sure it can't block clicks, and set its outline.
	mouseover_highlight_dummy.mouse_opacity = 0
	mouseover_highlight_dummy.layer = ABOVE_HUD_PLANE
	mouseover_highlight_dummy.plane = BALLOON_CHAT_PLANE
	mouseover_highlight_dummy.alpha = 255
	mouseover_highlight_dummy.appearance_flags |= (KEEP_TOGETHER|RESET_COLOR)
	mouseover_highlight_dummy.add_filter(
		"drop",
		1,
		list(
			type = "drop_shadow",
			color = mouseover_rainbow ? rgb(rand(0,255),rand(0,255),rand(0,255)) : "#0082c6",
			size = 1,
			offset = 2, x = 0, y = 0
		)
	)
	animate(mouseover_highlight_dummy, pixel_y = 24, time = 0.5 SECONDS, easing = ELASTIC_EASING, alpha = 180, maptext_y = 24)

	mouseover_highlight_dummy.maptext_width = 128
	mouseover_highlight_dummy.maptext_x = -48
	mouseover_highlight_dummy.maptext = MAPTEXT_SPESSFONT(AM)
	// Finally update our highlight's vis contents and location .
	clear_vis_contents(current_highlight)
	add_vis_contents(current_highlight, mouseover_highlight_dummy)
	current_highlight.loc = object
	current_highlight_atom = WEAKREF(AM)

	// Keep track our params so the update ticker knows if we were holding shift or not.
	last_mouseover_params = params

	return TRUE

// Simple hooks to catch the client mouseover/mouseleave events and start our highlight timer as needed.
/client/MouseEntered(object, location, control, params)
	if(world.time > last_mouseover_highlight_time && refresh_mouseover_highlight(object, params, check_adjacency = TRUE) && !mouseover_refresh_timer)
		last_mouseover_highlight_time = world.time
		mouseover_refresh_timer = addtimer(mouseover_callback, 1 SECONDS, (TIMER_OVERRIDE | TIMER_UNIQUE | TIMER_STOPPABLE))
	. = ..()

/client/MouseExited(object, location, control, params)
	var/initalpha = initial(mouseover_highlight_dummy.alpha)
	var/atom/movable/current_atom = current_highlight_atom?.resolve()
	if(current_atom != object && mouseover_highlight_dummy)
		animate(mouseover_highlight_dummy, pixel_y = 0, time = 0.2 SECONDS, easing = ELASTIC_EASING, alpha = initalpha)
		refresh_mouseover_highlight_timer(current_atom, object)

	. = ..()


/datum/preference/toggle/item_outlines/apply_to_client(client/client, value)
	. = ..()
	if(value == FALSE)
		client.mouseover = FALSE
	else
		client.mouseover = TRUE
