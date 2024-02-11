#define SHUTTLE_CONSOLE_ACCESSDENIED "accessdenied"
#define SHUTTLE_CONSOLE_ENDGAME "endgame"
#define SHUTTLE_CONSOLE_RECHARGING "recharging"
#define SHUTTLE_CONSOLE_INTRANSIT "intransit"
#define SHUTTLE_CONSOLE_DESTINVALID "destinvalid"
#define SHUTTLE_CONSOLE_SUCCESS "success"
#define SHUTTLE_CONSOLE_ERROR "error"

/obj/machinery/computer/shuttle
	name = "shuttle console"
	desc = "A shuttle control computer."
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	light_color = LIGHT_COLOR_CYAN
	req_access = list()
	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON
	/// ID of the attached shuttle
	var/shuttleId
	/// Possible destinations of the attached shuttle
	var/possible_destinations = ""
	/// Variable dictating if the attached shuttle requires authorization from the admin staff to move
	var/admin_controlled = FALSE
	/// Variable dictating if the attached shuttle is forbidden to change destinations mid-flight
	var/no_destination_swap = FALSE
	/// ID of the currently selected destination of the attached shuttle
	var/destination
	/// If the console controls are locked
	var/locked = FALSE
	/// List of head revs who have already clicked through the warning about not using the console
	var/static/list/dumb_rev_heads = list()
	/// Authorization request cooldown to prevent request spam to admin staff
	COOLDOWN_DECLARE(request_cooldown)

	var/uses_overmap = TRUE //SKYRAT EDIT ADDITION

/obj/machinery/computer/shuttle/Initialize(mapload)
	. = ..()
	connect_to_shuttle(mapload, SSshuttle.get_containing_shuttle(src))

//SKYRAT EDIT ADDITION
/obj/machinery/computer/shuttle/attacked_by(obj/item/smacking_object, mob/living/user)
	if(istype(smacking_object, /obj/item/navigation_datacard))
		var/obj/docking_port/mobile/M = SSshuttle.getShuttle(shuttleId)
		if(M.gateway_stranded)
			to_chat(user, span_notice("You insert [smacking_object] into [src], loading the navigational data!"))
			say("Navigational data loaded.")
			playsound(loc, 'sound/machines/terminal_insert_disc.ogg', 35, 1)
			M.gateway_stranded = FALSE
			qdel(smacking_object)
		else
			to_chat(user, span_notice("[src] does not have a corrupted navigations system!"))
			say("Error loading navigational disk.")
//SKYRAT EDIT END

/obj/machinery/computer/shuttle/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	//SKYRAT EDIT ADDITION/CHANGE
	if(uses_overmap)
		var/obj/docking_port/mobile/M = SSshuttle.getShuttle(shuttleId)
		if(!M)
			return
		var/list/dat = list("<center>")
		var/status_info
		if(admin_controlled)
			status_info = "Unauthorized Access"
		else if(locked)
			status_info = "Locked"
		else if(M.gateway_stranded)
			status_info = "NAVIGATIONAL SYSTEM ERROR, RECALIBRATION REQUIRED!"
		else
			switch(M.mode)
				if(SHUTTLE_IGNITING)
					status_info = "Igniting"
				if(SHUTTLE_IDLE)
					status_info = "Idle"
				if(SHUTTLE_RECHARGING)
					status_info = "Recharging"
				else
					status_info = "In Transit"
		dat += "STATUS: <b>[status_info]</b>"
		var/link
		if(M.mode == SHUTTLE_IDLE)
			link = "href='?src=[REF(src)];task=overmap_launch'"
		else
			link = "class='linkOff'"
		dat += "<BR><BR><a [link]>Depart to Overmap</a><BR>"

		dat += "<a href='?src=[REF(src)];task=engines_on']>Engines On</a> <a href='?src=[REF(src)];task=engines_off']>Engines Off</a>"

		dat += "<BR><BR><a [M.my_overmap_object ? "href='?src=[REF(src)];task=overmap_view'" : "class='linkOff'"]>Overmap View</a>"
		dat += "<BR><a [M.my_overmap_object ? "href='?src=[REF(src)];task=overmap_ship_controls'" : "class='linkOff'"]>Ship Controls</a></center>"
		var/datum/browser/popup = new(user, "shuttle_computer", name, 300, 200)
		popup.set_content(dat.Join())
		popup.open()
	else
		ui = SStgui.try_update_ui(user, src, ui)
		if(!ui)
			ui = new(user, src, "ShuttleConsole", name)
			ui.open()

/obj/machinery/computer/shuttle/Topic(href, href_list)
	var/mob/user = usr
	if(!isliving(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/obj/docking_port/mobile/M = SSshuttle.getShuttle(shuttleId)
	if(M.gateway_stranded)
		to_chat(usr, span_warning("Shuttle navigation systems are inoperable. Contact your IT supervisor immediately."))
		say("Navigational systems error.")
		playsound(src, 'modular_skyrat/modules/overmap/sound/shuttle_voice/error_navigation.ogg', OVERMAP_SHUTTLE_ALERT_VOLUME)
		return
	switch(href_list["task"])
		if("engines_off")
			M.TurnEnginesOff()
			say("Engines offline.")
			playsound(src, 'modular_skyrat/modules/overmap/sound/shuttle_voice/engines_off.ogg', OVERMAP_SHUTTLE_ALERT_VOLUME)
		if("engines_on")
			M.TurnEnginesOn()
			say("Engines online.")
			playsound(src, 'modular_skyrat/modules/overmap/sound/shuttle_voice/engines_on.ogg', OVERMAP_SHUTTLE_ALERT_VOLUME)
		if("overmap_view")
			if(M.my_overmap_object)
				M.my_overmap_object.GrantOvermapView(usr, get_turf(src))
				return
		if("overmap_ship_controls")
			if(M.my_overmap_object)
				M.my_overmap_object.DisplayUI(usr, get_turf(src))
				return
		if("overmap_launch")
			if(!uses_overmap)
				return
			if(!launch_check(usr))
				return
			if(M.launch_status == ENDGAME_LAUNCHED)
				to_chat(usr, "<span class='warning'>You've already escaped. Never going back to that place again!</span>")
				return
			if(no_destination_swap)
				if(M.mode == SHUTTLE_RECHARGING)
					to_chat(usr, "<span class='warning'>Shuttle engines are not ready for use.</span>")
					return
				if(M.mode != SHUTTLE_IDLE)
					to_chat(usr, "<span class='warning'>Shuttle already in transit.</span>")
					return
			if(uses_overmap)
				if(M.DrawDockingThrust())
					M.possible_destinations = possible_destinations
					M.destination = "overmap"
					M.mode = SHUTTLE_IGNITING
					M.play_engine_sound(src, TRUE)
					M.setTimer(5 SECONDS)
					say("Shuttle departing. Please stand away from the doors.")
					playsound(src, 'modular_skyrat/modules/overmap/sound/shuttle_voice/launch.ogg', OVERMAP_SHUTTLE_ALERT_VOLUME)
					log_shuttle("[key_name(usr)] has sent shuttle \"[M]\" into the overmap.")
					ui_interact(usr)
					return
				else
					say("Engine power insufficient to take off.")
					playsound(src, 'modular_skyrat/modules/overmap/sound/shuttle_voice/error_engines.ogg', OVERMAP_SHUTTLE_ALERT_VOLUME)
	ui_interact(usr)
//SKYRAT EDIT END
/obj/machinery/computer/shuttle/ui_data(mob/user)
	var/list/data = list()
	var/obj/docking_port/mobile/mobile_docking_port = SSshuttle.getShuttle(shuttleId)
	data["docked_location"] = mobile_docking_port ? mobile_docking_port.get_status_text_tgui() : "Unknown"
	data["locations"] = list()
	data["locked"] = locked
	data["authorization_required"] = admin_controlled
	data["timer_str"] = mobile_docking_port ? mobile_docking_port.getTimerStr() : "00:00"
	data["destination"] = destination
	if(!mobile_docking_port)
		data["status"] = "Missing"
		return data
	if(admin_controlled)
		data["status"] = "Unauthorized Access"
	else if(locked)
		data["status"] = "Locked"
	else
		switch(mobile_docking_port.mode)
			if(SHUTTLE_IGNITING)
				data["status"] = "Igniting"
			if(SHUTTLE_IDLE)
				data["status"] = "Idle"
			if(SHUTTLE_RECHARGING)
				data["status"] = "Recharging"
			else
				data["status"] = "In Transit"
	data["locations"] = get_valid_destinations()
	if(length(data["locations"]) == 1)
		for(var/location in data["locations"])
			destination = location["id"]
			data["destination"] = destination
	if(!length(data["locations"]))
		data["locked"] = TRUE
		data["status"] = "Locked"
	return data

/**
 * Checks if we are allowed to launch the shuttle
 *
 * Arguments:
 * * user - The mob trying to initiate the launch
 */
/obj/machinery/computer/shuttle/proc/launch_check(mob/user)
	if(!allowed(user)) //Normally this is already checked via interaction code but some cases may skip that so check it explicitly here (illiterates launching randomly)
		return FALSE
	return TRUE

/**
 * Returns a list of currently valid destinations for this shuttle console,
 * taking into account its list of allowed destinations, their current state, and the shuttle's current location
**/
/obj/machinery/computer/shuttle/proc/get_valid_destinations()
	var/list/destination_list = params2list(possible_destinations)
	var/obj/docking_port/mobile/mobile_docking_port = SSshuttle.getShuttle(shuttleId)
	var/obj/docking_port/stationary/current_destination = mobile_docking_port.destination
	var/list/valid_destinations = list()
	for(var/obj/docking_port/stationary/stationary_docking_port in SSshuttle.stationary_docking_ports)
		if(!destination_list.Find(stationary_docking_port.port_destinations))
			continue
		if(!mobile_docking_port.check_dock(stationary_docking_port, silent = TRUE))
			continue
		if(stationary_docking_port == current_destination)
			continue
		var/list/location_data = list(
			id = stationary_docking_port.shuttle_id,
			name = stationary_docking_port.name
		)
		valid_destinations += list(location_data)
	return valid_destinations

/**
 * Attempts to send the linked shuttle to dest_id, checking various sanity checks to see if it can move or not
 *
 * Arguments:
 * * dest_id - The ID of the stationary docking port to send the shuttle to
 * * user - The mob that used the console
 */
/obj/machinery/computer/shuttle/proc/send_shuttle(dest_id, mob/user)
	if(!launch_check(user))
		return SHUTTLE_CONSOLE_ACCESSDENIED
	var/obj/docking_port/mobile/shuttle_port = SSshuttle.getShuttle(shuttleId)
	if(shuttle_port.launch_status == ENDGAME_LAUNCHED)
		return SHUTTLE_CONSOLE_ENDGAME
	if(no_destination_swap)
		if(shuttle_port.mode == SHUTTLE_RECHARGING)
			return SHUTTLE_CONSOLE_RECHARGING
		if(shuttle_port.mode != SHUTTLE_IDLE)
			return SHUTTLE_CONSOLE_INTRANSIT
	//check to see if the dest_id passed from tgui is actually a valid destination
	var/list/dest_list = get_valid_destinations()
	var/validdest = FALSE
	for(var/list/dest_data in dest_list)
		if(dest_data["id"] == dest_id)
			validdest = TRUE //Found our destination, we can skip ahead now
			break
	if(!validdest) //Didn't find our destination in the list of valid destinations, something bad happening
		if(!isnull(user.client))
			log_admin("Warning: possible href exploit by [key_name(user)] - Attempted to dock [src] to illegal target location \"[url_encode(dest_id)]\"")
			message_admins("Warning: possible href exploit by [key_name_admin(user)] [ADMIN_FLW(user)] - Attempted to dock [src] to illegal target location \"[url_encode(dest_id)]\"")
		else
			stack_trace("[user] ([user.type]) tried to send the shuttle [src] to the target location [dest_id], but the target location was not found in the list of valid destinations.")
		return SHUTTLE_CONSOLE_DESTINVALID
	switch(SSshuttle.moveShuttle(shuttleId, dest_id, TRUE))
		if(DOCKING_SUCCESS)
			say("Shuttle departing. Please stand away from the doors.")
			log_shuttle("[key_name(user)] has sent shuttle \"[shuttleId]\" towards \"[dest_id]\", using [src].")
			return SHUTTLE_CONSOLE_SUCCESS
		else
			return SHUTTLE_CONSOLE_ERROR

/obj/machinery/computer/shuttle/ui_act(action, params)
	. = ..()
	//SKYRAT EDIT ADDITION
	if(uses_overmap)
		return
	//SKYRAT EDIT END
	if(.)
		return
	if(!allowed(usr))
		to_chat(usr, span_danger("Access denied."))
		return

	switch(action)
		if("move")
			switch (send_shuttle(params["shuttle_id"], usr)) //Try to send the shuttle, tell the user what happened
				if (SHUTTLE_CONSOLE_ACCESSDENIED)
					to_chat(usr, span_warning("Access denied."))
					return
				if (SHUTTLE_CONSOLE_ENDGAME)
					to_chat(usr, span_warning("You've already escaped. Never going back to that place again!"))
					return
				if (SHUTTLE_CONSOLE_RECHARGING)
					to_chat(usr, span_warning("Shuttle engines are not ready for use."))
					return
				if (SHUTTLE_CONSOLE_INTRANSIT)
					to_chat(usr, span_warning("Shuttle already in transit."))
					return
				if (SHUTTLE_CONSOLE_DESTINVALID)
					to_chat(usr, span_warning("Invalid destination."))
					return
				if (SHUTTLE_CONSOLE_ERROR)
					to_chat(usr, span_warning("Unable to comply."))
					return
				if (SHUTTLE_CONSOLE_SUCCESS)
					return TRUE //No chat message here because the send_shuttle proc makes the console itself speak
		if("set_destination")
			var/target_destination = params["destination"]
			if(target_destination)
				destination = target_destination
				return TRUE
		if("request")
			if(!COOLDOWN_FINISHED(src, request_cooldown))
				to_chat(usr, span_warning("CentCom is still processing last authorization request!"))
				return
			COOLDOWN_START(src, request_cooldown, 1 MINUTES)
			to_chat(usr, span_notice("Your request has been received by CentCom."))
			to_chat(GLOB.admins, "<b>SHUTTLE: <font color='#3d5bc3'>[ADMIN_LOOKUPFLW(usr)] (<A HREF='?_src_=holder;[HrefToken()];move_shuttle=[shuttleId]'>Move Shuttle</a>)(<A HREF='?_src_=holder;[HrefToken()];unlock_shuttle=[REF(src)]'>Lock/Unlock Shuttle</a>)</b> is requesting to move or unlock the shuttle.</font>")
			return TRUE

/obj/machinery/computer/shuttle/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	req_access = list()
	obj_flags |= EMAGGED
	balloon_alert(user, "id checking system fried")
	return TRUE

/obj/machinery/computer/shuttle/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	if(!mapload)
		return
	if(!port)
		return
	//Remove old custom port id and ";;"
	var/find_old = findtextEx(possible_destinations, "[shuttleId]_custom")
	if(find_old)
		possible_destinations = replacetext(replacetextEx(possible_destinations, "[shuttleId]_custom", ""), ";;", ";")
	shuttleId = port.shuttle_id
	possible_destinations += ";[port.shuttle_id]_custom"

#undef SHUTTLE_CONSOLE_ACCESSDENIED
#undef SHUTTLE_CONSOLE_ENDGAME
#undef SHUTTLE_CONSOLE_RECHARGING
#undef SHUTTLE_CONSOLE_INTRANSIT
#undef SHUTTLE_CONSOLE_DESTINVALID
#undef SHUTTLE_CONSOLE_SUCCESS
#undef SHUTTLE_CONSOLE_ERROR
