//This file makes it so that security will always get a deathrattle.

/datum/station_trait/deathrattle_department/security
	weight = 0

/datum/controller/subsystem/processing/station/SetupTraits()

	. = ..()

	var/datum/station_trait/deathrattle_department/security/existing_security_trait = locate() in station_traits
	if(existing_security_trait)
		return .

	var/datum/station_trait/deathrattle_all/existing_all_trait = locate() in station_traits
	if(existing_all_trait)
		return .

	setup_trait(/datum/station_trait/deathrattle_department/security)
