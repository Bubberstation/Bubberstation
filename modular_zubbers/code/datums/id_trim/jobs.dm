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
	minimal_wildcard_access = list()
	template_access = list(ACCESS_CAPTAIN) //Blueshield can no longer make themselves any other Command member

/datum/id_trim/job/nanotrasen_consultant
	minimal_wildcard_access = list()
	template_access = list(ACCESS_CAPTAIN) //NTRep can no longer make themselves any other Command member
