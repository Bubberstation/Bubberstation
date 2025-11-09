/datum/round_event_control/market_crash
	id = "market_crash"
	story_category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_AFFECTS_ECONOMY | STORY_TAG_AFFECTS_POLITICS
	typepath = /datum/round_event/market_crash

	story_weight = STORY_GOAL_BASE_WEIGHT * 1.2

/datum/round_event_control/market_crash/pre_storyteller_run(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	. = ..()
	var/good_for_station = FALSE
	// More likely to happen in faster paced rounds
	if(storyteller.mood.pace > 1.1)
		good_for_station = TRUE
	additional_arguments = good_for_station

/datum/round_event/market_crash
	STORYTELLER_EVENT

	allow_random = FALSE
	var/good_for_station = FALSE
	var/target_inflation = 1

	COOLDOWN_DECLARE(inflation_uptick_cooldown)

/datum/round_event/market_crash/__setup_for_storyteller(threat_points, ...)
	. = ..()
	good_for_station = get_additional_arguments()
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
