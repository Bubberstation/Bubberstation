/obj/item/banhammer/real
	name = "\improper REAL banhammer"
	desc = "A hammer that has been banned in several sectors. Careful when using this."
	desc_controls = "Click to temporarily send someone to the void. Click with combat mode on to permabrig someone. Click in hand to set ban reason."
	var/static/list/area/areas_to_teleport_to = list( //A list of areas to teleport to. Sorted by priority (first one is set first, if the area exists).
		/area/station/security/prison/safe,
		/area/station/security/prison/work,
		/area/station/security/prison/rec,
		/area/station/security/prison/upper,
		/area/station/security/prison,
	)
	var/ban_reason = "No reason specified."

/obj/item/banhammer/real/attack_self(mob/user)

	var/desired_ban_reason = reject_bad_text(tgui_input_text(user, "Ban Reason", "Set Ban Reason", ban_reason, MAX_PLAQUE_LEN))

	if(desired_ban_reason)
		ban_reason = desired_ban_reason
	else
		ban_reason = initial(ban_reason)

	to_chat(user, span_notice("Ban reason set to: \"[ban_reason]\""))


/obj/item/banhammer/real/attack(mob/M, mob/living/user)

	. = ..()

	if(!ishuman(M)) //Humans only.
		return

	if(M.can_block_magic())
		M.visible_message(span_danger("[M] resists the effects of the banhammer! They're ban immune!"))
		return

	if(user.combat_mode) //Perma
		var/area/current_area = get_area(M)
		if(!current_area || istype(current_area,/area/station/security/prison)) //Already perma'd.
			M.visible_message(span_danger("[M] resists the effects of the banhammer! They're already in the permabrig!"))
			return

		var/turf/turf_to_teleport_to
		for(var/area/area_path as anything in areas_to_teleport_to)
			turf_to_teleport_to = get_safe_random_station_turf(area_path)
			if(!turf_to_teleport_to)
				continue
			if(do_teleport(M,turf_to_teleport_to,forced = TRUE,channel = TELEPORT_CHANNEL_MAGIC)) //Rare chance of this actually failing for some reason.
				dispatch_announcement_to_players(span_noticealien("[M] has been sent to permabrig by [user]: Reason: [ban_reason]"),sound_override = 'sound/effects/adminhelp.ogg')
				return

	var/turf/T = get_turf(M)
	if(T) new /obj/effect/immortality_talisman/void(T, M) //Temp
