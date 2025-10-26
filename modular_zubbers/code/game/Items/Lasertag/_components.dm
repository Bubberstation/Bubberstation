/datum/component/lasertag
	var/team_color = "neutral"
	var/list/lasertag_granters = list()

/datum/component/lasertag/proc/should_delete(var/piece)
	lasertag_granters -= piece
	if(LAZYLEN(lasertag_granters))
		return FALSE
	return TRUE
