/datum/escape_menu/show_home_page()
	. = ..()
	page_holder.give_screen_object(
		new /atom/movable/screen/escape_menu/text/clickable/opfor(
			null,
			/* hud_owner = */ null,
			/* escape_menu = */ src,
			/* button_text = */ "OPFOR",
			/* offset = */ list(-311, -260),
			/* font_size = */ 24,
			/* on_click_callback = */ CALLBACK(src, PROC_REF(home_opfor)),
		)
	)

	page_holder.give_screen_object(
		new /atom/movable/screen/escape_menu/text/clickable/leave_body(
			null,
			/* hud_owner = */ null,
			/* escape_menu = */ src,
			/* button_text = */ "Ghost",
			/* offset = */ list(-346, -260),
			/* font_size = */ 24,
			/* on_click_callback = */ CALLBACK(src, PROC_REF(home_ghost)),
		)
	)

	page_holder.give_screen_object(
		new /atom/movable/screen/escape_menu/text/clickable/respawn(
			null,
			/* hud_owner = */ null,
			/* escape_menu = */ src,
			/* button_text = */ "Respawn",
			/* offset = */ list(-276, -260),
			/* font_size = */ 24,
			/* on_click_callback = */ CALLBACK(src, PROC_REF(home_respawn)),
		)
	)

/datum/escape_menu/proc/home_respawn()
	PRIVATE_PROC(TRUE)
	client?.mob.abandon_mob()
	qdel(src)

/datum/escape_menu/proc/home_ghost()
	PRIVATE_PROC(TRUE)

	// Not guaranteed to be living. Everything defines verb/ghost separately. Fuck you.
	var/mob/living/living_user = client?.mob
	living_user?.ghost()
	qdel(src)

/datum/escape_menu/proc/home_opfor()
	PRIVATE_PROC(TRUE)

	// Not guaranteed to be living. Everything defines verb/ghost separately. Fuck you.
	var/mob/living/living_user = client?.mob
	living_user?.opposing_force()
	qdel(src)

/atom/movable/screen/escape_menu/text/clickable/respawn

/datum/escape_menu/proc/respawn()
	PRIVATE_PROC(TRUE)

	var/mob/living/client_mob = client?.mob
	client_mob?.abandon_mob()

/atom/movable/screen/escape_menu/text/clickable/respawn/enabled()
	if (!..())
		return FALSE

	return !isliving(escape_menu.client?.mob)

/atom/movable/screen/escape_menu/text/clickable/opfor

/atom/movable/screen/escape_menu/text/clickable/opfor/enabled()
	if (!..())
		return FALSE

	return isliving(escape_menu.client?.mob)
