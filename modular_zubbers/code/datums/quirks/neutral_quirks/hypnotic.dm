/datum/quirk/hypnotic
	name = "Hypnotic"
	desc = "You are extremely captivating to people who might be suspectable to fall into a stupor"
	icon = "face-grin-hearts"
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_HIDE_FROM_SCAN
	gain_text = "Your presence grows richer."
	lose_text = "Your potent presence dulls."
	erp_quirk = TRUE
	var/hypnotic_text = "Their eyes are extremely captivating"
	var/hypnotic_color

/datum/quirk/hypnotic/add(client/client_source)
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_MOB_EXAMINING, PROC_REF(on_examine))
	hypnotic_text = client_source?.prefs.read_preference(/datum)

/datum/quirk/hypnotic/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_MOB_EXAMINING)

/datum/quirk/hypnotic/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/mob/living/examinee = user
	if(!istype(user))
		return
	//if(quirk_holder == examinee)
	//	return
	if(!(examinee.client?.prefs.read_preference(/datum/preference/toggle/master_erp_preferences) && examinee.client.prefs.read_preference(/datum/preference/toggle/erp/hypnosis)))
		return
	if(examinee.stat == DEAD)
		return
	examine_list += span_hypnophrase("[hypnotic_text]")

/datum/quirk_constant_data/hypnotic
	associated_typepath = /datum/quirk/hypnotic
	customization_options = list(
		/datum/preference/text/hypnotic_text,
		/datum/preference/choiced/hypnotic_span,
	)

/datum/preference/text/hypnotic_text

/datum/preference/choiced/hypnotic_span
