/obj/item/bitrunning_disk/prefs
	name = "DeForest biological simulation disk"
	desc = "A disk containing the biological simulation data necessary to load custom characters into bitrunning domains."
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	base_icon_state = "datadisk"
	icon_state = "datadisk0"

	var/datum/preferences/loaded_preference

/obj/item/bitrunning_disk/prefs/examine(mob/user)
	. = ..()
	if(!isnull(loaded_preference))
		var/name = loaded_preference.read_preference(/datum/preference/name/real_name)
		. += "It currently has the character [name] loaded."


/obj/item/bitrunning_disk/prefs/attack_self(mob/user, modifiers)
	. = ..()

	var/list/prefdata_names = user.client.prefs?.create_character_profiles()

	var/warning = tgui_alert(user, message = "This feature is experimental and messing with prefs. I suggest you save your prefs externally via the OOC tab. Proceed anyway?", title = "BEWARE", buttons = list("Yes", "No"))
	if(isnull(warning) || warning == "No")
		return
	var/choice = tgui_input_list(user, message = "Select a character",  title = "Character selection", items = prefdata_names)
	if(isnull(choice) || !user.is_holding(src))
		return

	loaded_preference = new(user.client)
	loaded_preference.load_character(prefdata_names.Find(choice))

	to_chat(user, span_notice("Character set to [choice] sucessfully!"))
