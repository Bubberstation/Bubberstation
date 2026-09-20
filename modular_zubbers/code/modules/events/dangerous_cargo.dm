////////////////////// violent gorilla //////////////////////

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
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_NPC_ANTAG)
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

////////////////////// syndie bomb squad //////////////////////

/datum/round_event_control/stray_cargo/syndie_bombsquad
	name = "Syndicate Bomb Squad"
	typepath = /datum/round_event/stray_cargo/syndie_bombsquad
	weight = 5
	min_players = 30
	max_occurrences = 1
	earliest_start = 45 MINUTES
	description = "A team of Syndicate saboteurs will try to blow up an important location."
	admin_setup = list(/datum/event_admin_setup/set_location/stray_cargo,)
	category = EVENT_CATEGORY_ENTITIES
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_NPC_ANTAG, TAG_DESTRUCTIVE)
	track = EVENT_TRACK_MODERATE

/datum/round_event/stray_cargo/syndie_bombsquad
	announce_when = 0
	announce_chance = 100
	possible_pack_types = list()
	///how many entities will be put in the pod?
	var/pod_entities = 6
	///what entities to use?
	var/list/possible_entities = list(
		/mob/living/basic/trooper/syndicate/melee,\
		/mob/living/basic/trooper/syndicate/melee/sword, \
		/mob/living/basic/trooper/syndicate/melee/sword/space, \
		/mob/living/basic/trooper/syndicate/ranged, \
		/mob/living/basic/trooper/syndicate/ranged/smg, \
		/mob/living/basic/trooper/syndicate/ranged/shotgun, \
		/mob/living/basic/trooper/syndicate/ranged/shotgun/space, \
	)
	lower_bound_wait_time = 0
	upper_bound_wait_time = 10


/datum/round_event/stray_cargo/syndie_bombsquad/announce(fake)
	if(fake)
		impact_area = find_event_area()
	priority_announce("The Syndicate has dispatched a bomb squad to attack [impact_area.name]. \n\n Security and engineering intervention recommended to eliminate threats and defuse the bomb.", "CentCom Department of Intelligence", 'modular_zubbers/sound/alerts/amber.ogg', color_override = "yellow")

///Apply the syndicate pod skin
/datum/round_event/stray_cargo/syndie_bombsquad/make_pod()
	var/obj/structure/closet/supplypod/S = new
	S.set_style(/datum/pod_style/syndicate)
	fill_pod(S)
	return S

///don't use this; instead use custom logic to put syndies in the pod
/datum/round_event/stray_cargo/syndie_bombsquad/get_contents()
	return null

///custom logic to put syndies in the pod
/datum/round_event/stray_cargo/syndie_bombsquad/proc/fill_pod(obj/to_fill)
	var/newobj
	for(var/i = 0; i < pod_entities; i ++)
		newobj = pick(possible_entities)
		newobj = new newobj(to_fill)
	insert_bomb(to_fill)

///creates and inserts a new syndiebomb to the pod
/datum/round_event/stray_cargo/syndie_bombsquad/proc/insert_bomb(obj/to_fill)
	var/obj/machinery/syndicatebomb/mybomb = new /obj/machinery/syndicatebomb/ezbomb(to_fill)
	mybomb.activate()

/datum/round_event/stray_cargo/syndie_bombsquad/find_event_area()
	var/list/potential_areas
	var/list/potential_areas_whitelist = list(
		/area/station/command/vault,
		/area/station/command/bridge,
		/area/station/security/armory,
		/area/station/security/evidence,
		/area/station/security/brig,
		/area/station/ai/upload,
		/area/station/engineering/main,
		/area/station/science/server,
		/area/station/medical/chemistry,
	)
	potential_areas = make_associative(GLOB.the_station_areas) & typecacheof(potential_areas_whitelist)
	return pick(potential_areas)

/obj/machinery/syndicatebomb/ezbomb
	name = "Syndicate EZ-Bomb"
	desc = "An off-the-shelf bomb stolen from Nanotrasen. Whoever assembled this did a shitty job; the wires follow a textbook example of a bomb, so anyone with a passing knowledge in circuitry knows how to disassemble this..."
	color = "#33bb33"
	minimum_timer = 300 // 300 seconds
	timer_set = 300
	anchored = TRUE

/obj/machinery/syndicatebomb/ezbomb/Initialize(mapload)
	. = ..()
	qdel(wires)
	set_wires(new /datum/wires/syndicatebomb/ezbomb(src))

/datum/wires/syndicatebomb/ezbomb
	proper_name = "Unconfigured Syndicate Explosive Device"

/datum/wires/syndicatebomb/ezbomb/can_reveal_wires(mob/user)
	if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		return TRUE
	if(HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		return TRUE
	if(HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		return TRUE
	return ..()
