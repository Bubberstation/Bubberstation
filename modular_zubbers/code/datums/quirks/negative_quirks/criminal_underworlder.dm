/datum/quirk/criminal_underworlder
	name = "Criminal Underworlder"
	desc = "You have documented criminal connections and experience 'encountering' the law which makes you able to exploit others."
	value = 0
	medical_record_text = "Patient has been observed to have an inclination towards run-ins with the law."
	security_record_text = "Person is known to have previous connections with criminals. DO NOT provide them with firearms or weapons!"
	icon = FA_ICON_PEOPLE_ROBBERY

/datum/quirk/criminal_underworlder/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.mind?.has_exploitables_override = TRUE
	human_holder.mind.handle_exploitables()

/datum/quirk/criminal_underworlder/post_add()
	var/criminal_underworlder_policy = get_policy("[type]") || "Please note that while you may be a [LOWER_TEXT(name)], this does NOT give you any additional right to attack people or cause chaos."
	// We shouldn't need this, but it prevents people using it as a dumb excuse in ahelps.
	to_chat(quirk_holder, span_big(span_info(criminal_underworlder_policy)))
