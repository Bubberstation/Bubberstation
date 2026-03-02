#define CURRENT_PRIVACY_VERSION 1

/datum/privacy_policy_ui
	var/client/owner

/datum/privacy_policy_ui/New(client/client_mob)
	owner = client_mob
	..()

/datum/privacy_policy_ui/ui_state(mob/user)
	return GLOB.always_state

/datum/privacy_policy_ui/ui_close(mob/user)
	if(owner?.prefs?.privacy_policy_acknowledged != TRUE)
		if(owner)
			to_chat(owner, span_danger("You must accept the Privacy Policy to continue playing."))
			qdel(owner)
	qdel(src)

/datum/privacy_policy_ui/ui_data(mob/user)
	return list(
		"policy_text" = file2text("config/privacy_policy.txt")
	)

/datum/privacy_policy_ui/ui_act(action, params, datum/tgui/ui)
	. = ..()
	switch(action)
		if("accept")
			if(owner?.prefs)
				owner.prefs.privacy_policy_acknowledged = TRUE
				owner.prefs.save_preferences()
			ui.close()
			return TRUE

	return FALSE

/datum/privacy_policy_ui/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(ui)
		return

	ui = new /datum/tgui(user, src, "PrivacyPolicy")
	ui.open()

/client/proc/show_privacy_policy()
	if(!mob)
		return

	var/datum/privacy_policy_ui/ui = new(src)
	ui.ui_interact(mob)

#undef CURRENT_PRIVACY_VERSION
