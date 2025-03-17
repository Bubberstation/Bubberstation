/datum/controller/subsystem/gamemode/proc/send_trait_report()
	. = "<b><i>Central Command Status Summary</i></b><hr>"
	SSstation.generate_station_goals(20)

	var/list/station_goals = SSstation.get_station_goals()

	if(!length(station_goals))
		. = "<hr><b>No assigned goals.</b><BR>"
	else
		. += generate_station_goal_report(station_goals)
	if(!SSstation.station_traits.len)
		. = "<hr><b>No identified shift divergencies.</b><BR>"
	else
		. += generate_station_trait_report()

	. += "<hr>This concludes your shift-start evaluation. Have a secure shift!<hr>\
	<p style=\"color: grey; text-align: justify;\">This label certifies an Intern has reviewed the above before sending. This document is the property of Nanotrasen Corporation.</p>"

	print_command_report(., "Central Command Status Summary", announce = FALSE)
	priority_announce("Hello, crew of [station_name()]. Our intern has finished their shift-start divergency and goals evaluation, which has been sent to your communications console. Have a secure shift!", "Divergency Report", SSstation.announcer.get_rand_report_sound())



/*
 * Generate a list of station goals available to purchase to report to the crew.
 *
 * Returns a formatted string all station goals that are available to the station.
 */
/datum/controller/subsystem/gamemode/proc/generate_station_goal_report(list/station_goals)
	. = "<hr><b>Special Orders for [station_name()]:</b><BR>"
	var/list/goal_reports = list()
	for(var/datum/station_goal/station_goal as anything in station_goals)
		station_goal.on_report()
		goal_reports += station_goal.get_report()

	. += goal_reports.Join("<hr>")
	return
/*
 * Generate a list of active station traits to report to the crew.
 *
 * Returns a formatted string of all station traits (that are shown) affecting the station.
 */
/datum/controller/subsystem/gamemode/proc/generate_station_trait_report()
	if(!SSstation.station_traits.len)
		return
	. = "<hr><b>Identified shift divergencies:</b><BR>"
	for(var/datum/station_trait/station_trait as anything in SSstation.station_traits)
		if(!station_trait.show_in_report)
			continue
		. += "[station_trait.get_report()]<BR>"
	return

/*/datum/controller/subsystem/gamemode/proc/generate_station_goals()
	var/list/possible = subtypesof(/datum/station_goal)
	var/goal_weights = 0
	while(possible.len && goal_weights < 1) // station goal budget is 1
		var/datum/station_goal/picked = pick_n_take(possible)
		goal_weights += initial(picked.weight)
		SSstation.goals_by_type += new picked // does this still work?
*/
