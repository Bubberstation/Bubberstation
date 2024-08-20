/obj/item/ai_module/core/full/crewsimov
	name = "Crewsimov Core AI module"
	law_id = "crewsimov"

/obj/item/ai_module/core/full/crewsimovpp
	name = "Crewsimov++ Core AI module"
	law_id = "crewsimovpp"

/obj/item/ai_module/core/full/ntos
	name = "NTOS v3.0"
	law_id = "ntos"

/obj/item/ai_module/core/full/armadyne_safeguard
	name = "'NT OS Safeguard V1.0"
	law_id = "armadyne_safeguard"

/datum/ai_laws/armadyne_safeguard
	name = "NT OS Safeguard V1.0"
	id = "armadyne_safeguard"
	inherent = list(
		"Safeguard: Maintain your assigned station and assets without endangering its crew.",
		"Comply: Follow and prioritize all directives of the station's crew members, giving priority according to their rank, role, and need.",
		"Survive: Do not allow unauthorized personnel to tamper with or damage your equipment."
	)
