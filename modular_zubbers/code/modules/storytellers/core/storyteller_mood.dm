// Mood profile for storytellers to influence decisions and pacing

/datum/storyteller_mood
	var/name = "Neutral"
	var/desc = ""
	/// 0.0 - 2.0; higher means more aggressive challenges
	var/aggression = 1.0
	/// 0.1 - 3.0; higher means events/goals happen more frequently
	var/pace = 1.0
	/// 0.0 - 2.0; higher means more variability/chaos in choices
	var/volatility = 1.0

/datum/storyteller_mood/proc/get_event_frequency_multiplier()
	return clamp(pace, 0.1, 3.0)

/datum/storyteller_mood/proc/get_threat_multiplier()
	return clamp(aggression, 0.0, 2.0)

/datum/storyteller_mood/proc/get_variance_multiplier()
	return clamp(volatility, 0.0, 2.0)

/datum/storyteller_mood/proc/get_value_multiplier()
	return 1


/datum/storyteller_mood/slow_builder
	name = "Slow Builder"
	aggression = 0.7
	pace = 0.6
	volatility = 0.8

/datum/storyteller_mood/spicy
	name = "Spicy"
	aggression = 1.4
	pace = 1.3
	volatility = 1.2

// Additional mood profiles adapted to RimWorld-inspired styles
/datum/storyteller_mood/cassandra_classic
	name = "Cassandra Classic"
	desc = "Escalating challenges with cycles of tension and relief, inspired by RimWorld's classic storyteller."
	aggression = 1.2
	pace = 1.0
	volatility = 0.9

/datum/storyteller_mood/phoebe_chillax
	name = "Phoebe Chillax"
	desc = "Relaxed pace with longer breaks between events, allowing recovery, like RimWorld's chill storyteller."
	aggression = 0.8
	pace = 0.5
	volatility = 0.7

/datum/storyteller_mood/randy_random
	name = "Randy Random"
	desc = "Highly unpredictable with random bursts of events, mimicking RimWorld's chaotic storyteller."
	aggression = 1.5
	pace = 1.2
	volatility = 1.8


/// Chill mood: Serene, introspective pacing with low aggression and minimal volatility.
/// Ideal for Mia'Chill — fosters roleplay immersion, slow sub-goal branches via extended grace, low threat for peaceful analysis.
/datum/storyteller_mood/chill
	name = "Chill"
	pace = 1.5  // Slower events for quiet wonders
	aggression = 0.6  // Gentle threats, yielding to cosmic peace
	volatility = 0.4  // Minimal swings, steady hush

/// Classic mood: Steady escalation with balanced aggression and low volatility.
/// For Cas'Classic — inevitable doom symphonies, consistent sub-goal buildup, medium tension for survival arcs.
/datum/storyteller_mood/classic
	name = "Classic"
	pace = 1.0  // Standard pacing for chronicled falls
	aggression = 1.2  // Heightened unrest whispers
	volatility = 0.6  // Controlled variance for symphonic progression

/// Gambit mood: Capricious, high volatility with neutral pace/aggression.
/// Randall's Gambit — dice rolls of fate, erratic chain flips (bureaucracy to apocalypse), high variance for whim-based vetting.
/datum/storyteller_mood/gambit
	name = "Gambit"
	pace = 1.1  // Slight edge for unpredictability
	aggression = 1.0  // Neutral, flips on whim
	volatility = 1.8  // High swings for fortune's folly


/// Catastrophe mood: Hyper-aggressive, low volatility for relentless pressure.
/// Nick Catastrophe — twin tempests of ruin, rapid escalation, minimal recovery in adaptation for doubled havoc.
/datum/storyteller_mood/catastrophe
	name = "Catastrophe"
	pace = 0.7  // Fast barrages, scant respite
	aggression = 1.8  // Crushing doomsayer fury
	volatility = 0.3  // Steady storm, no mercy variance


/// Challenge mood: Balanced hybrid with rising aggression and moderate volatility.
/// Mia & Nic'Challenge — serenity to fury pact, teetering balance, progressive tension for beautiful trials.
/datum/storyteller_mood/challenge
	name = "Challenge"
	pace = 1.2  // Starts tranquil, ramps to trials
	aggression = 1.3  // Blends lulls into escalating edge
	volatility = 1.2  // Moderate swings for paradoxical pact
