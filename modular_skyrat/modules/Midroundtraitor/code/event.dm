/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator
	name = "Syndicate Boarder"
	config_tag = "Midround Lone Infiltrator"
	preview_antag_datum = /datum/antagonist/traitor/lone_infiltrator
	midround_type = LIGHT_MIDROUND
	pref_flag = ROLE_LONE_INFILTRATOR
	blacklisted_roles = list(
		JOB_CYBORG,
		JOB_AI,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_CAPTAIN,
		JOB_CORRECTIONS_OFFICER,
		JOB_NT_REP,
		JOB_BLUESHIELD,
		JOB_ORDERLY,
		JOB_BOUNCER,
		JOB_CUSTOMS_AGENT,
		JOB_ENGINEERING_GUARD,
		JOB_SCIENCE_GUARD,
	)
	min_antag_cap = 1
	weight = 4 //Slightly less common than normal midround traitors.
	min_pop = 10

/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator/create_execute_args()
	return list(gather_spawns())

/// Create list of valid spawnpoints
/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator/proc/gather_spawns()
	var/list/spawns = list()
	for(var/obj/effect/landmark/carpspawn/carp in GLOB.landmarks_list)
		spawns += carp.loc
	return spawns

/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator/assign_role(datum/mind/candidate, list/valid_spawns)
	candidate.add_antag_datum(/datum/antagonist/traitor/lone_infiltrator)
	candidate.current.forceMove(pick(valid_spawns))

//OUTFIT//
/datum/outfit/syndicateinfiltrator
	name = "Syndicate Operative - Infiltrator"

	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves =  /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/syndicate/alt
	id = /obj/item/card/id/advanced/chameleon
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/mod/control/pre_equipped/nuclear/chameleon
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	internals_slot = ITEM_SLOT_RPOCKET
	belt = /obj/item/storage/belt/military
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/tank/jetpack/oxygen/harness=1,\
		/obj/item/gun/ballistic/automatic/pistol=1,\
		/obj/item/knife/combat/survival=1,\
		/obj/item/implanter/explosive=1)

	id_trim = /datum/id_trim/chameleon/operative

/datum/outfit/syndicateinfiltrator/post_equip(mob/living/carbon/human/H)
	H.faction |= ROLE_SYNDICATE
	H.update_icons()
