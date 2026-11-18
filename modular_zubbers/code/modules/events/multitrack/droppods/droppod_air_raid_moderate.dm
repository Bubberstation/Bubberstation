/datum/round_event_control/drop_troopers_syndicate_lesser
	name = "Drop Troopers: Syndicate (Lesser)"
	description = "The Syndicate sends small numbers of drop pod soldiers to fight the station."
	typepath = /datum/round_event/droppod_airraid/syndicate/lesser
	weight = 10
	max_occurrences = 1
	min_players = 12
	category = EVENT_CATEGORY_ENTITIES
	track = EVENT_TRACK_MUNDANE
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_NPC_ANTAG)

/datum/round_event/droppod_airraid/syndicate/lesser
	turf_droppods_ratio = 50
	spawn_wave_total_lower = 1
	spawn_wave_total_upper = 3
	droppod_density = 1
	boss_types = list()
	max_boss_pods = 0
	time_to_next_wave_droppod_factor = 50

/datum/round_event/droppod_airraid/syndicate/lesser/announce(fake)
	priority_announce("Alert! The Syndicate is sending a skirmishing party to [GLOB.station_name]. Please brace for impact.", "Incoming Enemy Scouts", sound = 'sound/announcer/notice/notice1.ogg', color_override = "orange")


//////////////////////////////////////
//////////////// BOTS ////////////////
//////////////////////////////////////

/datum/round_event_control/drop_troopers_hivebots
	name = "Drop Troopers: Hivebots"
	description = "A fleet of autonomous robot invaders attacks the station."
	typepath = /datum/round_event/droppod_airraid/hivebots
	weight = 10
	max_occurrences = 2
	min_players = 20
	admin_setup = list()
	//admin_setup = list(/datum/event_admin_setup/multiple_choice/droppod_troopers)
	category = EVENT_CATEGORY_ENTITIES
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_NPC_ANTAG)

/datum/round_event/droppod_airraid/hivebots
	turf_droppods_ratio = 50
	spawn_wave_total_lower = 3
	spawn_wave_total_upper = 5
	droppod_density = 5
	enemy_types = list(
		/mob/living/basic/hivebot/range, \
		/mob/living/basic/hivebot/rapid, \
		/mob/living/basic/hivebot/strong, \
		/mob/living/basic/hivebot/mechanic, \
	)
	max_boss_pods = 0
	time_to_next_wave_droppod_factor = 50

	droppod_style = /datum/pod_style
	max_droppod_dropdelay = 10
	min_droppod_dropdelay = 30

/datum/round_event/droppod_airraid/hivebots/announce(fake)
	priority_announce("Alert! Unidentified pod signatures have been detected en-route to [GLOB.station_name]. Please brace for impact.", "Unidentified Drop Pods", sound = 'sound/announcer/notice/notice1.ogg', color_override = "orange")

/datum/round_event/droppod_airraid/hivebots/announce_end()
	priority_announce("The pod fleet colliding into [GLOB.station_name] has ceased. Please calmly return to your work tasks.")
