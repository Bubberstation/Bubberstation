/datum/mkultra_command/say_my_name
	name = "Say my name"
	description = "Make someone say your name."
	trigger = "say my name|who am i"
	phase_requirement = 1
	cooldown = 30 SECONDS

/datum/mkultra_command/say_my_name/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	var/datum/status_effect/mkultra/ultra = status
	if(ultra.lewd)
		owner.say("[ultra.get_gender()]")
	else
		owner.say("[source]")
	return TRUE
