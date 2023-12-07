/datum/export/pull_requests
	cost = 1000
	unit_name = "pull request"
	export_types = list(/obj/item/paper/fluff/merge_my_fucking_pr)
	allow_negative_cost = TRUE

/datum/export/pull_requests/get_cost(obj/item/paper/fluff/merge_my_fucking_pr/pr)

	if(!length(SSeconomy.contributor_guidelines_blacklisted_words))
		return 1 //Something went wrong.

	if(length(pr.raw_stamp_data) > 1) //Too many stamps.
		return -init_cost*5

	if(pr.last_stamp_icon_state == "stamp-merged")
		if(SSeconomy.contributor_guidelines_blacklisted_words[pr.thing_to_remove])
			return -5000 //You merged a blacklisted PR!
		return ..() //Good job!

	return 0
