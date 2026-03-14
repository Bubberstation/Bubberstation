/// DEATHRATTLE MEANT FOR MINERS AND SPACETIDERS
/// Send a message with all players that have a headset with cargo OR medical encryptions when the user dies. On lowpop (less than 10 players), everyone gets the message regardless of the channels they have. Silicons also always get the messagebecause why not.

GLOBAL_VAR_INIT(offstation_deathrattle_group, null)

/datum/deathrattle_group/offstation
	var/list/offstation_traits = list(
		ZTRAIT_LAVA_RUINS,
		ZTRAIT_ICE_RUINS,
		ZTRAIT_ICE_RUINS_UNDERGROUND,
		ZTRAIT_MOONSTATION_RUINS,
	)
	var/list/deathrattle_sounds = list(
		'sound/items/knell/knell1.ogg',
		'sound/items/knell/knell2.ogg',
		'sound/items/knell/knell3.ogg',
		'sound/items/knell/knell4.ogg',
	)

/datum/deathrattle_group/offstation/proc/active_player_count()
	var/active_players = 0
	for(var/mob/living/player as anything in GLOB.player_list)
		if(!player.client)
			continue
		if(player.stat == DEAD)
			continue
		active_players++
	return active_players

/datum/deathrattle_group/offstation/proc/should_bypass_headset_requirement()
	return active_player_count() < 10

/datum/deathrattle_group/offstation/proc/headset_recipient(obj/item/radio/headset/headset)
	if(!istype(headset))
		return FALSE

	if(!length(headset.channels))
		return FALSE

	return (RADIO_CHANNEL_SUPPLY in headset.channels) || (RADIO_CHANNEL_MEDICAL in headset.channels)

/datum/deathrattle_group/offstation/proc/notify_recipient(mob/living/recipient, victim_name, victim_area, sound)
	var/radio_prefix = span_radio("Your headset crackles with a strange, robotic voice...")
	var/death_notice = span_robot("<b>[victim_name]</b> has died at <b>[victim_area]</b>.")
	to_chat(recipient, "[radio_prefix] \"[death_notice]\"")
	recipient.playsound_local(get_turf(recipient), sound, vol = 75, vary = FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/deathrattle_group/offstation/proc/area_auth(mob/living/owner)
	if(!istype(owner))
		return FALSE

	var/turf/owner_turf = get_turf(owner)
	if(!owner_turf)
		return FALSE

	var/owner_z = owner_turf?.z
	if(!owner_z || is_station_level(owner_z))
		return FALSE

	// Ignores CentCom & Interlink specifically
	if(is_centcom_level(owner_z) || is_away_level(owner_z) || istype(get_area(owner_turf), /area/centcom/interlink))
		return FALSE

	if(isspaceturf(owner_turf))
		return TRUE

	if(is_mining_level(owner_z) || is_spaceruins_level(owner_z))
		return TRUE

	for(var/trait in offstation_traits)
		if(SSmapping.level_trait(owner_z, trait))
			return TRUE

	return FALSE

/datum/deathrattle_group/offstation/on_implant_implantation(obj/item/implant/implant, mob/living/target, mob/user, silent = FALSE, force = FALSE)
	SIGNAL_HANDLER

	if(!target && istype(implant, /mob/living))
		target = implant

	if(!istype(target))
		return

	RegisterSignal(target, COMSIG_MOB_STATCHANGE, PROC_REF(on_user_statchange))

/datum/deathrattle_group/offstation/on_user_statchange(mob/living/owner, new_stat)
	SIGNAL_HANDLER

	if(new_stat != DEAD)
		return

	if(!area_auth(owner))
		return

	var/victim_name = owner.mind ? owner.mind.name : owner.real_name
	var/victim_area = get_area_name(get_turf(owner))
	var/sound = pick(deathrattle_sounds)
	var/bypass_headset_requirement = should_bypass_headset_requirement()

	for(var/mob/living/recipient as anything in GLOB.player_list)
		if(recipient == owner || recipient.stat == DEAD || !recipient.client)
			continue

		if(istype(recipient, /mob/living/silicon))
			notify_recipient(recipient, victim_name, victim_area, sound)
			continue

		var/mob/living/carbon/human/human_recipient = recipient
		if(!istype(human_recipient))
			continue

		var/obj/item/radio/headset/listener_headset = human_recipient.ears
		if(!istype(listener_headset))
			continue

		if(!bypass_headset_requirement && !headset_recipient(listener_headset))
			continue

		notify_recipient(recipient, victim_name, victim_area, sound)

/obj/item/implant/deathrattle/offstation
	name = "off-station deathrattle implant"

/obj/item/implant/deathrattle/offstation/Initialize(mapload)
	. = ..()

	if(!GLOB.offstation_deathrattle_group)
		GLOB.offstation_deathrattle_group = new /datum/deathrattle_group/offstation("off-station group")

	var/datum/deathrattle_group/offstation/group = GLOB.offstation_deathrattle_group
	group.register(src)

/obj/item/implantcase/deathrattle/offstation
	name = "implant case - 'Off-Station Deathrattle'"
	desc = "A glass case containing an off-station deathrattle implant."
	imp_type = /obj/item/implant/deathrattle/offstation

/obj/item/storage/box/offstation_deathrattle
	name = "off-station deathrattle kit"
	desc = "A box containing an implanter and an off-station deathrattle implant, which automatically sends a distress call to the cargo and medical departments in case of premature demise. It will only work outside of Station areas."
	icon = 'modular_skyrat/modules/aesthetics/storage/storage.dmi'
	icon_state = "box"

/obj/item/storage/box/offstation_deathrattle/PopulateContents()
	new /obj/item/implanter(src)

	var/obj/item/implantcase/deathrattle/offstation/case = new(src)
	if(!GLOB.offstation_deathrattle_group)
		GLOB.offstation_deathrattle_group = new /datum/deathrattle_group/offstation("off-station group")

	var/datum/deathrattle_group/offstation/group = GLOB.offstation_deathrattle_group
	group.register(case.imp)
