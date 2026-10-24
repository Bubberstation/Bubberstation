#define GRACE_PERIOD 45 MINUTES
#define LONEOP_DELAY 3

/obj/item/disk/nuclear/unsecured_process(last_move)
	//If there is no assigned captain, then don't run the event.
	if(!SSjob || !SSjob.assigned_captain)
		return

	if(last_move < world.time - GRACE_PERIOD)
		begin_nuclear_assault()

/obj/item/disk/nuclear/proc/begin_nuclear_assault()
	priority_announce(
		"ALERT:::SYNDICATE TRANSMISSION DETECTED:::NUCLEAR AUTHENTICATION DISK LOCATION PINPOINTED:::EXPECT IMMINENT NUCLEAR STRIKE - \
		ETA [LONEOP_DELAY] MINUTES.\
		\n\
		\n\
		SUGGESTION:::THROW ROCKS AT YOUR CAPTAIN.",
		"MILCOM Early Warning System",
		'modular_zubbers/sound/alerts/power_surge.ogg',
		has_important_message = TRUE,
		color_override = "red"
	)

	var/datum/component/keep_me_secure/our_component = GetComponent(/datum/component/keep_me_secure)
	our_component.last_move = world.time

	addtimer(CALLBACK(src, PROC_REF(spawn_loneop)), LONEOP_DELAY MINUTES)
	addtimer(CALLBACK(src, PROC_REF(delayed_alert)), 30 SECONDS)
	message_admins("Lone operative queued up for [LONEOP_DELAY] minutes from now due to the nuke disk being unsecured.")

/obj/item/disk/nuclear/proc/delayed_alert()
	priority_announce( "The security level has been elevated by Central Command.\
	\n\
	\n\
	An imminent high-speed insertion has been detected. The signtature matches common identifiers typically found with solo Syndicate nuclear operative deployments. \
	No chances can be taken. Immediate crew action and preparation is expected. Any present command staff are highly encouraged to secure the Nuclear Authentication Disk.",
	"Central Command Nuclear Operations", 'sound/announcer/notice/notice3.ogg',
	has_important_message = TRUE, color_override = "red")
	SSsecurity_level.set_level(SEC_LEVEL_RED, announce = FALSE)

/obj/item/disk/nuclear/proc/spawn_loneop()
	var/datum/round_event_control/operative/loneop = locate(/datum/round_event_control/operative) in SSgamemode.control
	if (!istype(loneop))
		return
	loneop.run_event(FALSE, event_cause = "the nuke disc being unsecured")

/datum/antagonist/nukeop/lone/on_gain()
	. = ..()

	var/datum/component/uplink/uplink = owner.find_syndicate_uplink()
	uplink?.uplink_handler?.telecrystals += 5 // extra for the warning

#undef GRACE_PERIOD
#undef LONEOP_DELAY
