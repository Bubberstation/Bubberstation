/*
*	Use this file to add
*	Modular ERT datums
*/

/datum/ert/asset_protection
	roles = list(/datum/antagonist/ert/asset_protection)
	leader_role = /datum/antagonist/ert/asset_protection/leader
	rename_team = "Asset Protection Team"
	code = "Red"
	mission = "Protect Nanotrasen's assets, crew are assets."
	polldesc = "a Nanotrasen asset protection team"

/datum/ert/private_security // just putting this here to make my life easier.
	roles = list(/datum/outfit/centcom/private_security)
	leader_role = /datum/outfit/centcom/private_security/commander
	teamsize = 5
	opendoors = FALSE
	rename_team = "Private Security Squad"
	code = "Blue"
	mission = "Assist in station-side resolution."
	polldesc = "a Nanotrasen private security team"
	random_names = FALSE
