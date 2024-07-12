/client
	var/datum/player_playtime/playtime_menu
	var/next_valve_grief_warning = 0
	var/next_chem_grief_warning = 0
	var/next_canister_grief_warning = 0
	var/next_ied_grief_warning = 0
	var/next_circuit_grief_warning = 0
	var/touched_transfer_valve = FALSE
	var/used_chem_dispenser = FALSE
	var/touched_canister = FALSE
	var/crafted_ied = FALSE
	var/touched_circuit = FALSE
	var/uses_vpn = FALSE

/datum/player_playtime/New(mob/viewer)
	ui_interact(viewer)

/datum/player_playtime/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PlayerPlaytimes", "Player Playtimes")
		ui.open()

/datum/player_playtime/ui_state(mob/user)
	return GLOB.admin_state

/datum/player_playtime/ui_data(mob/user)
	var/list/data = list()

	var/list/clients = list()
	for(var/client/C in GLOB.clients)
		var/list/client = list()

		client["ckey"] = C.ckey
		client["playtime_hours"] = C.get_exp_living()
		client["flags"] = check_flags(C)

		var/mob/M = C.mob
		client["observer"] = isobserver(M)
		client["ingame"] = !isnewplayer(M)
		client["name"] = M.real_name
		var/nnpa = CONFIG_GET(number/notify_new_player_age)
		if(nnpa >= 0)
			if(C.account_age >= 0 && (C.account_age < CONFIG_GET(number/notify_new_player_age)))
				client["new_account"] = "New BYOND account [C.account_age] day[(C.account_age==1?"":"s")] old, created on [C.account_join_date]"

		clients += list(client)

	clients = sort_list(clients, GLOBAL_PROC_REF(cmp_playtime_asc))
	data["clients"] = clients
	return data

/datum/player_playtime/ui_act(action, params)
	if(..())
		return

	switch(action)
		if("view_playtime")
			var/mob/target = get_mob_by_ckey(params["ckey"])
			usr.client.holder.cmd_show_exp_panel(target.client)
		if("admin_pm")
			usr.client.cmd_admin_pm(params["ckey"])
		if("player_panel")
			var/mob/target = get_mob_by_ckey(params["ckey"])
			SSadmin_verbs.dynamic_invoke_verb(usr.client, /datum/admin_verb/show_player_panel, target)
		if("view_variables")
			var/mob/target = get_mob_by_ckey(params["ckey"])
			usr.client.debug_variables(target)
		if("observe")
			if(!isobserver(usr) && !check_rights(R_ADMIN))
				return

			var/mob/target = get_mob_by_key(params["ckey"])
			if(!target)
				to_chat(usr, span_notice("Player not found."))
				return

			var/client/C = usr.client
			if(!isobserver(usr))
				SSadmin_verbs.dynamic_invoke_verb(usr.client, /datum/admin_verb/admin_ghost)
			var/mob/dead/observer/A = C.mob
			A.ManualFollow(target)

/datum/player_playtime/proc/check_flags(client/C)
	var/list/flags = list()

	if (C.touched_transfer_valve)
		var/list/flag = list()
		flag["icon"] = "bomb"
		flag["tooltip"] = "This player touched a Transfer Valve."
		flags += list(flag)

	if (C.used_chem_dispenser)
		var/list/flag = list()
		flag["icon"] = "flask"
		flag["tooltip"] = "This player used a Chem Dispenser."
		flags += list(flag)

	if (C.touched_canister)
		var/list/flag = list()
		flag["icon"] = "spray-can"
		flag["tooltip"] = "This player touched a gas canister."
		flags += list(flag)

	if (C.crafted_ied)
		var/list/flag = list()
		flag["icon"] = "hammer"
		flag["tooltip"] = "This player crafted an IED or Molotov."
		flags += list(flag)

	if (C.touched_circuit)
		var/list/flag = list()
		flag["icon"] = "code-branch"
		flag["tooltip"] = "This player touched an integrated circuit."
		flags += list(flag)

	if(C.uses_vpn)
		var/list/flag = list()
		flag["icon"] = "wifi"
		flag["tooltip"] = "This player is [round(C.ip_intel*100, 0.01)]% likely to be using a Proxy/VPN"
		flags += list(flag)

	return flags
