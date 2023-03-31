// BUTTERSTATION ADDITION

#define CHOICE_EXTENDED "Extended Ruleset (Minimal Threats)"
#define CHOICE_DYNAMIC "Dynamic Ruleset (Normal Threats)"

/datum/vote/gamemode_vote
	name = "Gamemode"
	default_choices = list(
		CHOICE_EXTENDED,
		CHOICE_DYNAMIC,
	)
	message = "Vote for the next rounds ruleset."

/datum/vote/gamemode_vote/is_accessible_vote()
	return FALSE

/datum/vote/gamemode_vote/finalize_vote(winning_option)
	if(winning_option == CHOICE_EXTENDED)
		rustg_file_write("Extended", "DYNAMIC_THREAT_VOTE_PATH")
		return

	if(winning_option == CHOICE_DYNAMIC)
		rustg_file_write("Dynamic", "DYNAMIC_THREAT_VOTE_PATH")
		return

	else
		CRASH("[type] wasn't passed a valid winning choice. (Got: [winning_option || "null"])")

#undef CHOICE_EXTENDED
#undef CHOICE_DYNAMIC
