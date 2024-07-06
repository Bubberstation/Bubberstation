/datum/tgs_chat_command/adddiscordpass
	name = "adddiscordpass"
	help_text = "adddiscordpass <ckey> | Add someone to the discord bunker bypass list"
	admin_only = TRUE

/datum/tgs_chat_command/adddiscordpass/Run(datum/tgs_chat_user/sender, params)
	if(!SSdbcore.IsConnected())
		return "The Database is not connected!"
	if(!SSdiscord)
		return "The discord subsystem hasn't initialized yet!"
	if(!CONFIG_GET(flag/discord_bunker))
		return "The Discord Bunker is deactivated!"

	GLOB.discord_passthrough |= ckey(params)
	GLOB.discord_passthrough[ckey(params)] = world.realtime
	log_admin("[sender.friendly_name] has added [params] to the current round's discord bypass list.")
	message_admins("[sender.friendly_name] has added [params] to the current round's discord bypass list.")
	return "[params] has been added to the current round's bunker bypass list."

/datum/tgs_chat_command/revdiscordpass
	name = "revdiscordpass"
	help_text = "revdiscordpass <ckey> | Remove someone from the discord bypass list"
	admin_only = TRUE

/datum/tgs_chat_command/revdiscordpass/Run(datum/tgs_chat_user/sender, params)
	if(!SSdbcore.IsConnected())
		return "The Database is not connected!"
	if(!SSdiscord)
		return "The discord subsystem hasn't initialized yet!"
	if(!CONFIG_GET(flag/discord_bunker))
		return "The Discord Bunker is deactivated!"

	GLOB.discord_passthrough -= ckey(params)
	log_admin("[sender.friendly_name] has removed [params] from the current round's discord bypass list.")
	message_admins("[sender.friendly_name] has removed [params] from the current round's discord bypass list.")
	return "[params] has been removed from the current round's discord bypass list."

/datum/tgs_chat_command/discordnulls
	name = "discordnulls"
	help_text = "Deletes all rows in the database where discord_id is NULL."
	admin_only = TRUE

/datum/tgs_chat_command/discordnulls/Run(datum/tgs_chat_user/sender, params)
	log_admin("[sender.friendly_name] has attempted to delete the NULLs from the discord database.")
	message_admins("[sender.friendly_name] has attempted to delete the NULLs from the discord database.")
	return "[SSdiscord.delete_nulls() ? "NULL rows deleted successfully" : "There was a problem while deleting NULLs"]"
