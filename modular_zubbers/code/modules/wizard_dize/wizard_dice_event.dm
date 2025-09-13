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
	announce_chance = 100
	//the "when" stuff is measured in 2 second ticks, not deciseconds.
	announce_when = 30 //1 minute
	end_when = 300 //10 minutes
	var/obj/item/dice/d20/teleporting_die_of_fate/created_dice
	var/did_announce = FALSE

/datum/round_event/wizard_dice/setup()
	//Create the dice and add the signal.
	created_dice = new(get_safe_lucky_player_turf())
	RegisterSignal(created_dice, COMSIG_QDELETING, PROC_REF(on_dice_destroy))

/datum/round_event/wizard_dice/start()
	//Announce the event.
	announce_to_ghosts()

/datum/round_event/wizard_dice/announce(fake)
	priority_announce("A magical twenty-sided artifact was detected in the area. Please refrain from interacting with anything that cannot be explained by science.", "Magusologist Expert Warning")
	did_announce = TRUE

/datum/round_event/wizard_dice/kill()
	UnregisterSignal(created_dice, COMSIG_QDELETING) //Remove this signal first.
	. = ..()
	//Garbage day!
	if(created_dice && !QDELETED(created_dice))
		qdel(created_dice)
	created_dice = null

/datum/round_event/wizard_dice/proc/on_dice_destroy()
	processing = FALSE //Stop processing the event.
	kill() //Kill the event.
