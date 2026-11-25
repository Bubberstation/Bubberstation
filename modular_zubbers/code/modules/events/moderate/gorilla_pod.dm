/datum/round_event_control/stray_cargo/ape_escape
	name = "Escaped Gorilla Pod"
	typepath = /datum/round_event/stray_cargo/ape_escape
	weight = 1
	min_players = 30
	max_occurrences = 1
	earliest_start = 45 MINUTES
	description = "Sends one violent gorilla to the station."
	admin_setup = list(/datum/event_admin_setup/set_location/stray_cargo,)
	category = EVENT_CATEGORY_ENTITIES
	tags = list(TAG_COMBAT, TAG_NPC_ANTAG)
	track = EVENT_TRACK_MODERATE

/datum/round_event/stray_cargo/ape_escape
	announce_when = 0
	announce_chance = 100
	possible_pack_types = list()

	///What mob will be spawned
	var/mob/spawned_mob = /mob/living/basic/gorilla/dangerous

/datum/round_event/stray_cargo/ape_escape/announce(fake)
	priority_announce("The ape has escaped. Beware.", "CentCom Dangerous Wildlife Division", sound = ANNOUNCER_SPOOKY, color_override = "yellow")

/datum/round_event/stray_cargo/ape_escape/make_pod()
	var/obj/structure/closet/supplypod/fivenightsatfreddys = new
	fivenightsatfreddys.set_style(/datum/pod_style/centcom)
	new spawned_mob(fivenightsatfreddys)
	return fivenightsatfreddys

/datum/round_event/stray_cargo/ape_escape/get_contents()
	return null

/mob/living/basic/gorilla/dangerous
	faction = list(FACTION_HOSTILE)
