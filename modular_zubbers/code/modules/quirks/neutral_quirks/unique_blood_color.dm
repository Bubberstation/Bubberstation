//i dont enjoy this implementation, but we're also not going to figure out how to write a proper do-all replace_blood_type() without |some| help....

/datum/quirk/unique_blood_color
	name = "Blood Pigmentation"
	desc = "Your blood has a different colour than what your species usually has."
	gain_text = span_purple("The undertones of your flesh shift in hue.")
	lose_text = span_notice("Your flesh returns to a natural look.")
	medical_record_text = "Patient has unusual blood pigmentation."
	value = 0
	icon = FA_ICON_DROPLET

/datum/quirk_constant_data/uniquebloodcolor
	associated_typepath = /datum/quirk/unique_blood_color
	customization_options = list(
		/datum/preference/color/input_blood_color,
		/datum/preference/choiced/select_blood_color,
		)

/datum/quirk/unique_blood_color/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!istype(human_holder)) //If you want to change the blood of a non-human mob, just varedit. It'll reset when changing species tho
		return
	var/datum/blood_type/override = new human_holder.dna.blood_type
	var/selected_color = client_source?.prefs.read_preference(/datum/preference/choiced/select_blood_color)
	switch(selected_color)
		if("Custom")
			override.color = client_source?.prefs.read_preference(/datum/preference/color/input_blood_color)
		if("Red/Human")
			override.color = BLOOD_COLOR_RED
		if("Lizard")
			override.color = BLOOD_COLOR_LIZARD
		if("Green/alt-Lizard")
			override.color = BLOOD_COLOR_GREEN
		if("Lime/Xeno")
			override.color = BLOOD_COLOR_XENO
		if("Violet/Avali")
			override.color = BLOOD_COLOR_VIOLET
		if("Cyan/Vox")
			override.color = BLOOD_COLOR_CYAN
		if("White/Synth")
			override.color = BLOOD_COLOR_WHITE
		else
			CRASH("target /datum/preference/choiced/select_blood_color not found")
	change_blood_color(quirked = human_holder, override = override)

//someone could turn this into a universal replace_blood() or something... but not me

/datum/quirk/unique_blood_color/proc/change_blood_color(datum/source, mob/living/carbon/human/quirked, datum/blood_type/override, update_cached_blood_dna_info)
	SIGNAL_HANDLER
///Making the new blood type
	var/datum/blood_type/new_blood_type = get_blood_type("[quirked.dna.blood_type.name]_alt_[override.color]") //for example, A-_alt_#69af19
	if(isnull(new_blood_type))
		//appends /alt_color to the datum path??? idk
		var/blood_type_path = "[quirked.dna.blood_type]/alt_color"
		new_blood_type = new /datum/blood_type/lizard/alt_color(override_blood_type = override)
		GLOB.blood_types[new_blood_type.id] = new_blood_type
	quirked.set_blood_type(new_blood_type)

	if(quirked.dna.species.exotic_bloodtype)
		quirked.dna.species.exotic_bloodtype = new_blood_type

