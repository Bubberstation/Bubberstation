/// Antag prompts get their own log file rather than sharing the antag ticket category.
/datum/log_category/antag_prompt
	category = LOG_CATEGORY_ANTAG_PROMPT
	config_flag = /datum/config_entry/flag/log_antag_prompt
	master_category = /datum/log_category/game

/proc/log_antag_prompt(text, list/data)
	logger.Log(LOG_CATEGORY_ANTAG_PROMPT, text, data)
