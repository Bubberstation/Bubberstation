GLOBAL_LIST_EMPTY(vetted_list_legacy)
GLOBAL_PROTECT(vetted_list_legacy)
GLOBAL_LIST_EMPTY(vetted_list)
GLOBAL_PROTECT(vetted_list)

/datum/player_rank_controller/vetted
	rank_title = "vetted user"

/client/
	var/is_vetted = null

/datum/controller/subsystem/player_ranks/proc/is_vetted(client/user, admin_bypass = TRUE)
	if(!istype(user))
		CRASH("Invalid user type provided to is_vetted(), expected 'client' and obtained '[user ? user.type : "null"]'.")
	if(!isnull(user.is_vetted))
		return user.is_vetted
	if(get_user_vetted_status_hot(user.ckey))
		user.is_vetted = TRUE
		return user.is_vetted
	else
		user.is_vetted = FALSE
		return user.is_vetted



/datum/controller/subsystem/player_ranks/proc/get_user_vetted_status_hot(ckey)
	if(IsAdminAdvancedProcCall())
		return
	if(!SSdbcore.Connect())
		return
	var/datum/db_query/query_load_player_rank = SSdbcore.NewQuery("SELECT ckey FROM vetted_list WHERE ckey = :ckey", list("ckey" = ckey))
	if(!query_load_player_rank.warn_execute())
		qdel(query_load_player_rank)
		return
	while(query_load_player_rank.NextRow())
		var/ckey2 = ckey(query_load_player_rank.item[1])
		. = ckey2
	qdel(query_load_player_rank)

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

	. = query_add_player_rank.warn_execute()
	qdel(query_add_player_rank)

/datum/player_rank_controller/vetted/add_player(ckey, legacy, admin)
	ckey = ckey(ckey)
	if(legacy)
		GLOB.vetted_list_legacy[ckey] = TRUE
	GLOB.vetted_list[ckey] = TRUE
	if(admin)
		add_player_to_sql(ckey, admin)

/datum/player_rank_controller/vetted/remove_player(ckey)
	GLOB.vetted_list -= ckey
	remove_player_from_sql(ckey)

/datum/player_rank_controller/vetted/proc/remove_player_from_sql(ckey)
	var/datum/db_query/query_remove_player_vetted = SSdbcore.NewQuery(
		"DELETE FROM vetted_list WHERE ckey = :ckey",
		list("ckey" = ckey),
	)
	. = query_remove_player_vetted.warn_execute()
	qdel(query_remove_player_vetted)

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
