/datum/preference/toggle/erp/vore_enable
	savefile_key = "vore_enable_pref"

/datum/preference/toggle/erp/vore_enable/apply_to_client(client/client, value)
	var/mob/living/L = client.mob
	if(istype(L))
		// Only add if in vore_allowed_mob_types, but always remove
		if(value && is_type_in_typecache(L, GLOB.vore_allowed_mob_types))
			AddComponent(/datum/component/vore, L)
		else
			var/datum/component/C = L.GetComponent(/datum/component/vore)
			if(C)
				qdel(C)

// Lightweight-ish reimplementation of /datum/preferences
/datum/vore_preferences
	var/list/pref_map = null
	var/datum/json_savefile/savefile

/datum/vore_preferences/New(datum/json_savefile/save)
	savefile = save
	load_from_savefile()

/datum/vore_preferences/Destroy(force)
	pref_map = null
	savefile = null
	. = ..()

/datum/vore_preferences/ui_data(mob/user)
	var/list/data = list()

	var/list/prefs = list()
	for(var/type in GLOB.vore_preference_entries)
		var/datum/vore_pref/pref = GLOB.vore_preference_entries[type]
		prefs[pref.savefile_key] = read_preference(type)

	data["preferences"] = prefs

	return data

/datum/vore_preferences/proc/load_from_savefile()
	pref_map = savefile.get_entry("vore", list())

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
