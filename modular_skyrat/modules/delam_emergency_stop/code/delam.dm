/obj/machinery/power/supermatter_crystal
	/// If admins and the station have been notified according to the delam suppression function
	var/station_notified = FALSE

/**
 * Send a single notification when the main engine integrity is 40% or lower.
 * If the round timer is under 30 minutes, we notify admins about
 * the automated delam suppression system, cause it'll trigger.
*/
/datum/sm_delam/proc/notify_delam_suppression(obj/machinery/power/supermatter_crystal/sm)
	if(!sm.is_main_engine)
		return

	if(sm.station_notified)
		return

	SSsecurity_level.minimum_security_level(SEC_LEVEL_ORANGE, TRUE, FALSE)
	var/obj/machinery/announcement_system/system = pick(GLOB.announcement_systems)
	system.broadcast("Danger! Crystal hyperstructure integrity faltering! Integrity: [round(sm.get_integrity_percent(), 0.01)]%", list(RADIO_CHANNEL_COMMAND), list(SPAN_COMMAND))
	sm.station_notified = TRUE

	if(world.time - SSticker.round_start_time > 30 MINUTES)
		return

	log_admin("DELAM: Round timer under 30 minutes! Supermatter will perform an automatic delam suppression at strength 0%.")
	for(var/client/staff as anything in GLOB.admins)
		if(staff?.prefs.read_preference(/datum/preference/toggle/comms_notification))
			SEND_SOUND(staff, sound('sound/misc/server-ready.ogg'))
	message_admins("<font color='[COLOR_ADMIN_PINK]'>DELAM: Round timer under 30 minutes! [ADMIN_VERBOSEJMP(sm)] will perform an automatic delam suppression once integrity reaches 0%. (<a href='byond://?src=[REF(src)];togglesuppression=yes'>TOGGLE AUTOMATIC INTERVENTION)</a>)</font>")

/datum/sm_delam/Topic(href, href_list)
	if(..())
		return

	if(!check_rights(R_FUN))
		return

	if(href_list["togglesuppression"])
		usr.client?.toggle_delam_suppression()

/**
 * Check if the station manifest has at least a certain amount of this staff type
 *
 * Arguments:
 * * crew_threshold - amount of crew before it's no longer considered a skeleton crew
 *
*/
/datum/controller/subsystem/job/proc/is_skeleton_engineering(crew_threshold)
	var/engineers = 0
	for(var/datum/record/crew/target in GLOB.manifest.general)
		if(target.trim == JOB_CHIEF_ENGINEER)
			return FALSE

		if(target.trim == JOB_STATION_ENGINEER)
			engineers++

		if(target.trim == JOB_ATMOSPHERIC_TECHNICIAN)
			engineers++

	if(engineers > crew_threshold)
		return FALSE

	return TRUE
