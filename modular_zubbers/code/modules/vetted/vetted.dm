GLOBAL_LIST_EMPTY(vetted_list_legacy)
GLOBAL_PROTECT(vetted_list_legacy)
GLOBAL_LIST_EMPTY(vetted_list)
GLOBAL_PROTECT(vetted_list)
/datum/controller/subsystem/player_ranks
	var/loaded_vetted_sql = FALSE

/datum/player_rank_controller/vetted
	rank_title = "vetted user"
	var/file_path_vetted

/datum/controller/subsystem/player_ranks/proc/is_vetted(client/user, admin_bypass = TRUE)
	if(!istype(user))
		CRASH("Invalid user type provided to is_vetted(), expected 'client' and obtained '[user ? user.type : "null"]'.")

	if(!CONFIG_GET(flag/check_vetted))
		return TRUE

	if(GLOB.vetted_list[user.ckey])
		return TRUE

	if(admin_bypass && is_admin(user))
		return TRUE

	return FALSE


/datum/controller/subsystem/player_ranks/proc/load_vetted_ckeys()
	PROTECTED_PROC(TRUE)
	if(loaded_vetted_sql)
		return
	if(IsAdminAdvancedProcCall())
		return

	vetted_controller = new
	vetted_controller.file_path_vetted = "[global.config.directory]/bubbers/vetted_players.txt"
	ASYNC
		for(var/line in world.file2list(vetted_controller.file_path_vetted))
			if(!line)
				continue

			if(findtextEx(line, "#", 1, 2))
				continue

			vetted_controller.add_player(line, legacy = TRUE)
			world.log << "Added [line] to vetted list."
		var/datum/db_query/query_load_player_rank = SSdbcore.NewQuery("SELECT * FROM vetted_list")
		if(!query_load_player_rank.warn_execute())
			return
		while(query_load_player_rank.NextRow())
			var/ckey = ckey(query_load_player_rank.item[1])
			vetted_controller.add_player(ckey)
			world.log << "Added [ckey] to vetted list."

	loaded_vetted_sql = TRUE
	return TRUE

/datum/player_rank_controller/vetted/proc/convert_all_to_sql()
	if(!SSdbcore.Connect())
		return message_admins("Failed to connect to database. Unable to complete flat file to SQL conversion.")
	for(var/ckey_ in GLOB.vetted_list_legacy)
		add_player_to_sql(ckey_)

/datum/player_rank_controller/vetted/proc/add_player_to_sql(ckey, admin_mob)
	var/ckey_admin = "Conversion Script"
	var/mob/admin_who_added_client = admin_mob
	if(istype(admin_who_added_client, /mob) && admin_who_added_client.client)
		ckey_admin = admin_who_added_client?.client?.ckey

	var/datum/db_query/query_add_player_rank = SSdbcore.NewQuery(
		"INSERT INTO vetted_list (ckey, admin_who_added) VALUES(:ckey, :admin_who_added)",
		list("ckey" = ckey, "admin_who_added" = ckey_admin),
	)

	if(!query_add_player_rank.warn_execute())
		return FALSE

/datum/player_rank_controller/vetted/add_player(ckey, legacy, admin)
	ckey = ckey(ckey)
	if(legacy)
		GLOB.vetted_list_legacy[ckey] = TRUE
	GLOB.vetted_list[ckey] = TRUE
	add_player_to_sql(ckey, admin)

/datum/player_rank_controller/vetted/remove_player(ckey)
	GLOB.vetted_list -= ckey
	remove_player_from_sql(ckey)

/datum/player_rank_controller/vetted/proc/remove_player_from_sql(ckey)
	var/datum/db_query/query_remove_player_vetted = SSdbcore.NewQuery(
		"DELETE FROM vetted_list WHERE ckey = :ckey",
		list("ckey" = ckey),
	)
	if(!query_remove_player_vetted.warn_execute())
		return FALSE

ADMIN_VERB(convert_flatfile_vettedlist_to_sql, R_DEBUG, "Convert Vetted list to SQL", "Warning! Might be slow!", ADMIN_CATEGORY_DEBUG)
	var/consent = tgui_input_list(usr, "Do you want to convert the vetted list to SQL?", "UH OH", list("Yes", "No"), "No")
	if(consent == "Yes")
		SSplayer_ranks.vetted_controller.convert_all_to_sql()
		message_admins("[usr] has forcefully converted the vetted list file to SQL.")
ADMIN_VERB(add_vetted, R_ADMIN, "Add user to Vetted", "Adds a user to the vetted list", ADMIN_CATEGORY_MAIN)
	var/user_adding = tgui_input_text(usr, "Whom is being added?", "Vetted List")
	if(length(user_adding))
		SSplayer_ranks.vetted_controller.add_player(ckey = user_adding, admin = usr)
		message_admins("[usr] has added [user_adding] to the vetted database.")

ADMIN_VERB(remove_vetted, R_ADMIN, "Remove user from Vetted", "Removes a user from the vetted list", ADMIN_CATEGORY_MAIN)
	var/user_del = tgui_input_text(usr, "Whom is being Removed?", "Vetted List")
	if(length(user_del))
		SSplayer_ranks.vetted_controller.remove_player(ckey = user_del)
		message_admins("[usr] has removed [user_del] from the vetted databse.")
