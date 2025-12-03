// Storyteller vault metrics for tracking station state
// Each metric represents a category of station conditions used by the storyteller to select goals and events

/*
	Health metrics
	These track the physical well-being of crew and antagonists, including health levels, wounds, and diseases.
*/

// Tracks the overall health status of antagonists to influence goal selection (e.g., antagonist support or crew advantage events).
#define STORY_VAULT_ANTAG_HEALTH "antag_health"
// Tracks the overall health status of the crew to influence goal selection.
#define STORY_VAULT_CREW_HEALTH "crew_health"
	// Many crew members are in critical condition, with very low health.
	#define STORY_VAULT_HEALTH_LOW 3
	// Many crew members are injured but not critical.
	#define STORY_VAULT_HEALTH_DAMAGED 2
	// Most crew members are in average health.
	#define STORY_VAULT_HEALTH_NORMAL 1
	// Most crew members are in excellent health.
	#define STORY_VAULT_HEALTH_HEALTHY 0

// Average wound count metrics (raw numeric values)
#define STORY_VAULT_AVG_CREW_WOUNDS "avg_crew_wounds"      // Average wounds per crew member
#define STORY_VAULT_AVG_ANTAG_WOUNDS "avg_atnag_wounds"    // Average wounds per antagonist

// Tracks the extent of physical wounds among antagonists.
#define STORY_VAULT_ANTAG_WOUNDING "antag_wounding"
// Tracks the extent of physical wounds among the crew.
#define STORY_VAULT_CREW_WOUNDING "crew_wounding"
	// Few to no crew members have significant wounds.
	#define STORY_VAULT_NO_WOUNDS 0
	// Some crew members have moderate wounds.
	#define STORY_VAULT_SOME_WOUNDED 1
	// Many crew members are heavily wounded.
	#define STORY_VAULT_MANY_WOUNDED 2
	// Many crew members have life-threatening wounds.
	#define STORY_VAULT_CRITICAL_WOUNDED 3

// Tracks the prevalence of diseases among the crew, influencing events like outbreaks or medical research.
#define STORY_VAULT_CREW_DISEASES "crew_diseases"
	// No significant diseases among the crew, allowing non-medical or routine events.
	#define STORY_VAULT_NO_DISEASES 0
	// Some crew members have minor diseases.
	#define STORY_VAULT_MINOR_DISEASES 1
	// Many crew members have serious diseases.
	#define STORY_VAULT_MAJOR_DISEASES 2
	// Widespread, critical disease outbreak.
	#define STORY_VAULT_OUTBREAK 3

/*
	Death and alive metrics
	These track counts and ratios of dead/alive crew and antagonists to gauge station mortality and survival rates.
*/

// Average health metrics (0-100, higher = healthier)
#define STORY_VAULT_AVG_CREW_HEALTH "avg_crew_health"   // Average health of crew (0-100)
#define STORY_VAULT_AVG_ANTAG_HEALTH "avg_atnag_health" // Average health of antagonists (0-100)


// Tracks the number of dead antagonists.
#define STORY_VAULT_ANTAG_DEAD_COUNT "antag_dead_count"

// Tracks the number of dead crew members.
#define STORY_VAULT_CREW_DEAD_COUNT "crew_dead_count"

// Tracks the number of alive antagonists.
#define STORY_VAULT_ANTAG_ALIVE_COUNT "antag_alive_count"

// Tracks the number of alive crew members.
#define STORY_VAULT_CREW_ALIVE_COUNT "crew_alive_count"

// Tracks the alive level for antagonists (based on dead counts).
#define STORY_VAULT_ANTAG_ALIVE_LEVEL "antag_alive_level"

// Tracks the alive level for crew (based on dead counts).
#define STORY_VAULT_CREW_ALIVE_LEVEL "crew_alive_level"
	// No dead crew members.
	#define STORY_VAULT_NO_DEAD 0
	// Few dead crew members (e.g., 1-5).
	#define STORY_VAULT_FEW_DEAD 1
	// Some dead crew members (e.g., 6-15).
	#define STORY_VAULT_SOME_DEAD 2
	// Many dead crew members (e.g., >15).
	#define STORY_VAULT_MANY_DEAD 3

// Tracks the ratio of dead to total antagonists.
#define STORY_VAULT_ANTAG_DEAD_RATIO "antag_dead_ratio"
// Tracks the ratio of dead to total crew.
#define STORY_VAULT_CREW_DEAD_RATIO "crew_dead_ratio"
	// Very low death ratio
	#define STORY_VAULT_LOW_DEAD_RATIO 0
	// Moderate death ratio
	#define STORY_VAULT_MODERATE_DEAD_RATIO 1
	// High death ratio
	#define STORY_VAULT_HIGH_DEAD_RATIO 2
	// Extreme death ratio
	#define STORY_VAULT_EXTREME_DEAD_RATIO 3

/*
	Resource metrics
	These track station resources, antagonist presence, and related factors affecting economic and operational stability.
*/

// Tracks the number of active antagonists on the station, influencing events like sabotage or crew conflict.
#define STORY_VAULT_ANTAGONIST_PRESENCE "antagonist_presence"
	// No active antagonists detected, favoring peaceful or routine station events.
	#define STORY_VAULT_NO_ANTAGONISTS 0
	// A small number of antagonists are active, prompting minor conflict or vigilance events.
	#define STORY_VAULT_FEW_ANTAGONISTS 1
	// A moderate number of antagonists are active, escalating to events requiring security response.
	#define STORY_VAULT_MODERATE_ANTAGONISTS 2
	// A large number of antagonists are active, triggering major conflict or crisis events.
	#define STORY_VAULT_MANY_ANTAGONISTS 3

// Tracks the inactivity ratio among alive antagonists (0..1).
#define STORY_VAULT_ANTAG_INACTIVE_RATIO "antag_inactive_ratio"

// Tracks the level of mineral resources on the station.
#define STORY_VAULT_RESOURCE_MINERALS "resource_minerals"

// Tracks the level of other (non-mineral) resources on the station.
#define STORY_VAULT_RESOURCE_OTHER "resource_other"

// Tracks overall low resource conditions on the station.
#define STORY_VAULT_LOW_RESOURCE "low_station_resources"

/*
	Security metrics
	These track security personnel, equipment, and alert levels to influence law enforcement and response events.
*/

// Number of active security personnel on station
#define STORY_VAULT_SECURITY_COUNT "security_count"

// Tracks security strength (number of active security officers, their gear, arrests made).
#define STORY_VAULT_SECURITY_STRENGTH "security_strength"
	#define STORY_VAULT_NO_SECURITY 0      // No active security
	#define STORY_VAULT_WEAK_SECURITY 1    // Few/low-geared officers
	#define STORY_VAULT_MODERATE_SECURITY 2 // Standard force
	#define STORY_VAULT_STRONG_SECURITY 3  // High numbers/well-equipped

// Tracks security alert level (green to delta).
#define STORY_VAULT_SECURITY_ALERT "security_alert"  // Already partially in code, expanded
	#define STORY_VAULT_GREEN_ALERT 0
	#define STORY_VAULT_BLUE_ALERT 1
	#define STORY_VAULT_RED_ALERT 2
	#define STORY_VAULT_DELTA_ALERT 3

/*
	Crew state metrics
	These track morale and readiness of the crew to handle crises or daily operations.
*/

// Total crew weight (sum of all crew member weights)
#define STORY_VAULT_CREW_WEIGHT "crew_weight"

// Tracks crew morale (happiness, stress from events/deaths).
#define STORY_VAULT_CREW_MORALE "crew_morale"
	#define STORY_VAULT_HIGH_MORALE 0     // Happy/productive
	#define STORY_VAULT_MODERATE_MORALE 1 // Neutral
	#define STORY_VAULT_LOW_MORALE 2      // Stressed
	#define STORY_VAULT_CRITICAL_MORALE 3 // Mutiny-level low

// Tracks crew readiness (access to weapons, meds, tools for crises).
#define STORY_VAULT_CREW_READINESS "crew_readiness"
	#define STORY_VAULT_UNPREPARED 0     // No gear/stockpiles
	#define STORY_VAULT_BASIC_READY 1    // Minimal supplies
	#define STORY_VAULT_PREPARED 2       // Good stockpiles
	#define STORY_VAULT_HIGHLY_READY 3   // Overprepared (armory full, etc.)

// Special state flags (boolean-like metrics)
#define STORY_VAULT_STATION_ALLIES "station_allies"    // Station has allied NPCs/ships
#define STORY_VAULT_NUKE_ACTIVATED "NUKE_INCOMING"    // Nuclear device activated
#define STORY_VAULT_DEATHSQUAD "doomguys_here"        // Deathsquad on station

#define STORY_VAULT_STATION_COMMAND "station_command"
	#define STORY_VAULT_NO_HEADS 0
	#define STORY_VAULT_ONLY_HEAD 1 	 // One head on the station
	#define STORY_VAULT_FEW_HEADS 2 	 // Two-four heads on the station
	#define STORY_VAULT_FULL_COMMAND 3 	 // Full of almost full command

// Current integrity of station SM
#define STORY_VAULT_ENGINE_INTEGRITY "ingine_integrity"
// Current integiry of station ATMOS rooms
#define STORY_VAULT_ATMOS_INTEGRITY "atmos_integrity"

/*
	Antagonist metrics
	These track antagonist behavior, progress, and impact to escalate or mitigate threats.
*/

// Total antagonist weight (sum of all antag weights)
#define STORY_VAULT_ANTAG_WEIGHT "antag_weight"

// Tracks the level of antagonist-driven disruption, influencing escalation or mitigation events.
#define STORY_VAULT_ANTAGONIST_ACTIVITY "antagonist_activity"
	// No significant antagonist activity, allowing calm or routine station operations.
	#define STORY_VAULT_NO_ACTIVITY 0
	// Minor antagonist actions (e.g., theft, minor sabotage), prompting low-level response events.
	#define STORY_VAULT_LOW_ACTIVITY 1
	// Noticeable antagonist actions (e.g., fights, system damage), requiring active security or repair events.
	#define STORY_VAULT_MODERATE_ACTIVITY 2
	// Major antagonist actions (e.g., bombings, mass chaos), escalating to critical station-wide events.
	#define STORY_VAULT_HIGH_ACTIVITY 3

// Tracks the number of crew killed by antagonists, influencing threat escalation.
#define STORY_VAULT_ANTAG_KILLS "antag_kills"
	// No kills by antagonists.
	#define STORY_VAULT_NO_KILLS 0
	// Few kills (e.g., 1-3).
	#define STORY_VAULT_FEW_KILLS 1
	// Moderate kills (e.g., 4-8).
	#define STORY_VAULT_MODERATE_KILLS 2
	// Many kills (e.g., >8).
	#define STORY_VAULT_MANY_KILLS 3

// Tracks completed objectives by antagonists (e.g., assassinations, thefts).
#define STORY_VAULT_ANTAG_OBJECTIVES_COMPLETED "antag_objectives_completed"
	// No objectives completed.
	#define STORY_VAULT_NO_OBJECTIVES 0
	// Few objectives done (e.g., 1-2 per antag).
	#define STORY_VAULT_FEW_OBJECTIVES 1
	// Moderate progress (e.g., half done).
	#define STORY_VAULT_MODERATE_OBJECTIVES 2
	// Most objectives completed.
	#define STORY_VAULT_MANY_OBJECTIVES 3

// Tracks antagonist influence (e.g., hacked systems, stolen resources, converted allies).
#define STORY_VAULT_ANTAG_INFLUENCE "antag_influence"
	// Minimal influence (no hacks/conversions).
	#define STORY_VAULT_LOW_INFLUENCE 0
	// Some influence (e.g., minor hacks).
	#define STORY_VAULT_MODERATE_INFLUENCE 1
	// Significant control (e.g., department hacked).
	#define STORY_VAULT_HIGH_INFLUENCE 2
	// Dominant influence (e.g., cult majority).
	#define STORY_VAULT_EXTREME_INFLUENCE 3

// Tracks disruption caused (e.g., power failures, fires from sabotage).
#define STORY_VAULT_ANTAG_DISRUPTION "antag_disruption"
	// No disruption.
	#define STORY_VAULT_NO_DISRUPTION 0
	// Minor issues (e.g., single room sabotage).
	#define STORY_VAULT_MINOR_DISRUPTION 1
	// Moderate chaos (e.g., area-wide blackout).
	#define STORY_VAULT_MAJOR_DISRUPTION 2
	// Station-wide crisis.
	#define STORY_VAULT_CRITICAL_DISRUPTION 3

// Tracks intensity of antag actions (low: sporadic; high: constant pressure).
#define STORY_VAULT_ANTAG_INTENSITY "antag_intensity"
	#define STORY_VAULT_LOW_INTENSITY 0
	#define STORY_VAULT_MODERATE_INTENSITY 1
	#define STORY_VAULT_HIGH_INTENSITY 2
	#define STORY_VAULT_EXTREME_INTENSITY 3

// Tracks teamwork among antags (low: solo; high: coordinated teams).
#define STORY_VAULT_ANTAG_TEAMWORK "antag_teamwork"
	#define STORY_VAULT_NO_TEAMWORK 0
	#define STORY_VAULT_LOW_TEAMWORK 1
	#define STORY_VAULT_MODERATE_TEAMWORK 2
	#define STORY_VAULT_HIGH_TEAMWORK 3

// Tracks stealth level (high: undetected progress; low: obvious chaos).
#define STORY_VAULT_ANTAG_STEALTH "antag_stealth"
	#define STORY_VAULT_NO_STEALTH 0
	#define STORY_VAULT_LOW_STEALTH 1
	#define STORY_VAULT_MODERATE_STEALTH 2
	#define STORY_VAULT_HIGH_STEALTH 3

// Tracks the major current threat/crisis type (e.g., "cult", "blob").
#define STORY_VAULT_MAJOR_THREAT "major_threat"

// Tracks threat escalation rate (slow: buildup; fast: sudden spikes).
#define STORY_VAULT_THREAT_ESCALATION "threat_escalation"
	#define STORY_VAULT_SLOW_ESCALATION 0
	#define STORY_VAULT_MODERATE_ESCALATION 1
	#define STORY_VAULT_FAST_ESCALATION 2
	#define STORY_VAULT_EXPLOSIVE_ESCALATION 3

/*
	Station crises metrics
	These track infrastructure, power, hazards, and research to influence emergency and recovery events.
*/

// Overall station structural integrity (0-100, higher = better)
#define STORY_VAULT_STATION_INTEGRITY "station_integrity"
// Tracks infrastructure damage (power, hull breaches, etc.).
#define STORY_VAULT_INFRA_DAMAGE "infra_damage"
	#define STORY_VAULT_NO_DAMAGE 0
	#define STORY_VAULT_MINOR_DAMAGE 1
	#define STORY_VAULT_MAJOR_DAMAGE 2
	#define STORY_VAULT_CRITICAL_DAMAGE 3

// Tracks station power availability, influencing events like blackouts or engineering repairs.
#define STORY_VAULT_POWER_STATUS "power_status"
	#define STORY_VAULT_FULL_POWER 0
	#define STORY_VAULT_LOW_POWER 1
	#define STORY_VAULT_BLACKOUT 2
	#define STORY_VAULT_CRITICAL_POWER_FAILURE 3


// Power grid metrics
#define STORY_POWER_SMES_DISCHARGE_DIVISOR "power_grid_smes"  // SMES discharge divisor for damage calculation
#define STORY_VAULT_POWER_GRID_STRENGTH "power_grid_strength" // Overall power grid strength (0-100)
#define STORY_VAULT_POWER_GRID_DAMAGE "power_grid_damage"     // Power grid damage level (0-3)
	#define STORY_VAULT_POWER_GRID_NOMINAL 0
	#define STORY_VAULT_POWER_GRID_FAILURES 1
	#define STORY_VAULT_POWER_GRID_DAMAGED 2
	#define STORY_VAULT_POWER_GRID_CRITICAL 3

// Tracks overall research progress, influencing science-related goals.
#define STORY_VAULT_RESEARCH_PROGRESS "research_progress"
	#define STORY_VAULT_LOW_RESEARCH 0
	#define STORY_VAULT_MODERATE_RESEARCH 1
	#define STORY_VAULT_HIGH_RESEARCH 2
	#define STORY_VAULT_ADVANCED_RESEARCH 3
