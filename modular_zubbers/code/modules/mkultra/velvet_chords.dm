/obj/item/organ/vocal_cords/velvet
	name = "velvet chords"
	desc = "The voice from these want to make you drift off, sleep, and obey"
	icon = 'modular_zubbers/icons/obj/vocal_cords.dmi'
	icon_state = "velvet_chords"
	actions_types = list(/datum/action/item_action/organ_action/velvet)
	spans = list("velvet")

/datum/action/item_action/organ_action/velvet
	name = "Velvet Chords"
	var/obj/item/organ/vocal_cords/velvet/chords

/datum/action/item_action/organ_action/velvet/New(Target)
	. = ..()
	chords = Target

/datum/action/item_action/organ_action/velvet/Trigger(mob/clicker, trigger_flags)
	. = ..()
	var/command = input(owner, "Speak in a sultry tone.", "Command")
	if(!command)
		return FALSE
	if(QDELETED(src) || QDELETED(owner))
		return FALSE
	owner.say(".x[command]")
	for(var/mob/living/people in get_hearers_in_view(DEFAULT_VIEW_RANGE, owner))
		var/datum/status_effect/mkultra/status
		if(people.has_status_effect(/datum/status_effect/mkultra))
			status.listener(owner, command)



