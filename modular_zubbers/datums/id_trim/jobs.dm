/datum/id_trim/job/blacksmith //Place Holder. You'll probably wanna come by and set these up correctly.
	assignment = "Blacksmith"
	trim_state = "trim_curator"
	orbit_icon = "book"
	department_color = COLOR_SERVICE_LIME
	subdepartment_color = COLOR_SERVICE_LIME
	sechud_icon_state = SECHUD_CURATOR
	minimal_access = list(
		ACCESS_AUX_BASE,
		ACCESS_LIBRARY,
		ACCESS_MINING_STATION,
		ACCESS_SERVICE,
		)
	extra_access = list()
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_HOP,
		)
	job = /datum/job/blacksmith
