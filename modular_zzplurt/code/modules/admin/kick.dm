ADMIN_VERB(kick, R_ADMIN, "Kick", "Kicks a client from the server.", ADMIN_CATEGORY_GAME, mob/target in world)
	if(!ismob(target))
		to_chat(usr, span_danger("Error: Target is not a mob. Please try again."))
		return
	if(!check_if_greater_rights_than(target.client))
		to_chat(usr, span_danger("Error: They have more rights than you do."), confidential = TRUE)
		return
	if(tgui_alert(usr, "Kick [key_name(target)]?", "Confirm", list("Yes", "No")) != "Yes")
		return
	if(!target)
		to_chat(usr, span_danger("Error: [target] no longer exists!"), confidential = TRUE)
		return
	if(!target.client)
		to_chat(usr, span_danger("Error: [target] no longer has a client!"), confidential = TRUE)
		return
	to_chat(target, span_danger("You have been kicked from the server by [usr.client.holder.fakekey ? "an Administrator" : "[usr.client.key]"]."), confidential = TRUE)
	log_admin("[key_name(usr)] kicked [key_name(target)].")
	message_admins(span_adminnotice("[key_name_admin(usr)] kicked [key_name_admin(target)]."))
	qdel(target.client)
	BLACKBOX_LOG_ADMIN_VERB("Kick")
