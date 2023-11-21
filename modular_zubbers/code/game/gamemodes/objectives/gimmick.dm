/datum/objective/gimmick
	name = "Dastardly Act"
	explanation_text = "Be dastardly as hell!"
	var/list/gimmick_list

/datum/objective/gimmick/New()
	if(isnull(gimmick_list))
		gimmick_list = list(
			"Try to frame innocent crewmembers for various crimes.",
			"Try to sabotage as much station infrastructure as possible without getting caught.",
			"Try to ruin a department's productivity with constant annoyances.",
			"Get yourself arrested, and then stage a violent jailbreak.",
			"If anyone gets arrested, try to rescue them. The Syndicate values its employees!",
			"Try to severely obstruct the flow of traffic around the station with barricades, sabotage, or construction projects.",
			"Wage a personal war against all the assistants. Try to eradicate them without attracting the attention of other departments.",
			"Play increasingly more dangerous pranks on other crew members. If confronted, insist it was just a joke.",
			"Waste Medbay's time by causing a lot of non-fatal injuries around the station.",
			"Waste Security's time by committing a lot of minor crimes.",
			"Start as many petty arguments and fistfights as possible. Be a real jerk.",
			"Try to make everyone hate a job department of your choice, through misdirection and slander.",
			"Try to make everyone hate a crew member of your choice, through misdirection and slander.",
			"Spread rumors about a crew member of your choice and ruin their reputation.",
			"Sneak into a department of your choice every once in awhile and mess with all the things inside.",
			"Try to deprive the station of medical items and objects.",
			"Try to deprive the station of tools and useful items.",
			"Try to deprive the station of their ID cards.",
			"Make the station as ugly and visually unpleasant as you can.",
			"Become a literal arms dealer. Harvest as many body parts as possible from the crew.",
			"Become a vigilante and violently harass people over the slightest suspicion.",
			"Seek out any non-security vigilantes on the station and make their life utter hell.",
			"Find another crew member's pet project and subvert it to a more violent purpose.",
			"Try to become a supervillain by using costumes, treachery, and a lot of bluster and bravado.",
			"Spy on the crew and uncover their deepest secrets.",
			"Kidnap Ian and hold him for ransom.",
			"Kidnap the Medical Director's cat and hold her for ransom.",
			"Convert the bridge into your own private bar.",
			"Single out a crew member and stalk them everywhere.",
			"Be as useless and incompetent as possible without getting killed.",
			"Make as much of the station as possible accessible to the public.",
			"Try to convince your department to go on strike and refuse to do any work.",
			"Steal things from crew members and attempt to auction them off for profit.",
		)

	explanation_text = pick(gimmick_list)

/datum/objective/gimmick/check_completion()
	return TRUE

