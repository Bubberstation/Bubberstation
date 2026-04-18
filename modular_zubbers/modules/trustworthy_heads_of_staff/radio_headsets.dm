/// Gives access to sec comms at amber level or above.

/obj/item/encryptionkey/heads/Initialize(mapload)
	. = ..()
	RegisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED, PROC_REF(check_security_level))

/obj/item/encryptionkey/heads/proc/check_security_level(datum/source, new_level)
	SIGNAL_HANDLER
	var/a = channels
	var/b = initial(channels)
	var/c = initial(channels)[RADIO_CHANNEL_SECURITY]
	var/has_sec_access_default = !isnull(initial(channels)[RADIO_CHANNEL_SECURITY])

	if(!has_sec_access_default)
		switch(new_level)
			if(SEC_LEVEL_AMBER)
				add_temp_sec_access()
			if(SEC_LEVEL_RED)
				add_temp_sec_access()
			if(SEC_LEVEL_DELTA)
				add_temp_sec_access()
			if(SEC_LEVEL_EPSILON)
				add_temp_sec_access()
			if(SEC_LEVEL_GAMMA)
				add_temp_sec_access()
			else
				remove_sec_access()

/obj/item/encryptionkey/heads/proc/add_temp_sec_access()
	if(isnull(channels[RADIO_CHANNEL_SECURITY]))
		channels[RADIO_CHANNEL_SECURITY] = 1

/obj/item/encryptionkey/heads/proc/remove_temp_sec_access()
	if(!isnull(channels[RADIO_CHANNEL_SECURITY]))
		channels -= RADIO_CHANNEL_SECURITY
