/datum/vote/map_vote
	count_method = VOTE_COUNT_METHOD_RANKED
	winner_method = VOTE_WINNER_METHOD_RANKED
	display_statistics = FALSE

/datum/vote/map_vote/finalize_vote(winning_option)
	SSmap_vote.finalize_map_vote(src, winning_option)
