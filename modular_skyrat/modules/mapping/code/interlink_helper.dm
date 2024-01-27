/// A file to help with making it possible to load the Interlink *modularly* instead of leaving it stuck in Z-2 where station should be and spawning all manner of bad behaviour.
#define INIT_ANNOUNCE(X) to_chat(world, span_boldannounce("[X]")); log_world(X)

/datum/controller/subsystem/mapping/loadWorld()
	. = ..()
	var/list/FailedZsRat = list()
	LoadGroup(FailedZsRat, "The Interlink", "bubber/map_files/centcom", "CentCom_bubber_z2.dmm", default_traits = ZTRAITS_CENTCOM) //Bubber edit: New Interlink map
	if(LAZYLEN(FailedZsRat)) //but seriously, unless the server's filesystem is messed up this will never happen
		var/msg = "RED ALERT! The following map files failed to load: [FailedZsRat[1]]"
		if(FailedZsRat.len > 1)
			for(var/I in 2 to FailedZsRat.len)
				msg += ", [FailedZsRat[I]]"
		msg += ". Yell at your server host!"
		INIT_ANNOUNCE(msg)

#undef INIT_ANNOUNCE
