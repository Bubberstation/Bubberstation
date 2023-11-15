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

/**
 * Abductors
 */
/datum/round_event_control/abductor
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ
	intensity_restriction = TRUE

/**
 * Anomalies
 */
/datum/round_event_control/anomaly/anomaly_bioscrambler
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_bluespace
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_dimensional
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_ectoplasm
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_flux
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

// We have other intensities
/datum/round_event_control/anomaly/anomaly_grav
	max_occurrences = 0

/datum/round_event_control/anomaly/anomaly_grav/high
	max_occurrences = 1
	min_players = 45
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_hallucination
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_pyro
	max_occurrences = 1
	min_players = 45
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_vortex
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Aurora Caelus
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/aurora_caelus
	max_occurrences = 3
	weight = MED_EVENT_FREQ

/**
 * Blob
 *
 * Disabled: Controlled by Dynamic
 */
/datum/round_event_control/blob
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ
	intensity_restriction = TRUE

/**
 * Brain Trauma
 *
 * Disabled: Interrupting scenes and preventing roleplay by interaction with medba
 */
/datum/round_event_control/brain_trauma
	max_occurrences = 0

/**
 * Brand Intelligence
 */
/datum/round_event_control/brand_intelligence
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Bureaucratic Error
 *
 * Disabled: Too intrusive and should be staff-onl
 */
/datum/round_event_control/bureaucratic_error
	max_occurrences = 0

/**
 * Camera Failure
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/camera_failure
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Carp Migration
 */
/datum/round_event_control/carp_migration
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Cortical Borers
 */
/datum/round_event_control/cortical_borer
	max_occurrences = 0
	weight = VERY_LOW_EVENT_FREQ

/**
 * Changeling
 *
 * Disabled: Controlled by Dynamic
 */
/datum/round_event_control/changeling
	max_occurrences = 1
	intensity_restriction = TRUE

/**
 * CME (Coronal Mass Ejection)
 *
 * Combined weight: 30
 */
/datum/round_event_control/cme/minimal
	max_occurrences = 1
	min_players = 30
	weight = MED_EVENT_FREQ

/datum/round_event_control/cme/moderate
	max_occurrences = 1
	min_players = 30
	weight = LOW_EVENT_FREQ
	intensity_restriction = TRUE

/datum/round_event_control/cme/extreme
	max_occurrences = 1
	min_players = 45
	weight = MIN_EVENT_FREQ
	earliest_start = 105 MINUTES
	intensity_restriction = TRUE

/datum/round_event_control/cme/unknown
	max_occurrences = 1
	min_players = 40
	weight = VERY_EVENT_FREQ
	intensity_restriction = TRUE

/**
 * Medical
 *
 * Combined weight: 40
 */
/datum/round_event_control/disease_outbreak
	max_occurrences = 0
	min_players = 45
	weight = VERY_LOW_EVENT_FREQ
	intensity_restriction = TRUE

/datum/round_event_control/disease_outbreak/advanced
	max_occurrences = 2
	min_players = 45
	weight = HIGH_EVENT_FREQ
	intensity_restriction = TRUE

/datum/round_event_control/fake_virus
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/heart_attack
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/sentient_disease
	max_occurrences = 0
	intensity_restriction = TRUE

/**
 * Electricity Events
 *
 * Combined weight: 32
 */
/datum/round_event_control/electrical_storm
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/datum/round_event_control/grid_check
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * False Alarm
 */
/datum/round_event_control/falsealarm
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Fugitives
 */
/datum/round_event_control/fugitives
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Ion Storm
 */
/datum/round_event_control/ion_storm
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Immovable Rod
 */
/datum/round_event_control/immovable_rod
	max_occurrences = 2
	weight = MED_EVENT_FREQ
	intensity_restriction = TRUE

/**
 * Meteors / Space Dust
 *
 * Combined weight: 36
 */
/datum/round_event_control/meteor_wave
	max_occurrences = 0
	weight = MIN_EVENT_FREQ

/datum/round_event_control/meteor_wave/ices
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ
	min_players = 30
	intensity_restriction = TRUE

// No preset ones, we have our own custom preset above
/datum/round_event_control/meteor_wave/threatening
	max_occurrences = 0
	weight = MIN_EVENT_FREQ

/datum/round_event_control/meteor_wave/catastrophic
	max_occurrences = 0
	weight = MIN_EVENT_FREQ

/datum/round_event_control/meteor_wave/meaty
	max_occurrences = 0
	weight = MIN_EVENT_FREQ

/datum/round_event_control/stray_meteor
	max_occurrences = 2
	weight = LOW_EVENT_FREQ
	intensity_restriction = FALSE

/datum/round_event_control/space_dust
	max_occurrences = 0
	weight = MIN_EVENT_FREQ

/datum/round_event_control/space_dust/major_dust
	max_occurrences = 1
	weight = LOW_EVENT_FREQ
	intensity_restriction = TRUE

/datum/round_event_control/sandstorm
	max_occurrences = 2
	min_players = 30
	weight = MED_EVENT_FREQ
	intensity_restriction = TRUE

/**
 * Mice Migration
 */
/datum/round_event_control/mice_migration
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Moldies
 */
/datum/round_event_control/mold
	max_occurrences = 1
	weight = LOW_EVENT_FREQ
	intensity_restriction = TRUE

/**
 * Lone op
 *
 * Disabled: Does not have policy. Will re-add if/when policy is added
 */
/datum/round_event_control/operative
	max_occurrences = 1

/**
 * Syndicate Portal Storm
 */
/datum/round_event_control/portal_storm_syndicate
	max_occurrences = 2
	weight = LOW_EVENT_FREQ

/**
 * Radiation
 *
 * Disabled: Unintutivie design and incompatibility with this server
 */
/datum/round_event_control/radiation_leak
	max_occurrences = 3
	weight = MED_EVENT_FREQ

/datum/round_event_control/radiation_storm
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ
	intensity_restriction = TRUE

/**
 * Scrubber Clogs
 *
 * Combined weight: 32
 */
/datum/round_event_control/scrubber_clog
	max_occurrences = 0

/datum/round_event_control/scrubber_clog/major
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/scrubber_clog/critical
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/scrubber_clog/strange
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Human-level Intelligence
 */
/datum/round_event_control/sentience
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Shuttle Events
 *
 * Combined weight: 24
 */
/datum/round_event_control/shuttle_catastrophe
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/shuttle_insurance
	max_occurrences = 0

/datum/round_event_control/shuttle_loan
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Spess Dragon
 *
 * Disabled: Controlled by Dynamic
 */
/datum/round_event_control/space_dragon
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ
	intensity_restriction = TRUE

/**
 * Spess Vines
 *
 *
 */
/datum/round_event_control/spacevine
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Stray Cargo Pods
 *
 * Combined weight: 24
 */
/datum/round_event_control/stray_cargo
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/datum/round_event_control/stray_cargo/syndicate
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Supermatter Surge
 */
/datum/round_event_control/supermatter_surge
	max_occurrences = 3
	weight = MED_EVENT_FREQ

/**
 * Wormholes
 */
/datum/round_event_control/wormholes
	max_occurrences = 1
	weight = LOW_EVENT_FREQ



#undef VERY_HIGH_EVENT_FREQ
#undef HIGH_EVENT_FREQ
#undef MED_EVENT_FREQ
#undef LOW_EVENT_FREQ
#undef VERY_LOW_EVENT_FREQ
#undef MIN_EVENT_FREQ
