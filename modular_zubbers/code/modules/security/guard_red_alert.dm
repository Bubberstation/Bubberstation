/datum/id_trim/job/guard
	/// Original normal access lists for guard IDs temporarily boosted by red alert.
	var/list/red_alert_original_access_by_id = list()

/datum/id_trim/job/guard/New()
	. = ..()
	RegisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED, PROC_REF(on_security_level_changed))
	if(SSsecurity_level?.get_current_level_as_number() >= SEC_LEVEL_RED)
		apply_red_alert_access_to_trim()

/datum/id_trim/job/guard/Destroy()
	UnregisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED)
	red_alert_original_access_by_id = null
	return ..()

/datum/id_trim/job/guard/proc/on_security_level_changed(datum/source, new_level)
	SIGNAL_HANDLER

	refresh_trim_access()
	if(new_level >= SEC_LEVEL_RED)
		apply_red_alert_access_to_current_guard_ids()
	else
		restore_red_alert_access_to_guard_ids()

/datum/id_trim/job/guard/proc/apply_red_alert_access_to_trim()
	if(SSsecurity_level?.get_current_level_as_number() < SEC_LEVEL_RED)
		return
	access |= extra_access

/datum/id_trim/job/guard/proc/apply_red_alert_access_to_current_guard_ids()
	for(var/mob/living/player in GLOB.player_list)
		if(!is_department_guard(player))
			continue

		var/obj/item/card/id/id_card = player.get_idcard(FALSE)
		if(!id_card || id_card.trim != src)
			continue

		apply_red_alert_access_to_guard_id(id_card)

/datum/id_trim/job/guard/proc/apply_red_alert_access_to_guard_id(obj/item/card/id/id_card)
	if(!id_card)
		return

	if(!(id_card in red_alert_original_access_by_id))
		red_alert_original_access_by_id[id_card] = id_card.access.Copy()

	id_card.access |= extra_access

/datum/id_trim/job/guard/proc/restore_red_alert_access_to_guard_ids()
	var/list/restored_ids = list()
	for(var/obj/item/card/id/id_card as anything in red_alert_original_access_by_id)
		if(!QDELETED(id_card))
			var/list/original_access = red_alert_original_access_by_id[id_card]
			id_card.access = original_access.Copy()
			restored_ids += id_card
		red_alert_original_access_by_id -= id_card

	for(var/mob/living/player in GLOB.player_list)
		if(!is_department_guard(player))
			continue

		var/obj/item/card/id/id_card = player.get_idcard(FALSE)
		if(!id_card || id_card.trim != src)
			continue
		if(id_card in restored_ids)
			continue

		id_card.access -= extra_access
