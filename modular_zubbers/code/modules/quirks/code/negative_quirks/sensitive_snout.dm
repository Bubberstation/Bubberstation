/datum/quirk/sensitivesnout
	value = -2

/datum/quirk/sensitivesnout/post_add()
	quirk_holder.apply_status_effect(/datum/status_effect/sensitivesnout)

/datum/quirk/sensitivesnout/remove()
	quirk_holder.remove_status_effect(/datum/status_effect/sensitivesnout)

/datum/status_effect/sensitivesnout
	id = "sensitivesnout"
	duration = -1
	alert_type = null

/datum/status_effect/sensitivesnout/get_examine_text()
	return span_warning("[owner.p_Their()] snout is rather bappable...")
