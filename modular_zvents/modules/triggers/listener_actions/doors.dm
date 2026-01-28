
/datum/listener_type/open_door
/datum/listener_type/open_door/apply_action(datum/trigger_type/trigger, list/extra_args)
	if(istype(parent, /obj/machinery/door))
		var/obj/machinery/door/D = parent
		D.open()




/datum/listener_type/close_door
/datum/listener_type/close_door/apply_action(datum/trigger_type/trigger, list/extra_args)
	if(istype(parent, /obj/machinery/door))
		var/obj/machinery/door/D = parent
		D.close()



/datum/listener_type/toggle_door
/datum/listener_type/toggle_door/apply_action(datum/trigger_type/trigger, list/extra_args)
	if(istype(parent, /obj/machinery/door))
		var/obj/machinery/door/D = parent
		if(D.density)
			D.open()
		else
			D.close()



/obj/effect/mapping_helpers/listener_helper/open_door
	name = "Listener Helper - Open Door"
	listener_type = /datum/listener_type/open_door
	EDITOR_TARGET = /obj/machinery/door

/obj/effect/mapping_helpers/listener_helper/open_door/delete_after
	name = "Listener Helper - Open Door (Delete After)"
	delete_after = TRUE

/obj/effect/mapping_helpers/listener_helper/close_door
	name = "Listener Helper - Close Door"
	listener_type = /datum/listener_type/close_door
	EDITOR_TARGET = /obj/machinery/door

/obj/effect/mapping_helpers/listener_helper/close_door/delete_after
	name = "Listener Helper - Close Door (Delete After)"
	delete_after = TRUE

/obj/effect/mapping_helpers/listener_helper/toggle_door
	name = "Listener Helper - Toggle Door"
	listener_type = /datum/listener_type/toggle_door
	EDITOR_TARGET = /obj/machinery/door

/obj/effect/mapping_helpers/listener_helper/toggle_door/delete_after
	name = "Listener Helper - Toggle Door (Delete After)"
	delete_after = TRUE
