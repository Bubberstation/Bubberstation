//Could be bitflags, but that would require a good amount of translations, which eh, either way works for me
/// When the event is combat oriented (spawning monsters, inherently hostile antags)
#define TAG_COMBAT "combat"
/// When the event is spooky (broken lights, some antags)
#define TAG_SPOOKY "spooky"
/// When the event is destructive in a decent capacity (meteors, blob)
#define TAG_DESTRUCTIVE "destructive"
/// When the event impacts most of the crewmembers in some capacity (comms blackout)
#define TAG_COMMUNAL "communal"
/// When the event targets a person for something (appendix, heart attack)
#define TAG_TARGETED "targeted"
/// When the event is positive and helps the crew, in some capacity (Shuttle Loan, Supply Pod)
#define TAG_POSITIVE "positive"
/// When one of the crewmembers becomes an antagonist
#define TAG_CREW_ANTAG "crew_antag"
/// When the antagonist event is focused around team cooperation.
#define TAG_TEAM_ANTAG "team_antag"
/// When one of the non-crewmember players becomes an antagonist
#define TAG_OUTSIDER_ANTAG "away_antag"
/// When the event is considered chaotic by a completely non-biased coder.
#define TAG_CHAOTIC "chaotic"
/// When the event impacts the overmap
#define TAG_OVERMAP "overmap"
/// When the event requires the station to be in space (meteors, carp)
#define TAG_SPACE "space"
/// When the event requires the station to be on planetary.
#define TAG_PLANETARY "planetary"


#define EVENT_TRACK_MUNDANE "Mundane"
#define EVENT_TRACK_MODERATE "Moderate"
#define EVENT_TRACK_MAJOR "Major"
#define EVENT_TRACK_CREWSET "Crewset"
#define EVENT_TRACK_GHOSTSET "Ghostset"

#define ALL_EVENTS "All"
#define UNCATEGORIZED_EVENTS "Uncategorized"

#define STORYTELLER_WAIT_TIME 20 SECONDS

#define EVENT_POINT_GAINED_PER_SECOND 0.05

#define TRACK_FAIL_POINT_PENALTY_MULTIPLIER 0.5

#define GAMEMODE_PANEL_MAIN "Main"
#define GAMEMODE_PANEL_VARIABLES "Variables"

/// Reused for multipliers of the thresholds
#define MUNDANE_POINT_THRESHOLD 1
#define MODERATE_POINT_THRESHOLD 1
#define MAJOR_POINT_THRESHOLD 1
#define CREWSET_POINT_THRESHOLD 1
#define GHOSTSET_POINT_THRESHOLD 1

#define MUNDANE_MIN_POP 0
#define MODERATE_MIN_POP 0
#define MAJOR_MIN_POP 20
#define CREWSET_MIN_POP 0
#define GHOSTSET_MIN_POP 0

/// Defines for how much pop do we need to stop applying a pop scalling penalty to event frequency.
#define MUNDANE_POP_SCALE_THRESHOLD 25
#define MODERATE_POP_SCALE_THRESHOLD 32
#define MAJOR_POP_SCALE_THRESHOLD 45
#define CREWSET_POP_SCALE_THRESHOLD 45
#define GHOSTSET_POP_SCALE_THRESHOLD 45

/// The maximum penalty coming from pop scalling, when we're at the most minimum point, easing into 0 as we reach the SCALE_THRESHOLD. This is treated as a percentage.
#define MUNDANE_POP_SCALE_PENALTY 35
#define MODERATE_POP_SCALE_PENALTY 35
#define MAJOR_POP_SCALE_PENALTY 35
#define CREWSET_POP_SCALE_PENALTY 35
#define GHOSTSET_POP_SCALE_PENALTY 35

#define STORYTELLER_VOTE "storyteller"

#define EVENT_TRACKS list(EVENT_TRACK_MUNDANE, EVENT_TRACK_MODERATE, EVENT_TRACK_MAJOR, EVENT_TRACK_CREWSET, EVENT_TRACK_GHOSTSET)
#define EVENT_PANEL_TRACKS list(EVENT_TRACK_MUNDANE, EVENT_TRACK_MODERATE, EVENT_TRACK_MAJOR, EVENT_TRACK_CREWSET, EVENT_TRACK_GHOSTSET, UNCATEGORIZED_EVENTS, ALL_EVENTS)

/// Defines for the antag cap to prevent midround injections.
#define ANTAG_CAP_FLAT 1
#define ANTAG_CAP_DENOMINATOR 9

///Below are defines for the percentage fill that the tracks should start on. +- 50% of the value will be added
#define ROUNDSTART_MUNDANE_BASE 20

#define ROUNDSTART_MODERATE_BASE 35

#define ROUNDSTART_MAJOR_BASE 40

#define ROUNDSTART_CREWSET_BASE 60

#define ROUNDSTART_GHOSTSET_BASE 40

/// Storyteller types below, basically prevents several intense teller rounds in a row
#define STORYTELLER_TYPE_ALWAYS_AVAILABLE 0
#define STORYTELLER_TYPE_CALM 1
#define STORYTELLER_TYPE_INTENSE 2
