/datum/phystool_mode
	var/name = "Defualt mode"
	var/desc = "Coder button."
	var/obj/item/phystool/our_tool


/datum/phystool_mode/proc/on_selected(mob/user)
	to_chat(user, span_notice(desc))

/datum/phystool_mode/proc/main_act(atom/target, mob/user)

/datum/phystool_mode/proc/secondnary_act(atom/target, mob/user)

/datum/phystool_mode/proc/use_act(mob/user)
