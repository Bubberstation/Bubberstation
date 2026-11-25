/// Logging for vampire powers unlocked.
/proc/log_vampire_power(text, list/data)
	logger.Log(LOG_CATEGORY_UPLINK_VAMPIRE, text, data)

/datum/log_category/uplink_vampire
	category = LOG_CATEGORY_UPLINK_VAMPIRE
	config_flag = /datum/config_entry/flag/log_uplink
	master_category = /datum/log_category/uplink
