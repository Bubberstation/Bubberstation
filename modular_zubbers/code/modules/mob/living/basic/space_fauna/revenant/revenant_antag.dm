// revenant antag datum is given on login, so this should be fine
/datum/antagonist/revenant/on_gain()
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(pick_name), owner.current)

/datum/antagonist/revenant/proc/pick_name(mob/living/basic/revenant/revenant)
	if(!istype(revenant))
		CRASH("Somehow a non-revenant got a revenant antag datum?")
	while(revenant?.client)
		var/new_name = reject_bad_text(tgui_input_text(revenant, "Would you like to change your ghostly name to something else?", "Spooky Identity", revenant.name, MAX_NAME_LEN, encode = FALSE))
		if(!new_name || new_name == revenant.name)
			if(tgui_alert(revenant, "Are you sure you would like to keep your default name of \"[revenant.name]\"?", "Spooky Identity", list("Yes", "No")) == "Yes")
				return
			else
				continue
		new_name = sanitize_name(new_name, allow_numbers = TRUE)
		if(!new_name)
			if(tgui_alert(revenant, "Invalid name, please pick another!", "Spooky Identity", list("Try Again", "Keep Default Name")) == "Try Again")
				continue
			else
				return

		revenant.log_message("set their revenant name to [new_name]", LOG_OWNERSHIP)
		message_admins("[ADMIN_LOOKUPFLW(revenant)] has changed their revenant name to \"[span_name(new_name)]\"")
		revenant.fully_replace_character_name(null, new_name)
		to_chat(revenant, span_revennotice("Your name is now \"[span_name(new_name)]\"."), type = MESSAGE_TYPE_INFO)
		return
