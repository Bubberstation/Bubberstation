//i dont enjoy this implementation, but we're also not going to figure out how to write a proper do-all replace_blood_type() without |some| help....

/datum/quirk/item_quirk/unique_blood_color
	name = "Blood Pigmentation"
	desc = "Your blood has a different colour than what your species usually has."
	gain_text = span_purple("Your flesh shifts in hue.")
	lose_text = span_purple("Your flesh returns to a natural look.")
	medical_record_text = "Patient has unusual blood pigmentation."
	value = 0
	icon = FA_ICON_DROPLET
	//this should only ever be a hex
	var/color_code = NONE
	var/datum/blood_type/new_blood = NONE
	//for removal, and having an un-appended type name
	var/datum/blood_type/old_blood = NONE

/datum/quirk_constant_data/uniquebloodcolor
	associated_typepath = /datum/quirk/item_quirk/unique_blood_color
	customization_options = list(
		/datum/preference/color/input_blood_color,
		/datum/preference/choiced/select_blood_color,
		)


/datum/quirk/item_quirk/unique_blood_color/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	//If you want to change the blood of a non-human mob, just varedit. It'll reset when changing species tho
	if(!istype(human_holder))
		return
	old_blood = human_holder.dna.blood_type
	var/selected_color = client_source?.prefs.read_preference(/datum/preference/choiced/select_blood_color) || "Custom"
	testing("selected_color is [selected_color]")
	if(selected_color != "Custom")
		color_code = GLOB.custom_blood_colors[selected_color]
		testing("selected_color is not Custom")
	else if(selected_color == "Custom")
		color_code = client_source?.prefs.read_preference(/datum/preference/color/input_blood_color)
		testing("selected_color is Custom")
	testing("color_code set to [color_code]")
	change_blood_color(quirked = human_holder, override = color_code)

/datum/quirk/item_quirk/unique_blood_color/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	if (!istype(human_holder) || isnull(old_blood))
		return
	var/datum/blood_type/new_blood = new old_blood.type
	human_holder.set_blood_type(new_blood)
	human_holder.dna.species.exotic_bloodtype = initial(human_holder.dna.species.exotic_bloodtype)

//someone could turn this into a universal replace_blood() or something... but not me

/datum/quirk/item_quirk/unique_blood_color/proc/change_blood_color(datum/source, mob/living/carbon/human/quirked, override, update_cached_blood_dna_info)
	SIGNAL_HANDLER
///Check if new blood type is same as old. Jank, but it should prevent cases of special blood types made from relative normal blood
	if(quirked.dna.blood_type.get_color() == color_code)
		to_chat(quirked, span_notice("...but nothing had actually changed."))
		remove_from_current_holder()
		WARNING("quirk 'unique_blood_color' automatically removed from [quirked.name]")
		return
///Making the new blood type
	new_blood = get_blood_type("[quirked.dna.blood_type] ([override])") //for example, A-_#69af19
///check if blood type already exists before making it new
	if(isnull(new_blood))
		var/recolor_type = quirked.dna.blood_type.recolor_blood_type
		new_blood = new recolor_type(override = override, orig = quirked.dna.blood_type)
		GLOB.blood_types[new_blood.id] = new_blood
	NOTICE("finalized new blood type [new_blood.id] for [quirked.name]")
	quirked.dna.species.exotic_bloodtype = new_blood
	quirked.set_blood_type(new_blood)


/datum/quirk/item_quirk/unique_blood_color/add_unique(client/client_source)
	var/get_bloodtype_id = old_blood.name
	var/obj/item/clothing/accessory/dogtag/unique_blood/dogtag = new(quirk_holder, get_bloodtype_id, color_code)
	give_item_to_holder(dogtag, list(LOCATION_BACKPACK, LOCATION_HANDS), flavour_text = "Medical should probably see this...", notify_player = TRUE)
