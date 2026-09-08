/// Hidden player prefs for Scene Assistant. Edited from the panel, not the prefs menu.

/proc/sanitize_scene_assistant_font(font_name)
	if(!istext(font_name))
		return "Verdana"
	var/cleaned = trim(STRIP_HTML_SIMPLE(font_name, 64))
	if(!length(cleaned))
		return "Verdana"
	var/static/list/disallowed_font_chars = list(";", ":", "(", ")", "<", ">", "\\", "/", "[", "]", "{", "}", "@", "!", "#", "$", "%", "^", "*", "=", "+")
	for(var/bad_char in disallowed_font_chars)
		if(findtext(cleaned, bad_char))
			return "Verdana"
	return cleaned

/datum/preference/toggle/scene_assistant_show_avatars
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_show_avatars"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/preference/toggle/scene_assistant_show_avatars/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/scene_assistant_avatar_size
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_avatar_size"
	savefile_identifier = PREFERENCE_PLAYER
	minimum = 32
	maximum = 128
	step = 1

/datum/preference/numeric/scene_assistant_avatar_size/create_default_value()
	return 64

/datum/preference/numeric/scene_assistant_avatar_size/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/text/scene_assistant_font
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_font"
	savefile_identifier = PREFERENCE_PLAYER
	maximum_value_length = 64

/datum/preference/text/scene_assistant_font/create_default_value()
	return "Verdana"

/datum/preference/text/scene_assistant_font/deserialize(input, datum/preferences/preferences)
	return sanitize_scene_assistant_font(..())

/datum/preference/text/scene_assistant_font/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/scene_assistant_font_size
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_font_size"
	savefile_identifier = PREFERENCE_PLAYER
	minimum = 80
	maximum = 150
	step = 1

/datum/preference/numeric/scene_assistant_font_size/create_default_value()
	return 100

/datum/preference/numeric/scene_assistant_font_size/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/scene_assistant_line_spacing
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_line_spacing"
	savefile_identifier = PREFERENCE_PLAYER
	minimum = 1
	maximum = 2
	step = 0.05

/datum/preference/numeric/scene_assistant_line_spacing/create_default_value()
	return 1.35

/datum/preference/numeric/scene_assistant_line_spacing/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/scene_assistant_theme
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_theme"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/choiced/scene_assistant_theme/init_possible_values()
	return list("default", "light", "cream", "strawberry", "super_dark", "apple")

/datum/preference/choiced/scene_assistant_theme/create_default_value()
	return "default"

/datum/preference/choiced/scene_assistant_theme/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/scene_assistant_soundpack
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_soundpack"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/choiced/scene_assistant_soundpack/init_possible_values()
	return list("default", "simpleandsweet", "delicate", "funkyou", "gravitas", "8bitautumn")

/datum/preference/choiced/scene_assistant_soundpack/create_default_value()
	return "default"

/datum/preference/choiced/scene_assistant_soundpack/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/scene_assistant_sound_message
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_sound_message"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/preference/toggle/scene_assistant_sound_message/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/scene_assistant_sound_join
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_sound_join"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/preference/toggle/scene_assistant_sound_join/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/scene_assistant_sound_leave
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_sound_leave"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/preference/toggle/scene_assistant_sound_leave/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/scene_assistant_volume_message
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_volume_message"
	savefile_identifier = PREFERENCE_PLAYER
	minimum = 0
	maximum = 100
	step = 1

/datum/preference/numeric/scene_assistant_volume_message/create_default_value()
	return 50

/datum/preference/numeric/scene_assistant_volume_message/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/scene_assistant_volume_join
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_volume_join"
	savefile_identifier = PREFERENCE_PLAYER
	minimum = 0
	maximum = 100
	step = 1

/datum/preference/numeric/scene_assistant_volume_join/create_default_value()
	return 50

/datum/preference/numeric/scene_assistant_volume_join/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/scene_assistant_volume_leave
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "scene_assistant_volume_leave"
	savefile_identifier = PREFERENCE_PLAYER
	minimum = 0
	maximum = 100
	step = 1

/datum/preference/numeric/scene_assistant_volume_leave/create_default_value()
	return 50

/datum/preference/numeric/scene_assistant_volume_leave/is_accessible(datum/preferences/preferences)
	return FALSE
