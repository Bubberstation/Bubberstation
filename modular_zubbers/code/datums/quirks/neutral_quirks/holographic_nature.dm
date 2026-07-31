/datum/quirk/holographic_nature
	name = "Holographic Nature"
	desc = "You are a being of hardlight, still physical, but you look marginally cooler"
	icon = FA_ICON_ALIGN_CENTER
	medical_record_text = "Patient seems to be barely corporeal"
	gain_text = span_notice("You can see the floor through your body")
	lose_text = span_notice("When did you get a body?")
	quirk_flags = QUIRK_HIDE_FROM_SCAN | QUIRK_CHANGES_APPEARANCE

/datum/quirk_constant_data/holographic_nature
	associated_typepath = /datum/quirk/holographic_nature
	customization_options = list(
		/datum/preference/color/holographic_nature_color,
	)

/datum/preference/color/holographic_nature_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "holographic_nature__color"

/datum/preference/color/holographic_nature_color/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/quirk/holographic_nature/add(client/client_source)
	var/chosen_color = client_source?.prefs.read_preference(/datum/preference/color/holographic_nature_color)
	var/default_color = rgb2hsv("#7DB4E1")
	if(chosen_color)
		var/quirkholder_color = rgb2hsv(chosen_color)

		default_color[1] = quirkholder_color[1]

		default_color = hsv2rgb(default_color)

	quirk_holder.makeHologram(0.62, default_color)
	quirk_holder.AddComponent(/datum/component/holographic_nature)
/datum/quirk/holographic_nature/remove(client/client_source)
	quirk_holder.remove_filter(list("HOLO: Color and Transparent", "HOLO: Scanline"))
	var/datum/component/holo_component = quirk_holder.GetComponent(/datum/component/holographic_nature)
	holo_component?.Destroy()
