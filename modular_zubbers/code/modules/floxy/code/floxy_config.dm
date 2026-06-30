/datum/config_entry/string/floxy_url
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/string/floxy_url/ValidateAndSet(str_val)
	if(!is_http_protocol(str_val))
		return FALSE
	return ..()

/datum/config_entry/string/floxy_username
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/floxy_password
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN
