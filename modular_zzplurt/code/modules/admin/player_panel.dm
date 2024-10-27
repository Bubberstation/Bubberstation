GLOBAL_LIST_INIT(mute_bits, list(
	list(name = "IC", bitflag = MUTE_IC),
	list(name = "OOC", bitflag = MUTE_OOC),
	list(name = "LOOC", bitflag = MUTE_LOOC),
	list(name = "Pray", bitflag = MUTE_PRAY),
	list(name = "Ahelp", bitflag = MUTE_ADMINHELP),
	list(name = "Deadchat", bitflag = MUTE_DEADCHAT)
))

GLOBAL_LIST_INIT(pp_limbs, list(
	"Head" 		= BODY_ZONE_HEAD,
	"Left leg" 	= BODY_ZONE_L_LEG,
	"Right leg" = BODY_ZONE_R_LEG,
	"Left arm" 	= BODY_ZONE_L_ARM,
	"Right arm" = BODY_ZONE_R_ARM
))

/datum/player_panel
	var/mob/targetMob
	var/client/targetClient

/datum/player_panel/New(mob/target)
	. = ..()
	targetMob = target

/datum/player_panel/Destroy(force, ...)
	targetMob = null
	targetClient = null

	SStgui.close_uis(src)
	return ..()

/datum/player_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!targetMob)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "PlayerPanel", "[targetMob.real_name] Player Panel")
		ui.open()

/datum/player_panel/ui_state(mob/user)
	return GLOB.admin_state

/datum/player_panel/ui_data(mob/user)
	. = list()
	.["mob_name"] = targetMob.real_name
	.["mob_type"] = targetMob.type
	.["admin_mob_type"] = user.client?.mob.type
	.["godmode"] = HAS_TRAIT(user, TRAIT_GODMODE)

	var/mob/living/L = targetMob
	if (istype(L))
		.["is_frozen"] = L.admin_frozen
		.["is_slept"] = L.admin_sleeping
		.["mob_scale"] = L.current_size

	if(targetMob.client)
		targetClient = targetMob.client
		.["client_ckey"] = targetClient.ckey
		.["client_muted"] = targetClient.prefs.muted
		.["client_rank"] = targetClient.holder ? targetClient.holder.ranks : "Player"
	else
		targetClient = null
		.["client_ckey"] = null

		if (targetMob.ckey)
			.["last_ckey"] = copytext(targetMob.ckey, 2)

/datum/player_panel/ui_static_data()
	. = list()

	.["transformables"] = GLOB.pp_transformables
	.["glob_limbs"] = GLOB.pp_limbs
	.["glob_mute_bits"] = GLOB.mute_bits
	.["current_time"] = time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")

	if(targetClient)
		var/byond_version = "Unknown"
		if(targetClient.byond_version)
			byond_version = "[targetClient.byond_version].[targetClient.byond_build ? targetClient.byond_build : "xxx"]"
		.["data_byond_version"] = byond_version
		.["data_player_join_date"] = targetClient.player_join_date
		.["data_account_join_date"] = targetClient.account_join_date
		.["data_related_cid"] = targetClient.related_accounts_cid
		.["data_related_ip"] = targetClient.related_accounts_ip

		var/datum/player_details/deets = GLOB.player_details[targetClient.ckey]
		.["data_old_names"] = deets.get_played_names() || null

		var/list/player_ranks = list()
		if(SSplayer_ranks.is_donator(targetClient, admin_bypass = FALSE))
			player_ranks += "Donator"
		if(SSplayer_ranks.is_mentor(targetClient, admin_bypass = FALSE))
			player_ranks += "Mentor"
		if(SSplayer_ranks.is_veteran(targetClient, admin_bypass = FALSE))
			player_ranks += "Veteran"
		if(SSplayer_ranks.is_vetted(targetClient, admin_bypass = FALSE))
			player_ranks |= "Vetted"
		.["ranks"] = length(player_ranks) ? player_ranks.Join(", ") : null

		if(CONFIG_GET(flag/use_exp_tracking))
			.["playtimes_enabled"] = TRUE
			.["playtime"] = targetMob.client.get_exp_living()

/datum/player_panel/ui_act(action, params, datum/tgui/ui)
	. = ..()

	var/mob/adminMob = ui.user
	var/client/adminClient = adminMob.client

	if(. || !check_rights_for(adminClient, R_ADMIN))
		message_admins(span_adminhelp("WARNING: NON-ADMIN [ADMIN_LOOKUPFLW(adminMob)] ATTEMPTED TO ACCESS ADMIN PANEL. NOTIFY Casper3044."))
		to_chat(adminClient, "Error: you are not an admin!")
		return

	switch(action)
		// If this mob used to be player controlled but isn't anymore, this action will open the player panel for the mob that player is now controlling.
		if ("open_latest_panel")
			if (targetMob.client || !targetMob.ckey)
				return

			// Remove '@' from the start of the ckey.
			var/ckey = copytext(targetMob.ckey, 2)
			var/mob/latestMob = get_mob_by_ckey(ckey)

			if(!latestMob)
				to_chat(adminClient, span_warning("That ckey is not controlling a mob."))
				return

			if(targetMob == latestMob)
				return

			to_chat(adminClient, span_notice("New mob found for player: [targetMob.ckey] ([latestMob])."))
			SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/show_player_panel, latestMob)

		if ("edit_rank")
			if (!targetMob.client?.ckey)
				return

			var/list/context = list()

			context["key"] = targetMob.client.ckey

			if (GLOB.admin_datums[targetMob.client.ckey] || GLOB.deadmins[targetMob.client.ckey])
				context["editrights"] = "rank"
			else
				context["editrights"] = "add"

			adminClient.holder.edit_rights_topic(context)

		if ("access_variables")
			adminClient.debug_variables(targetMob)

		if ("access_playtimes")
			if (targetMob.client)
				adminClient.holder.cmd_show_exp_panel(targetMob.client)

		if ("private_message")
			SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/cmd_admin_pm_context, targetMob)

		if ("subtle_message")
			var/list/subtle_message_options = list("Voice in head", RADIO_CHANNEL_CENTCOM, RADIO_CHANNEL_SYNDICATE)
			var/sender = tgui_input_list(adminClient, "Choose the method of subtle messaging", "Subtle Message", subtle_message_options)
			if (!sender)
				return

			var/msg = input("Contents of the message", text("Subtle PM to [targetMob.key]")) as text
			if (!msg)
				return

			if (sender == "Voice in head")
				to_chat(targetMob, "<i>You hear a voice in your head... <b>[msg]</i></b>")
			else
				var/mob/living/carbon/human/H = targetMob

				if(!istype(H))
					to_chat(adminClient, "The person you are trying to contact is not human. Unsent message: [msg]")
					return

				if(!istype(H.ears, /obj/item/radio/headset))
					to_chat(adminClient, "The person you are trying to contact is not wearing a headset. Unsent message: [msg]")
					return

				to_chat(H, "You hear something crackle in your ears for a moment before a voice speaks.  \"Please stand by for a message from [sender == RADIO_CHANNEL_SYNDICATE ? "your benefactor" : "Central Command"].  Message as follows[sender == RADIO_CHANNEL_SYNDICATE ? ", agent." : ":"] <span class='bold'>[msg].</span> Message ends.\"")


			log_admin("SubtlePM ([sender]): [key_name(adminClient)] -> [key_name(targetMob)] : [msg]")
			msg = span_adminnotice("<b> SubtleMessage ([sender]): [key_name_admin(adminClient)] -> [key_name_admin(targetMob)] :</b> [msg]")
			message_admins(msg)
			admin_ticket_log(targetMob, msg)

		if ("set_name")
			targetMob.vv_auto_rename(params["name"])

		if ("heal")
			SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/cmd_admin_rejuvenate, targetMob)

		if ("ghost")
			if(targetMob.client)
				log_admin("[key_name(adminClient)] ejected [key_name(targetMob)] from their body.")
				message_admins("[key_name_admin(adminClient)] ejected [key_name_admin(targetMob)] from their body.")
				to_chat(targetMob, span_danger("An admin has ejected you from your body."))
				targetMob.ghostize(FALSE)

		if ("offer_control")
			offer_control(targetMob)

		if ("take_control")
			// Disassociates observer mind from the body mind
			if(targetMob.client)
				targetMob.ghostize(FALSE)
			else
				for(var/mob/dead/observer/ghost in GLOB.dead_mob_list)
					if(targetMob.mind == ghost.mind)
						ghost.mind = null

			targetMob.ckey = adminMob.ckey
			qdel(adminMob)

			message_admins(span_adminnotice("[key_name_admin(adminClient)] took control of [targetMob]."))
			log_admin("[key_name(adminClient)] took control of [targetMob].")
			addtimer(CALLBACK(targetMob.mob_panel, TYPE_PROC_REF(/datum, ui_interact), targetMob), 0.1 SECONDS)

		if ("smite")
			SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/admin_smite, targetMob)

		if ("bring")
			SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/get_mob, targetMob)

		if ("orbit")
			if(!isobserver(adminMob))
				SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/admin_ghost)
			var/mob/dead/observer/O = adminClient.mob
			O.ManualFollow(targetMob)

		if ("jump_to")
			SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/jump_to_mob, targetMob)

		if ("freeze")
			var/mob/living/L = targetMob
			if (istype(L))
				L.toggle_admin_freeze(adminClient)

		if ("sleep")
			var/mob/living/L = targetMob
			if (istype(L))
				L.toggle_admin_sleep(adminClient)

		if ("lobby")
			if(!isobserver(targetMob))
				to_chat(adminClient, span_notice("You can only send ghost players back to the Lobby."))
				return

			if(!targetMob.client)
				to_chat(adminClient, span_warning("[targetMob] doesn't seem to have an active client."))
				return

			log_admin("[key_name(adminClient)] has sent [key_name(targetMob)] back to the Lobby.")
			message_admins("[key_name(adminClient)] has sent [key_name(targetMob)] back to the Lobby.")

			var/mob/dead/new_player/NP = new()
			NP.ckey = targetMob.ckey
			qdel(targetMob)

		if ("select_equipment")
			SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/select_equipment, targetMob)

		if ("strip")
			for(var/obj/item/I in targetMob)
				targetMob.dropItemToGround(I, TRUE) //The TRUE forces all items to drop, since this is an admin undress.

		if ("cryo")
			targetMob.vv_send_cryo()

		if ("force_say")
			targetMob.say(params["to_say"], forced="admin")

		if ("force_emote")
			if (params["to_emote"])
				QUEUE_OR_CALL_VERB_FOR(VERB_CALLBACK(targetMob, TYPE_PROC_REF(/mob, emote), "me", EMOTE_VISIBLE|EMOTE_AUDIBLE, params["to_emote"], TRUE), SSspeech_controller)

		if ("prison")
			if(isAI(targetMob))
				to_chat(adminClient, "This cannot be used on instances of type /mob/living/silicon/ai.")
				return

			targetMob.forceMove(pick(GLOB.prisonwarp))
			to_chat(targetMob, span_userdanger("You have been sent to Prison!"))

			log_admin("[key_name(adminClient)] has sent [key_name(targetMob)] to Prison!")
			message_admins("[key_name_admin(adminClient)] has sent [key_name_admin(targetMob)] to Prison!")

		if ("kick")
			if(!check_if_greater_rights_than(targetClient))
				to_chat(adminClient, span_danger("Error: They have more rights than you do."), confidential = TRUE)
				return
			if(tgui_alert(adminMob, "Kick [key_name(targetMob)]?", "Confirm", list("Yes", "No")) != "Yes")
				return
			if(!targetMob)
				to_chat(adminClient, span_danger("Error: [targetMob] no longer exists!"), confidential = TRUE)
				return
			if(!targetClient)
				to_chat(adminClient, span_danger("Error: [targetMob] no longer has a client!"), confidential = TRUE)
				return
			to_chat(targetMob, span_danger("You have been kicked from the server by [adminClient.holder.fakekey ? "an Administrator" : "[adminClient.key]"]."), confidential = TRUE)
			log_admin("[key_name(adminClient)] kicked [key_name(targetMob)].")
			message_admins(span_adminnotice("[key_name_admin(adminClient)] kicked [key_name_admin(targetMob)]."))
			qdel(targetClient)

		if ("ban")
			var/player_key = targetMob.key
			var/player_ip = targetMob.client.address
			var/player_cid = targetMob.client.computer_id
			adminClient.holder.ban_panel(player_key, player_ip, player_cid)

		if ("sticky_ban")
			var/list/ban_settings = list()
			if(targetMob.client)
				ban_settings["ckey"] = targetMob.ckey
			adminClient.holder.stickyban("add", ban_settings)

		if ("notes")
			if (targetMob.client)
				browse_messages(target_ckey = ckey(targetMob.ckey))

		if ("logs")
			var/source = targetMob.client ? LOGSRC_CKEY : LOGSRC_MOB
			show_individual_logging_panel(targetMob, source)

		if ("mute")
			if(!targetMob.client)
				return

			targetMob.client.prefs.muted = text2num(params["mute_flag"])
			log_admin("[key_name(adminClient)] set the mute flags for [key_name(targetMob)] to [targetMob.client.prefs.muted].")

		if ("mute_all")
			if(!targetMob.client)
				return

			for(var/bit in GLOB.mute_bits)
				targetMob.client.prefs.muted |= bit["bitflag"]

			log_admin("[key_name(adminClient)] mass-muted [key_name(targetMob)].")

		if ("unmute_all")
			if(!targetMob.client)
				return

			for(var/bit in GLOB.mute_bits)
				targetMob.client.prefs.muted &= ~bit["bitflag"]

			log_admin("[key_name(adminClient)] mass-unmuted [key_name(targetMob)].")

		if ("related_accounts")
			if(targetMob.client)
				var/related_accounts
				if (params["related_thing"] == "CID")
					related_accounts = targetMob.client.related_accounts_cid
				else
					related_accounts = targetMob.client.related_accounts_ip

				related_accounts = splittext(related_accounts, ", ")

				var/list/dat = list("Related accounts by [params["related_thing"]]:")
				dat += related_accounts
				adminClient << browse(dat.Join("<br>"), "window=related_[targetMob.client];size=420x300")

		if ("transform")
			var/choice = params["newType"]
			if (choice == "/mob/living")
				choice = tgui_input_list(adminClient, "What should this mob transform into", "Mob Transform", subtypesof(choice))
				if (!choice)
					return

			adminClient.holder.transformMob(targetMob, adminMob, choice, params["newTypeName"])

		if ("toggle_godmode")
			adminClient.cmd_admin_godmode(targetMob)

		if ("spell")
			SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/give_spell, targetMob)

		if ("martial_art")
			adminClient.teach_martial_art(targetMob)

		if ("quirk")
			adminClient.toggle_quirk(targetMob)

		if ("species")
			adminClient.set_species(targetMob)

		if ("limb")
			if(!params["limbs"] || !ishuman(targetMob))
				return

			var/mob/living/carbon/human/H = targetMob

			for(var/limb in params["limbs"])
				if (!limb)
					continue

				if (params["delimb_mode"])
					var/obj/item/bodypart/L = H.get_bodypart(limb)
					if (!L)
						continue
					L.dismember()
					playsound(H, 'sound/effects/cartoon_sfx/cartoon_pop.ogg', 70)
				else
					H.regenerate_limb(limb)

		if ("scale")
			var/mob/living/L = targetMob
			if(!isnull(params["new_scale"]) && istype(L))
				L.vv_edit_var("current_size", params["new_scale"])

		if ("explode")
			var/power = text2num(params["power"])
			var/empMode = text2num(params["emp_mode"])


			var/turf/T = get_turf(adminMob)
			message_admins("[ADMIN_LOOKUPFLW(adminClient)] created an admin [empMode ? "EMP" : "explosion"] at [ADMIN_VERBOSEJMP(T)].")
			log_admin("[key_name(adminClient)] created an admin [empMode ? "EMP" : "explosion"] at [adminMob.loc].")

			if (empMode)
				empulse(adminMob, power, power / 2, TRUE)
			else
				explosion(adminMob, power / 3, power / 2, power, power, ignorecap = TRUE)

		if ("narrate")
			var/list/stylesRaw = params["classes"]

			var/styles = ""
			for(var/style in stylesRaw)
				styles += "[style]:[stylesRaw[style]];"

			if (params["mode_global"])
				to_chat(world, "<span style='[styles]'>[params["message"]]</span>")
				log_admin("GlobalNarrate: [key_name(adminClient)] : [params["message"]]")
				message_admins(span_adminnotice("[key_name_admin(adminClient)] Sent a global narrate"))
			else
				for(var/mob/M in view(params["range"], adminMob))
					to_chat(M, "<span style='[styles]'>[params["message"]]</span>")

				log_admin("LocalNarrate: [key_name(adminClient)] at [AREACOORD(adminMob)]: [params["message"]]")
				message_admins(span_adminnotice("<b> LocalNarrate: [key_name_admin(adminClient)] at [ADMIN_VERBOSEJMP(adminMob)]:</b> [params["message"]]<BR>"))

		if ("languages")
			var/datum/language_holder/H = targetMob.get_language_holder()
			H.open_language_menu(adminMob)

		if ("traitor_panel")
			SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/show_traitor_panel, targetMob)

		if ("job_exemption_panel")
			show_job_exempt_menu(adminMob, targetMob.ckey)

		if ("skill_panel")
			SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/show_skill_panel, targetMob)

		if ("commend")
			if(!targetMob.ckey)
				to_chat(adminClient, span_warning("This mob either no longer exists or no longer is being controlled by someone!"))
				return

			switch(tgui_alert(adminMob, "Would you like the effects to apply immediately or at the end of the round? Applying them now will make it clear it was an admin commendation.", "<3?", list("Apply now", "Apply at round end", "Cancel")))
				if("Apply now")
					targetMob.receive_heart(adminMob, instant = TRUE)
				if("Apply at round end")
					targetMob.receive_heart(adminMob)

		if ("play_sound_to")
			var/soundFile = input("", "Select a sound file",) as null|sound

			if(soundFile && targetMob)
				SSadmin_verbs.dynamic_invoke_verb(adminClient, /datum/admin_verb/play_direct_mob_sound, soundFile, targetMob)

		if ("apply_client_quirks")
			var/mob/living/carbon/human/H = targetMob
			if(!istype(H))
				to_chat(adminClient, "this can only be used on instances of type /mob/living/carbon/human.", confidential = TRUE)
				return
			if(!H.client)
				to_chat(adminClient, "[H] has no client!", confidential = TRUE)
				return
			SSquirks.AssignQuirks(H, H.client)
			log_admin("[key_name(adminClient)] applied client quirks to [key_name(H)].")
			message_admins(span_adminnotice("[key_name_admin(adminClient)] applied client quirks to [key_name_admin(H)]."))

