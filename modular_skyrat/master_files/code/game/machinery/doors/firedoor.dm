/obj/machinery/door/firedoor/AltClick(mob/user)
	. = ..()
	if(!user.can_perform_action(src))
		return
	try_manual_override(user)

/obj/machinery/door/firedoor/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click the door to use the manual override.")

/obj/machinery/door/proc/try_manual_override(mob/user)
	if(density && !welded && !operating)
		balloon_alert(user, "opening...")
		if(do_after(user, 5 SECONDS, target = src)) //BUBBERSTATION CHANGE: 10 SECONDS TO 5 SECONDS.
			try_to_crowbar_secondary(null,user) // BUBBERSTATION CHANGE: FIXES TG/SKYRAT FIREDOOR CONFLICT.
			return TRUE
	return FALSE

/* BUBBERSTATION CHANGE START: FIXES TG/SKYRAT FIREDOOR CONFLICT.
/obj/machinery/door/firedoor/try_to_crowbar(obj/item/used_object, mob/user)
	if(welded || operating)
		balloon_alert(user, "opening failed!")
		return

	if(density)
		open()
	else
		close()
BUBBERSTATION CHANGE END: FIXES TG/SKYRAT FIREDOOR CONFLICT. */

/obj/machinery/door/firedoor/heavy/closed
	icon_state = "door_closed"
	density = TRUE
	alarm_type = FIRELOCK_ALARM_TYPE_GENERIC

/obj/machinery/door/firedoor/solid
	name = "solid emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'modular_skyrat/modules/aesthetics/firedoor/icons/firedoor.dmi'
	glass = FALSE

/obj/machinery/door/firedoor/solid/closed
	icon_state = "door_closed"
	density = TRUE
	opacity = TRUE
	alarm_type = FIRELOCK_ALARM_TYPE_GENERIC

