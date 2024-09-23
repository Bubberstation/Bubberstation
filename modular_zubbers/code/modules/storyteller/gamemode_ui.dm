// Open the ui, nothing special here
// Maybe make it update static data?
/datum/controller/subsystem/gamemode/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Zubbers_Storyteller", "Storyteller control panel")
		ui.open()

/datum/controller/subsystem/gamemode/ui_data(mob/user)
	var/data = list()
	data["storyteller_name"] = storyteller ? storyteller.name : "None"
	data["storyteller_halt"] = storyteller_halted
	data["pop"] = get_correct_popcount()
	data["antag_count"] = GLOB.current_living_antags.len
	data["antag_cap"] = get_antag_cap()
	return data

/datum/controller/subsystem/gamemode/ui_static_data(mob/user)
	. = ..()

/datum/controller/subsystem/gamemode/ui_state(mob/user)
	return GLOB.admin_state

/datum/controller/subsystem/gamemode/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("set_storyteller")
			var/list/name_list = list()
			for(var/storyteller_type in storytellers)
				var/datum/storyteller/storyboy = storytellers[storyteller_type]
				name_list[storyboy.name] = storyboy.type
			var/new_storyteller_name = input(usr, "Choose new storyteller (circumvents voted one):", "Storyteller")  as null|anything in name_list
			if(!new_storyteller_name)
				return
			message_admins("[key_name_admin(usr)] has changed the Storyteller to [new_storyteller_name].")
			var/new_storyteller_type = name_list[new_storyteller_name]
			set_storyteller(new_storyteller_type, TRUE, usr.ckey)
		if("halt_storyteller")
			halt_storyteller(usr)
