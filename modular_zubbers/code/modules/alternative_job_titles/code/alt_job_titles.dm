/datum/job/security_medic
	alt_titles = list(
		"Security Medic",
		"Field Medic",
		"Security Corpsman",
		"Brig Physician",
		"Combat Medic",
		"Special Operations Medic",
	)

/datum/job/orderly/New()
	alt_titles |= list(
		"Medical Attendant",
		"Medical Support Technician",
	)
	. = ..()

//New titles for Blacksmith
/datum/job/blacksmith
	alt_titles = list(
		"Ithastrist",
		"Metalurgist",
		"Metal Worker",
		"Metalsmith",
		"Forge Artisan",
		"Forgemaster",
		"Weaponsmith",
		"Armorsmith",
	)

/datum/job/bridge_assistant
	alt_titles = list(
		"Bridge Secretary",
		"Bridge Coffee Maker",
		"Command Deck Assistant",
		"Bridge Aide",
		"Bridge Attendant",
		"Captain's Assistant",
		"Coffee Officer",
		"Bridge Support",
		"Bridge Liaison",
		"Command Entertainment Officer",
		"Bridge Concierge",
		"Bridge Steward",
		"Bridge Custodian",
		"Junior Officer of the Deck",
		"Bridge Butler",
		"Bridge Caretaker",
		"Assistant to the Captain",
		"Coffee Brewer",
		"Supervisor of Coffee",
		"Command Aide",
		"Lackey",
		"Bridge Maid",
		"Command Cadet",
		"Assistant to the Regional Manager",
		"Assistant Manager Supervisor Junior",
		"Bridge Underling",
		"Bridge Taskrunner",
		"Clipboard Jockey",
		"Paperwork Specialist",
		"Manager Representative",
		"Head Assistant",
		"Bridge Tour Coordinator",
	)

/datum/job/paramedic/New()
	alt_titles |= list(
		"Body Retrieval Specialist",
	)
	. = ..()
