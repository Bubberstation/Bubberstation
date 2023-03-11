/datum/config_entry/flag/disable_erp_preferences
	default = FALSE

/datum/config_entry/flag/disable_lewd_items
	default = FALSE

/datum/config_entry/str_list/erp_emotes_to_disable

/datum/config_entry/str_list/erp_emotes_to_disable/ValidateAndSet(str_val)
	. = ..()
	if (CONFIG_GET(flag/disable_erp_preferences) && (str_val in GLOB.keybindings_by_name))
		GLOB.keybindings_by_name -= str_val

/datum/preference/toggle/master_erp_preferences
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "master_erp_pref"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/preference/toggle/master_erp_preferences/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return TRUE

/datum/preference/toggle/master_erp_preferences/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	. = ..()

/datum/preference/toggle/erp
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_identifier = PREFERENCE_PLAYER
	savefile_key = "erp_pref"
	default_value = FALSE

/datum/preference/toggle/erp/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/toggle/erp/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return FALSE
	. = ..()

/datum/preference/toggle/erp/apply_to_client_updated(client/client, value)
	. = ..()
	var/mob/living/carbon/human/target = client?.mob
	if(!value && istype(target))
		target.arousal = 0
		target.pain = 0
		target.pleasure = 0

/datum/preference/toggle/erp/sex_toy
	savefile_key = "sextoy_pref"

/datum/preference/toggle/erp/sex_toy/apply_to_client_updated(client/client, value)
	apply_to_client(client, value)
	if(!value)
		if(ishuman(client.mob))
			var/mob/living/carbon/human/target = client.mob
			if(target.vagina != null)
				target.dropItemToGround(target.vagina, TRUE, target.loc, TRUE, FALSE, TRUE)
			if(target.anus != null)
				target.dropItemToGround(target.anus, TRUE, target.loc, TRUE, FALSE, TRUE)
			if(target.nipples != null)
				target.dropItemToGround(target.nipples, TRUE, target.loc, TRUE, FALSE, TRUE)
			if(target.penis != null)
				target.dropItemToGround(target.penis, TRUE, target.loc, TRUE, FALSE, TRUE)


	client.mob.hud_used.hidden_inventory_update(client.mob)
	client.mob.hud_used.persistent_inventory_update(client.mob)

/datum/preference/toggle/erp/bimbofication
	savefile_key = "bimbofication_pref"

/datum/preference/toggle/erp/aphro
	savefile_key = "aphro_pref"

/datum/preference/toggle/erp/breast_enlargement
	savefile_key = "breast_enlargement_pref"
	
/datum/preference/toggle/erp/breast_shrinkage
	savefile_key = "breast_shrinkage_pref"

/datum/preference/toggle/erp/penis_enlargement
	savefile_key = "penis_enlargement_pref"
	
/datum/preference/toggle/erp/penis_shrinkage
	savefile_key = "penis_shrinkage_pref"

/datum/preference/toggle/erp/genitalia_removal
	savefile_key = "genitalia_removal_pref"	

/datum/preference/toggle/erp/gender_change
	savefile_key = "gender_change_pref"

/datum/preference/toggle/erp/autocum
	savefile_key = "autocum_pref"

/datum/preference/toggle/erp/autoemote
	savefile_key = "autoemote_pref"

/datum/preference/toggle/erp/new_genitalia_growth
	savefile_key = "new_genitalia_growth_pref"

/datum/preference/choiced/erp_status
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref"

/datum/preference/choiced/erp_status/init_possible_values()
	return list("Yes - Switch", "Yes - Sub", "Yes - Dom", "Check OOC", "Ask", "No")

/datum/preference/choiced/erp_status/create_default_value()
	return "Ask"

/datum/preference/choiced/erp_status/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_status/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "disabled"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "No"
	. = ..()

/datum/preference/choiced/erp_status/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/erp_status_nc
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref_nc"

/datum/preference/choiced/erp_status_nc/init_possible_values()
	return list("Yes - Switch", "Yes - Sub", "Yes - Dom", "Check OOC", "Ask", "No")

/datum/preference/choiced/erp_status_nc/create_default_value()
	return "Ask"

/datum/preference/choiced/erp_status_nc/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_status_nc/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "No"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "No"
	. = ..()

/datum/preference/choiced/erp_status_nc/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/erp_status_v
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref_v"

/datum/preference/choiced/erp_status_v/init_possible_values()
	return list("Yes - Switch", "Yes - Prey", "Yes - Pred", "Check OOC", "Ask", "No")

/datum/preference/choiced/erp_status_v/create_default_value()
	return "Ask"

/datum/preference/choiced/erp_status_v/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_status_v/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "No"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "No"
	. = ..()

/datum/preference/choiced/erp_status_v/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/erp_status_mechanics
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref_mechanics"

/datum/preference/choiced/erp_status_mechanics/init_possible_values()
	return list("Roleplay only", "Mechanical only", "Mechanical and Roleplay", "None")

/datum/preference/choiced/erp_status_mechanics/create_default_value()
	return "None"

/datum/preference/choiced/erp_status_mechanics/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_status_mechanics/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "None"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "None"
	. = ..()

/datum/preference/choiced/erp_status_mechanics/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/erp_sexuality
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_identifier = PREFERENCE_PLAYER
	savefile_key = "erp_sexuality_pref"

/datum/preference/choiced/erp_sexuality/init_possible_values()
	return list("Gay", "Straight", "None") // For simplicity's sake we only have 3 options.

/datum/preference/choiced/erp_sexuality/create_default_value()
	return "None"

/datum/preference/choiced/erp_sexuality/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_sexuality/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "None"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "None"
	. = ..()

/datum/preference/choiced/erp_sexuality/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
