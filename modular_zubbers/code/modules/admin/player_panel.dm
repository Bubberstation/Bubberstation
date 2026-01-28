GLOBAL_LIST_INIT(mute_bits, list(
	list(name = "IC", bitflag = MUTE_IC),
	list(name = "OOC", bitflag = MUTE_OOC),
	list(name = "LOOC", bitflag = MUTE_LOOC),
	list(name = "Pray", bitflag = MUTE_PRAY),
	list(name = "Ahelp", bitflag = MUTE_ADMINHELP),
	list(name = "Deadchat", bitflag = MUTE_DEADCHAT)
))

GLOBAL_DATUM_INIT(admin_state, /datum/ui_state/admin_state, new)

/datum/ui_state/admin_state/can_use_topic(src_object, mob/user)
	if(check_rights_for(user.client, R_ADMIN))
		return UI_INTERACTIVE
	return UI_CLOSE

GLOBAL_LIST_INIT(pp_limbs, list(
	"Head" 		= BODY_ZONE_HEAD,
	"Left leg" 	= BODY_ZONE_L_LEG,
	"Right leg" = BODY_ZONE_R_LEG,
	"Left arm" 	= BODY_ZONE_L_ARM,
	"Right arm" = BODY_ZONE_R_ARM
))

/datum/player_panel
	var/mob/target_mob
	var/client/target_client
	var/discord_id_cache

/datum/player_panel/New(mob/target)
	. = ..()
	target_mob = target

/datum/player_panel/Destroy(force, ...)
	target_mob = null
	target_client = null

	SStgui.close_uis(src)
	return ..()

/datum/player_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!target_mob)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "PlayerPanel", "[target_mob.real_name] Player Panel")
		ui.open()

/datum/player_panel/ui_state(mob/user)
	return GLOB.admin_state

/datum/player_panel/ui_data(mob/user)
	. = list()

	if(!target_mob)
		return .

	.["mob_name"] = target_mob.real_name
	.["mob_type"] = target_mob.type
	.["admin_mob_type"] = user.client?.mob.type
	.["godmode"] = HAS_TRAIT(target_mob, TRAIT_GODMODE)

	var/mob/living/living_mob = target_mob
	if (istype(living_mob))
		.["is_frozen"] = living_mob.admin_frozen
		.["is_slept"] = living_mob.admin_sleeping
		.["mob_scale"] = living_mob.current_size
		.["mob_speed"] = living_mob.cached_multiplicative_slowdown
		.["mob_status_flags"] = living_mob.status_flags
		if(islist(living_mob.faction))
			.["current_faction"] = living_mob.faction
		else if(living_mob.faction)
			.["current_faction"] = list(living_mob.faction)
		else
			.["current_faction"] = list()

	if(target_mob.client)
		target_client = target_mob.client
		.["client_ckey"] = target_client.ckey
		.["client_muted"] = target_client.prefs.muted
		.["client_rank"] = target_client.holder ? target_client.holder.ranks : "Player"
		.["discord_id"] = discord_id_cache
	else
		target_client = null
		.["client_ckey"] = null
		.["discord_id"] = discord_id_cache

		if (target_mob.ckey)
			.["last_ckey"] = get_target_ckey()

/datum/player_panel/ui_static_data()
	. = list()

	if(!target_mob)
		return .

	.["transformables"] = GLOB.pp_transformables
	.["glob_limbs"] = GLOB.pp_limbs
	.["glob_mute_bits"] = GLOB.mute_bits
	.["current_time"] = time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")

	// Status flags
	.["glob_status_flags"] = list(
		"Stun" = CANSTUN,
		"Knockdown" = CANKNOCKDOWN,
		"Unconscious" = CANUNCONSCIOUS,
		"Push" = CANPUSH,
		"Godmode" = "godmode" // Special string for godmode trait
	)

	// Factions list
	.["glob_factions"] = list(
		"None",
		"neutral",
		"crew",
		"hostile",
		"mining",
		"pirate",
		"spider",
		"syndicate",
		"wizard",
		"Custom"
	)

	if(target_client)
		var/byond_version = "Unknown"
		if(target_client.byond_version)
			byond_version = "[target_client.byond_version].[target_client.byond_build ? target_client.byond_build : "xxx"]"
		.["data_byond_version"] = byond_version
		.["data_player_join_date"] = target_client.player_join_date
		.["data_account_join_date"] = target_client.account_join_date
		.["data_related_cid"] = target_client.related_accounts_cid
		.["data_related_ip"] = target_client.related_accounts_ip
		/* // Find relevant PR maybe?
		var/datum/player_details/deets = GLOB.player_details[target_client.ckey]
		.["data_old_names"] = deets.get_played_names() || null
		*/
		var/list/player_ranks = list()
		if(SSplayer_ranks.is_donator(target_client, admin_bypass = FALSE))
			player_ranks += "Donator"
		if(SSplayer_ranks.is_mentor(target_client, admin_bypass = FALSE))
			player_ranks += "Mentor"
		if(SSplayer_ranks.is_vetted(target_client, admin_bypass = FALSE))
			player_ranks += "Vetted"
		.["ranks"] = length(player_ranks) ? player_ranks.Join(", ") : null

		if(CONFIG_GET(flag/use_exp_tracking))
			.["playtimes_enabled"] = TRUE
			.["playtime"] = target_mob.client.get_exp_living()
	else if(target_mob.ckey)
		var/target_ckey = get_target_ckey()
		if(target_ckey)
			var/datum/persistent_client/PC = GLOB.persistent_clients_by_ckey[target_ckey]
			.["data_old_names"] = PC?.get_played_names() || null

/datum/player_panel/ui_act(action, params, datum/tgui/ui)
	. = ..()

	if(!target_mob)
		return TRUE

	var/mob/admin_mob = ui.user
	var/client/admin_client = admin_mob.client

	switch(action)
		// If this mob used to be player controlled but isn't anymore, this action will open the player panel for the mob that player is now controlling.
		if ("open_latest_panel")
			if (target_mob.client || !target_mob.ckey)
				return

			var/ckey = get_target_ckey()
			var/mob/latest_mob = get_mob_by_ckey(ckey)

			if(!latest_mob)
				to_chat(admin_client, span_warning("That ckey is not controlling a mob."))
				return

			if(target_mob == latest_mob)
				return

			to_chat(admin_client, span_notice("New mob found for player: [target_mob.ckey] ([latest_mob])."))
			SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/show_player_panel, latest_mob)

		/// Edits player Rank
		if ("edit_rank")
			if (!target_mob.client?.ckey)
				return

			var/list/context = list()

			context["key"] = target_mob.client.ckey

			if (GLOB.admin_datums[target_mob.client.ckey] || GLOB.deadmins[target_mob.client.ckey])
				context["editrights"] = "rank"
			else
				context["editrights"] = "add"

			admin_client.holder.edit_rights_topic(context)

		/// Opens the view variables list
		if ("access_variables")
			admin_client.debug_variables(target_mob)

		/// Sees selected player/client playtime
		if ("access_playtimes")
			if (target_mob.client)
				admin_client.holder.cmd_show_exp_panel(target_mob.client)

		/// Privately messages player
		if ("private_message")
			SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/cmd_admin_pm_context, target_mob)

		/// Subtly messages selected mob (requires target to have a headset)
		if ("subtle_message")
			var/list/subtle_message_options = list("Voice in head", RADIO_CHANNEL_CENTCOM, RADIO_CHANNEL_SYNDICATE)
			var/sender = tgui_input_list(admin_client, "Choose the method of subtle messaging", "Subtle Message", subtle_message_options)
			if (!sender)
				return

			var/msg = input("Contents of the message", text("Subtle PM to [target_mob.key]")) as text
			if (!msg)
				return

			if (sender == "Voice in head")
				to_chat(target_mob, "<i>You hear a voice in your head... <b>[msg]</i></b>")
			else
				var/mob/living/carbon/human/selected_mob = target_mob

				if(!istype(selected_mob))
					to_chat(admin_client, "The person you are trying to contact is not human. Unsent message: [msg]")
					return

				if(!istype(selected_mob.ears, /obj/item/radio/headset))
					to_chat(admin_client, "The person you are trying to contact is not wearing a headset. Unsent message: [msg]")
					return

				to_chat(selected_mob, "You hear something crackle in your ears for a moment before a voice speaks.  \"Please stand by for a message from [sender == RADIO_CHANNEL_SYNDICATE ? "your benefactor" : "Central Command"].  Message as follows[sender == RADIO_CHANNEL_SYNDICATE ? ", agent." : ":"] <span class='bold'>[msg].</span> Message ends.\"")


			log_admin("SubtlePM ([sender]): [key_name(admin_client)] -> [key_name(target_mob)] : [msg]")
			msg = span_adminnotice("<b> SubtleMessage ([sender]): [key_name_admin(admin_client)] -> [key_name_admin(target_mob)] :</b> [msg]")
			message_admins(msg)
			admin_ticket_log(target_mob, msg)

		/// Forces a name change on selected player
		if ("set_name")
			target_mob.vv_auto_rename(params["name"])

		/// Admin heals
		if ("heal")
			SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/cmd_admin_rejuvenate, target_mob)

		/// Forces selected player/client into ghost, disconnecting them from mob.
		if ("ghost")
			if(target_mob.client)
				log_admin("[key_name(admin_client)] ejected [key_name(target_mob)] from their body.")
				message_admins("[key_name_admin(admin_client)] ejected [key_name_admin(target_mob)] from their body.")
				to_chat(target_mob, span_danger("An admin has ejected you from your body."))
				target_mob.ghostize(FALSE)

		/// offers control to ghosts for selected mob/body
		if ("offer_control")
			offer_control(target_mob)

		/// Steals control from selected client's body
		if ("take_control")
			// Disassociates observer mind from the body mind
			if(target_mob.client)
				target_mob.ghostize(FALSE)
			else
				for(var/mob/dead/observer/ghost in GLOB.dead_mob_list)
					if(target_mob.mind == ghost.mind)
						ghost.mind = null

			target_mob.ckey = admin_mob.ckey
			qdel(admin_mob)

			message_admins(span_adminnotice("[key_name_admin(admin_client)] took control of [target_mob]."))
			log_admin("[key_name(admin_client)] took control of [target_mob].")
			addtimer(CALLBACK(target_mob.mob_panel, TYPE_PROC_REF(/datum, ui_interact), target_mob), 0.1 SECONDS)

		/// Smites selected Client/Target
		if ("smite")
			SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/admin_smite, target_mob)

		/// Brings selected Client/target
		if ("bring")
			SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/get_mob, target_mob)

		/// Orbits arround selected Target
		if ("orbit")
			if(!isobserver(admin_mob))
				SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/admin_ghost)
			var/mob/dead/observer/satellite = admin_client.mob
			satellite.ManualFollow(target_mob)

		/// Jumps to selected mob
		if ("jump_to")
			SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/jump_to_mob, target_mob)

		/// Forces the selected mob/client to stop moving
		if ("freeze")
			var/mob/living/living_mob = target_mob
			if (istype(living_mob))
				living_mob.toggle_admin_freeze(admin_client)

		/// Forces slected mob/client to sleep
		if ("sleep")
			var/mob/living/living_mob = target_mob
			if (istype(living_mob))
				living_mob.toggle_admin_sleep(admin_client)

		/// Yeets target client to the lobby (only works on ghosts)
		if ("lobby")
			if(!isobserver(target_mob))
				to_chat(admin_client, span_notice("You can only send ghost players back to the Lobby."))
				return

			if(!target_mob.client)
				to_chat(admin_client, span_warning("[target_mob] doesn't seem to have an active client."))
				return

			log_admin("[key_name(admin_client)] has sent [key_name(target_mob)] back to the Lobby.")
			message_admins("[key_name(admin_client)] has sent [key_name(target_mob)] back to the Lobby.")

			var/mob/dead/new_player/new_connected_player = new()
			new_connected_player.ckey = target_mob.ckey
			qdel(target_mob)

		/// Selects admin equipmeent via Equipment UI on the selected player/mob
		if ("select_equipment")
			SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/select_equipment, target_mob)

		/// Forces selecteed client to drop all their stuff (SPREAD YOUR SHIT)
		if ("strip")
			for(var/obj/item/begone_items in target_mob)
				target_mob.dropItemToGround(begone_items, TRUE) //The TRUE forces all items to drop, since this is an admin undress.

		/// Forces selected client into cryo storage
		if ("cryo")
			target_mob.vv_send_cryo()

		/// Forces selected client to say things against their will
		if ("force_say")
			target_mob.say(params["to_say"], forced="admin")

		/// Forces selected client to emote against their will
		if ("force_emote")
			if (params["to_emote"])
				QUEUE_OR_CALL_VERB_FOR(VERB_CALLBACK(target_mob, TYPE_PROC_REF(/mob, emote), "me", EMOTE_VISIBLE|EMOTE_AUDIBLE, params["to_emote"], TRUE), SSspeech_controller)

		/// Sends the offender to SUPERJAIL known as SPACE PRISON (admin prison)
		if ("prison")
			if(isAI(target_mob))
				to_chat(admin_client, "This cannot be used on instances of type /mob/living/silicon/ai.")
				return

			target_mob.forceMove(pick(GLOB.prisonwarp))
			to_chat(target_mob, span_userdanger("You have been sent to Prison!"))

			log_admin("[key_name(admin_client)] has sent [key_name(target_mob)] to Prison!")
			message_admins("[key_name_admin(admin_client)] has sent [key_name_admin(target_mob)] to Prison!")

		/// Boots the offending client from the server
		if ("kick")
			if(!check_if_greater_rights_than(target_client))
				to_chat(admin_client, span_danger("Error: They have more rights than you do."), confidential = TRUE)
				return
			if(tgui_alert(admin_mob, "Kick [key_name(target_mob)]?", "Confirm", list("Yes", "No")) != "Yes")
				return
			if(!target_mob)
				to_chat(admin_client, span_danger("Error: [target_mob] no longer exists!"), confidential = TRUE)
				return
			if(!target_client)
				to_chat(admin_client, span_danger("Error: [target_mob] no longer has a client!"), confidential = TRUE)
				return
			to_chat(target_mob, span_danger("You have been kicked from the server by [admin_client.holder.fakekey ? "an Administrator" : "[admin_client.key]"]."), confidential = TRUE)
			log_admin("[key_name(admin_client)] kicked [key_name(target_mob)].")
			message_admins(span_adminnotice("[key_name_admin(admin_client)] kicked [key_name_admin(target_mob)]."))
			qdel(target_client)

		/// Bans target
		if ("ban")
			var/target_ckey = get_target_ckey()
			var/player_ip = target_mob.client?.address
			var/player_cid = target_mob.client?.computer_id
			if(!target_ckey)
				to_chat(admin_client, span_warning("No ckey found for this mob."))
				return
			admin_client.holder.ban_panel(target_ckey, player_ip, player_cid)

		/// Stickbans target
		if ("sticky_ban")
			var/list/ban_settings = list()
			var/target_ckey = get_target_ckey()
			if(!target_ckey)
				to_chat(admin_client, span_warning("No ckey found for this mob."))
				return
			ban_settings["ckey"] = target_ckey
			admin_client.holder.stickyban("add", ban_settings)

		/// Opens selected target's Notes
		if ("notes")
			var/target_ckey = get_target_ckey()
			if(!target_ckey)
				to_chat(admin_client, span_warning("No ckey found for this mob."))
				return
			browse_messages(target_ckey = target_ckey)

		/// Opens selected target's logs
		if ("logs")
			var/source = target_mob.client ? LOGSRC_CKEY : LOGSRC_MOB
			show_individual_logging_panel(target_mob, source)

		/// Just mutes
		if ("mute")
			if(!target_mob.client)
				return

			target_mob.client.prefs.muted = text2num(params["mute_flag"])
			log_admin("[key_name(admin_client)] set the mute flags for [key_name(target_mob)] to [target_mob.client.prefs.muted].")

		/// MUTES EVERYBODY (NO ONE GETS TALKING STICK!!!)
		if ("mute_all")
			if(!target_mob.client)
				return

			for(var/bit in GLOB.mute_bits)
				target_mob.client.prefs.muted |= bit["bitflag"]

			log_admin("[key_name(admin_client)] mass-muted [key_name(target_mob)].")

		/// Unmutes EVERYBODY
		if ("unmute_all")
			if(!target_mob.client)
				return

			for(var/bit in GLOB.mute_bits)
				target_mob.client.prefs.muted &= ~bit["bitflag"]

			log_admin("[key_name(admin_client)] mass-unmuted [key_name(target_mob)].")

		/// Showing linked discord_id
		if ("show_discord_id")
			load_discord_id()
			SStgui.update_uis(src)

		/// Looks for related account data to the selected mob
		if ("related_accounts")
			if(target_mob.client)
				var/related_accounts
				if (params["related_thing"] == "CID")
					related_accounts = target_mob.client.related_accounts_cid
				else
					related_accounts = target_mob.client.related_accounts_ip

				related_accounts = splittext(related_accounts, ", ")

				var/list/dat = list("Related accounts by [params["related_thing"]]:")
				dat += related_accounts
				admin_client << browse(dat.Join("<br>"), "window=related_[target_mob.client];size=420x300")

		/// Transforms the selected mob
		if ("transform")
			var/choice = params["newType"]
			if (choice == "/mob/living")
				choice = tgui_input_list(admin_client, "What should this mob transform into", "Mob Transform", subtypesof(choice))
				if (!choice)
					return

			admin_client.holder.transform_mob(target_mob, admin_mob, choice, params["newTypeName"])


		/// Gives targeted mob spells (shadow wizard money gang)
		if ("spell")
			SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/give_spell, target_mob)

		/// Gives targeted mob quirks
		if ("martial_art")
			admin_client.teach_martial_art(target_mob)

		/// Sets targeted mob's quirks
		if ("quirk")
			admin_client.toggle_quirk(target_mob)

		/// Sets targeted mob's species
		if ("species")
			admin_client.set_species(target_mob)

		/// Delimbs targeted mob (SNAAAAAAAAAAKE!!!!)
		if ("limb")
			if(!params["limbs"] || !ishuman(target_mob))
				return

			var/mob/living/carbon/human/punished_mob = target_mob

			for(var/limb in params["limbs"])
				if (!limb)
					continue

				if (params["delimb_mode"])
					var/obj/item/bodypart/targeted_limb = punished_mob.get_bodypart(limb)
					if (!targeted_limb)
						continue
					targeted_limb.dismember()
					playsound(punished_mob, 'sound/effects/bamf.ogg', 70)
				else
					punished_mob.regenerate_limb(limb)

		/// Assigns selected olayer/client's scale
		if ("scale")
			var/mob/living/local_mob_data = target_mob
			if(!isnull(params["new_scale"]) && istype(local_mob_data))
				local_mob_data.vv_edit_var("current_size", params["new_scale"])

		/// Explodes the selected player with assigned power and blasts (for the funny of course!)
		if ("explode")
			var/power = text2num(params["power"])
			var/emp_mode = text2num(params["emp_mode"])


			var/turf/target_turf = get_turf(admin_mob)
			message_admins("[ADMIN_LOOKUPFLW(admin_client)] created an admin [emp_mode ? "EMP" : "explosion"] at [ADMIN_VERBOSEJMP(target_turf)].")
			log_admin("[key_name(admin_client)] created an admin [emp_mode ? "EMP" : "explosion"] at [admin_mob.loc].")

			if (emp_mode)
				empulse(admin_mob, power, power / 2, TRUE)
			else
				explosion(admin_mob, power / 3, power / 2, power, power, ignorecap = TRUE)

		/// Narrates typed texxt to the selected client's chatboxx
		if ("narrate")
			var/list/raw_styles = params["classes"]

			var/styles = ""
			for(var/style in raw_styles)
				styles += "[style]:[raw_styles[style]];"

			if (params["mode_global"])
				to_chat(world, "<span style='[styles]'>[params["message"]]</span>")
				log_admin("GlobalNarrate: [key_name(admin_client)] : [params["message"]]")
				message_admins(span_adminnotice("[key_name_admin(admin_client)] Sent a global narrate"))
			else
				for(var/mob/individual_mob in view(params["range"], admin_mob))
					to_chat(individual_mob, "<span style='[styles]'>[params["message"]]</span>")

				log_admin("LocalNarrate: [key_name(admin_client)] at [AREACOORD(admin_mob)]: [params["message"]]")
				message_admins(span_adminnotice("<b> LocalNarrate: [key_name_admin(admin_client)] at [ADMIN_VERBOSEJMP(admin_mob)]:</b> [params["message"]]<BR>"))

		/// Opens languages panel for the selected player/client
		if ("languages")
			var/datum/language_holder/selected_character = target_mob.get_language_holder()
			selected_character.open_language_menu(admin_mob)

		/// Opens the Traitor Panel for the selected player/client
		if ("traitor_panel")
			SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/show_traitor_panel, target_mob)

		/// Opens the Job Exemption Panel for the selected player/client
		if ("job_exemption_panel")
			show_job_exempt_menu(admin_mob, target_mob.ckey)

		/// Opens the selected player/client's skills panel
		if ("skill_panel")
			SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/show_skill_panel, target_mob)

		/// Opens the selected player/client's borg panel
		if ("borg_panel")
			if(!iscyborg(target_mob))
				to_chat(admin_client, span_warning("This can only be used on cyborgs."))
				return
			SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/borg_panel, target_mob)

		/// Gives targeted mob GOD (its only invulnerability)
		if ("toggle_godmode")
			admin_client.cmd_admin_godmode(target_mob)

		/// Forces a commendation to selected client/player
		if ("commend")
			if(!target_mob.ckey)
				to_chat(admin_client, span_warning("This mob either no longer exists or no longer is being controlled by someone!"))
				return

			switch(tgui_alert(admin_mob, "Would you like the effects to apply immediately or at the end of the round? Applying them now will make it clear it was an admin commendation.", "<3?", list("Apply now", "Apply at round end", "Cancel")))
				if("Apply now")
					target_mob.receive_heart(admin_mob, instant = TRUE)
				if("Apply at round end")
					target_mob.receive_heart(admin_mob)

		/// Plays a selected sound to target client
		if ("play_sound_to")
			var/sound_file = input("", "Select a sound file",) as null|sound

			if(sound_file && target_mob)
				SSadmin_verbs.dynamic_invoke_verb(admin_client, /datum/admin_verb/play_direct_mob_sound, sound_file, target_mob)

		/// Applies selected client's quirks
		if ("apply_client_quirks")
			var/mob/living/carbon/human/specified_humanoid = target_mob
			if(!istype(specified_humanoid))
				to_chat(admin_client, "this can only be used on instances of type /mob/living/carbon/human.", confidential = TRUE)
				return
			if(!specified_humanoid.client)
				to_chat(admin_client, "[specified_humanoid] has no client!", confidential = TRUE)
				return
			SSquirks.AssignQuirks(specified_humanoid, specified_humanoid.client)
			log_admin("[key_name(admin_client)] applied client quirks to [key_name(specified_humanoid)].")
			message_admins(span_adminnotice("[key_name_admin(admin_client)] applied client quirks to [key_name_admin(specified_humanoid)]."))

		/// Toggles a status flag on the selected mob
		if ("toggle_status_flag")
			var/mob/living/living_mob = target_mob
			if(!istype(living_mob))
				return

			var/flag = params["flag"]
			var/enabled = params["enabled"]

			// Special handling for godmode trait
			if(flag == "godmode")
				admin_client.cmd_admin_godmode(target_mob)
			else
				var/numeric_flag = text2num(flag)
				if(enabled)
					living_mob.status_flags |= numeric_flag
				else
					living_mob.status_flags &= ~numeric_flag
				log_admin("[key_name(admin_client)] [enabled ? "enabled" : "disabled"] status flag [numeric_flag] on [key_name(target_mob)].")

		/// Sets the movement speed of the selected mob
		if ("set_speed")
			var/mob/living/living_mob = target_mob
			if(!istype(living_mob))
				return

			var/new_speed = text2num(params["speed"])
			if(isnull(new_speed))
				return

			// Remove existing admin speed modifier
			living_mob.remove_movespeed_modifier(/datum/movespeed_modifier/admin_varedit)
			var/diff = new_speed - living_mob.cached_multiplicative_slowdown
			if(diff != 0)
				living_mob.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/admin_varedit, multiplicative_slowdown = diff)

			log_admin("[key_name(admin_client)] set speed of [key_name(target_mob)] to [new_speed].")
		/// Adds a faction to the selected mob
		if ("add_faction")
			var/mob/living/living_mob = target_mob
			if(!istype(living_mob))
				return

			var/new_faction = params["faction"]
			if(new_faction == "Custom")
				new_faction = tgui_input_text(admin_client, "Enter custom faction name:", "Custom Faction")
				if(!new_faction)
					return

			if(!living_mob.faction)
				living_mob.faction = list()
			else if(!islist(living_mob.faction))
				living_mob.faction = list(living_mob.faction)

			if(!(new_faction in living_mob.faction))
				living_mob.faction += new_faction

			log_admin("[key_name(admin_client)] added faction [new_faction] to [key_name(target_mob)].")
			message_admins(span_adminnotice("[key_name_admin(admin_client)] added faction [new_faction] to [key_name_admin(target_mob)]."))
		/// Removes a faction from the selected mob
		if ("remove_faction")
			var/mob/living/living_mob = target_mob
			if(!istype(living_mob))
				return

			var/faction_to_remove = params["faction"]
			if(!living_mob.faction || !islist(living_mob.faction))
				return

			LAZYREMOVE(living_mob.faction, faction_to_remove)

			log_admin("[key_name(admin_client)] removed faction [faction_to_remove] from [key_name(target_mob)].")
			message_admins(span_adminnotice("[key_name_admin(admin_client)] removed faction [faction_to_remove] from [key_name_admin(target_mob)]."))

		/// Loads the client's preferences onto the selected human mob
		if ("load_preferences")
			var/mob/living/carbon/human/human_mob = target_mob
			if(!istype(human_mob))
				to_chat(admin_client, "This can only be used on humans.", confidential = TRUE)
				return
			if(!human_mob.client)
				to_chat(admin_client, "[human_mob] has no client!", confidential = TRUE)
				return

			human_mob.client.prefs.apply_prefs_to(human_mob)
			log_admin("[key_name(admin_client)] loaded preferences onto [key_name(human_mob)].")
			message_admins(span_adminnotice("[key_name_admin(admin_client)] loaded preferences onto [key_name_admin(human_mob)]."))

/// Gets the target mob's ckey, handling both active clients and stored ckeys
/datum/player_panel/proc/get_target_ckey()
	if(target_mob.client)
		return target_mob.client.ckey
	if(target_mob.ckey)
		if(copytext(target_mob.ckey, 1, 2) == "@")
			var/result = copytext(target_mob.ckey, 2)
			return result
		else
			return target_mob.ckey
	return null

/// Loads the Discord ID for the target mob from the database and caches it
/datum/player_panel/proc/load_discord_id()
	if(!target_mob)
		return

	if(!SSdbcore.IsConnected())
		discord_id_cache = "Database not connected"
		return

	var/target_ckey = get_target_ckey()
	if(!target_ckey)
		discord_id_cache = "No ckey found"
		return

	var/datum/db_query/discord_query = SSdbcore.NewQuery(
		"SELECT CAST(discord_id AS CHAR) FROM [format_table_name("discord_links")] WHERE ckey = :ckey and valid = '1'",
		list("ckey" = target_ckey)
	)
	if(discord_query.warn_execute())
		if(discord_query.NextRow())
			discord_id_cache = discord_query.item[1]
		else
			discord_id_cache = "Not found"
	else
		discord_id_cache = "Database error"
	qdel(discord_query)

