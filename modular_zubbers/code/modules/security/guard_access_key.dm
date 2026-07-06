/obj/item/access_key/guard
	name = "department guard access key ring"
	desc = "A key ring issued to department guards for deliberate access to restricted departmental rooms."
	/// Access added to the user's ID access while using this key on a door.
	var/list/guard_access = list()
	/// How long it takes to open a door with this key.
	var/use_time = 5 SECONDS

/obj/item/access_key/guard/Initialize(mapload)
	. = ..()
	UnregisterSignal(SSdcs, COMSIG_ON_DEPARTMENT_ACCESS)
	GLOB.janitor_devices -= src

/obj/item/access_key/guard/examine(mob/user)
	. = ..()
	if(length(guard_access))
		. += span_notice("It is configured for: [english_list(guard_access)].")

/obj/item/access_key/guard/examine_more(mob/user)
	. = ..()
	. -= span_notice("Access can be granted through a Keycard Authentication Device.")
	. -= span_notice("This access is limited to one department at a time.")
	. += span_notice("Use it on an airlock to slowly try its configured departmental access.")

/obj/item/access_key/guard/attempt_open_door(mob/living/user, obj/machinery/door/airlock/airlock)
	if(DOING_INTERACTION_WITH_TARGET(user, airlock))
		return

	user.balloon_alert_to_viewers("fumbles with keys...", "finding key...")
	user.playsound_local(src, 'sound/items/rattling_keys.ogg', 25, TRUE)
	if(!do_after(user, use_time, airlock))
		return FALSE

	var/list/combined_access = guard_access.Copy()
	var/obj/item/card/id/id_card = user.get_idcard()
	if(id_card)
		combined_access |= id_card.GetAccess()

	if(!length(guard_access) || !airlock.check_access_list(combined_access))
		airlock.balloon_alert(user, "no access!")
		return FALSE

	return airlock.try_to_activate_door(user, access_bypass = TRUE)

/obj/item/access_key/guard/science
	name = "science guard access key ring"
	guard_access = list(
		ACCESS_AUX_BASE,
		ACCESS_GENETICS,
		ACCESS_ORDNANCE,
		ACCESS_ORDNANCE_STORAGE,
		ACCESS_ROBOTICS,
		ACCESS_TECH_STORAGE,
		ACCESS_XENOBIOLOGY,
	)

/obj/item/access_key/guard/medical
	name = "orderly access key ring"
	guard_access = list(
		ACCESS_MORGUE,
		ACCESS_PARAMEDIC,
		ACCESS_PHARMACY,
		ACCESS_PLUMBING,
		ACCESS_SURGERY,
		ACCESS_VIROLOGY,
		ACCESS_MORGUE_SECURE,
		ACCESS_PSYCHOLOGY,
	)

/obj/item/access_key/guard/engineering
	name = "engineering guard access key ring"
	guard_access = list(
		ACCESS_AUX_BASE,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_TCOMMS,
	)

/obj/item/access_key/guard/cargo
	name = "customs agent access key ring"
	guard_access = list(
		ACCESS_BLACKSMITH,
		ACCESS_MINING_STATION,
		ACCESS_BIT_DEN,
		ACCESS_MINING,
	)

/obj/item/access_key/guard/service
	name = "bouncer access key ring"
	guard_access = list(
		ACCESS_MORGUE,
		ACCESS_THEATRE,
		ACCESS_JANITOR,
	)
