#define LOG_CATEGORY_FLOXY "floxy"

/datum/log_category/floxy
	category = LOG_CATEGORY_FLOXY

/proc/log_floxy(text, list/data)
	logger.Log(LOG_CATEGORY_FLOXY, text, data)

#undef LOG_CATEGORY_FLOXY
