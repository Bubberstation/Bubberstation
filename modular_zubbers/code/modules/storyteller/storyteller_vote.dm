/datum/vote
	var/has_desc = FALSE

/datum/vote/proc/return_desc(vote_name)
	return ""

/datum/vote/storyteller
	name = "Storyteller"
	default_message = "Vote for the storyteller!"
	has_desc = TRUE
	count_method = VOTE_COUNT_METHOD_RANKED
	winner_method = VOTE_WINNER_METHOD_RANKED
	ranked_winner_threshold = 70 // 70% threshold for direct win
	display_statistics = FALSE
	vote_reminder = TRUE
	/// Only readied players can vote
	var/ready_only = TRUE

/datum/vote/storyteller/New()
	. = ..()
	default_choices = list()
	default_choices = SSgamemode.storyteller_vote_choices()

/datum/vote/storyteller/initiate_vote(initiator, duration)
	. = ..()
	to_chat(world, vote_font(fieldset_block("Storyteller Vote", "[span_vote_notice("Only players who are ready and joining the game round start will be calculated in voting results.")]", "boxed_message purple_box")))

/datum/vote/storyteller/return_desc(vote_name)
	return SSgamemode.storyteller_desc(vote_name)

/datum/vote/storyteller/get_result_text(winners, final_winner, non_voters)
	if(!ready_only)
		return ..()

	return fieldset_block("Storyteller Vote", "Storyteller voting is now closed! Storyteller will be determined when the round starts.", "boxed_message purple_box")

/datum/vote/storyteller/create_vote()
	. = ..()
	if((length(choices) == 1)) // Only one choice, no need to vote.
		var/de_facto_winner = choices[1]
		SSgamemode.storyteller_vote_result(de_facto_winner)
		to_chat(world, span_boldannounce("The storyteller vote has been skipped because there is only one storyteller left to vote for. The storyteller has been changed to [de_facto_winner]."))
		return FALSE

/datum/vote/storyteller/can_be_initiated(mob/by_who, forced = FALSE)
	. = ..()
	if(forced)
		return TRUE

	if(SSgamemode.storyteller_voted)
		default_message = "The next Storyteller has already been selected."
		return FALSE

/datum/vote/storyteller/finalize_vote(winning_option)
	SSgamemode.storyteller_vote_result(winning_option)
	SSgamemode.storyteller_voted = TRUE
	if(ready_only)
		SSgamemode.ready_only_vote = TRUE

/*
### PERSISTENCE SUBSYSTEM TRACKING BELOW ###
Basically, this keeps track of what we voted last time to prevent it being voted on again.
For this, we use the SSpersistence.last_storyteller_type variable

We then just check what the last one is in SSgamemode.storyteller_vote_choices()
*/

#define STORYTELLER_LAST_FILEPATH "data/storyteller_last_round.txt"

/// Extends collect_data
/datum/controller/subsystem/persistence/collect_data()
	. = ..()
	collect_storyteller_type()

/// Loads last storyteller into last_storyteller_type
/datum/controller/subsystem/persistence/proc/load_storyteller_type()
	if(!fexists(STORYTELLER_LAST_FILEPATH))
		return
	last_storyteller_type = text2num(file2text(STORYTELLER_LAST_FILEPATH))

/// Collects current storyteller and stores it
/datum/controller/subsystem/persistence/proc/collect_storyteller_type()
	rustg_file_write("[SSgamemode.storyteller.storyteller_type]", STORYTELLER_LAST_FILEPATH)

#undef STORYTELLER_LAST_FILEPATH
