/datum/job/wire_priest
	title = ROLE_WIRE_PRIEST

/datum/antagonist/wire_priest
	name = "\improper Wire Priest"
	antagpanel_category = ANTAG_GROUP_HORRORS
	pref_flag = ROLE_WIRE_PRIEST

	show_in_antagpanel = TRUE
	antagpanel_category = "Wire Priest"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	ui_name = "AntagInfoWirePriest"
	suicide_cry = "FOR THE FLESHMIND!!"

/datum/antagonist/wire_priest/on_gain()
	. = ..()
	owner.current.AddComponent(/datum/component/human_corruption)

/datum/antagonist/wire_priest/get_preview_icon()
	var/icon/icon = icon('modular_zubbers/icons/fleshmind/fleshmind_machines.dmi', "core")
	icon.Scale(ANTAGONIST_PREVIEW_ICON_SIZE, ANTAGONIST_PREVIEW_ICON_SIZE)
	return icon

// DYNAMIC (If we ever use it)
/datum/dynamic_ruleset/midround/from_ghosts/wire_priest
	name = "Wire Priest"
	config_tag = "Wire Priest"
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

/datum/round_event/ghost_role/wire_priest
	minimum_required = 30
	fakeable = FALSE
	role_name = "Wire Priest"
