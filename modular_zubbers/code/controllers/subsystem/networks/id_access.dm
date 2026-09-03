/datum/controller/subsystem/id_access/setup_access_flags()
	. = ..()
	accesses_by_flag["[ACCESS_FLAG_SPECIAL]"] |= list(ACCESS_MERC)
	flags_by_access |= list("[ACCESS_MERC]" = ACCESS_FLAG_SPECIAL)
