
////  Toggles Selected quirks on selected mobs
/client/proc/toggle_quirk(mob/living/carbon/human/selected_mob)
	if (!istype(selected_mob))
		to_chat(usr, "This can only be used on /mob/living/carbon/human.")
		return

	var/list/options = list("Clear"="Clear")
	for(var/quirk_variable in subtypesof(/datum/quirk))
		var/datum/quirk/applicable_quirk = quirk_variable
		var/quirk_name = initial(applicable_quirk.name)
		options[selected_mob.has_quirk(applicable_quirk) ? "[quirk_name] (Remove)" : "[quirk_name] (Add)"] = applicable_quirk

	var/result = tgui_input_list(usr, "Choose quirk to add/remove", "Mob Quirks", options)

	if(QDELETED(selected_mob))
		to_chat(usr, "Mob doesn't exist anymore")
		return

	if(result)
		if(result == "Clear")
			for(var/datum/quirk/selected_quirk in selected_mob.quirks)
				selected_mob.remove_quirk(selected_quirk.type)
		else
			var/toggle_quirk = options[result]
			if(selected_mob.has_quirk(toggle_quirk))
				selected_mob.remove_quirk(toggle_quirk)
			else
				selected_mob.add_quirk(toggle_quirk,TRUE)

////  "Teaches" Martial arts to the selected mob
/client/proc/teach_martial_art(mob/living/carbon/selected_mob)
	if (!istype(selected_mob))
		to_chat(usr, "This can only be used on /mob/living/carbon.")
		return

	var/list/art_paths = subtypesof(/datum/martial_art)
	var/list/art_names = list()
	for(var/martial_art_skill in art_paths)
		var/datum/martial_art/martial_skill = martial_art_skill
		art_names[initial(martial_skill.name)] = martial_skill
	var/result = tgui_input_list(usr, "Choose the martial art to teach", "JUDO CHOP", art_names)
	if(isnull(result))
		return

	if(QDELETED(selected_mob))
		to_chat(usr, "Mob doesn't exist anymore")
		return
	if(result)
		var/chosen_art = art_names[result]
		var/datum/martial_art/martial_skill = new chosen_art
		martial_skill.teach(selected_mob)
		log_admin("[key_name(usr)] has taught [martial_skill] to [key_name(selected_mob)].")
		message_admins(span_notice("[key_name_admin(usr)] has taught [martial_skill] to [key_name_admin(selected_mob)]."))

////  Sets species of the selected client
/client/proc/set_species(mob/living/carbon/human/selected_mob)
	if (istype(selected_mob))
		var/result = tgui_input_list(usr, "Choose a new species","Species", GLOB.species_list)
		if(QDELETED(selected_mob))
			to_chat(usr, "Mob doesn't exist anymore")
			return
		if(result)
			admin_ticket_log("[key_name_admin(usr)] has modified the bodyparts of [selected_mob] to [result]")
			selected_mob.set_species(GLOB.species_list[result])
