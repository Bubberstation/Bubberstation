/datum/preference/toggle/erp/vore_enable
	savefile_key = "vore_enable_pref"

/datum/preference/toggle/erp/vore_enable/apply_to_client(client/client, value)
	var/mob/living/L = client.mob
	if(istype(L))
		// Only add if in vore_allowed_mob_types, but always remove
		if(value && is_type_in_typecache(L, GLOB.vore_allowed_mob_types))
			L.AddComponent(/datum/component/vore, L)
		else
			// instantly eject them when consent is removed
			if(istype(L.loc, /obj/vore_belly))
				L.forceMove(get_turf(L))
			var/datum/component/C = L.GetComponent(/datum/component/vore)
			if(C)
				qdel(C)

/proc/get_player_save_folder(ckey)
	return "data/player_saves/[ckey[1]]/[ckey]"

/client
	var/datum/vore_preferences/vore_prefs

/// Returns null if the client is not interested in vore at all and therefore has no opinions
/client/proc/get_vore_prefs()
	if(vore_prefs)
		return vore_prefs

	// do not create the prefs at all for normies
	// default pref values are not safe for them and they cannot configure them without the vore component
	var/enable_vore = prefs.read_preference(/datum/preference/toggle/erp/vore_enable)
	if(!enable_vore)
		return null
	vore_prefs = new(src)
	return vore_prefs

/mob/proc/get_vore_prefs()
	if(client)
		return client.get_vore_prefs()
	return null

// Lightweight-ish reimplementation of /datum/preferences
/datum/vore_preferences
	var/client/owner
	var/belly_layout_slot = 0
	var/list/pref_map = null
	var/datum/json_savefile/savefile

/datum/vore_preferences/New(client/C)
	owner = C
	savefile = new("[get_player_save_folder(C.ckey)]/vore.json")
	pref_map = savefile.get_entry("vore", list())
	reset_belly_layout_slot()

/datum/vore_preferences/proc/reset_belly_layout_slot()
	var/new_belly_layout_slot = LAZYACCESS(get_lookup_table(), "[owner.prefs.default_slot]")
	if(!isnull(new_belly_layout_slot))
		belly_layout_slot = new_belly_layout_slot

/datum/vore_preferences/Destroy(force)
	QDEL_NULL(savefile)
	LAZYNULL(pref_map)
	. = ..()

/datum/vore_preferences/ui_data(mob/user)
	if(user.client != owner)
		CRASH("[key_name(user)] managed to access [key_name(owner)]'s vore preferences")
	var/list/data = list()

	var/list/prefs = list()
	for(var/type in GLOB.vore_preference_entries)
		var/datum/vore_pref/pref = GLOB.vore_preference_entries[type]
		prefs[pref.savefile_key] = read_preference(type)

	data["preferences"] = prefs
	data["current_slot"] = get_slot_name()

	return data

/datum/vore_preferences/proc/get_slot_metadata()
	return savefile.get_entry("slot_metadata", list())

/datum/vore_preferences/proc/set_slot_metadata(list/data)
	savefile.set_entry("slot_metadata", data)
	savefile.save()

/datum/vore_preferences/proc/get_slot_name(slot = belly_layout_slot)
	var/list/slot_metadata = get_slot_metadata()
	if("[slot]" in slot_metadata)
		return slot_metadata["[slot]"]["name"]
	return "New Slot ([slot])"

/datum/vore_preferences/proc/set_slot_name(name, slot = belly_layout_slot)
	var/list/slot_metadata = get_slot_metadata()
	LAZYSET(slot_metadata["[slot]"], "name", name)
	set_slot_metadata(slot_metadata)

/datum/vore_preferences/proc/get_lookup_table()
	return savefile.get_entry("slot_lookup_table", list())

/datum/vore_preferences/proc/set_lookup_table(list/data)
	savefile.set_entry("slot_lookup_table", data)
	savefile.save()

/datum/vore_preferences/proc/generate_slot_choice_list()
	var/list/choices = list()
	for(var/i in 0 to MAX_BELLY_LAYOUTS)
		var/name = get_slot_name(i)
		// avoid duplicates
		if(name in choices)
			name = "[name] ([i])"
		choices["[name]"] = i
	return choices

/datum/vore_preferences/proc/load_slot()
	var/list/choices = generate_slot_choice_list()
	var/choice = tgui_input_list(usr, "Choose a slot to load", "Belly Slot", choices, get_slot_name())
	if(choice)
		if(tgui_alert(usr, "Are you SURE you want to delete all current bellies and replace them with the slot '[choice]'?", "Slot Loading", list("No", "Yes")) != "Yes")
			return FALSE
		belly_layout_slot = choices[choice]
		return TRUE
	return FALSE

/datum/vore_preferences/proc/copy_to_slot()
	var/list/choices = generate_slot_choice_list()
	var/choice = tgui_input_list(usr, "Choose a slot to copy over", "Belly Slot", choices)
	if(choice)
		if(tgui_alert(usr, "Are you SURE you want to overwrite '[choice]' with current bellies?", "Slot Copying", list("No", "Yes")) != "Yes")
			return null

		set_slot_name("[get_slot_name()] (Copy)", choices[choice])
		return choices[choice]
	return null

/datum/vore_preferences/proc/export_slot()
	var/list/choices = generate_slot_choice_list()
	var/choice = tgui_input_list(usr, "Choose a slot to export", "Belly Slot", choices)
	if(choice)
		var/slot_index = choices[choice]
		var/data = get_belly_export(slot_index)
		var/path = "[get_player_save_folder(usr.ckey)]/vore_export.json"
		rustg_file_write(json_encode(data, JSON_PRETTY_PRINT), path)
		to_chat(usr, span_notice("Sending you [choice], this may take a moment..."))
		usr << ftp(file(path))
		fdel(path)

/datum/vore_preferences/proc/get_bellies()
	return savefile.get_entry("bellies[belly_layout_slot]")

/datum/vore_preferences/proc/get_belly_export(slot = belly_layout_slot)
	var/list/bellies = savefile.get_entry("bellies[slot]")

	return list(
		"db_version" = VORE_DB_VERSION,
		"db_repo" = VORE_DB_REPO,
		"bellies" = bellies
	)

/datum/vore_preferences/proc/set_bellies(list/data, slot = belly_layout_slot)
	savefile.set_entry("bellies[slot]", data)
	savefile.save()

/datum/vore_preferences/proc/read_preference(preference_type)
	var/datum/vore_pref/preference_entry = GLOB.vore_preference_entries[preference_type]
	if(isnull(preference_entry))
		var/extra_info = ""

		// Current initializing subsystem is important to know because it might be a problem with
		// things running pre-assets-initialization.
		if(!isnull(Master.current_initializing_subsystem))
			extra_info = "Info was attempted to be retrieved while [Master.current_initializing_subsystem] was initializing."
		else if(!MC_RUNNING())
			extra_info = "Info was attempted to be retrieved before the MC started, but not while it was actively initializing a subsystem"

		CRASH("Preference type `[preference_type]` is invalid! [extra_info]")

	var/value = preference_entry.read(pref_map, src)
	if(isnull(value))
		value = preference_entry.create_informed_default_value(src)
		if(write_preference(preference_entry, value))
			return value
		else
			CRASH("Couldn't write the default value for [preference_type] (received [value])")
	return value

/datum/vore_preferences/proc/write_preference(datum/vore_pref/preference, preference_value)
	var/new_value = preference.deserialize(preference_value, src)
	var/success = preference.write(pref_map, new_value)
	save()
	if(success)
		preference.on_change(src, new_value)
	return success

/datum/vore_preferences/proc/save()
	savefile.set_entry("vore", pref_map)
	savefile.save()

/// An assoc list list of types to instantiated `/datum/preference` instances
GLOBAL_LIST_INIT(vore_preference_entries, init_vore_preference_entries())

/// An assoc list of preference entries by their `savefile_key`
GLOBAL_LIST_INIT(vore_preference_entries_by_key, init_vore_preference_entries_by_key())

/proc/init_vore_preference_entries()
	var/list/output = list()
	for (var/datum/vore_pref/preference_type as anything in subtypesof(/datum/vore_pref))
		if (initial(preference_type.abstract_type) == preference_type)
			continue
		output[preference_type] = new preference_type
	return output

/proc/init_vore_preference_entries_by_key()
	var/list/output = list()
	for(var/datum/vore_pref/preference_type as anything in subtypesof(/datum/vore_pref))
		if (initial(preference_type.abstract_type) == preference_type)
			continue
		output[initial(preference_type.savefile_key)] = GLOB.vore_preference_entries[preference_type]
	return output

/datum/vore_pref
	var/abstract_type = /datum/vore_pref
	var/savefile_key = ""

/// Checks that a given value is valid.
/// Must be overriden by subtypes.
/// Any type can be passed through.
/datum/vore_pref/proc/is_valid(value)
	SHOULD_NOT_SLEEP(TRUE)
	SHOULD_CALL_PARENT(FALSE)
	CRASH("`is_valid()` was not implemented for [type]!")

/// Called on the saved input when retrieving.
/// Also called by the value sent from the user through UI. Do not trust it.
/// Input is the value inside the savefile, output is to tell other code
/// what the value is.
/// This is useful either for more optimal data saving or for migrating
/// older data.
/// Must be overridden by subtypes.
/// Can return null if no value was found.
/datum/vore_pref/proc/deserialize(input, datum/vore_preferences/preferences)
	SHOULD_NOT_SLEEP(TRUE)
	SHOULD_CALL_PARENT(FALSE)
	CRASH("`deserialize()` was not implemented on [type]!")

/// Called on the input while saving.
/// Input is the current value, output is what to save in the savefile.
/datum/vore_pref/proc/serialize(input)
	SHOULD_NOT_SLEEP(TRUE)
	return input

/// Produce a default, potentially random value for when no value for this
/// preference is found in the savefile.
/// Either this or create_informed_default_value must be overriden by subtypes.
/datum/vore_pref/proc/create_default_value()
	SHOULD_NOT_SLEEP(TRUE)
	SHOULD_CALL_PARENT(FALSE)
	CRASH("`create_default_value()` was not implemented on [type]!")

/// Produce a default, potentially random value for when no value for this
/// preference is found in the savefile.
/// Unlike create_default_value(), will provide the preferences object if you
/// need to use it.
/// If not overriden, will call create_default_value() instead.
/datum/vore_pref/proc/create_informed_default_value(datum/vore_preferences/preferences)
	return create_default_value()

/// Given a savefile, return either the saved data or an acceptable default.
/// This will write to the savefile if a value was not found with the new value.
/datum/vore_pref/proc/read(list/save_data, datum/vore_preferences/preferences)
	SHOULD_NOT_OVERRIDE(TRUE)

	var/value

	if (!isnull(save_data))
		value = save_data[savefile_key]

	if (isnull(value))
		return null
	else
		return deserialize(value, preferences)

/// Given a savefile, writes the inputted value.
/// Returns TRUE for a successful application.
/// Return FALSE if it is invalid.
/datum/vore_pref/proc/write(list/save_data, value)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(!is_valid(value))
		return FALSE

	if(!isnull(save_data))
		save_data[savefile_key] = serialize(value)

	return TRUE

/datum/vore_pref/proc/on_change(datum/vore_preferences/vore_prefs, new_value)
	return

/datum/vore_pref/trinary
	abstract_type = /datum/vore_pref/trinary

/datum/vore_pref/trinary/is_valid(value)
	return isnum(value) && value >= PREF_TRINARY_NEVER && value <= PREF_TRINARY_ALWAYS

/datum/vore_pref/trinary/deserialize(input, datum/vore_preferences/preferences)
	return clamp(input, PREF_TRINARY_NEVER, PREF_TRINARY_ALWAYS)

/datum/vore_pref/trinary/serialize(input)
	return clamp(input, PREF_TRINARY_NEVER, PREF_TRINARY_ALWAYS)

/datum/vore_pref/trinary/create_default_value()
	return PREF_TRINARY_PROMPT

/datum/vore_pref/trinary/prey
	savefile_key = "prey_toggle"

/datum/vore_pref/trinary/pred
	savefile_key = "pred_toggle"

/datum/vore_pref/toggle
	abstract_type = /datum/vore_pref/toggle

/datum/vore_pref/toggle/is_valid(value)
	return isnum(value) && (value == FALSE || value == TRUE)

/datum/vore_pref/toggle/deserialize(input, datum/vore_preferences/preferences)
	return !!input

/datum/vore_pref/toggle/serialize(input)
	return !!input

/datum/vore_pref/toggle/create_default_value()
	return TRUE

/datum/vore_pref/toggle/eating_noises
	savefile_key = "eating_noises"

/datum/vore_pref/toggle/digestion_noises
	savefile_key = "digestion_noises"

/datum/vore_pref/toggle/belch_noises
	savefile_key = "belch_noises"

/datum/vore_pref/toggle/digestion
	savefile_key = "digestion_allowed"

/datum/vore_pref/toggle/digestion_qdel
	savefile_key = "qdel_allowed"

/datum/vore_pref/toggle/absorb
	savefile_key = "absorb_allowed"

/datum/vore_pref/toggle/overlays
	savefile_key = "fullscreen_overlays_allowed"

/datum/vore_pref/toggle/overlays/on_change(datum/vore_preferences/vore_prefs, new_value)
	var/mob/living/owner_mob = vore_prefs?.owner?.mob
	if(!istype(owner_mob))
		return

	if(new_value)
		if(istype(owner_mob.loc, /obj/vore_belly))
			var/obj/vore_belly/belly = owner_mob.loc
			belly.show_fullscreen(owner_mob)
	else
		owner_mob.clear_fullscreen("vore")
