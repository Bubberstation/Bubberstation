/datum/controller/subsystem/discord/Initialize()
	. = ..()
	delete_nulls()


/datum/controller/subsystem/discord/proc/check_login(mob/dead/new_player/player)
	. = TRUE
	if(!(SSdbcore.IsConnected() && CONFIG_GET(flag/discord_bunker) && CONFIG_GET(string/discordbotcommandprefix))) //If not configured/using DB
		return TRUE
	if(!player.client) //Safety check
		return FALSE
	if(player.client?.ckey in GLOB.discord_passthrough) //If they have bypass
		return TRUE

	var/datum/discord_link_record/player_link = find_discord_link_by_ckey(player.client?.ckey, only_valid = TRUE)

	if(!(player_link && player_link?.discord_id))
		return FALSE

/datum/controller/subsystem/discord/proc/delete_nulls()
	var/query = "DELETE FROM [format_table_name("discord_links")] WHERE discord_id IS NULL"
	var/datum/db_query/query_delete_nulls = SSdbcore.NewQuery(
		query
	)
	if(!query_delete_nulls.Execute())
		log_runtime("DATABASE: There was an error while deleting NULL discord IDs") // This codebase doesn't have a subsystem_log()
		message_admins(span_warning("There was an error while deleting NULL IDs, please delete them manually using the Delete Null Discords verb"))
		send2adminchat("Discord Subsystem", "There was an error while deleting NULL IDs, please delete them manually using `!tgs discordnulls`")
		qdel(query_delete_nulls)
		return FALSE

	qdel(query_delete_nulls)
	return TRUE
