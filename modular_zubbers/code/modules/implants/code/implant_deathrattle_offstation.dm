/// DEATHRATTLE MEANT FOR MINERS AND SPACETIDERS
/// Sends a message to all players that have a headset with cargo OR medical encryptions when the user dies. On lowpop (less than 10 players), everyone gets the message regardless of the channels they have. Silicons also always get the message because why not.

GLOBAL_VAR_INIT(offstation_deathrattle_group, null)

/datum/offstation_deathrattle_group
	var/name
	var/list/implants = list()
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

/datum/offstation_deathrattle_group/New(name)
	if(name)
		src.name = name
	else
		src.name = "off-station group"

/datum/offstation_deathrattle_group/proc/register(obj/item/implant/deathrattle/implant)
	if(implant in implants)
		return

	RegisterSignal(implant, COMSIG_IMPLANT_IMPLANTED, PROC_REF(on_implant_implantation))
	RegisterSignal(implant, COMSIG_IMPLANT_REMOVED, PROC_REF(on_implant_removal))
	RegisterSignal(implant, COMSIG_QDELETING, PROC_REF(on_implant_destruction))

	implants += implant

	if(implant.imp_in)
		on_implant_implantation(implant, implant.imp_in)

/datum/offstation_deathrattle_group/proc/on_implant_removal(obj/item/implant/implant, mob/living/source, silent = FALSE, special = 0)
	UnregisterSignal(source, COMSIG_MOB_STATCHANGE)

/datum/offstation_deathrattle_group/proc/on_implant_destruction(obj/item/implant/implant)
	implants -= implant

/datum/offstation_deathrattle_group/proc/active_player_count()
	var/active_players = 0
	for(var/mob/living/player as anything in GLOB.player_list)
		if(!player.client)
			continue
		if(player.stat == DEAD)
			continue
		active_players++
	return active_players

/datum/offstation_deathrattle_group/proc/should_bypass_headset_requirement()
	return active_player_count() < 10

/datum/offstation_deathrattle_group/proc/headset_recipient(obj/item/radio/headset/headset)
	if(!istype(headset))
		return FALSE

	if(!length(headset.channels))
		return FALSE

	return (RADIO_CHANNEL_SUPPLY in headset.channels) || (RADIO_CHANNEL_MEDICAL in headset.channels)

/datum/offstation_deathrattle_group/proc/notify_recipient(mob/living/recipient, victim_name, victim_area, sound)
	var/radio_prefix = span_radio("Your headset crackles with a strange, robotic voice...")
	var/death_notice = span_robot("<b>[victim_name]</b> has died at <b>[victim_area]</b>.")
	to_chat(recipient, "[radio_prefix] \"[death_notice]\"")
	recipient.playsound_local(get_turf(recipient), sound, vol = 75, vary = FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/offstation_deathrattle_group/proc/area_auth(mob/living/owner)
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

/datum/offstation_deathrattle_group/proc/on_implant_implantation(obj/item/implant/implant, mob/living/target, mob/user, silent = FALSE, force = FALSE)
	if(!target && istype(implant, /mob/living))
		target = implant

	if(!istype(target))
		return

	RegisterSignal(target, COMSIG_MOB_STATCHANGE, PROC_REF(on_user_statchange))

/datum/offstation_deathrattle_group/proc/on_user_statchange(mob/living/owner, new_stat)
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
		GLOB.offstation_deathrattle_group = new /datum/offstation_deathrattle_group("off-station group")

	var/datum/offstation_deathrattle_group/group = GLOB.offstation_deathrattle_group
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
		GLOB.offstation_deathrattle_group = new /datum/offstation_deathrattle_group("off-station group")

	var/datum/offstation_deathrattle_group/group = GLOB.offstation_deathrattle_group
	group.register(case.imp)
