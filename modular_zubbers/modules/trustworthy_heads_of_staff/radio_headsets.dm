/// Gives access to sec comms at amber alert level or above.

/obj/item/encryptionkey/heads
	var/grants_temp_sec_channel = FALSE

/obj/item/encryptionkey/heads/Initialize(mapload)
	. = ..()
	if(isnull(channels[RADIO_CHANNEL_SECURITY]))
		grants_temp_sec_channel = TRUE
	RegisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED, PROC_REF(check_security_level))

/obj/item/encryptionkey/heads/proc/check_security_level(datum/source, new_level)
	SIGNAL_HANDLER
	if(grants_temp_sec_channel)
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
				remove_temp_sec_access()

/obj/item/encryptionkey/heads/proc/add_temp_sec_access()
	if(isnull(channels[RADIO_CHANNEL_SECURITY]))
		channels[RADIO_CHANNEL_SECURITY] = 1

/obj/item/encryptionkey/heads/proc/remove_temp_sec_access()
	if(!isnull(channels[RADIO_CHANNEL_SECURITY]))
		channels -= RADIO_CHANNEL_SECURITY

/obj/item/radio/Initialize(mapload)
	. = ..()
	RegisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED, PROC_REF(check_security_level))
/obj/item/radio/proc/check_security_level()
	recalculateChannels()

/*
/obj/item/encryptionkey/heads/rd
	grants_temp_sec_channel = TRUE

/obj/item/encryptionkey/heads/hos
	grants_temp_sec_channel = TRUE

/obj/item/encryptionkey/heads/ce
	grants_temp_sec_channel = TRUE

/obj/item/encryptionkey/heads/cmo
	grants_temp_sec_channel = TRUE

/obj/item/encryptionkey/heads/hop
	grants_temp_sec_channel = TRUE

/obj/item/encryptionkey/heads/qm
	grants_temp_sec_channel = TRUE
	*/
