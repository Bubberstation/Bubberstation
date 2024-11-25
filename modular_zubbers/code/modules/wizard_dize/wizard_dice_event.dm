/// Immovable rod random event.
/// The rod will spawn at some location outside the station, and travel in a straight line to the opposite side of the station
/datum/round_event_control/wizard_dice
	name = "Wizard Dice"
	typepath = /datum/round_event/wizard_dice
	category = EVENT_CATEGORY_INVASION
	description = "A magical d20 is teleported to station. If someone lands on 20, they become a wizard. If they roll a 1, they die."

	min_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS
	max_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS

	min_players = 30
	max_occurrences = 1
	weight = 10
	earliest_start = 60 MINUTES

	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL,TAG_COMBAT)	

/datum/round_event/wizard_dice
	announce_when = 5

/datum/round_event/wizard_dice/announce(fake)
	if(prob(80)) //Announcement Optimization
		priority_announce("A magical twenty-sided artifact was detected in the area. Please refrain from interacting with anything that cannot be explained by science.", "Magusologist Expert Warning")

/datum/round_event/wizard_dice/start()

	var/turf/desired_turf = get_safe_random_station_turf()
	if(!desired_turf)
		return

	var/obj/item/dice/d20/teleporting_die_of_fate/created_dice = new(desired_turf)
	announce_to_ghosts(created_dice) //Me on my way to respawn and instantly rush at the spawned dice that has a 5% chance to actually give me wizard.
