/// -- Defines for the unique-examine element. --
/// Displays the description regardless. Pass no requirements.
#define EXAMINE_CHECK_NONE "none"
/// For displaying info to those with a mindshield implant. Pass no requirements.
#define EXAMINE_CHECK_MINDSHIELD "mindshield"
/// For displaying info to those with a certain antag datum, e.g. "traitors". Pass a list of /datum/antagonist typepaths.
/// You can optionally pass a special_affiliation with your element to overide the displayed antagonist name
/// (Such as passing "Special agent" so it shows that instead of "Traitor")
#define EXAMINE_CHECK_ANTAG "antag"
/// For displaying info to specific jobs, e.g. "scientists". Pass a list of /datum/job typepaths.
#define EXAMINE_CHECK_JOB "job"
/// For displaying info to people a part of specific departments, e.g. "all jobs in service". Pass a bitflag of departments.
#define EXAMINE_CHECK_DEPARTMENT "department"
/// For displaying info to mob factions, e.g. "syndicate". Pass a string "faction"
/// Note: factions aren't set very consistently, and often are just set by antag datums,
/// so you should probably try to use other checks if possible (like antag datums).
#define EXAMINE_CHECK_FACTION "faction"
/// For displaying info to people with certain skill-chips. Pass a list of /obj/item/skillchip typepaths.
#define EXAMINE_CHECK_SKILLCHIP "skillchip"
/// For displayind info to people with certain traits. Pass a list of trait keys / strings.
#define EXAMINE_CHECK_TRAIT "trait"
/// For displayind info to people of certain species. Pass a list of /datum/species typepaths.
#define EXAMINE_CHECK_SPECIES "species"

/// -- Examine group lists, for ease of use. --
/// If this was done upstream / nonmodularly ideally these lists would be generalized so they aren't JUST for this.
/// It'd justify the use of GLOB more; at least

/// ANTAGONISTS

/// All Syndicate-Aligned Antagonists
GLOBAL_LIST_INIT(examine_syndicate_antag_list, list(
	/datum/antagonist/battlecruiser, \
	/datum/antagonist/brother, \
	/datum/antagonist/malf_ai, \
	/datum/antagonist/nukeop, \
	/datum/antagonist/rev/head, \
	/datum/antagonist/pirate, \
	/datum/antagonist/spy, \
	/datum/antagonist/syndicate_monkey, \
	/datum/antagonist/traitor, \
	))
