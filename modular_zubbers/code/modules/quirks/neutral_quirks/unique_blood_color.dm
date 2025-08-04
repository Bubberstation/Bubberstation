//i dont enjoy this implementation, but we're also not going to figure out how to write a proper do-all replace_blood_type() without |some| help....

/datum/quirk/unique_blood_color
	name = "Blood Pigmentation"
	desc = "Your blood has a different colour than what your species usually has."
	gain_text = span_purple("Your flesh shifts in hue.")
	lose_text = span_purple("Your flesh returns to a natural look.")
	medical_record_text = "Patient has unusual blood pigmentation."
	value = 0
	icon = FA_ICON_DROPLET
	var/datum/blood_type/old_blood = null

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
	var/override
	var/selected_color = client_source?.prefs.read_preference(/datum/preference/choiced/select_blood_color)
	old_blood = human_holder.dna.blood_type.type
	testing("selected_color is [selected_color]")
	switch(selected_color)
		if("Custom")
			override = client_source?.prefs.read_preference(/datum/preference/color/input_blood_color)
		if("Red/Human")
			override = BLOOD_COLOR_RED
		if("Lizard")
			override = BLOOD_COLOR_LIZARD
		if("Green/alt-Lizard")
			override = BLOOD_COLOR_GREEN
		if("Lime/Xeno")
			override = BLOOD_COLOR_XENO
		if("Violet/Avali")
			override = BLOOD_COLOR_VIOLET
		if("Cyan/Vox")
			override = BLOOD_COLOR_CYAN
		if("White/Nanites")
			override = BLOOD_COLOR_NANITE_SLURRY
		if("Black/Evil")
			override = BLOOD_COLOR_BLACK
		else
			CRASH("incorrect/missing /datum/preference/choiced/select_blood_color - [selected_color]")
	testing("override set to [override]")

///Check if new blood type is same as old. Jank, but it should prevent cases of special blood types made from relative normal blood
	if(human_holder.dna.blood_type.get_color() == override)
		to_chat(human_holder, span_notice("...but nothing had actually changed."))
		remove_from_current_holder()
		WARNING("quirk 'unique_blood_color' automatically removed from [human_holder.name]")
		return
	testing("Passing [override] to change_blood_color()")
	change_blood_color(quirked = human_holder, override = override)

/datum/quirk/unique_blood_color/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	if (!istype(human_holder) || isnull(old_blood))
		return
	var/datum/blood_type/new_blood = new old_blood
	human_holder.set_blood_type(new_blood)
	human_holder.dna.species.exotic_bloodtype = initial(human_holder.dna.species.exotic_bloodtype)

//someone could turn this into a universal replace_blood() or something... but not me

/datum/quirk/unique_blood_color/proc/change_blood_color(datum/source, mob/living/carbon/human/quirked, override, update_cached_blood_dna_info)
	SIGNAL_HANDLER
///Making the new blood type
	var/datum/blood_type/new_blood = get_blood_type("[quirked.dna.blood_type]_[override]") //for example, A-_#69af19
///check if blood type already exists before making it new
	if(isnull(new_blood))
		var/recolor_type = quirked.dna.blood_type.recolor_blood_type
		new_blood = new recolor_type(override = override, orig = quirked.dna.blood_type)
		GLOB.blood_types[new_blood.id] = new_blood
	NOTICE("finalized new blood type [new_blood.id] for [quirked.name]")
	quirked.dna.species.exotic_bloodtype = new_blood
	quirked.set_blood_type(new_blood)

