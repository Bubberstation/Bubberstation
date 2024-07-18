ADMIN_VERB(discordbunker, R_SERVER, "Toggle Discord Bunker", "Toggles the Discord Bunker on or off.", ADMIN_CATEGORY_SERVER)
	if(!SSdbcore.IsConnected())
		to_chat(user, span_adminnotice("The Database is not connected/enabled!"))
		return

	var/new_dbun = !CONFIG_GET(flag/discord_bunker)
	CONFIG_SET(flag/discord_bunker, new_dbun)

	log_admin("[key_name(user)] has toggled the Discord Bunker, it is now [new_dbun ? "on" : "off"]")
	message_admins("[key_name_admin(user)] has toggled the Discord Bunker, it is now [new_dbun ? "enabled" : "disabled"].")
	SSblackbox.record_feedback("nested tally", "discord_toggle", 1, list("Toggle Discord Bunker", "[new_dbun ? "Enabled" : "Disabled"]"))
	send2adminchat("Discord Bunker", "[key_name(user)] has toggled the Discord Bunker, it is now [new_dbun ? "enabled" : "disabled"].")

ADMIN_VERB(adddiscordbypass, R_SERVER, "Add Discord Bypass", "Allows a given ckey to connect through the discord bunker for the round even if they haven't verified yet.", ADMIN_CATEGORY_SERVER, ckeytobypass as text)
	if(!SSdbcore.IsConnected())
		to_chat(user, span_adminnotice("The Database is not connected!"))
		return
	if(!SSdiscord)
		to_chat(user, span_adminnotice("The discord subsystem hasn't initialized yet!"))
		return
	if(!CONFIG_GET(flag/discord_bunker))
		to_chat(user, span_adminnotice("The Discord Bunker is deactivated!"))
		return

	GLOB.discord_passthrough |= ckey(ckeytobypass)
	GLOB.discord_passthrough[ckey(ckeytobypass)] = world.realtime
	log_admin("[key_name(user)] has added [ckeytobypass] to the current round's discord bypass list.")
	message_admins("[key_name_admin(user)] has added [ckeytobypass] to the current round's discord bypass list.")
	send2adminchat("Discord Bunker", "[key_name(user)] has added [ckeytobypass] to the current round's discord bypass list.")

ADMIN_VERB(revokediscordbypass, R_SERVER, "Revoke Discord Bypass", "Revoke's a ckey's permission to bypass the discord bunker for a given round.", ADMIN_CATEGORY_SERVER, ckeytobypass as text)
	if(!SSdbcore.IsConnected())
		to_chat(user, span_adminnotice("The Database is not connected!"))
		return
	if(!SSdiscord)
		to_chat(user, span_adminnotice("The discord subsystem hasn't initialized yet!"))
		return
	if(!CONFIG_GET(flag/discord_bunker))
		to_chat(user, span_adminnotice("The Discord Bunker is deactivated!"))
		return

	GLOB.discord_passthrough -= ckey(ckeytobypass)
	log_admin("[key_name(user)] has removed [ckeytobypass] from the current round's discord bypass list.")
	message_admins("[key_name_admin(user)] has removed [ckeytobypass] from the current round's discord bypass list.")
	send2adminchat("Discord Bunker", "[key_name(user)] has removed [ckeytobypass] from the current round's discord bypass list.")
