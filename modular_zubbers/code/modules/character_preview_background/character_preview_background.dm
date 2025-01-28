/// Enables the choice of background in the character preview menu
/datum/preference/choiced/bgstate
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "bgstate"
	savefile_identifier = PREFERENCE_CHARACTER
	should_generate_icons = FALSE

/datum/preference/choiced/apply_to_client(client/client, value)
	. = ..()
	if(SStgui.get_open_ui(client, client.prefs))
		INVOKE_ASYNC(client.prefs.character_preview_view, TYPE_PROC_REF(/atom/movable/screen/map_view/char_preview, update_body))

GLOBAL_LIST_INIT(bgstate_options, list(
	"000",
	"midgrey",
	"FFF",
	"white",
	"plasteel",
	"dark" ,
	"plating",
	"reinforced",
	))

/datum/preference/choiced/bgstate/create_default_value()
	return "000"

/datum/preference/choiced/bgstate/init_possible_values()
	return GLOB.bgstate_options

/datum/preference/choiced/bgstate/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return
