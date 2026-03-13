/datum/trigger_type/remote_controlled
	var/ui_type = "button"
	var/del_on_use = FALSE
	var/active = FALSE
	var/name = "Remote Trigger"
	var/datum/computer_file/program/trigger_control/linked_program

/datum/trigger_type/remote_controlled/New(atom/_parent, _key, list/extra_args = null)
	. = ..()
	var/obj/machinery/modular_computer/comp = parent
	var/datum/computer_file/program/trigger_control/prog = locate() in comp?.cpu?.stored_files
	if(prog)
		linked_program = prog
		prog.register_trigger(trigger_key, src)
	else
		qdel(src)

/datum/trigger_type/remote_controlled/parse_extra_args(trigger_name, trigger_ui_type, trigger_del_on_use)
	ui_type = trigger_ui_type
	name = trigger_name
	del_on_use = trigger_del_on_use

/datum/trigger_type/remote_controlled/Destroy()
	if(linked_program && trigger_key)
		linked_program.unregister_trigger(trigger_key)
	return ..()

/datum/trigger_type/remote_controlled/proc/toggle(new_state)
	active = new_state
	if(active)
		subscribe_to_parent()
	else
		unsubscribe_from_parent()

/datum/trigger_type/remote_controlled/trigger(datum/source, list/arguments)
	. = ..()
	if(del_on_use)
		qdel(src)


/obj/effect/mapping_helpers/trigger_helper/programm_trigger
	del_on_use = FALSE

	trigger_type = /datum/trigger_type/remote_controlled
	var/EDITOR_trigger_name = "Action"
	var/EDITOR_trigger_ui_type = "button"
	var/EDITOR_trigger_del_on_use = FALSE

/obj/effect/mapping_helpers/trigger_helper/programm_trigger/Initialize(mapload)
	for(var/atom/AM in loc)
		if(istype(AM, /obj/machinery/modular_computer))
			EDITOR_TARGET = AM.type
	extra_params = list(
		"trigger_name" = EDITOR_trigger_name,
		"trigger_ui_type" = EDITOR_trigger_ui_type,
		"trigger_del_on_use" = EDITOR_trigger_del_on_use,
	)
	..()
