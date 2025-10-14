/datum/storyteller_goal/execute_event/market_crash
	id = "market_crash"
	name = "Execute Market Crash Event"
	desc = "Triggers the Market Crash event, causing a temporary increase in vending machine prices."
	children = list()
	category = STORY_GOAL_NEUTRAL
	event_path = null



/datum/storyteller_goal/execute_event/market_crash/complete(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points, station_value)
	var/datum/storyteller_mood/mood = storyteller.mood
	var/good_for_station = FALSE
	// More likely to happen in faster paced rounds
	if(mood.pace > 1.1)
		good_for_station = TRUE
	var/datum/round_event/market_crash/evt = new /datum/round_event/market_crash(TRUE, new /datum/round_event_control/storyteller_control)
	evt.__setup_for_storyteller(threat_points, good_for_station)


/datum/round_event/market_crash
	allow_random = FALSE
	var/good_for_station = FALSE
	var/target_inflation = 1

	COOLDOWN_DECLARE(inflation_uptick_cooldown)

/datum/round_event/market_crash/__setup_for_storyteller(threat_points, ...)
	. = ..()
	good_for_station = args[1]
	end_when = round((threat_points/10))

	if(good_for_station)
		target_inflation = 0.2
	else
		// More severe inflation increase if the event is bad for the station
		target_inflation = 10

/datum/round_event/market_crash/__storyteller_tick(seconds_per_tick)
	if(SSeconomy.inflation_value != target_inflation && COOLDOWN_FINISHED(src, inflation_uptick_cooldown))
		SSeconomy.inflation_value = lerp(SSeconomy.inflation_value, target_inflation, 0.1)
		COOLDOWN_START(src, inflation_uptick_cooldown, 1 MINUTES)
		SSeconomy.update_vending_prices()
