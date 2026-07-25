// Job estimation code, this appears on the statpanel before roundstart
// Credit: https://github.com/DaedalusDock/daedalusdock/pull/377

/datum/config_entry/flag/show_job_estimation
	default = TRUE

/datum/preference/toggle/ready_job
	savefile_key = "ready_job"
	savefile_identifier = PREFERENCE_PLAYER
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = TRUE

/datum/preference/toggle/ready_job/apply_to_human(mob/living/carbon/human/target, value, /datum/preferences/preferences)
	return FALSE

/mob/dead/get_status_tab_items()
	.=..()
	//Adds the Job Estimation panel to the end of the Statpanel.
	if(CONFIG_GET(flag/show_job_estimation) && SSticker.current_state == GAME_STATE_PREGAME)
		. += SSticker.job_estimation_list
