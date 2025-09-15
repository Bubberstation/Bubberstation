/obj/machinery/door/firedoor
	name = "emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. This one has a glass panel. It has a mechanism to open it with just your hands."
	icon = 'modular_zubbers/icons/obj/doors/doorfireglass.dmi'

/obj/machinery/door/firedoor/click_alt(mob/user)
	try_manual_override(user)
	return CLICK_ACTION_SUCCESS

/obj/machinery/door/firedoor/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click the door to use the manual override.")

/obj/machinery/door/firedoor/update_overlays()
	. = ..()
	if(istype(src, /obj/machinery/door/firedoor/border_only))
		return
	if(density) // if the door is closed, add the bottom blinking overlay -- and only if it's closed
		. += mutable_appearance(icon, "firelock_alarm_type_bottom")
		. += emissive_appearance(icon, "firelock_alarm_type_bottom", src, alpha = src.alpha)

/obj/machinery/door/firedoor/proc/try_manual_override(mob/user)
	if(density && !welded && !operating)
		balloon_alert(user, "opening...")
		if(do_after(user, 5 SECONDS, target = src))
			try_to_crowbar(null,user)
			return TRUE
	return FALSE

/obj/machinery/door/firedoor/animation_effects(animation, force_type)
	. = ..()
	switch(animation)
		if(DOOR_OPENING_ANIMATION, DOOR_CLOSING_ANIMATION)
			playsound(src, 'modular_zubbers/sound/machines/firedoor_open.ogg', 100, TRUE)

/obj/machinery/door/firedoor/closed
	alarm_type = FIRELOCK_ALARM_TYPE_GENERIC

/obj/machinery/door/firedoor/solid
	name = "solid emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'modular_zubbers/icons/obj/doors/doorfire.dmi'
	glass = FALSE

/obj/machinery/door/firedoor/solid/closed
	icon_state = "door_closed"
	density = TRUE
	opacity = TRUE
	alarm_type = FIRELOCK_ALARM_TYPE_GENERIC

/obj/machinery/door/firedoor/heavy
	name = "heavy emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'modular_zubbers/icons/obj/doors/doorfire.dmi'

/obj/machinery/door/firedoor/heavy/closed
	icon_state = "door_closed"
	density = TRUE
	alarm_type = FIRELOCK_ALARM_TYPE_GENERIC

/obj/effect/spawner/structure/window/reinforced/no_firelock
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile)
