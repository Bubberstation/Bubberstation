/// Used to handle global hooks like Login and process bellies
PROCESSING_SUBSYSTEM_DEF(vore)
	name = "Vore Belly Ticker"
	wait = 2 SECONDS
	flags = SS_KEEP_TIMING

/datum/controller/subsystem/processing/vore/Initialize()
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGGED_IN, PROC_REF(on_mob_login))
	return SS_INIT_SUCCESS

/datum/controller/subsystem/processing/vore/Destroy()
	UnregisterSignal(SSdcs, list(COMSIG_GLOB_MOB_LOGGED_IN))
	. = ..()

/datum/controller/subsystem/processing/vore/proc/on_mob_login(datum/source, mob/new_login)
	SIGNAL_HANDLER
	if(is_type_in_typecache(new_login, GLOB.vore_allowed_mob_types) && new_login.client)
		var/enable_vore = new_login.client.prefs.read_preference(/datum/preference/toggle/erp/vore_enable)
		if(enable_vore)
			// vore is COMPONENT_DUPE_UNIQUE so this is safe to just call even if they already had vore enabled
			new_login._AddComponent(list(/datum/component/vore))

