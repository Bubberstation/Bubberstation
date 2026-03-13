
///Interlink-specific airlocks that gate you if you're still a newbie (to prevent getting lost and confused as a first impressioon)
/obj/machinery/door/airlock/interlink_access
	resistance_flags = INDESTRUCTIBLE

///Item pass to get early access (given via admin request)
/obj/item/interlink_key
	name = "Interlink access pass"
	desc = "A pass giving early access to Nanotrasen's private lounge planet. New employees may request this pass to their employers."
	icon = 'icons/obj/fluff/puzzle_small.dmi'
	icon_state = "keycard"
	color = "#46daff"

/obj/machinery/door/airlock/interlink_access/bumpopen(mob/user)
	if(user_has_interlink_access(user))
		return ..()

/obj/machinery/door/airlock/interlink_access/Bumped(atom/movable/AM)
	if(istype(AM, /mob/living))
		return ..()

/obj/machinery/door/airlock/interlink_access/try_to_activate_door(mob/living/user, access_bypass = FALSE)
	if(user_has_interlink_access(user))
		return ..()

/obj/machinery/door/airlock/interlink_access/proc/user_has_interlink_access(mob/user)
	if(!isnull(user) && !isnull(user.client))
		if (user.client.get_exp_living(pure_numeric = TRUE) > CONFIG_GET(number/newbie_hours_threshold) * 60 || (!isnull(user.contents) && is_path_in_list(/obj/item/interlink_key, user.contents)) || unrestricted_side(user))
			return TRUE

	if(airlock_state == AIRLOCK_CLOSED)
		to_chat(user, span_notice("You may only access the company's private lounge planet after working for a life total of [CONFIG_GET(number/newbie_hours_threshold)] hours! You have currently worked for [user.client.get_exp_living(pure_numeric = TRUE) / 60.0] hours. You may ask another crew member for their access, or adminhelp to request an interlink key. But for now, we recommend playing on the station."))
		run_animation(DOOR_DENY_ANIMATION)
	return FALSE


/obj/machinery/door/airlock/interlink_access/public
	name = "public airlock"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station2/glass.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station2/overlays.dmi'

/obj/machinery/door/airlock/interlink_access/public/glass
	name = "public glass airlock"
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/interlink_access/security
	name = "security airlock"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/security.dmi'

/obj/machinery/door/airlock/interlink_access/security/glass
	name = "security glass airlock"
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/interlink_access/medical
	name = "medical airlock"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/medical.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_med

/obj/machinery/door/airlock/interlink_access/medical/glass
	name = "medical glass airlock"
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/interlink_access/service
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/service.dmi'

/obj/machinery/door/airlock/interlink_access/service/glass
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/interlink_access/bathroom
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/bathroom.dmi'

/obj/machinery/door/airlock/interlink_access/corporate
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/corporate.dmi'

/obj/machinery/door/airlock/interlink_access/corporate/glass
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/interlink_access/freezer
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/freezer.dmi'

/obj/machinery/door/airlock/interlink_access/centcom //Use grunge as a station side version, as these have special effects related to them via phobias and such.
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/centcom/centcom.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/centcom/overlays.dmi'
	can_be_glass = FALSE

/obj/machinery/door/airlock/interlink_access/multi_tile
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/multi_tile/glass.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/multi_tile/glass_overlays.dmi'
	multi_tile = TRUE
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/interlink_access/multi_tile/setDir(newdir)
	. = ..()
	set_bounds()
