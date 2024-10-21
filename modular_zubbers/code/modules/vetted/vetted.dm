GLOBAL_LIST_EMPTY(vetted_list)
GLOBAL_PROTECT(vetted_list)

/datum/controller/subsystem/player_ranks

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

	if(IsAdminAdvancedProcCall())
		return

	vetted_controller = new
	vetted_controller.file_path_vetted = "[global.config.directory]/bubbers/vetted_players.txt"
	for(var/line in world.file2list(vetted_controller.file_path_vetted))
		if(!line)
			continue

		if(findtextEx(line, "#", 1, 2))
			continue

		vetted_controller.add_player(line)

	return TRUE

/datum/player_rank_controller/vetted/add_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	ckey = ckey(ckey)

	GLOB.vetted_list[ckey] = TRUE

/datum/player_rank_controller/vetted/remove_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	GLOB.vetted_list -= ckey
