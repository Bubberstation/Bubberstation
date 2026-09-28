GLOBAL_LIST_INIT(department_guard_trims, typecacheof(list(
	/datum/id_trim/job/science_guard,
	/datum/id_trim/job/orderly,
	/datum/id_trim/job/engineering_guard,
	/datum/id_trim/job/customs_agent,
	/datum/id_trim/job/bouncer,
)))

/// Returns the WARRANT_AUTH_* tier granted by the user's worn or held ID.
/proc/get_warrant_authority(mob/living/carbon/human/user)
	var/obj/item/card/id/id_card = user.get_idcard(hand_first = FALSE)
	if(!id_card)
		return WARRANT_AUTH_NONE
	var/list/access = id_card.GetAccess()
	if((ACCESS_CAPTAIN in access) || (ACCESS_HOS in access))
		return WARRANT_AUTH_COMMAND
	if(id_card.trim && is_type_in_typecache(id_card.trim, GLOB.department_guard_trims))
		return WARRANT_AUTH_GUARD
	if(ACCESS_SECURITY in access)
		return WARRANT_AUTH_SECURITY
	return WARRANT_AUTH_NONE

/**
 * Whether death warrants may currently be issued. Amber alert or above.
 * The clown is exempt from the alert requirement. Provoking someone into killing you is the height
 * of the craft, and command has long since stopped pretending otherwise.
 */
/proc/death_warrants_active(datum/record/crew/target)
	if(istype(target) && (target.trim == JOB_CLOWN || target.rank == JOB_CLOWN))
		return TRUE
	return SSsecurity_level.get_current_level_as_number() >= SEC_LEVEL_AMBER

/// Distributes a wanted order over the newscaster network and announces it stationwide.
/proc/distribute_wanted_order(datum/record/crew/target, stated_reason, mob/living/issuer)
	if(GLOB.news_network)
		var/datum/picture/photo
		var/obj/item/photo/front = target.get_front_photo()
		if(istype(front))
			photo = front.picture
		GLOB.news_network.submit_wanted(target.name, "DEATH WARRANT: [stated_reason]", issuer?.real_name, photo, newMessage = TRUE)

	priority_announce(
		text = "A death warrant has been issued for [target.name] on the following grounds: \"[stated_reason]\" \
			The subject is classified as an uncontainable hostile. All security personnel are authorized to use lethal force on sight. \
			Crew are advised to avoid the subject and report sightings immediately.",
		title = "Wanted Order Distributed",
		sound = 'sound/announcer/announcement/announce_dig.ogg',
		sender_override = "Nanotrasen Security Warrant Authority",
		has_important_message = TRUE,
		color_override = "red",
	)
	log_game("A death warrant was distributed against [target.name] by [key_name(issuer)]. Stated grounds: [stated_reason]")

/**
 * Runs the guard's incident-report flow when they raise an Alert: pick a category, then optionally add a note.
 * Returns the composed detail string ("[category]: [note] (reported by [role])"), or null if they cancelled.
 */
/proc/build_alert_incident(mob/living/carbon/human/reporter)
	var/category = tgui_input_list(reporter, "What kind of incident is this?", "Security Alert", ALERT_REASONS())
	if(!category || QDELETED(reporter))
		return null
	var/note = tgui_input_text(reporter, "Add a short note (optional).", "Security Alert", max_length = WARRANT_REASON_MAX_LENGTH)
	if(QDELETED(reporter))
		return null
	var/role = reporter.get_assignment(if_no_id = "an unknown party", if_no_job = "an unknown party")
	if(note)
		return "[category]: [note] (reported by [role])"
	return "[category] (reported by [role])"

/// Records an Alert or death warrant on the target's crime list, so the status leaves an accountable paper trail.
/proc/log_warrant_status_change(datum/record/crew/target, new_status, mob/setter, reason)
	var/setter_name = "Security Warrant Authority"
	if(ishuman(setter))
		var/mob/living/carbon/human/human_setter = setter
		setter_name = human_setter.get_authentification_name()
	var/datum/crime/logged
	if(new_status == WANTED_EXECUTE)
		logged = new /datum/crime(name = "Death Warrant", details = target.death_warrant_reason || "No grounds stated.", author = setter_name)
		logged.warrant_kind = "execute"
	else
		logged = new /datum/crime(name = "Security Alert", details = reason || "Flagged for questioning.", author = setter_name)
		logged.warrant_kind = "alert"
	target.crimes += logged
