/datum/antagonist/traitor/forge_single_generic_objective()
	if(prob(KILL_PROB))

		var/datum/objective/gimmick/gimmick_objective = new()
		gimmick_objective.owner = owner
		return gimmick_objective

	var/datum/objective/steal/steal_objective = new()
	steal_objective.owner = owner
	steal_objective.find_target()
	return steal_objective

/datum/traitor_objective_category/final_objective
	name = "Final Objective"
	objectives = list(
//		/datum/traitor_objective/ultimate/battlecruiser = 1, Debatable.
		/datum/traitor_objective/ultimate/battle_royale = 1,
		/datum/traitor_objective/ultimate/dark_matteor = 1,
		/datum/traitor_objective/ultimate/infect_ai = 1,
//		/datum/traitor_objective/ultimate/romerol = 1, Meh.
//		/datum/traitor_objective/ultimate/supermatter_cascade = 1, Engineering doesn't need to cook this spaghetti today.
	)

/datum/traitor_objective/ultimate/dark_matteor // lol fuck no, just two big rocks instead. This objective was non-modularly editted.
	name = "Summon twin tunguska meteors to rip through the station."
	description = "Go to %AREA%, and receive the smuggled satellites + emag. Set up and emag the satellites, \
	after enough have been recalibrated by the emag."

/obj/item/paper/dark_matteor_summoning // SLIGHT REWORDING FROM DARK METEOR TO TUNGUSKA
	name = "notes - twin tunguska meteor summoning"
	default_raw_text = {"
		Summoning twin tunguska meteor.<br>
		<br>
		<br>
		Operative, this crate contains 10+1 spare meteor shield satellites stolen from NT’s supply lines. Your mission is to
		deploy them in space near the station and recalibrate them with the provided emag. Be careful: you need a 30 second
		cooldown between each hack, and NT will detect your interference after seven recalibrations. That means you
		have at least 5 minutes of work and 1 minute of resistance.<br>
		<br>
		This is a high-risk operation. You’ll need backup, fortification, and determination. The reward?
		A spectacular display of twin meteors ripping through the station.<br>
		<br>
		<b>**Death to Nanotrasen.**</b>
"}
