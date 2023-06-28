/datum/id_trim/job/blacksmith //Place Holder. You'll probably wanna come by and set these up correctly.
	assignment = "Blacksmith"
	trim_state = "trim_cargotechnician"
	department_color = COLOR_CARGO_BROWN
	subdepartment_color = COLOR_CARGO_BROWN
	sechud_icon_state = SECHUD_CARGO_TECHNICIAN
	minimal_access = list(
		ACCESS_BLACKSMITH,
		ACCESS_CARGO,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_MINING,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_SHIPPING,
		)
	extra_access = list(
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_QM,
		)
	job = /datum/job/blacksmith

/datum/id_trim/job/blueshield
	extra_access = list(ACCESS_SECURITY, ACCESS_COURT, ACCESS_CARGO, ACCESS_GATEWAY) //Blueshield loses Brig access and cannot perform arrests.
	minimal_wildcard_access = list()
	template_access = list(ACCESS_CAPTAIN) //Blueshield can no longer change to any other ID trim

/datum/id_trim/job/blueshield/New()
	.=..()
	minimal_access |= list(ACCESS_CAPTAIN)
//BUBBER ADDITION: adds ACCESS_CAPTAIN to the Blueshield's minimal_access.
//Lowering the Blueshield's ID from CENTCOM to silver necessitates moving this access.

/datum/id_trim/job/nanotrasen_consultant
	minimal_wildcard_access = list()
	template_access = list(ACCESS_CAPTAIN) //NTRep can no longer change to any other ID trim
