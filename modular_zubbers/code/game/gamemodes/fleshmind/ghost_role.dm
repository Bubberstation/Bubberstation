/datum/job/wire_priest
	title = ROLE_WIRE_PRIEST

/datum/antagonist/wire_priest
	name = "\improper Wire Priest"
	antagpanel_category = ANTAG_GROUP_CREW
	pref_flag = ROLE_WIRE_PRIEST

	show_in_antagpanel = TRUE
	antagpanel_category = "Wire Priest"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	ui_name = "AntagInfoWirePriest"
	suicide_cry = "FOR THE FLESHMIND!!"
	var/datum/outfit/outfit = /datum/outfit/wire_priest

/datum/antagonist/wire_priest/on_gain()
	. = ..()
	owner.current.AddComponent(/datum/component/human_corruption)
	equip_wire_priest()

/datum/antagonist/wire_priest/get_preview_icon()
	var/icon/icon = icon('modular_zubbers/icons/fleshmind/fleshmind_machines.dmi', "core")
	icon.Scale(ANTAGONIST_PREVIEW_ICON_SIZE, ANTAGONIST_PREVIEW_ICON_SIZE)
	return icon

// DYNAMIC (If we ever use it)
/datum/dynamic_ruleset/midround/from_ghosts/wire_priest
	name = "Wire Priest"
	config_tag = "wire_priest"
	preview_antag_datum = /datum/antagonist/wire_priest

	midround_type = LIGHT_MIDROUND
	pref_flag = ROLE_WIRE_PRIEST
	ruleset_flags = RULESET_INVADER

	weight = 0 // We don't want it to spawn naturally, it gets handled by our own code.
	min_pop = 35

// STORYTELLERS
/datum/round_event_control/wire_priest
	name = "Spawn Wire Priest"
	typepath = /datum/round_event/ghost_role/wire_priest
	max_occurrences = 0
	weight = 0
	earliest_start = 30 MINUTES
	min_players = 35
	category = EVENT_CATEGORY_INVASION
	description = "A Wire Priest that works to spread the wireweed currently invading the station."
	tags = list(TAG_COMBAT, TAG_OUTSIDER_ANTAG)
	track = EVENT_TRACK_GHOSTSET

/datum/round_event/ghost_role/wire_priest/spawn_role()
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(check_jobban = ROLE_WIRE_PRIEST, role = ROLE_WIRE_PRIEST, role_name_text = role_name, amount_to_pick = 1)
	if(isnull(chosen_one))
		return NOT_ENOUGH_PLAYERS
	var/datum/mind/player_mind = new /datum/mind(chosen_one.key)
	player_mind.active = TRUE

	var/spawn_location
	var/obj/structure/fleshmind/structure/core/core = locate(/obj/structure/fleshmind/structure/core) in world
	if(core)
		spawn_location = core.loc
	if(isnull(spawn_location))
		return MAP_ERROR

	var/mob/living/carbon/human/priest = new(spawn_location)
	priest.randomize_human_appearance(~RANDOMIZE_SPECIES)
	priest.dna.update_dna_identity()
	var/datum/mind/Mind = new /datum/mind(chosen_one.key)
	Mind.set_assigned_role(SSjob.get_job_type(/datum/job/wire_priest))
	Mind.active = TRUE
	Mind.transfer_to(priest)

	if(!priest.client?.prefs.read_preference(/datum/preference/toggle/nuke_ops_species))
		var/species_type = priest.client.prefs.read_preference(/datum/preference/choiced/species)
		priest.set_species(species_type) //Apply the preferred species to our freshly-made body.

	player_mind.set_assigned_role(SSjob.get_job_type(/datum/job/wire_priest))
	player_mind.add_antag_datum(/datum/antagonist/wire_priest)

	message_admins("[ADMIN_LOOKUPFLW(priest)] has been made into a Wire Priest by an event.")
	priest.log_message("was spawned as a Wire Priest by an event.", LOG_GAME)
	spawned_mobs += priest
	return SUCCESSFUL_SPAWN

/datum/round_event/ghost_role/wire_priest
	minimum_required = 1
	fakeable = FALSE
	role_name = "Wire Priest"

/datum/antagonist/wire_priest/proc/equip_wire_priest()
	var/mob/living/carbon/human/priest = owner.current
	if(!istype(priest))
		return

	priest.dna.species.give_important_for_life(priest)
	priest.equipOutfit(outfit)

// OUTFIT
/datum/outfit/wire_priest
	name = "Wire Priest"

	uniform = /obj/item/clothing/under/rank/rnd/roboticist
	belt = /obj/item/storage/belt/utility/full
	suit = /obj/item/clothing/suit/hooded/techpriest
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/knife/combat/survival
