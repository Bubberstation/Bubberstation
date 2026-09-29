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

/// TRUE when this person is wearing emagged sechuds, which scrub their name off anything they file.
/// Only affects the IC-visible record. investigate_log and the admin logs still name the real culprit.
/proc/warrant_attribution_scrubbed(mob/living/carbon/human/user)
	if(!ishuman(user))
		return FALSE
	var/obj/item/clothing/glasses/hud/security/shades = user.glasses
	return istype(shades) && (shades.obj_flags & EMAGGED)

/// A junk name for a scrubbed record. Rolled per entry, so repeat offenders do not leave a consistent signature.
/proc/scrubbed_warrant_attribution()
	return pick(WARRANT_ANONYMOUS_REPORTERS())

/// Whether this person carries the authority to file a death warrant. Captain, Head of Security and Warden hold it by default.
/proc/has_death_warrant_authority(mob/living/carbon/human/user)
	if(!ishuman(user))
		return FALSE
	var/obj/item/card/id/id_card = user.get_idcard(hand_first = FALSE)
	if(!id_card)
		return FALSE
	return (ACCESS_DEATH_WARRANT in id_card.GetAccess())

/// Whether death warrants may currently be issued. Amber alert or above.
/// The clown is exempt from the alert requirement, for reasons command stopped questioning years ago.
/proc/death_warrants_active(datum/record/crew/target)
	if(istype(target) && (target.trim == JOB_CLOWN || target.rank == JOB_CLOWN))
		return TRUE
	return SSsecurity_level.get_current_level_as_number() >= SEC_LEVEL_AMBER

/// Distributes a wanted order over the newscaster network and announces it stationwide.
/proc/distribute_wanted_order(datum/record/crew/target, stated_reason, mob/living/issuer)
	var/filed_by = issuer?.real_name || "Nanotrasen Security Warrant Authority"
	if(ishuman(issuer) && warrant_attribution_scrubbed(issuer))
		filed_by = scrubbed_warrant_attribution()
	if(GLOB.news_network)
		var/datum/picture/photo
		var/obj/item/photo/front = target.get_front_photo()
		if(istype(front))
			photo = front.picture
		GLOB.news_network.submit_wanted(target.name, "DEATH WARRANT: [stated_reason]", filed_by, photo, newMessage = TRUE)
		// The headline carries the severity, the form field carries the bare offence.
		GLOB.news_network.wanted_issue.criminal_activity = stated_reason

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

/// Runs the incident-report flow for an Alert: pick a category, then optionally add a note.
/// Returns the composed detail string, or null if they cancelled.
/proc/build_alert_incident(mob/living/carbon/human/reporter)
	var/category = tgui_input_list(reporter, "What kind of incident is this?", "Security Alert", ALERT_REASONS())
	if(!category || QDELETED(reporter))
		return null
	var/note = tgui_input_text(reporter, "Add a short note (optional).", "Security Alert", max_length = WARRANT_REASON_MAX_LENGTH)
	if(QDELETED(reporter))
		return null
	var/role = warrant_attribution_scrubbed(reporter) ? scrubbed_warrant_attribution() : reporter.get_assignment(if_no_id = "an unknown party", if_no_job = "an unknown party")
	if(note)
		return "[category]: [note] (reported by [role])"
	return "[category] (reported by [role])"

/// Records an Alert or death warrant on the target's crime list.
/proc/log_warrant_status_change(datum/record/crew/target, new_status, mob/setter, reason, source = "SecHUD")
	var/setter_name = "Security Warrant Authority"
	if(ishuman(setter))
		var/mob/living/carbon/human/human_setter = setter
		setter_name = warrant_attribution_scrubbed(human_setter) ? scrubbed_warrant_attribution() : human_setter.get_authentification_name()
	var/datum/crime/logged
	if(new_status == WANTED_EXECUTE)
		logged = new /datum/crime(name = "Death Warrant", details = target.death_warrant_reason || "No grounds stated.", author = setter_name)
		logged.warrant_kind = "execute"
	else if(reason)
		logged = new /datum/crime(name = "Security Alert", details = reason, author = setter_name)
		logged.warrant_kind = "alert"
	else
		// Nobody filled the incident form. File it the way a SecHUD arrest does, but keep the marker so it still reads as an Alert.
		logged = new /datum/crime(details = "Set by [source].", author = setter_name)
		logged.warrant_kind = "alert"
	target.crimes += logged
