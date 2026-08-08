/obj/item/organ/cyberimp/brain/nif
	///Currently Avalible themese for the NIFs
	var/static/list/ui_themes = list(
		"abductor",
		"cardtable",
		"hackerman",
		"malfunction",
		"default",
		"ntos",
		"ntos_darkmode",
		"ntOS95",
		"ntos_synth",
		"ntos_terminal",
		"wizard",
	)
	///What theme is currently being used on the NIF?
	var/current_theme = "default"

/obj/item/organ/cyberimp/brain/nif/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	if(!ui)
		ui = new(user, src, "NifPanel", name)
		ui.open()

/obj/item/organ/cyberimp/brain/nif/ui_state(mob/user)
	return GLOB.conscious_state

/obj/item/organ/cyberimp/brain/nif/ui_status(mob/user)
	if(user == linked_mob)
		return UI_INTERACTIVE
	return UI_CLOSE

/obj/item/organ/cyberimp/brain/nif/ui_static_data(mob/user)
	var/list/data = list()

	data["loaded_nifsofts"] = list()
	for(var/datum/nifsoft/nifsoft as anything in loaded_nifsofts)
		var/list/nifsoft_data = list(
			"name" = nifsoft.program_name,
			"desc" = nifsoft.program_desc,
			"active" = nifsoft.active,
			"active_mode" = nifsoft.active_mode,
			"activation_cost" = nifsoft.activation_cost,
			"active_cost" = nifsoft.active_cost,
			"reference" = REF(nifsoft),
			"ui_icon" = nifsoft.ui_icon,
			"able_to_keep" = nifsoft.able_to_keep,
			"keep_installed" = nifsoft.keep_installed,
		)
		data["loaded_nifsofts"] += list(nifsoft_data)

	data["ui_themes"] = ui_themes
	data["max_nifsofts"] = max_nifsofts
	data["max_durability"] = max_durability
	data["max_power"] = max_power_level
	data["max_blood_level"] = linked_mob.blood_volume_normal
	data["product_notes"] = manufacturer_notes
	data["stored_points"] = rewards_points
	data["default_examine_text"] = /datum/component/nif_examine::nif_examine_text

	return data

/obj/item/organ/cyberimp/brain/nif/ui_data(mob/user)
	var/list/data = list()
	//User Preference Variables
	data["linked_mob_name"] = linked_mob.name
	data["current_theme"] = current_theme

	//Power Variables
	data["power_level"] = power_level
	data["power_usage"] = power_usage

	data["nutrition_drain"] = nutrition_drain
	data["nutrition_level"] = linked_mob.nutrition

	data["blood_level"] = linked_mob.get_blood_volume()
	data["blood_drain"] = blood_drain
	data["minimum_blood_level"] = minimum_blood_level

	//Durability Variables.
	data["durability"] = durability

	var/datum/component/nif_examine/examine_datum = linked_mob.GetComponent(/datum/component/nif_examine)

	if(examine_datum && examine_datum.nif_examine_text != initial(examine_datum.nif_examine_text))
		data["current_examine_text"] = examine_datum.nif_examine_text
	else
		data["current_examine_text"] = null

	return data

/obj/item/organ/cyberimp/brain/nif/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("toggle_nutrition_drain")
			return toggle_nutrition_drain()

		if("toggle_blood_drain")
			return toggle_blood_drain()

		if("change_examine_text")
			var/text_to_use = html_encode(params["new_text"])
			var/datum/component/nif_examine/examine_datum = linked_mob.GetComponent(/datum/component/nif_examine)

			if(!examine_datum)
				return FALSE

			if(!text_to_use || length(text_to_use) <= 6)
				examine_datum.nif_examine_text = initial(examine_datum.nif_examine_text)
				return TRUE

			examine_datum.nif_examine_text = text_to_use
			return TRUE

		if("uninstall_nifsoft")
			var/nifsoft_to_remove = locate(params["nifsoft_to_remove"]) in loaded_nifsofts
			if(!nifsoft_to_remove)
				return FALSE

			remove_nifsoft(nifsoft_to_remove)
			update_static_data(ui.user, ui)

		if("change_theme")
			var/target_theme = params["target_theme"]

			if(!target_theme || !(target_theme in ui_themes))
				return FALSE

			current_theme = target_theme
			for(var/datum/nifsoft/installed_nifsoft as anything in loaded_nifsofts)
				installed_nifsoft.update_theme()
			return TRUE

		if("activate_nifsoft")
			var/datum/nifsoft/activated_nifsoft = locate(params["activated_nifsoft"]) in loaded_nifsofts
			if(!activated_nifsoft)
				return FALSE

			activated_nifsoft.activate()
			update_static_data(ui.user, ui)

		if("toggle_keeping_nifsoft")
			var/datum/nifsoft/nifsoft_to_keep = locate(params["nifsoft_to_keep"]) in loaded_nifsofts
			if(!nifsoft_to_keep || !nifsoft_to_keep.able_to_keep)
				return FALSE

			nifsoft_to_keep.keep_installed = !nifsoft_to_keep.keep_installed
			update_static_data(ui.user, ui)
