/datum/examine_panel
	/// Mob that the examine panel belongs to.
	var/mob/living/holder
	/// The screen containing the appearance of the mob
	var/atom/movable/screen/map_view/examine_panel_screen/examine_panel_screen


/datum/examine_panel/ui_state(mob/user)
	return GLOB.always_state


/datum/examine_panel/ui_close(mob/user)
	user.client.clear_map(examine_panel_screen.assigned_map)


/atom/movable/screen/map_view/examine_panel_screen
	name = "examine panel screen"


/datum/examine_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!examine_panel_screen)
		examine_panel_screen = new
		examine_panel_screen.name = "screen"
		examine_panel_screen.assigned_map = "examine_panel_[REF(holder)]_map"
		examine_panel_screen.del_on_map_removal = FALSE
		examine_panel_screen.screen_loc = "[examine_panel_screen.assigned_map]:1,1"

	var/mutable_appearance/current_mob_appearance = new(holder)
	current_mob_appearance.setDir(SOUTH)
	current_mob_appearance.transform = matrix() // We reset their rotation, in case they're lying down.

	// In case they're pixel-shifted, we bring 'em back!
	current_mob_appearance.pixel_x = 0
	current_mob_appearance.pixel_y = 0

	examine_panel_screen.cut_overlays()
	examine_panel_screen.add_overlay(current_mob_appearance)

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		examine_panel_screen.display_to(user)
		user.client.register_map_obj(examine_panel_screen)
		ui = new(user, src, "ExaminePanel")
		ui.open()


/datum/examine_panel/ui_data(mob/user)
	var/list/data = list()

	var/datum/preferences/preferences = holder.client?.prefs

	var/flavor_text
	var/custom_species
	var/custom_species_lore
	var/obscured
	var/name = "" //BUBBER EDIT
	var/obscurity_examine_pref = preferences?.read_preference(/datum/preference/toggle/obscurity_examine) // BUBBER EDIT
	var/ooc_notes = ""
	var/headshot = ""

	//  Handle OOC notes first
	if(preferences && preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		var/e_prefs = preferences.read_preference(/datum/preference/choiced/erp_status)
		var/e_prefs_nc = preferences.read_preference(/datum/preference/choiced/erp_status_nc)
		var/e_prefs_hypno = preferences.read_preference(/datum/preference/choiced/erp_status_hypno) // bubberstation edit
		var/e_prefs_v = preferences.read_preference(/datum/preference/choiced/erp_status_v)
		var/e_prefs_mechanical = preferences.read_preference(/datum/preference/choiced/erp_status_mechanics)
		ooc_notes += "ERP: [e_prefs]\n"
		ooc_notes += "Non-Con: [e_prefs_nc]\n"
		ooc_notes += "Hypnosis: [e_prefs_hypno]\n" // bubberstation Edit
		ooc_notes += "Vore: [e_prefs_v]\n"
		ooc_notes += "ERP Mechanics: [e_prefs_mechanical]\n"
		ooc_notes += "\n"

	// Now we handle silicon and/or human, order doesn't really matter
	// If other variants of mob/living need to be handled at some point, put them here
	if(issilicon(holder))
		flavor_text = preferences.read_preference(/datum/preference/text/silicon_flavor_text)
		//BUBBER EDIT BEGIN: SILICON PREFS
		custom_species = preferences.read_preference(/datum/preference/text/custom_species/silicon)
		custom_species_lore = preferences.read_preference(/datum/preference/text/custom_species_lore/silicon)
		ooc_notes += preferences.read_preference(/datum/preference/text/ooc_notes/silicon)
		headshot += preferences.read_preference(/datum/preference/text/headshot/silicon)
		//BUBBER EDIT END: SILICON HEADSHOT

	if(ishuman(holder))
		var/mob/living/carbon/human/holder_human = holder
		obscured = (holder_human.wear_mask && (holder_human.wear_mask.flags_inv & HIDEFACE)) && obscurity_examine_pref || (holder_human.head && (holder_human.head.flags_inv & HIDEFACE) && obscurity_examine_pref) // BUBBERSTATION EDIT - EXAMINE PREFS
		ooc_notes += holder_human.dna.features["ooc_notes"]
		//BUBBER EDIT BEGIN: Updates custom species and custom species lore
		//Check if the mob is obscured, then continue to headshot and species lore
		if(obscured || !holder_human.dna)
			custom_species = "Obscured"
			custom_species_lore = "Obscured"
			flavor_text = "Obscured"
			name = "Unknown"
		else
			headshot += preferences.read_preference(/datum/preference/text/headshot)
			flavor_text = holder_human.dna.features["flavor_text"]
			name = holder.name
		//Custom species handling. Reports the normal custom species if there is not one set.
			if(holder_human.dna.species.lore_protected || holder_human.dna.features["custom_species"] == "")
				custom_species = holder_human.dna.species.name
			else
				custom_species = holder_human.dna.features["custom_species"]
		//Custom species lore handling. Reports the species lore with summary if there is not one set. Does this separately so you can name your subrace without the lore changing.
			if(holder_human.dna.species.lore_protected || holder_human.dna.features["custom_species_lore"] == "")
				custom_species_lore += "[holder_human.dna.species.get_species_description()]\n"
				custom_species_lore += "\n"
				custom_species_lore += LAZYACCESS(holder_human.dna.species.get_species_lore(), 1)
			else
				custom_species_lore = holder_human.dna.features["custom_species_lore"]
		//BUBBER EDIT END: Panel refactor

	data["obscured"] = obscured ? TRUE : FALSE
	data["character_name"] = name
	data["assigned_map"] = examine_panel_screen.assigned_map
	data["flavor_text"] = flavor_text
	data["ooc_notes"] = ooc_notes
	data["custom_species"] = custom_species
	data["custom_species_lore"] = custom_species_lore
	data["headshot"] = headshot
	return data
