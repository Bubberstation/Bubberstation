#define BORDER_CONTROL_DISABLED 0
#define BORDER_CONTROL_LEARNING 1
#define BORDER_CONTROL_ENFORCED 2


GLOBAL_LIST_EMPTY(whitelistedCkeys)
GLOBAL_VAR_INIT(borderControlFile, new /savefile("data/bordercontrol.db"))
GLOBAL_VAR_INIT(whitelistLoaded, FALSE)

//////////////////////////////////////////////////////////////////////////////////
proc/BC_ModeToText(mode)
	switch(mode)
		if(BORDER_CONTROL_DISABLED)
			return "Disabled"
		if(BORDER_CONTROL_LEARNING)
			return "Learning"
		if(BORDER_CONTROL_ENFORCED)
			return "Enforced"

//////////////////////////////////////////////////////////////////////////////////
proc/BC_IsKeyAllowedToConnect(key)
	key = ckey(key)

	var/borderControlMode = CONFIG_GET(number/border_control)

	if(borderControlMode == BORDER_CONTROL_DISABLED)
		return 1
	else if (borderControlMode == BORDER_CONTROL_LEARNING)
		if(!BC_IsKeyWhitelisted(key))
			log_and_message_admins("[key] has joined and was added to the border whitelist.")
		BC_WhitelistKey(key)
		return 1
	else
		return BC_IsKeyWhitelisted(key)

//////////////////////////////////////////////////////////////////////////////////
proc/BC_IsKeyWhitelisted(key)
	key = ckey(key)

	if(!GLOB.whitelistLoaded)
		BC_LoadWhitelist()

	if(LAZYISIN(GLOB.whitelistedCkeys, key))
		return 1
	else
		return 0

//////////////////////////////////////////////////////////////////////////////////
//ADMIN_VERB_ADD(/client/proc/BC_WhitelistKeyVerb, R_ADMIN, FALSE)
///client/proc/BC_WhitelistKeyVerb()
/datum/admins/proc/BC_WhitelistKeyVerb()

	set name = "Border Control - Whitelist Key"
	set category = "Admin.Border Control"

	var/key = input("CKey to Whitelist", "Whitelist Key") as null|text

	if(key)
		var/confirm = alert("Add [key] to the border control whitelist?", , "Yes", "No")
		if(confirm == "Yes")
			log_and_message_admins("added [key] to the border whitelist.")
			BC_WhitelistKey(key)


//////////////////////////////////////////////////////////////////////////////////
proc/BC_WhitelistKey(key)
	var/keyAsCkey = ckey(key)

	if(!GLOB.whitelistLoaded)
		BC_LoadWhitelist()

	if(!keyAsCkey)
		return 0
	else
		if(LAZYISIN(GLOB.whitelistedCkeys,keyAsCkey))
			// Already in
			return 0
		else
			LAZYINITLIST(GLOB.whitelistedCkeys)

			ADD_SORTED(GLOB.whitelistedCkeys, keyAsCkey, /proc/cmp_text_asc)

			BC_SaveWhitelist()
			return 1



//////////////////////////////////////////////////////////////////////////////////
//ADMIN_VERB_ADD(/client/proc/BC_RemoveKeyVerb, R_ADMIN, FALSE)
///client/proc/BC_RemoveKeyVerb()
/datum/admins/proc/BC_RemoveKeyVerb()

	set name = "Border Control - Remove Key"
	set category = "Admin.Border Control"

	var/keyToRemove = input("CKey to Remove", "Remove Key") as null|anything in GLOB.whitelistedCkeys

	if(keyToRemove)
		var/confirm = alert("Remove [keyToRemove] from the border control whitelist?", , "Yes", "No")
		if(confirm == "Yes")
			log_and_message_admins("removed [keyToRemove] from the border whitelist.")
			BC_RemoveKey(keyToRemove)

	return


//////////////////////////////////////////////////////////////////////////////////
proc/BC_RemoveKey(key)
	key = ckey(key)

	if(!LAZYISIN(GLOB.whitelistedCkeys, key))
		return 1
	else
		if(GLOB.whitelistedCkeys)
			GLOB.whitelistedCkeys.Remove(key)
		BC_SaveWhitelist()
		return 1




//////////////////////////////////////////////////////////////////////////////////
//ADMIN_VERB_ADD(/client/proc/BC_ToggleState, R_ADMIN, FALSE)
///client/proc/BC_ToggleState()
/datum/admins/proc/BC_ToggleState()

	set name = "Border Control - Toggle Mode"
	set category = "Admin.Border Control"
	set desc="Enables or disables border control"

	var/borderControlMode = CONFIG_GET(number/border_control)

	var/choice = input("New State (Current state is: [BC_ModeToText(borderControlMode)])", "Border Control State") as null|anything in list("Disabled", "Learning", "Enforced")

	switch(choice)
		if("Disabled")
			if(borderControlMode != BORDER_CONTROL_DISABLED)
				borderControlMode = BORDER_CONTROL_DISABLED
				log_and_message_admins("has disabled border control.")
		if("Learning")
			if(borderControlMode != BORDER_CONTROL_LEARNING)
				borderControlMode = BORDER_CONTROL_LEARNING
				log_and_message_admins("has set border control to learn new keys on connection!")
			var/confirm = alert("Learn currently connected keys?", , "Yes", "No")
			if(confirm == "Yes")
				for(var/client/C in GLOB.clients)
					if (BC_WhitelistKey(C.key))
						log_and_message_admins("[key_name(usr)] added [C.key] to the border whitelist by adding all current clients.")

		if("Enforced")
			if(borderControlMode != BORDER_CONTROL_ENFORCED)
				borderControlMode = BORDER_CONTROL_ENFORCED
				log_and_message_admins("has enforced border controls. New keys can no longer join.")

	CONFIG_SET(number/border_control, borderControlMode)

	return


//////////////////////////////////////////////////////////////////////////////////

/hook/startup/proc/loadBorderControlWhitelistHook()
	BC_LoadWhitelist()
	return 1

//////////////////////////////////////////////////////////////////////////////////
/proc/BC_LoadWhitelist()

	LAZYCLEARLIST(GLOB.whitelistedCkeys)

	LAZYINITLIST(GLOB.whitelistedCkeys)

	if(!GLOB.borderControlFile)
		return 0

	GLOB.borderControlFile["WhitelistedCkeys"] >> GLOB.whitelistedCkeys

	GLOB.whitelistLoaded = 1


//////////////////////////////////////////////////////////////////////////////////
proc/BC_SaveWhitelist()
	if(!GLOB.whitelistedCkeys)
		return 0

	if(!GLOB.borderControlFile)
		return 0

	GLOB.borderControlFile["WhitelistedCkeys"] << GLOB.whitelistedCkeys
