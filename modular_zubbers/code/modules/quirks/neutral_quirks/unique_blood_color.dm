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
		/datum/preference/toggle/preset_blood_color,
		/datum/preference/choiced/select_blood_color,
		)

/datum/quirk/unique_blood_color/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!istype(human_holder)) //If you want to change the blood of a non-human mob, just varedit. It'll reset when changing species tho
		return
	var/datum/blood_type/override = human_holder.dna.blood_type
	if(client_source?.prefs.read_preference(/datum/preference/toggle/preset_blood_color) == TRUE)
		var/selected_color = client_source?.prefs.read_preference(/datum/preference/choiced/select_blood_color)
		switch(selected_color)
			if("Red/Human")
				override.color = BLOOD_COLOR_RED
			//if("Lizard")
			//	override.color = BLOOD_COLOR_LIZARD
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
				override.color = BLOOD_COLOR_RED
	else
		override.color = client_source?.prefs.read_preference(/datum/preference/color/input_blood_color)
	change_blood_color(new_species = human_holder.dna.species, override = human_holder.dna.blood_type)

//someone could turn this into a universal replace_blood() or something... but not me

/datum/quirk/unique_blood_color/proc/change_blood_color(datum/source, datum/species/new_species, datum/species/old_species, datum/blood_type/override, pref_load, regenerate_icons)
	SIGNAL_HANDLER

	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!istype(human_holder))
		return

///Making the new blood type
	var/datum/blood_type/new_blood_type = new /datum/blood_type/custom(human_holder.dna.blood_type, human_holder.dna.blood_type.compatible_types)
	new_blood_type.color = override.color
	GLOB.blood_types[new_blood_type.id] = new_blood_type
	human_holder.set_blood_type(new_blood_type)

	if(new_species.exotic_bloodtype)
		new_species.exotic_bloodtype = new_blood_type

