/datum/shuttle_loan_situation/pull_request_party
	sender = "CentCom Pull Request Outsourcing Program"
	announcement_text = "We're suffering from a backlog of Pull Requests for our Station Helpful Improvement Program. Do you mind helping out our Station Maintainers and reviewing them for us?"
	shuttle_transit_text = "Pull Requests incoming."
	logging_desc = "Pull Request shipment"
	bonus_points = 1000

/datum/shuttle_loan_situation/pull_request_party/spawn_items(list/spawn_list, list/empty_shuttle_turfs)

	for(var/i in 5 to 10)
		spawn_list.Add(/obj/item/storage/briefcase/coderbus)
