#define ORGANS_DEFAULT_NAME "Default"
#define LIMBS_DEFAULT_NAME "None"

/datum/preference_middleware/limbs_and_markings/post_set_preference(mob/user, preference, value)
	preferences.character_preview_view.update_body()
	. = ..()

/datum/preference_middleware/limbs_and_markings
	action_delegations = list(
		"set_limb_aug" = PROC_REF(set_limb_aug),
		"set_limb_aug_style" = PROC_REF(set_limb_aug_style),
		"add_marking" = PROC_REF(add_marking),
		"change_marking" = PROC_REF(change_marking),
		"color_marking" = PROC_REF(color_marking),
		"remove_marking" = PROC_REF(remove_marking),
		"set_organ_aug" = PROC_REF(set_organ_aug),
		"set_preset" = PROC_REF(set_preset),
		"change_emissive" = PROC_REF(change_emissive_marking),
	)
	var/list/limbs_to_process = list(
		"l_arm" = "Left Arm",
		"r_arm" = "Right Arm",
		"l_leg" = "Left Leg",
		"r_leg" = "Right Leg",
		"chest" = "Chest",
		"head" = "Head",
		"l_hand" = "Left Hand",
		"r_hand" = "Right Hand"
	)

	var/list/organs_to_process = list(
		"heart" = "Heart",
		"lungs" = "Lungs",
		"liver" = "Liver",
		"stomach" = "Stomach",
		"eyes" = "Eyes",
		"tongue" = "Tongue",
		"Mouth implant" = "Mouth implant"
	)

	var/list/aug_support = list(
		"l_arm" = TRUE,
		"r_arm" = TRUE,
		"l_leg" = TRUE,
		"r_leg" = TRUE,
		"chest" = FALSE, // TODO: figure out why head/chest augs dont render, needed for IPC head on non IPC body
		"head" = FALSE,
		"l_hand" = FALSE,
		"r_hand" = FALSE,
	)
	var/list/nice_aug_names = list()
	var/list/augment_to_path = list()
	var/list/costs = list(
		AUGMENT_CATEGORY_LIMBS = list(),
		AUGMENT_CATEGORY_ORGANS = list(),
	)
	var/list/robotic_styles

/datum/preference_middleware/limbs_and_markings/proc/set_limb_aug(list/params, mob/user)
	var/limb_slot = params["limb_slot"]
	var/augment_name = params["augment_name"]
	if(augment_name == LIMBS_DEFAULT_NAME)
		preferences.augments -= limbs_to_process[limb_slot]
	else
		preferences.augments[limbs_to_process[limb_slot]] = augment_to_path[augment_name]
	// Remove some positive quirks if the point balance becomes too low.
	var/list/filtered_quirks = SSquirks.filter_invalid_quirks(preferences.all_quirks, preferences.augments)
	if(filtered_quirks != preferences.all_quirks)
		preferences.all_quirks = filtered_quirks
		preferences.update_static_data(user)
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/set_limb_aug_style(list/params, mob/user)
	var/limb_slot = params["limb_slot"]
	var/style_name = params["style_name"]
	if(style_name == LIMBS_DEFAULT_NAME)
		preferences.augment_limb_styles -= limbs_to_process[limb_slot]
	else
		preferences.augment_limb_styles[limbs_to_process[limb_slot]] = style_name
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/fix_colors_on_markings_to_tgui(markings_list, limb_slot)
	var/list/fixed_markings = list()
	var/marking_count = 0
	for(var/marking in markings_list)
		var/name = marking
		var/color = markings_list[name][1]
		var/emissive = markings_list[name][2]
		marking_count++
		fixed_markings += list(list("name" = name, "color" = sanitize_hexcolor(color), "marking_id" = "[limb_slot]_[marking_count]", "emissive" = emissive))
	return fixed_markings

/datum/preference_middleware/limbs_and_markings/proc/add_marking(list/params, mob/user)
	var/limb_slot = params["limb_slot"]
	if(!preferences.body_markings[limb_slot])
		preferences.body_markings[limb_slot] = list()
	if(preferences.body_markings[limb_slot].len >= MAXIMUM_MARKINGS_PER_LIMB)
		return
	preferences.body_markings[limb_slot] += list(GLOB.body_markings_per_limb[limb_slot][1] = list("#FFFFFF", FALSE)) // Default to the first in the list for the limb.
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/change_marking(list/params, mob/user)
	var/limb_slot = params["limb_slot"]
	var/marking_id = params["marking_id"]
	var/marking_name = params["marking_name"]

	var/list/markings = preferences.body_markings[limb_slot]
	var/list/new_markings = list()
	var/marking_count = 0
	for(var/marking_entry in markings)
		marking_count++
		if(marking_id == "[limb_slot]_[marking_count]")
			new_markings[marking_name] = markings[marking_entry] // gets the color from the old entry
			continue
		new_markings[marking_entry] = markings[marking_entry]
	preferences.body_markings[limb_slot] = new_markings
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/color_marking(list/params, mob/user)
	var/limb_slot = params["limb_slot"]
	var/marking_id = params["marking_id"]
	var/list/markings = preferences.body_markings[limb_slot]
	var/list/new_markings = list()
	var/marking_count = 0
	var/marking_entry_name
	for(var/marking_entry in markings)
		marking_count++
		if(marking_id == "[limb_slot]_[marking_count]")
			marking_entry_name = marking_entry
		new_markings[marking_entry] = markings[marking_entry]
	var/new_color = input(
		usr,
		"Select new color",
		null,
		preferences.body_markings[limb_slot][marking_entry_name],
	) as color | null
	if(!new_color)
		return TRUE
	new_markings[marking_entry_name][1] = sanitize_hexcolor(new_color) // gets the new color from the picker
	preferences.body_markings[limb_slot] = new_markings
	preferences.character_preview_view.update_body()
	return TRUE


/datum/preference_middleware/limbs_and_markings/proc/change_emissive_marking(list/params, mob/user)
	var/limb_slot = params["limb_slot"]
	var/marking_id = params["marking_id"]
	var/emissive = !params["emissive"]
	var/list/markings = preferences.body_markings[limb_slot]
	var/list/new_markings = list()
	var/marking_count = 0
	var/marking_entry_name
	for(var/marking_entry in markings)
		marking_count++
		if(marking_id == "[limb_slot]_[marking_count]")
			marking_entry_name = marking_entry
		new_markings[marking_entry] = markings[marking_entry]
	new_markings[marking_entry_name][2] = sanitize_integer(emissive)
	preferences.body_markings[limb_slot] = new_markings
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/remove_marking(list/params, mob/user)
	var/limb_slot = params["limb_slot"]
	var/marking_id = params["marking_id"]


	var/list/markings = preferences.body_markings[limb_slot]
	var/list/new_markings = list()
	var/marking_count = 0
	for(var/marking_entry in markings)
		marking_count++
		if(marking_id == "[limb_slot]_[marking_count]")
			continue
		new_markings[marking_entry] = markings[marking_entry]
	preferences.body_markings[limb_slot] = new_markings
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/set_organ_aug(list/params, mob/user)
	var/organ_slot = params["organ_slot"]
	var/augment_name = params["augment_name"]
	if(augment_name == ORGANS_DEFAULT_NAME)
		preferences.augments -= organs_to_process[organ_slot]
	else
		preferences.augments[organs_to_process[organ_slot]] = augment_to_path[augment_name]
	// Remove some positive quirks if the point balance becomes too low.
	var/list/filtered_quirks = SSquirks.filter_invalid_quirks(preferences.all_quirks, preferences.augments)
	if(filtered_quirks != preferences.all_quirks)
		preferences.all_quirks = filtered_quirks
		preferences.update_static_data(user)
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/set_preset(list/params, mob/user)
	var/preset = params["preset"]
	if (preset)
		var/datum/body_marking_set/BMS = GLOB.body_marking_sets[preset]
		preferences.body_markings = assemble_body_markings_from_set(BMS, preferences.features, preferences.pref_species)
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/get_ui_data(mob/user)
	var/list/data = list()
	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/allow_mismatched_parts = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	if(!robotic_styles)
		robotic_styles = list()
		for(var/style_name in GLOB.robotic_styles_list)
			robotic_styles += style_name
	data["robotic_styles"] = robotic_styles
	var/list/limbs_data = list()
	for(var/limb in limbs_to_process)
		if(!nice_aug_names[limb])
			nice_aug_names[limb] = list()
			for(var/augment in GLOB.augment_slot_to_items[limbs_to_process[limb]])
				var/obj/item/aug = augment
				var/datum/augment_item/expensive_augment = GLOB.augment_items[augment]
				var/cost = 0
				var/name = initial(aug.name)
				if (expensive_augment)
					cost = expensive_augment.cost
					name = expensive_augment.name
				// To display the cost of the limb, if it's anything aside from 0.
				var/aug_name = cost != 0 ? name + " ([cost])" : name
				costs[AUGMENT_CATEGORY_LIMBS][aug_name] = cost
				nice_aug_names[limb][augment] = aug_name
				augment_to_path[aug_name] = augment
			nice_aug_names[limb]["none"] = LIMBS_DEFAULT_NAME
		var/chosen_augment
		if(preferences.augments[limbs_to_process[limb]] && !isnull(nice_aug_names[limb][preferences.augments[limbs_to_process[limb]]]))
			chosen_augment = nice_aug_names[limb][preferences.augments[limbs_to_process[limb]]]
		else
			chosen_augment = LIMBS_DEFAULT_NAME
		var/list/choices = GLOB.body_markings_per_limb[limb].Copy()
		if (!allow_mismatched_parts)
			for (var/name in choices)
				var/datum/body_marking/marking = GLOB.body_markings[name]
				if (marking.recommended_species && !(initial(species_type.id) in marking.recommended_species))
					choices -= name
		limbs_data += list(list(
			"slot" = limb,
			"name" = limbs_to_process[limb],
			"can_augment" = aug_support[limb],
			"chosen_aug" = chosen_augment,
			"chosen_style" = preferences.augment_limb_styles[limbs_to_process[limb]] ? preferences.augment_limb_styles[limbs_to_process[limb]] : LIMBS_DEFAULT_NAME,
			"aug_choices" = nice_aug_names[limb],
			"costs" = costs[AUGMENT_CATEGORY_LIMBS],
			"markings" = list(
				"marking_choices" = choices,
				"markings_list" = fix_colors_on_markings_to_tgui(preferences.body_markings[limb], limb)
			),
		))

	data["limbs_data"] = limbs_data

	var/list/organs_data = list()
	for(var/organ in organs_to_process)
		if(!nice_aug_names[organ])
			nice_aug_names[organ] = list()
			for(var/augment in GLOB.augment_slot_to_items[organs_to_process[organ]])
				var/obj/item/aug = augment
				var/datum/augment_item/expensive_augment = GLOB.augment_items[augment]
				var/cost = 0
				var/name = initial(aug.name)
				if (expensive_augment)
					cost = expensive_augment.cost
					name = expensive_augment.name
				// To display the cost of the limb, if it's anything aside from 0.
				var/aug_name = cost != 0 ? name + " ([cost])" : name
				costs[AUGMENT_CATEGORY_ORGANS][aug_name] = cost
				nice_aug_names[organ][augment] = aug_name
				augment_to_path[aug_name] = augment
			nice_aug_names[organ]["organic"] = ORGANS_DEFAULT_NAME
		var/chosen_organ
		if(preferences.augments[organs_to_process[organ]] && !isnull(nice_aug_names[organ][preferences.augments[organs_to_process[organ]]]))
			chosen_organ = nice_aug_names[organ][preferences.augments[organs_to_process[organ]]]
		else
			chosen_organ = ORGANS_DEFAULT_NAME
		organs_data += list(list(
			"slot" = organ,
			"name" = organs_to_process[organ],
			"chosen_organ" = chosen_organ,
			"organ_choices" = nice_aug_names[organ],
			"costs" = costs[AUGMENT_CATEGORY_ORGANS]
		))

	data["organs_data"] = organs_data

	var/list/presets = GLOB.body_marking_sets.Copy()
	if (!allow_mismatched_parts)
		for (var/name in presets)
			var/datum/body_marking_set/BMS = presets[name]
			if (BMS.recommended_species && !(initial(species_type.id) in BMS.recommended_species))
				presets -= name

	data["marking_presets"] = presets

	return data

#undef LIMBS_DEFAULT_NAME
#undef ORGANS_DEFAULT_NAME
