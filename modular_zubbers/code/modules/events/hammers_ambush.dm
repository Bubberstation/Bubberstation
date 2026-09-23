/datum/round_event_control/syndicate_assassination_attempt
	name = "Syndicate Assasination Attempt"
	typepath = /datum/round_event/syndicate_assassination_attempt
	weight = 8
	min_players = 30
	max_occurrences = 4
	earliest_start = 40 MINUTES
	description = "Syndicate goons appear from a drop pod and attack a targeted player."
	tags = list(TAG_COMBAT, TAG_NPC_ANTAG)
	track = EVENT_TRACK_MODERATE

///Spawns a cargo pod containing a random cargo supply pack on a random area of the station
/datum/round_event/syndicate_assassination_attempt
	var/mob/victim ///Randomly picked player
	announce_chance = 100
	///types of syndies to send in
	var/list/potential_assassins = list(
		/mob/living/basic/trooper/syndicate/melee,\
		/mob/living/basic/trooper/syndicate/melee/sword/space, \
		/mob/living/basic/trooper/syndicate/melee/sword/space/stormtrooper,\
		/mob/living/basic/trooper/syndicate/ranged, \
		/mob/living/basic/trooper/syndicate/ranged/smg, \
		/mob/living/basic/trooper/syndicate/ranged/shotgun/space, \
	)
	///how many syndies to send in
	var/spawn_number = 5

/datum/round_event/syndicate_assassination_attempt/announce(fake)
	if(fake)
		victim = find_victim()
	priority_announce("Dear [victim], count your days left, because they are numbered. You're marked for death and we're here to collect.", "The Syndicate", 'sound/announcer/announcement/announce_syndi.ogg', ANNOUNCEMENT_TYPE_SYNDICATE, has_important_message = TRUE, color_override = "red")

/**
* Tries to find a valid area, throws an error if none are found
* Also randomizes the start timer
*/
/datum/round_event/syndicate_assassination_attempt/setup()
	start_when = rand(20, 40)
	victim = find_victim()
	if(isnull(victim))
		CRASH("No valid candidates for assassination found.")

///Spawns a random supply pack, puts it in a pod, and spawns it on a random tile of the selected area
/datum/round_event/syndicate_assassination_attempt/start()
	var/obj/structure/closet/supplypod/pod = make_pod()
	fill_pod(pod)
	var/turf/landing_zone = get_turf(victim)

	new /obj/effect/pod_landingzone (landing_zone, pod)

	alert_ghosts(victim)

/datum/round_event/syndicate_assassination_attempt/proc/alert_ghosts(mob/victim)
	notify_ghosts("[victim.name] is being attacked by the syndicate!", source = victim, header = "Assassination in progress")

/datum/round_event/syndicate_assassination_attempt/proc/find_victim()
	var/list/candidates = list()
	var/list/blacklisted_areas = get_blacklisted_areas()
	for(var/mob/player as anything in GLOB.player_list)
		if(player.has_faction(ROLE_SYNDICATE))
			continue
		var/area_type = get_area(player)
		if(area_type in blacklisted_areas)
			continue
		if(!is_station_level(player.z))
			continue
		if(isdead(player))
			continue
		if(!ishuman(player))
			continue
		candidates += player

	return pick(candidates)

/datum/round_event/syndicate_assassination_attempt/proc/get_blacklisted_areas()
	return GLOB.expected_erp_areas.Copy()

///Handles the creation of the pod, in case it needs to be modified beforehand
/datum/round_event/syndicate_assassination_attempt/proc/make_pod()
	var/obj/structure/closet/supplypod/S = new
	S.set_style(/datum/pod_style/syndicate)
	return S

///Puts entities in the pod
/datum/round_event/syndicate_assassination_attempt/proc/fill_pod(obj/structure/closet/supplypod)
	var/spawntype
	for(var/i = 0; i < spawn_number; i ++)
		spawntype = pick(potential_assassins)
		new spawntype(supplypod)

///////////////////////////////////////////////////
///////////////////// Hammers /////////////////////
///////////////////////////////////////////////////

/datum/round_event_control/kill_this_guy_with_hammers
	name = "Kill this guy with hammers"
	typepath = /datum/round_event/syndicate_assassination_attempt/hammers
	weight = 1
	max_occurrences = 1
	min_players = 30
	earliest_start = 40 MINUTES
	description = "Syndicate goons appear from a drop pod and attack a targeted player with hammers."
	tags = list(TAG_COMBAT, TAG_NPC_ANTAG)
	track = EVENT_TRACK_MODERATE

/datum/round_event/syndicate_assassination_attempt/hammers
	potential_assassins = list(
		/mob/living/basic/trooper/syndicate/melee/hammer,\
	)
	spawn_number = 8

/datum/round_event/syndicate_assassination_attempt/hammers/announce(fake)
	priority_announce("We are going to kill [victim] with hammers. This is a threat.", "The Syndicate", 'sound/announcer/announcement/announce_syndi.ogg', ANNOUNCEMENT_TYPE_SYNDICATE, has_important_message = TRUE, color_override = "red")

/mob/living/basic/trooper/syndicate/melee/hammer
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "hammers"
	attack_verb_simple = "hammer"
	attack_sound = 'sound/items/weapons/sonic_jackhammer.ogg'
	armour_penetration = 35
	r_hand = /obj/item/melee/breaching_hammer
