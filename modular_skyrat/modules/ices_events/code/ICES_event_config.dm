#define VERY_HIGH_EVENT_FREQ 64
#define HIGH_EVENT_FREQ 32
#define MED_EVENT_FREQ 16
#define LOW_EVENT_FREQ 8
#define VERY_LOW_EVENT_FREQ 4
#define MIN_EVENT_FREQ 2

/**
 * ICES - Intensity Credit Events System
 *
 * This file is used to denote weight and frequency
 * for events to be spawned by the system.
 */

/**
 * Event subsystem
 *
 * Overriden min and max start times
 * to accomodate for much longer rounds
 */
/datum/controller/subsystem/events
	/// Rate at which we add intensity credits
	var/intensity_credit_rate = 27000
	/// Last world time we added an intensity credit
	var/intensity_credit_last_time = 8400
	/// Current active ICES multiplier
	var/active_intensity_multiplier = EVENT_MIDPOP_TIMER_MULTIPLIER
	/// LOWPOP player threshold
	var/intensity_low_players = EVENT_LOWPOP_THRESHOLD
	/// LOWPOP multiplier (lower = more events)
	var/intensity_low_multiplier = EVENT_LOWPOP_TIMER_MULTIPLIER
	/// MIDPOP player threshold
	var/intensity_mid_players = EVENT_MIDPOP_THRESHOLD
	/// MIDPOP multiplier (lower = more events)
	var/intensity_mid_multiplier = EVENT_MIDPOP_TIMER_MULTIPLIER
	/// HIGHPOP player threshold
	var/intensity_high_players = EVENT_HIGHPOP_THRESHOLD
	/// HIGHPOP multiplier (lower = more events)
	var/intensity_high_multiplier = EVENT_HIGHPOP_TIMER_MULTIPLIER

/datum/controller/subsystem/events/Initialize()
	. = ..()
	frequency_lower = CONFIG_GET(number/event_frequency_lower)
	frequency_upper = CONFIG_GET(number/event_frequency_upper)
	intensity_credit_rate = CONFIG_GET(number/intensity_credit_rate)

#undef VERY_HIGH_EVENT_FREQ
#undef HIGH_EVENT_FREQ
#undef MED_EVENT_FREQ
#undef LOW_EVENT_FREQ
#undef VERY_LOW_EVENT_FREQ
#undef MIN_EVENT_FREQ
