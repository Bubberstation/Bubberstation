/datum/job/bridge_assistant
	title = JOB_BRIDGE_ASSISTANT
	description = "Watch over the Bridge, command its consoles, and spend your days brewing coffee for higher-ups."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD //not really a head but close enough
	department_head = list(JOB_CAPTAIN)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Captain, and in non-Bridge related situations the other heads"
	minimal_player_age = 7
	exp_requirements = 300
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BRIDGE_ASSISTANT"

	outfit = /datum/outfit/job/bridge_assistant
	plasmaman_outfit = /datum/outfit/plasmaman/bridge_assistant

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CIV

	liver_traits = list(TRAIT_PRETENDER_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_BRIDGE_ASSISTANT
	department_for_prefs = /datum/job_department/captain
	departments_list = list(/datum/job_department/command)

	family_heirlooms = list(/obj/item/banner/command/mundane)

	mail_goodies = list(
		/obj/item/storage/fancy/cigarettes = 1,
		/obj/item/pen/fountain = 1,
	)
	rpg_title = "Royal Guard"
	allow_bureaucratic_error = FALSE
	job_flags = STATION_JOB_FLAGS | JOB_ANTAG_BLACKLISTED | JOB_CANNOT_OPEN_SLOTS
	human_authority = JOB_AUTHORITY_NON_HUMANS_ALLOWED

/obj/effect/landmark/start/bridge_assistant
	name = "Bridge Assistant"
	icon_state = "Blueshield"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/datum/job/bridge_assistant/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	var/mob/living/carbon/bridgie = spawned
	if(istype(bridgie))
		bridgie.gain_trauma(/datum/brain_trauma/special/axedoration)

/datum/job/bridge_assistant/get_roundstart_spawn_point()
	var/list/chair_turfs = list()
	var/list/possible_turfs = list()
	var/area/bridge = GLOB.areas_by_type[/area/station/command/bridge]
	if(isnull(bridge))
		return ..() //if no bridge, spawn on the arrivals shuttle (but also what the fuck)
	for (var/list/zlevel_turfs as anything in bridge.get_zlevel_turf_lists())
		for (var/turf/possible_turf as anything in zlevel_turfs)
			if(possible_turf.is_blocked_turf())
				continue
			if(locate(/obj/structure/chair) in possible_turf)
				chair_turfs += possible_turf
				continue
			possible_turfs += possible_turf
	if(length(chair_turfs))
		return pick(chair_turfs) //prioritize turfs with a chair
	if(length(possible_turfs))
		return pick(possible_turfs) //if none, just pick a random turf in the bridge
	return ..() //if the bridge has no turfs, spawn on the arrivals shuttle

/datum/outfit/job/bridge_assistant
	name = "Bridge Assistant"
	jobtype = /datum/job/bridge_assistant

	id_trim = /datum/id_trim/job/bridge_assistant
	backpack_contents = list(
		/obj/item/modular_computer/pda/bridge_assistant = 1,
	)

	uniform = /obj/item/clothing/under/trek/command/next
	neck = /obj/item/clothing/neck/large_scarf/blue
	belt = /obj/item/storage/belt/utility/full/inducer
	ears = /obj/item/radio/headset/headset_com
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/fingerless
	head = /obj/item/clothing/head/soft/black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/gun/energy/e_gun/mini
	r_pocket = /obj/item/assembly/flash/handheld

// Coffeemaker time!
/datum/job/bridge_assistant/New()
	. = ..()
	RegisterSignal(SSatoms, COMSIG_SUBSYSTEM_POST_INITIALIZE, PROC_REF(add_coffeemaker))

/// Creates a coffeemaker in the bridge, if we don't have one yet.
/datum/job/bridge_assistant/proc/add_coffeemaker(datum/source)
	SIGNAL_HANDLER
	var/area/bridge = GLOB.areas_by_type[/area/station/command/bridge]
	if(isnull(bridge)) //no bridge, what will he assist?
		return
	var/list/possible_coffeemaker_positions = list(/area/station/command/bridge, /area/station/command/meeting_room)
	var/list/coffeemakers = SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/coffeemaker)
	for(var/obj/machinery/coffeemaker as anything in coffeemakers) //don't spawn a coffeemaker if there is already one on the bridge
		if(is_type_in_list(get_area(coffeemaker), possible_coffeemaker_positions))
			return
	var/list/tables = list()
	for(var/turf/area_turf as anything in bridge.get_turfs_from_all_zlevels())
		var/obj/structure/table/table = locate() in area_turf
		if(isnull(table))
			continue
		if(area_turf.is_blocked_turf(ignore_atoms = list(table))) //don't spawn a coffeemaker on a fax machine or smth
			continue
		tables += table
	if(!length(tables))
		return
	var/picked_table = pick_n_take(tables)
	var/picked_turf = get_turf(picked_table)
	if(length(tables))
		var/another_table = pick(tables)
		for(var/obj/thing_on_table in picked_turf) //if there's paper bins or other shit on the table, get that off
			if(thing_on_table == picked_table)
				continue
			if(HAS_TRAIT(thing_on_table, TRAIT_WALLMOUNTED) || (thing_on_table.flags_1 & ON_BORDER_1) || thing_on_table.layer < TABLE_LAYER)
				continue
			if(thing_on_table.invisibility || !thing_on_table.alpha || !thing_on_table.mouse_opacity)
				continue
			thing_on_table.forceMove(get_turf(another_table))
	new /obj/machinery/coffeemaker/impressa(picked_turf)
	new /obj/item/reagent_containers/cup/coffeepot(picked_turf)
	new /obj/item/storage/box/coffeepack(picked_turf)
