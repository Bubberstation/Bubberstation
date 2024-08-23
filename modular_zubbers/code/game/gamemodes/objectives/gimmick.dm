/datum/objective/gimmick
	name = "Dastardly Act"
	explanation_text = "Be dastardly as hell!"
	var/list/gimmick_list

/datum/objective/gimmick/New()
	if(isnull(gimmick_list))
		gimmick_list = list(
			"Frame innocent crewmembers for various pretty crimes they did not do.",
			"Get yourself arrested, then stage a mass jailbreak.",
			"Rescue anyone caught and arrested by security.",
			"Obstruct the flow of traffic around the station.",
			"Wage a personal war against assistants, forcing them to get a real job.",
			"Play increasingly more dangerous pranks on station.",
			"Commit as many minor and/or moderate crimes as possible.",
			"Start as many fights as you can on station. The more fistfights, the better.",
			"Start a competing shady business that makes a chosen department redundant.",
			"Seek out any non-security vigilantes on the station and prevent them from hunting others.",
			"Try to become a supervillain by using costumes, treachery, and a lot of bluster and bravado.",
			"Kidnap a pet or a crewmember and hold them for ransom.",
			"Convert a secure area, such as the bridge, into something more \"fun\" for the crew.",
			"Make as much of the station as possible accessible to the general public.",
			"Start a worker's union and encourage your fellow workers to stop working and go on strike.",
			"Steal things from crew members and attempt to auction them off for profit.",
			"Steal high value items from the station and attempt to sell them back to the crew.",
			"Attempt to monetize basic services the station provides.",
			"Start a successful coup and depose the Captain or a chosen Head of Staff.",
			"Perform a grand heist of the vault.",
			"Take over a part of the station, then expand slowly and gradually into other areas.",
			"Cause as many minor injures to crewmembers as possible."
		)

	explanation_text = pick(gimmick_list)

/datum/objective/gimmick/check_completion()
	return TRUE

