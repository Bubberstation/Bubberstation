/datum/storyteller_metric/utility
	name = "Utility metric"


/datum/storyteller_metric/utility/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)

	//Let's find ERT first
	var/deathsquad_on_station = FALSE
	var/ert_on_station = FALSE
	for(var/datum/antagonist/ert/ert in GLOB.antagonists)
		if(ert.rip_and_tear)
			deathsquad_on_station = TRUE
			break
		ert_on_station = TRUE
		break

	if(ert_on_station)
		inputs.vault += STORY_VAULT_STATION_ALLIES
	if(deathsquad_on_station)
		inputs.vault += STORY_VAULT_DEATHSQUAD
	..()


