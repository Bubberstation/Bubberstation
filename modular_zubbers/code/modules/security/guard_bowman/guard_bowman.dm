//guard bowman headsets, issued to department guards instead of a plain dept headset
//can send one-way reports on the security channel through the announcement network, but carry no security key so they never hear it back

/datum/aas_config_entry/guard_report
	name = "Security: Department Guard Report"
	announcement_lines_map = list(
		"Message" = "Report from %PERSON, %DEPARTMENT, message as follows: %MESSAGE")
	vars_and_tooltips_map = list(
		"MESSAGE" = "the guard's report.",
		"PERSON" = "will be replaced with the reporting guard's name.",
		"DEPARTMENT" = "the guard's department.",
	)

/datum/aas_config_entry/guard_report/act_up()
	. = ..()
	if(.)
		return
	announcement_lines_map["Message"] = pick(
		"R#PORT FR*M \[NULL\]: B%@ TEXT DET#CTED",
		"incoming report... incoming report... incoming re-",
		"AAS.exe has encountered guard report and must close.")

/obj/item/radio/headset/guard_bowman
	name = "guard bowman headset"
	desc = "A bowman headset issued to department guards. It's designed to relay reports to Security, though you won't hear back any time soon."
	icon = 'modular_zubbers/icons/obj/devices/guard_bowman.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/guard_bowman_worn.dmi'
	icon_state = "guard_bowman"
	worn_icon_state = "guard_bowman"
	post_init_icon_state = "guard_bowman"
	greyscale_config = /datum/greyscale_config/guard_bowman
	greyscale_config_worn = /datum/greyscale_config/guard_bowman/worn
	greyscale_colors = COLOR_WHITE + COLOR_GRAY
	flags_1 = IS_PLAYER_COLORABLE_1
	//time between reports, tunable
	var/report_cooldown_time = 1 MINUTES
	//click played only on a successful sec report, kept separate from radiosound so normal dept chatter is unaffected
	var/report_sound = 'modular_skyrat/modules/kahraman_equipment/sound/morse_signal.wav'
	COOLDOWN_DECLARE(report_cooldown)

/obj/item/radio/headset/guard_bowman/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/radio/headset/guard_bowman/talk_into(atom/movable/talking_movable, message, channel, list/spans, datum/language/language, list/message_mods)
	if(channel != RADIO_CHANNEL_SECURITY)
		return ..()
	if(RADIO_CHANNEL_SECURITY in channels)
		//for if you get a real key
		return ..()

	if(!COOLDOWN_FINISHED(src, report_cooldown))
		balloon_alert_to_viewers("still recharging")
		return

	var/spoken_language = language || talking_movable.get_selected_language()
	if(spoken_language && !ispath(spoken_language, /datum/language/common) && !(obj_flags & EMAGGED))
		send_report(talking_movable, "\[UNINTELLIGIBLE\]")
		return

	send_report(talking_movable, message)

/obj/item/radio/headset/guard_bowman/proc/send_report(atom/movable/talking_movable, message)
	var/reporter = talking_movable.name
	var/department_name = get_reporting_department()
	var/body = message
	if(obj_flags & EMAGGED)
		reporter = scrambled_reporter()
		department_name = scrambled_department()
		body = scrambled_message()

	var/obj/machinery/announcement_system/announcer = get_announcement_system(/datum/aas_config_entry/guard_report, src, list(RADIO_CHANNEL_SECURITY))
	if(!announcer)
		balloon_alert_to_viewers("no response")
		return

	announcer.announce(/datum/aas_config_entry/guard_report, list(
		"PERSON" = reporter,
		"DEPARTMENT" = department_name,
		"MESSAGE" = body,
	), list(RADIO_CHANNEL_SECURITY))
	COOLDOWN_START(src, report_cooldown, report_cooldown_time)
	if(report_sound)
		playsound(talking_movable, report_sound, radio_sound_volume, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT)
	var/security_span = get_radio_span(GLOB.default_radio_channels[RADIO_CHANNEL_SECURITY])
	to_chat(talking_movable, "<span class='[security_span]'><span class='name'>\[Security\] The Automated Announcement System</span> coldly states, <span class='message robot'>\"Your message has been received.\"</span></span>")

//lets the bogus report through even with a real key installed
/obj/item/radio/headset/guard_bowman/click_alt(mob/user)
	if(!(obj_flags & EMAGGED))
		return NONE
	if(!COOLDOWN_FINISHED(src, report_cooldown))
		balloon_alert_to_viewers("still recharging")
		return CLICK_ACTION_BLOCKING
	send_report(user, "")
	return CLICK_ACTION_SUCCESS

/obj/item/radio/headset/guard_bowman/examine(mob/user)
	. = ..()
	if(!(item_flags & IN_INVENTORY) || loc != user)
		return
	if(obj_flags & EMAGGED)
		. += span_info("<b>Alt-click</b> to send a 'totally legitimate' report.")
	if(RADIO_CHANNEL_SECURITY in channels)
		return
	var/security_span = get_radio_span(GLOB.default_radio_channels[RADIO_CHANNEL_SECURITY])
	. += span_notice("<ul style='display:inline-block; margin: 0; list-style: square;'><li><b>[span_class(security_span, RADIO_TOKEN_SECURITY)]</b> to report an incident on the security channel</li></ul>")
	if(!get_announcement_system(/datum/aas_config_entry/guard_report, src, list(RADIO_CHANNEL_SECURITY)))
		. += span_warning("Its status display reads: ERROR")
	else if(!COOLDOWN_FINISHED(src, report_cooldown))
		. += span_notice("Its status display reads: It can send another message in [DisplayTimeText(COOLDOWN_TIMELEFT(src, report_cooldown))]!")
	else
		. += span_notice("Its status display reads: It can send a message right now.")

/obj/item/radio/headset/guard_bowman/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	if(obj_flags & EMAGGED)
		return .
	balloon_alert(user, "report filter disabled")
	playsound(src, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	obj_flags |= EMAGGED
	return TRUE

//overridden per subtype
/obj/item/radio/headset/guard_bowman/proc/get_reporting_department()
	return "an unknown department"

//biased toward the clown, but can pick any real crew member
/obj/item/radio/headset/guard_bowman/proc/scrambled_reporter()
	if(prob(50))
		var/manifest_pick = pick_manifest_reporter()
		if(manifest_pick)
			return manifest_pick
	return pick(
		"Bingus the Clown",
		"\[REDACTED\]",
		"the vending machine",
		"Officer Beepsky",
		"nobody",
		"a strange voice",
		"the station AI",
		"an unnamed source",
		"whoever's left",
		"a very confused mime",
		"the clown, again",
		"person unknown",
		"a shadow near the vents",
		"the last guy who asked",
		"somebody's ghost",
		"an anonymous tip",
		"the intern",
		"a suspicious raccoon",
		"no one in particular",
		"the last person to touch this headset",
		"unknown",
		"a potted plant",
		"static",
		"a masked figure",
		"the hamster",
		"a very tired ghost",
		"whoever's on shift",
		"an unlabeled crate",
		"a passing shadow",
		"the guy in the vents",
		"somebody",
	)

/obj/item/radio/headset/guard_bowman/proc/pick_manifest_reporter()
	if(!length(GLOB.manifest.general))
		return null
	var/list/clowns = list()
	for(var/datum/record/crew/target as anything in GLOB.manifest.general)
		if(target.rank == "Clown")
			clowns += target
	var/datum/record/crew/picked
	if(length(clowns))
		picked = prob(40) ? pick(clowns) : pick(GLOB.manifest.general)
		return picked.name
	if(prob(10))
		return pick("Bingus the Clown", "the clown, again")
	picked = pick(GLOB.manifest.general)
	return picked.name

/obj/item/radio/headset/guard_bowman/proc/scrambled_department()
	return pick(
		"Maintenance",
		"\[NO DATA\]",
		"Deep Space",
		"Centcom Catering",
		"Break Room",
		"Chapel Basement",
		"Arrivals",
		"Undisclosed Location",
		"Nowhere In Particular",
		"the vents",
		"a locker",
		"the ceiling",
		"wherever that smell is coming from",
		"a department that doesn't exist",
		"somewhere cold",
		"the bar",
		"behind you",
	)

/obj/item/radio/headset/guard_bowman/proc/scrambled_message()
	var/list/lines = list(
		"HELP AI ABSORBING ME MAINT",
		"the walls are talking again",
		"send more donuts, situation critical",
		"i can see through time",
		"there is a spider the size of a chair",
		"the captain is three clowns in a suit",
		"everything is fine everything is fine everything is",
		"who authorized the second sun",
		"the vending machine knows my name",
		"my badge is not my badge anymore",
		"i counted the lights and there are too many",
		"tell my department i said hi",
		"the moths have unionized",
		"i think i already reported this",
		"there's a second station and it's closer than it looks",
		"my reflection is running late",
		"the coffee machine is sentient and it's judging me",
		"someone keeps eating the evidence",
		"i don't remember requesting backup but here it is",
		"the clown filed this report, not me",
		"requesting immediate backup",
		"intruder alert, repeat, intruder alert",
		"hull breach in progress",
		"shots fired, officer down",
		"disregard my last report",
		"disregard my next report too",
		"my badge won't stop beeping",
		"the manifest has an extra name on it now",
		"i swore an oath and i intend to keep it",
		"nothing to report, just checking this thing works",
		"the ceiling is closer than it was yesterday",
		"someone photocopied my badge",
		"i heard a number station on this frequency once",
		"the lights spelled out a word and then stopped",
		"help maint",
	)
	var/list/place_lines = list(
		"send backup to %PLACE",
		"all units to %PLACE",
		"something is moving in %PLACE",
		"the clown has been spotted in %PLACE",
		"loud banging coming from %PLACE",
		"i'm trapped in %PLACE",
		"suspicious activity reported in %PLACE",
		"someone is crying in %PLACE",
		"shots fired in %PLACE",
		"do not go to %PLACE",
		"structural breach reported near %PLACE",
		"unauthorized access reported at %PLACE",
		"possible hostage situation in %PLACE",
		"fire reported near %PLACE",
		"screaming heard from %PLACE",
	)
	var/list/incident_lines = list(
		"%WHO stole from cargo",
		"bomb reported in %PLACE",
		"%WHO is threatening the crew",
		"%WHO assaulted an officer",
		"%WHO broke into %PLACE",
		"%WHO is resisting arrest",
		"found contraband on %WHO",
		"%WHO is trying to flee through %PLACE",
		"%WHO is causing a disturbance in %PLACE",
		"%WHO has a weapon",
		"requesting backup, %WHO is not cooperating",
		"%WHO was seen leaving %PLACE in a hurry",
		"%WHO tried to bribe me",
		"%WHO impersonated an officer",
		"%WHO won't stop talking about %PLACE",
	)
	var/list/culprits = list(
		"the clown",
		"an unmarked crate",
		"a floating skull",
		"someone in a mask",
		"the guy in the hat",
		"a raccoon",
		"the new hire",
		"person unknown",
		"the vending machine",
		"a very suspicious mime",
		"an off-duty assistant",
		"someone claiming to be the captain",
	)
	var/list/places = list(
		"the clown's anus",
		"the captain's anus",
		"an alternate dimension",
		"the gulag",
		"atmospherics",
		"hell",
		"a locker",
		"the vents",
		"my own skull",
		"the space between floors",
		"a closet that shouldn't exist",
		"behind the bar",
		"the bottom of the disposals chute",
		"a maintenance tunnel that loops forever",
		"the chef's walk-in freezer",
		"a hole that wasn't there yesterday",
		"the wrong side of a mirror",
		"the underside of the escape shuttle",
		"a shift that already ended",
		"Engineering",
		"the Bridge",
		"Medbay",
		"Arrivals",
		"Cargo Bay",
		"the Brig",
		"the Chapel",
		"Science",
	)
	var/roll = rand(1, 100)
	if(roll <= 35)
		var/who = prob(10) ? (pick_manifest_reporter() || pick(culprits)) : pick(culprits)
		var/incident = replacetext(pick(incident_lines), "%WHO", who)
		incident = replacetext(incident, "%PLACE", pick(places))
		return uppertext(incident)
	if(roll <= 65)
		return uppertext(replacetext(pick(place_lines), "%PLACE", pick(places)))
	return uppertext(pick(lines))

/obj/item/radio/headset/guard_bowman/science
	greyscale_colors = COLOR_WHITE + COLOR_SCIENCE_PINK
	keyslot = /obj/item/encryptionkey/headset_sci

/obj/item/radio/headset/guard_bowman/science/get_reporting_department()
	return "Science"

/obj/item/radio/headset/guard_bowman/medical
	greyscale_colors = COLOR_WHITE + COLOR_MEDICAL_BLUE
	keyslot = /obj/item/encryptionkey/headset_med

/obj/item/radio/headset/guard_bowman/medical/get_reporting_department()
	return "Medical"

/obj/item/radio/headset/guard_bowman/engineering
	greyscale_colors = COLOR_WHITE + COLOR_ENGINEERING_ORANGE
	keyslot = /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/guard_bowman/engineering/get_reporting_department()
	return "Engineering"

/obj/item/radio/headset/guard_bowman/cargo
	greyscale_colors = COLOR_WHITE + COLOR_CARGO_BROWN
	keyslot = /obj/item/encryptionkey/headset_cargo

/obj/item/radio/headset/guard_bowman/cargo/get_reporting_department()
	return "Cargo"

/obj/item/radio/headset/guard_bowman/service
	greyscale_colors = COLOR_WHITE + COLOR_SERVICE_LIME
	keyslot = /obj/item/encryptionkey/headset_service

/obj/item/radio/headset/guard_bowman/service/get_reporting_department()
	return "Service"

/datum/greyscale_config/guard_bowman
	name = "Guard Bowman Headset"
	icon_file = 'modular_zubbers/icons/obj/devices/guard_bowman.dmi'
	json_config = 'modular_zubbers/code/datums/greyscale/json_configs/guard_bowman.json'

/datum/greyscale_config/guard_bowman/worn
	name = "Guard Bowman Headset (Worn)"
	icon_file = 'modular_zubbers/icons/mob/clothing/guard_bowman_worn.dmi'
	json_config = 'modular_zubbers/code/datums/greyscale/json_configs/guard_bowman_worn.json'
