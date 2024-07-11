
/client/proc/toggle_quirk(mob/living/carbon/human/H)
	if (!istype(H))
		to_chat(usr, "This can only be used on /mob/living/carbon/human.")
		return

	var/list/options = list("Clear"="Clear")
	for(var/x in subtypesof(/datum/quirk))
		var/datum/quirk/T = x
		var/qname = initial(T.name)
		options[H.has_quirk(T) ? "[qname] (Remove)" : "[qname] (Add)"] = T

	var/result = tgui_input_list(usr, "Choose quirk to add/remove", "Mob Quirks", options)

	if(QDELETED(H))
		to_chat(usr, "Mob doesn't exist anymore")
		return

	if(result)
		if(result == "Clear")
			for(var/datum/quirk/q in H.quirks)
				H.remove_quirk(q.type)
		else
			var/T = options[result]
			if(H.has_quirk(T))
				H.remove_quirk(T)
			else
				H.add_quirk(T,TRUE)

/client/proc/teach_martial_art(mob/living/carbon/C)
	if (!istype(C))
		to_chat(usr, "This can only be used on /mob/living/carbon.")
		return

	var/list/artpaths = subtypesof(/datum/martial_art)
	var/list/artnames = list()
	for(var/i in artpaths)
		var/datum/martial_art/M = i
		artnames[initial(M.name)] = M
	var/result = tgui_input_list(usr, "Choose the martial art to teach", "JUDO CHOP", artnames) // input(usr, "Choose the martial art to teach","JUDO CHOP") as null|anything in artnames

	if(QDELETED(C))
		to_chat(usr, "Mob doesn't exist anymore")
		return
	if(result)
		var/chosenart = artnames[result]
		var/datum/martial_art/MA = new chosenart
		MA.teach(C)
		log_admin("[key_name(usr)] has taught [MA] to [key_name(C)].")
		message_admins(span_notice("[key_name_admin(usr)] has taught [MA] to [key_name_admin(C)]."))

/client/proc/set_species(mob/living/carbon/human/H)
	if (istype(H))
		var/result = tgui_input_list(usr, "Choose a new species","Species", GLOB.species_list)
		if(QDELETED(H))
			to_chat(usr, "Mob doesn't exist anymore")
			return
		if(result)
			admin_ticket_log("[key_name_admin(usr)] has modified the bodyparts of [H] to [result]")
			H.set_species(GLOB.species_list[result])
