
#define MAP_VOTE_RECENT_PENALTY 0.25 //As a percent. 0.25 = 25%.

/datum/vote/map_vote/get_vote_result(list/non_voters)
	for(var/option in choices)
		if(option in SSpersistence.restricted_maps)
			choices[option] *= (1 - MAP_VOTE_RECENT_PENALTY)
	. = ..()

/datum/vote/map_vote/get_result_text(list/all_winners, real_winner, list/non_voters)
	if(length(all_winners) <= 0 || !real_winner)
		return span_bold("Vote Result: Inconclusive - No Votes!")

	var/returned_text = ""
	if(override_question)
		returned_text += span_bold(override_question)
	else
		returned_text += span_bold("[capitalize(name)] Vote")

	for(var/option in choices)
		returned_text += "\n[span_bold(option)]: [choices[option]]"
		if(option in SSpersistence.restricted_maps)
			returned_text += " ([100 - MAP_VOTE_RECENT_PENALTY*100]% from being played recently)"

	returned_text += "\n"
	returned_text += get_winner_text(all_winners, real_winner, non_voters)

	return returned_text

#undef MAP_VOTE_RECENT_PENALTY